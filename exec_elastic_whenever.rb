#!/usr/bin/env ruby
# frozen_string_literal: true

require 'aws-sdk-core'
require 'aws-sdk-cloudformation'

module ElasticWheneverHelper
  class Command
    attr_reader :stack

    def initialize(stack, schedule_file:)
      @stack = stack
      @schedule_file = schedule_file
    end

    def to_s
      command = "bundle exec elastic_whenever"
      options = command_options.map { |key, value| "#{key} \"#{value}\"" }
      [command, *options].join(' ')
    end

    def command_options
      stack_name = stack[:name]

      {
        '--cluster': stack[:cluster_id],
        '--task-definition': "#{stack_name}-rails",
        '--container': 'rails',
        '--launch-type': 'FARGATE',
        '--security-groups': stack[:security_groups],
        '--subnets': stack[:public_subnets],
        '--assign-public-ip': 'ENABLED',
        '--update': 'rails',
        '--file': @schedule_file
      }
    end
  end

  class CloudformationStack
    def initialize(options = {})
      opt = {
        region: 'ap-northeast-1',
        environment: 'production',
        task: 'rails',
      }.merge(options)

      @client = Aws::CloudFormation::Client.new(region: opt[:region])

      @app = opt[:app]
      @environment = opt[:environment]
    end

    def stack_name
      "#{@app}-#{@environment}"
    end

    def describe
      res = @client.describe_stacks(stack_name: stack_name)
      stack = res.stacks.first

      {
        name: stack.stack_name,
        cluster_id: stack_output_value(stack, 'ClusterId'),
        security_groups: stack_output_value(stack, 'EnvironmentSecurityGroup'),
        private_subnets: stack_output_value(stack, 'PrivateSubnets'),
        public_subnets: stack_output_value(stack, 'PublicSubnets'),
      }
    end

    private

    def stack_output_value(stack, key)
      output = stack.outputs.detect { |output| output.output_key == key }
      output&.output_value
    end
  end
end

app_name = ARGV[0]
environment = ARGV[1]
schedule_file = ARGV[2]

cloud_formation_stack = ElasticWheneverHelper::CloudformationStack.new(
  app: app_name,
  environment: environment
).describe

command = ElasticWheneverHelper::Command.new(
  cloud_formation_stack,
  schedule_file: schedule_file
).to_s

puts 'elastic whenever command:'
puts command

if system(command)
  puts 'elastic_whenever completed.'
else
  puts "elastic_whenever failed. exist code: #{$?}"
  exit $?
end
