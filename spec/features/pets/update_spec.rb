require "rails_helper"

RSpec.describe "Pets Update Page", type: :feature do
  describe "As a visitor" do
    before :each do
      @shelter_1 = Shelter.create!(name: "The Humane Society - Denver",
        address: "1 Place St",
        city: "Denver",
        state: "CO",
        zip: "11111")
      @shelter_2 = Shelter.create!(name: "Denver Animal Shelter",
        address: "7 There Blvd",
        city: "Denver",
        state: "CO",
        zip: "22222")

      image_1 = "https://www.101dogbreeds.com/wp-content/uploads/2019/01/Chihuahua-Mixes.jpg"
      image_2 = "https://www.loveyourdog.com/wp-content/uploads/2019/12/Catahoula-Pitbull-Mix-900x500.jpg"
      @image_3 = "https://dl5zpyw5k3jeb.cloudfront.net/photos/pets/47475338/2/?bust=1586831049&width=720"
      @image_4 = "https://www.iamcasper.com/wp-content/uploads/2018/03/Torbie-Ragdoll-1030x790.png"

      @pet_1 = Pet.create!(image: image_1,
        name: "Tinkerbell",
        approximate_age: 3,
        sex: "Female",
        shelter_id: "#{@shelter_1.id}",
        description: "Adorable chihuahua mix with lots of love to give",
        status: true)
      @pet_2 = Pet.create!(image: image_2,
        name: "George",
        approximate_age: 5,
        sex: "Male",
        shelter_id: "#{@shelter_1.id}",
        description: "This pitty mix will melt your heart with his sweet temperament",
        status: false)
      @pet_3 = Pet.create!(image: @image_3,
        name: "Ruby",
        approximate_age: 0,
        sex: "Female",
        shelter_id: "#{@shelter_2.id}",
        description: "This flat-coated retriever mix is your best friend on walks and is perfect for families with kids",
        status: true)
      @pet_4 = Pet.create!(image: @image_4,
        name: "Pierce Brosnan",
        approximate_age: 7,
        sex: "Male",
        shelter_id: "#{@shelter_2.id}",
        description: "This ragdoll mix is a fluffy and friendly addition to your household",
        status: true)
    end

    it "can update pet information and save to database" do
      visit "/pets/#{@pet_4.id}"
      expect(page).to have_link('Update Pet')
      click_link 'Update Pet'
      expect(current_path).to eq("/pets/#{@pet_4.id}/edit")

      expect(find_field(:image).value).to eq "#{@image_4}"
      expect(find_field(:name).value).to eq "Pierce Brosnan"
      expect(find_field(:approximate_age).value).to eq "7"
      expect(find_field(:sex).value).to eq "Male"
      expect(find_field(:description).value).to eq "This ragdoll mix is a fluffy and friendly addition to your household"

      fill_in :approximate_age, with: "8"
      fill_in :description, with: "This ragdoll-mix is a fluffy, friendly, and loyal addition to your household"

      click_button "Submit your Edits"
      # Then a `PATCH` request is sent to '/pets/:id', the pet's data is updated
      save_and_open_page
      expect(current_path).to eq("/pets/#{@pet_4.id}")

      expect(page).to have_content("8")
      expect(page).to have_content("This ragdoll-mix is a fluffy, friendly, and loyal addition to your household")

      # I think that age should be a float, not integer, let's update Ruby for 0.7 age
              # visit "/pets/#{@pet_3.id}"
              # @pet_3 = Pet.create!(image: @image_3,
              #   name: "Ruby",
              #   approximate_age: 0,
              #   sex: "Female",
              #   shelter_id: "#{@shelter_2.id}",
              #   description: "This flat-coated retriever mix is your best friend on walks and is perfect for families with kids",
              #   status: true)
    end

  end
end