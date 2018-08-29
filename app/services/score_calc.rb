class ScoreCalc
  attr_reader :idea

  def self.avg(idea)
    new(idea).avg
  end

  def initialize(idea)
    @idea = idea
  end

  def avg
    calculate_avg
  end

  private

  def calculate_avg
    args = %i[ease confidence impact].map { |attr| idea.send(attr) }
    args.reduce(:+) / args.size.to_f
  end
end
