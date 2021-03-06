require 'rails_helper'

describe 'a get request to meals#index' do
  describe 'when processed correctly' do
    it 'gives a listing of all meals as JSON' do
      breakfast = Meal.create!(name: 'Breakfast')

      pear = breakfast.foods.create!(name: 'pear', calories: 33)
      peach = breakfast.foods.create!(name: 'peach', calories: 88)

      get "/api/v1/meals/#{breakfast.id}/foods"

      expect(response).to be_successful

      meal = JSON.parse(response.body)

      expect(meal).to be_a Hash

      expect(meal["name"]).to eq("Breakfast")
      expect(meal["foods"]).to be_a Array
      expect(meal["foods"][0]["name"]).to eq("pear")
      expect(meal["foods"][0]["calories"]).to eq(33)
      expect(meal["foods"][1]["name"]).to eq("peach")
      expect(meal["foods"][1]["calories"]).to eq(88)
    end
  end

  describe 'when not found' do
    it 'returns a 404 status code' do
      breakfast = Meal.create!(name: 'Breakfast')
      breakfast.foods.create!(name: 'pear', calories: 33)
      breakfast.foods.create!(name: 'peach', calories: 88)

      get '/api/v1/meals/88/foods'

      expect(response).to_not be_successful
      expect(response.status).to eq(404)
    end
  end
end
