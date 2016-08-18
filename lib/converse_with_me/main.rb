module ConverseWithMe
  class Main
    def self.converse_with_me(user_uid, user_nick, user_xmpp_password, room_uid)
      raise ConverseWithMe::InvalidArgs if user_uid.blank? || user_nick.blank? || user_xmpp_password.blank? || room_uid.blank?

      setup = Setup.new(user_uid, room_uid)
      XmppChat.register_user(setup.user_jid, user_xmpp_password)
      tokens = XmppChat.get_prebind_url_tokens(setup.bosh_service_url, setup.user_jid, user_xmpp_password)
      # TODO: initialize GON with tokens values to pass to ConverseJS
    end
  end

end