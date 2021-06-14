# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Meet, type: :model do
  subject(:new_meet) { described_class.new }

  it { should belong_to(:room) }

  it {
    expect(new_meet).to define_enum_for(:status).with_values(
      scheduled: 'scheduled',
      canceled: 'canceled',
      finished: 'finished'
    ).backed_by_column_of_type(:string)
  }

  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:status) }
  it { should validate_presence_of(:starts_at) }
  it { should validate_presence_of(:ends_at) }

  it 'validates starts_at and ends_at correctness' do
    described_class.validates(:ends_at, date: { after: :starts_at })
  end

  it 'validates starts_at time' do
    meet = described_class.new(starts_at: DateTime.now.change(hour: 21))
    meet.valid?
    expect(meet.errors[:starts_at]).to be_present
  end

  it 'validates ends_at time' do
    meet = described_class.new(ends_at: DateTime.now.change(hour: 22))
    meet.valid?
    expect(meet.errors[:ends_at]).to be_present
  end

  context 'having period conflict' do
    before { create(:scheduled_meet) }

    let(:invalid_meet) do
      described_class.create(starts_at: described_class.first.starts_at,
                             ends_at: described_class.first.ends_at + 10.minutes)
    end

    it 'validates meet period conflicts' do
      expect(invalid_meet.errors[:base]).to include(
        "There's been a conflict on your times, please choose another set of times"
      )
    end
  end

  context 'when canceling a meet' do
    let(:meet) { create(:scheduled_meet) }

    before do
      meet.cancel!
    end

    it 'updates the meet status' do
      expect(meet.status).to eq('canceled')
    end

    it 'persists the `canceled_at` attribute' do
      expect(meet.canceled_at).to be_present
    end
  end
end
