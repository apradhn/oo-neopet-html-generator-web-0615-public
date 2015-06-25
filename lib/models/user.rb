class User
  # attrs here
  attr_reader :name
  attr_accessor :neopoints, :items, :neopets
  PET_NAMES = ["Angel", "Baby", "Bailey", "Bandit", "Bella", "Buddy", "Charlie", "Chloe", "Coco", "Daisy", "Lily", "Lucy", "Maggie", "Max", "Molly", "Oliver", "Rocky", "Shadow", "Sophie", "Sunny", "Tiger"]

  # initialize here
  def initialize(name)
      @name = name
      @neopoints = 2500
      @items = []
      @neopets = []
  end

  # other methods here
  def select_pet_name
    PET_NAMES.reject{|name| self.neopets.collect{|n| n.name}.include?(name)}.sample
  end

  def make_file_name_for_index_page
      self.name.gsub(" ", "-").downcase
  end

  def buy_item
    if self.neopoints >= 150
        self.neopoints -= 150
        self.items << Item.new
        "You have purchased a #{self.items.last.type}."
    else
        "Sorry, you do not have enough Neopoints."
    end
  end

  def find_item_by_type(type)
      self.items.find{|item| item.type == type}
  end

  def buy_neopet
    if self.neopoints >= 250
      self.neopoints -= 250
      self.neopets << Neopet.new(select_pet_name)
      "You have purchased a #{self.neopets.last.species} named #{self.neopets.last.name}."
    end
  end

  def find_neopet_by_name(name)
      self.neopets.find{|neopet| neopet.name == name}
  end

  def sell_neopet_by_name(name)
    self.neopoints += 200
    if find_neopet_by_name(name).nil?
      "Sorry, there are no pets named #{name}."
    else
      self.neopets.delete(find_neopet_by_name(name))
      "You have sold #{name}. You now have #{self.neopoints} neopoints."
    end
  end

  def feed_neopet_by_name(name)
    neopet = find_neopet_by_name(name)
    if neopet.happiness < 9
      neopet.happiness += 2
      "After feeding, #{name} is #{neopet.mood}."
    elsif neopet.happiness == 9
      neopet.happiness += 1
      "After feeding, #{name} is #{neopet.mood}."
    else
      "Sorry, feeding was unsuccessful as #{name} is already #{neopet.mood}."
    end
  end

  def give_present(item_type, neopet_name)
    if find_item_by_type(item_type).nil? || find_neopet_by_name(neopet_name).nil?
      "Sorry, an error occurred. Please double check the item type and neopet name."   
    else
      neopet = find_neopet_by_name(neopet_name)
      neopet.items << find_item_by_type(item_type)
      self.items.delete(find_item_by_type(item_type)) 
      neopet.happiness += 5
      neopet.happiness = 10 if neopet.happiness > 10
      "You have given a #{item_type} to #{neopet_name}, who is now #{neopet.mood}."
    end
  end

  def make_index_page
    html = File.read('./views/templates/show_user.html.erb')
    template = ERB.new(html)
    @user = self
    result = template.result(binding)
    File.write("./views/users/#{make_file_name_for_index_page}.html", result)
  end
 
end