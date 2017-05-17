require ('./app')
run Sinatra::Application

configure do
    LOGGER = Logger.new("logs/sinatra.log")
    original_formatter = Logger::Formatter.new
    LOGGER.formatter = proc { |severity, datetime, progname, msg|
        original_formatter.call(severity, datetime, progname, "#{ip} #{msg.dump}")
    }
end
