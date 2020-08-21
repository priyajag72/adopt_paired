require 'rails_helper'

RSpec.describe "Shelters New" do
  describe "As a visitor" do
    before :each do
      @shelter_1 = Shelter.create!(name: "The Humane Society - Denver",
        address: "1 Place St",
        city: "Denver",
        state: "CO",
        zip: "11111")
    end

    describe "When I visit a shelter show page then click the link update shelter" do
      it "can edit the shelter form" do
        visit "/shelters/#{@shelter_1.id}"

        expect(page).to have_link('Update Shelter')

        click_link 'Update Shelter'

        expect(current_path).to eq("/shelters/#{@shelter_1.id}/edit")

        expect(find_field(:name).value).to eq "The Humane Society - Denver"
        expect(find_field(:address).value).to eq "1 Place St"
        expect(find_field(:city).value).to eq "Denver"
        expect(find_field(:state).value).to eq "CO"
        expect(find_field(:zip).value).to eq "11111"
      end

      it "can update shelter information after submit" do
        visit "/shelters/#{@shelter_1.id}"
        expect(page).to have_link('Update Shelter')
        click_link 'Update Shelter'
        expect(current_path).to eq("/shelters/#{@shelter_1.id}/edit")

        expect(find_field(:address).value).to eq "1 Place St"
        expect(find_field(:zip).value).to eq "11111"

        fill_in :address, with: "17 There Blvd"
        fill_in :zip, with: "33333"

        click_on "Submit your Edits"
        expect(current_path).to eq("/shelters/#{@shelter_1.id}")

        expect(page).to have_content("17 There Blvd")
        expect(page).to have_content("33333")
      end

      it "can redirect to updated shelter show page"
    end
  end
end
