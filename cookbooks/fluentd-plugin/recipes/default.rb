#
# Cookbook Name:: fluentd-plugin
# Recipe:: default
#
# Copyright 2015, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

filename = "fluent-plugin-elasticsearch-0.9.0.gem"

cookbook_file "/tmp/#{filename}" do
  source "#{filename}"
end

gem_package "fluentd-elasticsearch" do
  gem_binary "/usr/sbin/td-agent-gem"
  action :install
  source "/tmp/#{filename}"
end


parser_postgres.rb

#=====================================================================
# postgres log parser
#=====================================================================

module Fluent
  require 'fluent/parser'

  class TextParser

    #パーサープラグインの名前
    class PostgresParser < Parser

      # このプラグインをパーサプラグインとして登録する
      Plugin.register_parser('postgres', self)

      FORMAT = /^(?<time>[^",]*),"?(?<user_name>(?:[^"]|"")*)"?,"?(?<database_name>(?:[^"]|"")*)"?,(?<process_id>[^",]*),"?(?<connection_from>(?:[^"]|"")*)"?,(?<session_id>[^",]*),(?<session_line_num>[^",]*),"?(?<command_tag>(?:[^"]|"")*)"?,(?<session_start_time>[^",]*),(?<virtual_transaction_id>[^",]*),(?<transaction_id>[^",]*),(?<error_severity>[^",]*),(?<sql_state_code>[^",]*),"?(?<message>(?:[^"]|"")*)"?,(?<detail>[^",]*),"?(?<hint>(?:[^"]|"")*)"?,(?<internal_query>[^",]*),(?<internal_query_pos>[^",]*),(?<context>[^",]*),(?<query>[^",]*),(?<query_pos>[^",]*),(?<location>[^",]*),"?(?<application_name>(?:[^"]|"")*)"?$/
      TIME_FORMAT = "%Y-%m-%d %H:%M:%S.%L %Z"


      # 初期化
      def initialize
        super
        @mutex = Mutex.new
      end

      def patterns
        {'format' => FORMAT, 'time_format' => TIME_FORMAT}
      end

      def configure(conf)
        super
      end

      def parse(text)
        elements = FORMAT.match(text)
        unless elements
          if block_given?
            yield nil, nil
            return
          else
            return nil, nil
          end
        end

        time                   = elements['time']
        user_name              = elements['user_name']
        database_name          = elements['database_name']
        process_id             = elements['process_id']
        connection_from        = elements['connection_from']
        session_id             = elements['session_id']
        session_line_num       = elements['session_line_num']
        command_tag            = elements['command_tag']
        session_start_time     = elements['session_start_time']
        virtual_transaction_id = elements['virtual_transaction_id']
        transaction_id         = elements['transaction_id']
        error_severity         = elements['error_severity']
        sql_state_code         = elements['sql_state_code']
        message                = elements['message']
        detail                 = elements['detail']
        hint                   = elements['hint']
        internal_query         = elements['internal_query']
        internal_query_pos     = elements['internal_query_pos']
        context                = elements['context']
        query                  = elements['query']
        query_pos              = elements['query_pos']
        location               = elements['location']
        application_name       = elements['application_name']

        record = {
          "time"                   => time,
          "user_name"              => user_name,
          "database_name"          => database_name,
          "process_id"             => process_id,
          "connection_from"        => connection_from,
          "session_id"             => session_id,
          "session_line_num"       => session_line_num,
          "command_tag"            => command_tag,
          "session_start_time"     => session_start_time,
          "virtual_transaction_id" => virtual_transaction_id,
          "transaction_id"         => transaction_id,
          "error_severity"         => error_severity,
          "sql_state_code"         => sql_state_code,
          "message"                => message,
          "detail"                 => detail,
          "hint"                   => hint,
          "internal_query"         => internal_query,
          "internal_query_pos"     => internal_query_pos,
          "context"                => context,
          "query"                  => query,
          "query_pos"              => query_pos,
          "location"               => location,
          "application_name"       => application_name
        }

        if block_given?
          yield Engine.now, record
        else
          return Engine.now, record
        end

      end

    end

  end

end
