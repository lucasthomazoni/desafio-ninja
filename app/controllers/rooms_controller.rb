# frozen_string_literal: true

class RoomsController < ApplicationController
  def index
    render_json_api(serializer: RoomSerializer, body: Room.all)
  end
end
