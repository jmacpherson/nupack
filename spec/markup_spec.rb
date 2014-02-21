require "spec_helper"
require_relative "../nupack_job"
require_relative "../markup_calculator"

describe NuPackJob do
  let(:job) { NuPackJob.new(1299.99, 3, "food") }
  let(:subject) { job }

  it { should respond_to(:basecost)}
  it { should respond_to(:personnel) }
  it { should respond_to(:products) }

  its(:basecost) { should be(1299.99) }
  its(:personnel) { should be(3) }
  its(:products) { should include("food") }
  its("products.length") { should be(1) }

  describe "with more than one product" do
    let(:job) { NuPackJob.new(1299.99, 3, "food", "pharmaceuticals") }
    let(:subject) { job }

    its("products.length") { should be(2) }
    its(:products) { should include("pharmaceuticals") }
  end
end

describe MarkupCalculator do
  let(:nujob) { NuPackJob.new(1299.99, 3, "food", "pharmaceuticals") }
  let(:calculator) { MarkupCalculator.new(nujob) }
  let(:subject) { calculator }

  it { should respond_to(:job) }
  it { should respond_to(:personnel_markup) }
  it { should respond_to(:additional_markup) }
  it { should respond_to(:product_markup) }
  it { should respond_to(:final_cost) }

  its(:flat_markup) { should be(0.05) }
  its(:personnel_markup) { should be(0.036)}
  its(:product_markup) { should be(0.205)}
  its(:additional_markup) { should be(0.241) }
  its(:final_cost) { should eq("$1693.95") }

  describe "example1" do
    let(:nujob) { NuPackJob.new(1299.99, 3, "food") }
    let(:calculator) { MarkupCalculator.new(nujob) }
    let(:subject) { calculator }

    its(:final_cost) { should eq("$1591.58")}
  end

  describe "example2" do
    let(:nujob) { NuPackJob.new(5432.00, 1, "drugs") }
    let(:calculator) { MarkupCalculator.new(nujob) }
    let(:subject) { calculator }

    its(:additional_markup) { should be(0.087) }
    its(:final_cost) { should eq("$6199.81")}
  end

  describe "example3" do
    let(:nujob) { NuPackJob.new(12456.95, 4, "books") }
    let(:calculator) { MarkupCalculator.new(nujob) }
    let(:subject) { calculator }

    its(:additional_markup) { should be(0.048)}
    its(:final_cost) { should eq("$13707.63")}
  end
end