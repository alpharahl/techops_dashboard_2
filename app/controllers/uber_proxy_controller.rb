class UberProxyController < ActionController::API
  protect_from_forgery except: :attendee_search
  def attendee_search
    head :no_content
  end
end
