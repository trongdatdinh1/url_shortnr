# frozen_string_literal: true

class RedirectController < ApplicationController
  skip_after_action :verify_authorized, :verify_policy_scoped

  def show
    url = Url.find_by short: params[:short]
    to_path = url.blank? ? '/' : url.original
    redirect_to(to_path, allow_other_host: true)
  end
end
