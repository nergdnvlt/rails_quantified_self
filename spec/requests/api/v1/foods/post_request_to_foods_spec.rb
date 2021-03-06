require 'rails_helper'

describe 'a get request to foods#index' do
  describe 'when processed correctly' do
    it 'posts a new food to JSON' do
      post "/api/v1/foods", params: { "food": { "name": "apricot", "calories": "88"} }

      expect(response).to be_successful

      apricot_response = JSON.parse(response.body)

      expect(apricot_response).to be_a Hash
      expect(apricot_response["name"]).to eq("apricot")
      expect(apricot_response["calories"]).to eq(88)
    end
  end

  describe 'when not processed correctly' do
    it 'gives 404 response code when name is missing' do
      post "/api/v1/foods", params: { "food": { "calories": "88" } }

      expect(response).to_not be_successful
      expect(response.status).to eq(404)
    end
  end

  describe 'when not processed correctly' do
    it 'gives 404 response code when calories are missing' do
      post "/api/v1/foods", params: { "food": { "name": "jerky" } }

      expect(response).to_not be_successful
      expect(response.status).to eq(404)
    end
  end
end
