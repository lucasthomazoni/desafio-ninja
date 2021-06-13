# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Rooms', type: :request do
  describe 'GET /rooms' do
    before { get '/rooms' }

    it 'returns a 200 OK status' do
      expect(response).to have_http_status(:ok)
    end
  end
end
