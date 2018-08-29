# frozen_string_literal: true

class Idea < ApplicationRecord
  belongs_to :user

  validates_presence_of :content, :ease, :confidence, :impact

  validates_numericality_of :ease, :confidence, :impact,
                            greater_than_or_equal_to: 0,
                            less_than_or_equal_to: 10
end
