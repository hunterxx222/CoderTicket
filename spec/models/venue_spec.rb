require 'rails_helper'

describe Venue do

  before(:each) { @venue = Venue.new(name: 'Hoa Binh') }

  subject { @venue }

  it { should respond_to(:name) }
  it { should respond_to(:id) }

  it "doesn't save if name is not unique" do
    expect(@venue.save).to be true

    @venue2 = Venue.new(name: 'Hoa Binh')
    expect(@venue2.save).to be false
  end
end
