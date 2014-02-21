class MarkupCalculator
  attr_reader :job

  @@product_classes = [
    {matchers: [/pharma/,/drug/], markup: 0.075},
    {matchers:[/food/], markup: 0.13},
    {matchers:[/electr/],markup: 0.02}
  ]

  def initialize(job)
    @job = job
  end

  def flat_markup
    0.05
  end

  def personnel_markup
    (0.012 * @job.personnel).round(3)
  end

  def product_markup
    markup = 0
    @job.products.each do |product|
      @@product_classes.each do |product_class|
        product_class[:matchers].each do |matcher|
          if matcher =~ product
            markup += product_class[:markup] 
            break
          end
        end
      end
    end
    markup.round(3)
  end

  def additional_markup
    (personnel_markup + product_markup).round(3)
  end

  def final_cost
    cost = @job.basecost
    cost += cost * flat_markup
    cost += cost * additional_markup
    "$#{sprintf("%.2f",cost)}"
  end
end