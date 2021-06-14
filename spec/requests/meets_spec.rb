# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Meets', type: :request do
  describe 'GET /meets' do
    before { get '/meets' }

    it 'returns a 200 OK status' do
      expect(response).to have_http_status(:ok)
    end
  end

  describe 'GET /meets/:id' do
    let(:meet) { create(:scheduled_meet) }

    it 'returns a 200 OK status' do
      get "/meets/#{meet.id}"
      expect(response).to have_http_status(:ok)
    end

    it 'returns a 404 Not Found status when not finding a meet' do
      get "/meets/999"
      expect(response).to have_http_status(:not_found)
    end
  end

  describe 'POST /meets' do
    before do
      create(:room)
      create(:user)
    end

    let(:create_params) do
      {
        name: "#{Faker::Company.unique.name} Meet",
        starts_at: '2021-06-14T13:45:30',
        ends_at: '2021-06-14T15:45:30',
        room_id: Room.first.id,
        created_by_id: User.first.id
      }
    end

    it 'returns a 201 Created status' do
      post '/meets', params: create_params
      expect(response).to have_http_status(:created)
    end

    it 'returns a 400 Bad Request status when payload is bad' do
      post '/meets', params: {}
      expect(response).to have_http_status(:bad_request)
    end
  end

  describe 'PATCH /meets/:id' do
    let(:meet) { create(:scheduled_meet) }

    let(:patch_params) do
      {
        name: "#{Faker::Company.unique.name} Meet",
        starts_at: '2021-06-14T13:45:30',
        ends_at: '2021-06-14T13:55:30'
      }
    end

    it 'returns a 200 OK status' do
      patch "/meets/#{meet.id}", params: patch_params
      expect(response).to have_http_status(:ok)
    end

    it 'returns a 400 Bad Request status when payload is bad' do
      patch "/meets/#{meet.id}", params: { name: '' }
      expect(response).to have_http_status(:bad_request)
    end

    it 'returns a 404 Not Found status when not finding a meet' do
      patch "/meets/999", params: patch_params
      expect(response).to have_http_status(:not_found)
    end
  end

  describe 'POST /meets/:meet_id/cancel' do
    let(:meet) { create(:scheduled_meet) }

    it 'returns a 200 OK status' do
      post "/meets/#{meet.id}/cancel"
      expect(response).to have_http_status(:ok)
    end

    it 'returns a 404 Not Found status when not finding a meet' do
      post '/meets/999/cancel'
      expect(response).to have_http_status(:not_found)
    end
  end

  describe 'DELETE /meets/:id' do
    let(:meet) { create(:scheduled_meet) }

    it 'returns a 200 OK status' do
      delete "/meets/#{meet.id}"
      expect(response).to have_http_status(:ok)
    end

    it 'returns a 404 Not Found status when not finding a meet' do
      delete '/meets/999'
      expect(response).to have_http_status(:not_found)
    end
  end
end
