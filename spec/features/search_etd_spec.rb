require 'rails_helper'

RSpec.feature 'Search for an ETD' do
  let(:title) { ['Journey to Skull Island'] }
  let(:creator) { ['Quest, Jane'] }
  let(:keyword) { ['Pirates', 'Adventure'] }
  let(:visibility) { Hydra::AccessControls::AccessRight::VISIBILITY_TEXT_VALUE_PUBLIC }
  let(:degree) { ["Master of Pirate Studies"] }
  let :etd do
    Etd.new(
      title: title,
      creator: creator,
      keyword: keyword,
      visibility: visibility,
      degree: degree
    )
  end

  context 'general search' do
    before do
      etd.save
    end
    scenario "Search for an ETD" do
      visit("/")
      fill_in "q", with: "Journey"
      click_button "Go"
      # Uncomment this to display the HTML capybara is seeing
      # puts page.body
      expect(page).to have_content etd.title.first
      expect(page).to have_content etd.creator.first
      expect(page).to have_content etd.keyword.first
      expect(page).to have_content etd.degree.first
      expect(page).to have_xpath("//h3", text: "Creator")
      expect(page).to have_link(etd.creator.first, class: "facet_select")
      expect(page).to have_xpath("//h3", text: "Degree")
      expect(page).to have_link(etd.degree.first, class: "facet_select")
    end
  end
end
