# frozen_string_literal: true

class UsersController < ApplicationController
  def index
    render_json_api(serializer: UserSerializer, body: User.all)
  end
end
