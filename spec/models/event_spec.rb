require 'rails_helper'

describe Event do

  before(:each) { @event = Event.new(name: 'Test Event') }

  subject { @event }

  it { should respond_to(:name) }

  it "doesn't save if required fields are blank" do
    expect(@event.save).to be false
  end

  it "saves successfully when required fields are filled" do
    @event.extended_html_description = 'This is a test description'
    @event.venue = Venue.new
    @event.category = Category.new
    @event.starts_at = Time.now

    expect(@event.save).to be true
  end

end
