# frozen_string_literal: true

class Api::V1::Accounts::LookupController < Api::BaseController
  before_action -> { authorize_if_got_token! :read, :'read:accounts' }
  before_action :set_account

  def show
    expires_in 3.minutes, public: true unless user_signed_in?
    render json: @account, serializer: REST::AccountSerializer
  end

  private

  def set_account
    @account = ResolveAccountService.new.call(params[:acct], skip_webfinger: true) || raise(ActiveRecord::RecordNotFound)
  rescue Addressable::URI::InvalidURIError
    raise(ActiveRecord::RecordNotFound)
  end
end
