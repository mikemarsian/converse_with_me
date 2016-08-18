module ConverseWithMe
  module ViewHelpers

    def include_converse_with_me(user_id, user_nick, user_xmpp_password, room_id)
      ConverseWithMe::Base.converse_with_me(user_id, user_nick, user_xmpp_password, room_id)
    end

  end
end

# add methods to ActionView helpers
ActionView::Base.send :include, ConverseWithMe::ViewHelpers