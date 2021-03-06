require "rails_helper"

RSpec.describe "Favorites index can see applied for pets", type: :feature do
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
      image_3 = "https://dl5zpyw5k3jeb.cloudfront.net/photos/pets/47475338/2/?bust=1586831049&width=720"
      image_4 = "https://www.iamcasper.com/wp-content/uploads/2018/03/Torbie-Ragdoll-1030x790.png"

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
        status: true)
      @pet_3 = Pet.create!(image: image_3,
        name: "Ruby",
        approximate_age: 0,
        sex: "Female",
        shelter_id: "#{@shelter_2.id}",
        description: "This flat-coated retriever mix is your best friend on walks and is perfect for families with kids",
        status: true)
      @pet_4 = Pet.create!(image: image_4,
        name: "Pierce Brosnan",
        approximate_age: 7,
        sex: "Male",
        shelter_id: "#{@shelter_2.id}",
        description: "This ragdoll mix is a fluffy and friendly addition to your household",
        status: true)
    end

    it "can see pets that have been applied for" do
      visit "/pets/#{@pet_1.id}"
      click_button("Favorite This Pet!")

      visit "/pets/#{@pet_2.id}"
      click_button("Favorite This Pet!")

      visit "/pets/#{@pet_3.id}"
      click_button("Favorite This Pet!")

      click_link "My Favorites"
      click_link "Adopt from Favorited Pets!"

      within "#apply-pet-#{@pet_1.id}" do
        check("Adopt Me!")
        click_button("Save changes")
      end

      within "#apply-pet-#{@pet_2.id}" do
        check("Adopt Me!")
        click_button("Save changes")
      end

      fill_in :name, with: "Second Person"
      fill_in :address, with: "96 There St"
      fill_in :city, with: "CityPlace"
      fill_in :state, with: "StateLocation"
      fill_in :zip, with: 88888
      fill_in :phone_number, with: "(555)555-5555"
      fill_in :description, with: "Person from Favorites Index Test"

      click_button "Submit My Application"

      visit "/favorites"
      within "#applied-for-pets" do
        expect(page).to have_content(@pet_2.name)
        expect(page).to have_link(@pet_2.name)
        expect(page).to have_content(@pet_1.name)
        expect(page).to have_link(@pet_1.name)
        expect(page).to_not have_content(@pet_3.name)
      end

      within "#favorited-pets" do
        expect(page).to have_content(@pet_3.name)
        expect(page).to have_link(@pet_3.name)
        expect(page).to_not have_content(@pet_1.name)
        expect(page).to_not have_content(@pet_2.name)
      end
    end
  end
end
