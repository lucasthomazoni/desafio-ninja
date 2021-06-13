# frozen_string_literal: true

class MeetsController < ApplicationController
  before_action :set_meet, except: %i[index create]

  def index
    render_json_api(serializer: MeetSerializer, body: Meet.scheduled)
  end

  def show
    render_json_api(serializer: MeetSerializer, body: @meet)
  end

  def create
    @meet = Meet.new(create_params)

    status = if @meet.save
               :created
             else
               :bad_request
             end

    render_json_api(serializer: MeetSerializer, status: status, body: @meet)
  end

  def update
    status = if @meet.update(update_params)
               :ok
             else
               :bad_request
             end

    render_json_api(serializer: MeetSerializer, status: status, body: @meet)
  end

  def destroy
    if @meet.destroy
      body = []
      status = :ok
    else
      body = @meet
      status = :bad_request
    end

    render_json_api(serializer: MeetSerializer, status: status, body: body)
  end

  def cancel
    status = if @meet.cancel!
               :ok
             else
               :bad_request
             end

    render_json_api(serializer: MeetSerializer, status: status, body: @meet)
  end

  private

  def create_params
    params.permit(
      :name,
      :room_id,
      :created_by_id,
      :starts_at,
      :ends_at
    )
  end

  def update_params
    params.permit(:name)
  end

  def set_meet
    id = params[:id] || params[:meet_id]
    @meet = Meet.find(id)
  rescue ActiveRecord::RecordNotFound
    render json: [], status: :not_found and return
  end
end
