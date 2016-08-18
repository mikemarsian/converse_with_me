require 'xmpp4r'
require 'xmpp4r/muc'
require 'ruby_bosh'

module ConverseWithMe
  class XmppChat

    # Initializes XMPP prebind, which allows retaining the same XMPP session on page reloads
    #
    # @return [JSON Hash of tokens]
    def self.get_prebind_url_tokens(bosh_service_url, user_jid, user_password)
      ConverseWithMe.logger.info("BOSH/XMPP: initializing BOSH session on #{bosh_service_url}...")
      jabber_id, session_id, random_id = RubyBOSH.initialize_session(user_jid,
                                                                     user_password, bosh_service_url)
      ConverseWithMe.logger.info("BOSH/XMPP: returned jabber_id: #{jabber_id}, session_id: #{session_id}, random_id: #{random_id}")

      {"jid" => "#{jabber_id}", "sid" => "#{session_id}", "rid" => "#{random_id}" }
    rescue RubyBOSH::AuthFailed => exc
      msg = "BOSH/XMPP Error: couldn't initialize BOSH session for #{user_jid} on #{bosh_service_url}. #{exc.message}"
      ConverseWithMe.logger.error(msg)
      raise ConnectionError.new(msg)
    end

    # Registers user on the XMPP server
    #
    # @return [Jabber::Client] client object, that can be used to manage XMPP connection
    def self.register_user(user_jid, user_password)
      client = connect_client(user_jid)
      ConverseWithMe.logger.info("BOSH/XMPP: registering user #{user_jid} ...")
      begin
        client.register(user_password)
      rescue Jabber::ClientAuthenticationFailure, Jabber::ServerError => exc
        ConverseWithMe.logger.warn("BOSH/XMPP: couldn't register #{user_jid} on the server, probably already registered. #{exc.message}")
      end

      client
    end

    private

    def self.connect_client(user_jid)
      client = Jabber::Client.new(Jabber::JID.new(user_jid))
      client.connect
      client
    rescue Jabber::ClientAuthenticationFailure, Jabber::ServerError => exc
      msg = "BOSH/XMPP Error: couldn't connect to server. #{exc.message}"
      ConverseWithMe.logger.error(msg)
      raise ConnectionError.new(msg)
    end
  end
end
