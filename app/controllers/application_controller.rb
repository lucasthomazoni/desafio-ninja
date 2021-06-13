# frozen_string_literal: true

class ApplicationController < ActionController::API
  def render_json_api(serializer: nil, status: :ok, body: [])
    render json: serializer.new(body).serializable_hash, status: status
  end
end
