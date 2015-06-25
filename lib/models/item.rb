class Item
  # attrs here
  attr_reader :type

  # initialize here
  def initialize
      @type = get_type
  end

  # other methods here
  def get_type
      types = []
      Dir.new("./public/img/items").each{|item|types << item.split(".jpg").first}
      types.reject!{|item| item == "." || item == ".."}
      @type = types.sample
  end

  def format_type
      @type = self.type.gsub("_", " ").capitalize
  end

  def formatted_type
    self.type
  end
end