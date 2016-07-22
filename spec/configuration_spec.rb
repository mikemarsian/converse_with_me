require "spec_helper"

describe ConverseWithMe::Configuration do
  describe "#configure" do

    context "initial values" do
      it "should be set correctly" do
        config = ConverseWithMe.configuration
        expect(config.xmpp_server).to eq("localhost")
        expect(config.xmpp_server_port).to eq("5280")
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
    end
  end
end