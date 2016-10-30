# spec/views/index.html.erb**_spec.rb**
require 'rails_helper'

RSpec.describe "events/index", type: :view do
  it "renders Discover upcoming events in a header tag" do
    assign(:events, [])
    render

    expect(rendered).to include("Discover upcoming events")
  end

  it "Display an event title" do
    event = Event.create!(name: "Halloween", starts_at: 1.days.ago, ends_at: 1.day.ago, extended_html_description: " a past event",
                          venue: Venue.new, category: Category.new)
    assign(:events, [event])
    render
    expect(rendered).to include('<h4 class="card-title">Halloween</h4>')
  end
end
