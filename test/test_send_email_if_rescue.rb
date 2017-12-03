# frozen_string_literal: true

require 'minitest/autorun'
require 'mocha/mini_test'

require_relative '../lib/send_email_if_rescue'

class TestSendEmailIfRescue < Minitest::Test
  def test_send_email_if_rescue_sends_email_when_exception_is_raised
    script_name = 'test'

    request_mock = mock
    request_mock.expects(:send).once

    PostageApp::Request.expects(:new).once.with do |method, options|
      error_subject = "EDM Scraper: error while running script '#{script_name}'"
      method == :send_message && options[:headers][:subject] == error_subject
    end.returns(request_mock)

    send_email_if_rescue(script_name) do
      raise 'Test exception'
    end
  end

  def test_send_email_if_rescue_does_not_send_email_if_no_exception_raised
    request_mock = mock
    request_mock.expects(:send).never

    PostageApp::Request.expects(:new).never.returns(request_mock)

    send_email_if_rescue('test') do
    end
  end
end
