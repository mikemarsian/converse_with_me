require "spec_helper"

describe ConverseWithMe::Configuration do
  before(:each) do
    ConverseWithMe.reset_configuration
  end
  describe "#configure" do

    context "initial values" do
      it "should be set correctly" do
        config = ConverseWithMe.configuration
        expect(config.xmpp_server).to eq("localhost")
        expect(config.bosh_service_url).to be nil
        expect(config.use_https).to be false
      end
    end

    context "setting values" do
      context "xmpp_server" do
        it "should work" do
          ConverseWithMe.configure do |config|
            config.xmpp_server = "example.com"
          end

          expect(ConverseWithMe.configuration.xmpp_server).to eq("example.com")
        end
      end
      context "xmpp_server_port" do
        it "should work" do
          ConverseWithMe.configure do |config|
            config.xmpp_server_port = "6666"
          end

          expect(ConverseWithMe.configuration.xmpp_server_port).to eq("6666")
        end
      end

      context "bosh_service_url" do
        let(:bosh_url) { "http://example.com:5281/http-bind" }
        it "should work" do
          ConverseWithMe.configure do |config|
            config.bosh_service_url = bosh_url
          end

          expect(ConverseWithMe.configuration.bosh_service_url).to eq(bosh_url)
        end
      end
    end
  end
  describe "#logger" do
    it "should return a Logger object" do
      logger = ConverseWithMe.logger

      expect(logger).to be_a(Logger)
    end

    it "should allow assigning custom logger" do
      logger = Logger.new(STDOUT)
      ConverseWithMe.logger = logger

      expect(ConverseWithMe.logger).to eq(logger)
    end
  end
end