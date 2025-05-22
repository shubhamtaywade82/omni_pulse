# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Api::V1::Dhans' do
  describe 'GET /holdings' do
    it 'returns http success' do
      get '/api/v1/dhan/holdings'
      expect(response).to have_http_status(:success)
    end
  end

  describe 'GET /place_order' do
    it 'returns http success' do
      get '/api/v1/dhan/place_order'
      expect(response).to have_http_status(:success)
    end
  end
end
