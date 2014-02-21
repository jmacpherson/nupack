class NuPackJob
  attr_reader :basecost
  attr_reader :personnel
  attr_reader :products

  def initialize(basecost, personnel, *products)
    @basecost = basecost
    @personnel = personnel
    @products = products
  end
end