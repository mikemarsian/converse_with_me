module ConverseWithMe
  def self.converse_with_me(user_uid, user_nick, user_xmpp_password, room_uid)
    raise ConverseWithMe::InvalidArgs if user_uid.blank? || user_nick.blank? || user_xmpp_password.blank? || room_uid.blank?

    setup = Setup.new(user_uid, room_uid)
    XmppChat.register_user(setup.user_jid, user_xmpp_password)
    tokens = XmppChat.get_prebind_url_tokens(setup.bosh_service_url, setup.user_jid, user_xmpp_password)

    # initialize GON with tokens values to pass to ConverseJS
    # if tokens.present?
    #   gon.bosh_service_url = setup.bosh_service_url
    #   gon.prebind_url = chat_prebind_tokens_path
    #   gon.current_user_jid = setup.user_jid
    #   gon.current_user_sid = tokens["sid"]
    #   gon.current_user_rid = tokens["rid"]
    #   gon.current_user_nick = user_nick
    #   gon.room_jid = setup.room_jid
    # else
    #   ConverseWithMe.logger.warn("Not initializing ConverseJS, since couldn't establish BOSH connection." /
    #                         "Check that the XMPP server is online at #{@bosh_service_url}")
    # end
  end
end