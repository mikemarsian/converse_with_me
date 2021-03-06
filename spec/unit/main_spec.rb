require "spec_helper"

describe ConverseWithMe do
  let(:user_uid) { 16 }
  let(:user_nick) { "John" }
  let(:user_xmpp_password) { "sdgSdge45" }
  let(:room_uid) { 1456 }

  describe "#converse_with_me" do
    before(:each) do
      ConverseWithMe.reset_configuration
    end
    context "valid params" do

      context "connecting to XMPP server" do
        context "using custom params" do
          it "should work" do
            expect_any_instance_of(Jabber::Client).to receive(:connect).with("localhost", "5244")
            ConverseWithMe.configure do |c|
              c.xmpp_server_port = "5244"
            end

            expect { ConverseWithMe.converse_with_me(user_uid,
                                      user_nick, user_xmpp_password, room_uid) }.to raise_error(ConverseWithMe::ConnectionError)
          end
        end
      end

      context "registering user" do
        before do
          allow(ConverseWithMe::XmppChat).to receive(:get_prebind_url_tokens) { {"jid" => "4353", "sid" => "3453", "rid" => "432563" } }
        end
        it "should call register_user with correct params" do
          expect(ConverseWithMe::XmppChat).to receive(:register_user).with("user_16@localhost", "sdgSdge45")
          ConverseWithMe.converse_with_me(user_uid, user_nick, user_xmpp_password, room_uid)
        end
        it "should raise ConnectionError when XMPP server is down" do
          expect { ConverseWithMe.converse_with_me(user_uid,
                             user_nick, user_xmpp_password, room_uid) }.to raise_error(ConverseWithMe::ConnectionError)
        end
      end

      context "prebinding" do
        before do
          allow(ConverseWithMe::XmppChat).to receive(:register_user) {}
          # stub Bosh server to return 500 status
          stub_request(:post, "http://localhost:5280/http-bind").to_return(status: 500)
        end
        it "should call get_prebind_url_tokens with correct params" do
          expect(ConverseWithMe::XmppChat).to receive(:get_prebind_url_tokens).with("http://localhost:5280/http-bind",
                                                                                    "user_16@localhost",
                                                                                    "sdgSdge45")
          ConverseWithMe.converse_with_me(user_uid, user_nick, user_xmpp_password, room_uid)
        end

        it "should raise ConnectionError when Bosh server is down" do
          expect { ConverseWithMe.converse_with_me(user_uid,
                                                         user_nick, user_xmpp_password, room_uid) }.to raise_error(ConverseWithMe::ConnectionError)
        end

        context "with configuration" do
          it "should call get_prebind_url_tokens with params given in configuration" do
            expect(ConverseWithMe::XmppChat).to receive(:get_prebind_url_tokens).with("https://example.com:5280/http-bind",
                                                                                      "user_16@example.com",
                                                                                      "sdgSdge45")

            ConverseWithMe.configure do |config|
              config.xmpp_server = "example.com"
              config.use_https = true
            end
            ConverseWithMe.converse_with_me(user_uid, user_nick, user_xmpp_password, room_uid)
          end
        end
      end
    end

    context "invalid params" do
      it "throws InvalidArgs" do
        expect { ConverseWithMe.converse_with_me(nil, user_nick, user_xmpp_password, room_uid) }.to raise_error(ConverseWithMe::InvalidArgs)
        expect { ConverseWithMe.converse_with_me(user_uid, "", user_xmpp_password, room_uid) }.to raise_error(ConverseWithMe::InvalidArgs)
        expect { ConverseWithMe.converse_with_me(user_uid, user_nick, "", room_uid) }.to raise_error(ConverseWithMe::InvalidArgs)
      end
    end
  end

end