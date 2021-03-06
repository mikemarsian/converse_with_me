module ConverseWithMe
  class Setup
    attr_reader :bosh_service_url, :user_jid, :room_jid

    def initialize(user_id, room_id)
      @config = ConverseWithMe.configuration

      set_bosh_service_url
      set_user_jid(user_id)
      set_room_jid(room_id)
    end

    private

    def set_bosh_service_url
      if @config.bosh_service_url.blank?
        protocol = @config.use_https ? 'https' : 'http'
        @bosh_service_url = "#{protocol}://#{@config.xmpp_server}:5280/http-bind"
      else
        @bosh_service_url = @config.bosh_service_url
      end
    end

    def set_user_jid(user_id)
      @user_jid = "user_#{user_id}@#{@config.xmpp_server}"
    end

    def set_room_jid(room_id)
      @room_jid = "room_#{room_id}@conference.#{@config.xmpp_server}"
    end
  end
end