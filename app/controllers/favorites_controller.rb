class FavoritesController < ApplicationController
  include ActionView::Helpers::TextHelper

  def index
  end

  def update
    pet = Pet.find(params[:pet_id])
    favorites.add_pet(pet.id)
    session[:favorite] = favorites.contents
    quantity = favorites.count
    flash[:add_favorite] = "This pet was added to My Favorites. You now have #{pluralize(quantity, "favorite")}"
    redirect_to "/pets/#{pet.id}"
  end

  def destroy
    pet = Pet.find(params[:pet_id])
    favorites.remove_pet(pet.id)
    session[:favorite] = favorites.contents
    quantity = favorites.count
    flash[:remove_favorite] = "This pet was removed from My Favorites. You now have #{pluralize(quantity, "favorite")}"
    redirect_to request.referer
  end

  def remove_all
    favorites.contents.clear
    redirect_to request.referer
  end
end
