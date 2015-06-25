class Neopet
  # attrs here
  attr_reader :name, :species, :strength, :defence, :movement
  attr_accessor :happiness, :items

  # initialize here
  def initialize(name)
      @name = name
      @strength = get_points
      @defence = get_points
      @movement = get_points
      @happiness = get_points
      @species = get_species
      @items = []
  end

  # other methods here
  def get_points
      rand(1..10)
  end

  def get_species
    all_species = []
    Dir.new("./public/img/neopets").each{|neopet| all_species << neopet.split(".jpg").first}
    all_species.reject!{|s| s == "." || s == ".."}
    @species = all_species.sample
  end

  def mood
    if self.happiness >= 1 && self.happiness <= 2
        "depressed"
    elsif self.happiness >= 3 && self.happiness <=4
        "sad"
    elsif self.happiness >= 5 && self.happiness <=6
        "meh"
    elsif self.happiness >= 7 && self.happiness <=8
        "happy"
    elsif self.happiness >=9 && self.happiness <=10
        "ecstatic"
    end
  end

end