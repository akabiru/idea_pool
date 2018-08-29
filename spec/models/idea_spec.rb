# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Idea, type: :model do
  it { should belong_to(:user) }
  it { should validate_presence_of(:content) }

  it do
    should validate_numericality_of(:confidence)
      .is_greater_than_or_equal_to(0)
      .is_less_than_or_equal_to(10)
  end

  it do
    should validate_numericality_of(:ease)
      .is_greater_than_or_equal_to(0)
      .is_less_than_or_equal_to(10)
  end

  it do
    should validate_numericality_of(:impact)
      .is_greater_than_or_equal_to(0)
      .is_less_than_or_equal_to(10)
  end
end
