# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Users', type: :request do
  describe 'GET /users' do
    before { get '/users' }

    it 'returns a 200 OK status' do
      expect(response).to have_http_status(:ok)
    end
  end
end
