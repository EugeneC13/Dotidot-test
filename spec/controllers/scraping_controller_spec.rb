require 'rails_helper'

RSpec.describe ScrapingController, type: :controller do
  describe 'GET #fetch_data' do
    let(:url) { "https://www.alza.cz/aeg-7000-prosteam-lfr73964cc-d7635493.htm" }
    let(:valid_fields) { 
      {
        "price": ".price-box__price",
        "rating_count": ".ratingCount",
        "rating_value": ".ratingValue"
      }
    } 
    let(:valid_fields_with_meta) { 
      {
        "price": ".price-box__price",
        "rating_count": ".ratingCount",
        "rating_value": ".ratingValue",
        "meta": ["keywords", "twitter:image"]
      }
    }
    let(:invalid_fields) { 
      {
        "price": ".price-box__price",
        "rating_count": ".ratingCount"
      }
    }

    context 'when user request with valid params' do

      it 'returns success response with valid field' do

        get :fetch_data, params: { url: url, fields: valid_fields }

        json_response = JSON.parse(response.body)
        expected_response = {
                              "price": "18290,-",
                              "rating_value": "4,9",
                              "rating_count": "7 hodnocení"
                            }

        expect(response).to have_http_status(:success)
        expect(json_response).to eq(json_response)
      end

      it 'returns success response with valid field include meta' do

        get :fetch_data, params: { url: url, fields: valid_fields_with_meta }

        json_response = JSON.parse(response.body)
        expected_response = {
                              "price": "18290,-",
                              "rating_value": "4,9",
                              "rating_count": "7 hodnocení",
                              "meta": {
                                        "keywords": "AEG,7000,ProSteam®,LFR73964CC,Automatické pračky,Automatické pračky AEG,Chytré pračky,Chytré pračky AEG",
                                        "twitter:image": "https://image.alza.cz/products/AEGPR065/AEGPR065.jpg?width=360&height=360"
                                      }
                            }

        expect(response).to have_http_status(:success)
        expect(json_response).to eq(json_response)
      end
    end

    context 'when user request with invalid params' do
      it 'with empty url' do

        get :fetch_data, params: { url: url, fields: invalid_fields }

        expect(response).to have_http_status(:bad_request)
      end

      it 'with invalid fields' do

        get :fetch_data, params: { url: nil, fields: invalid_fields }

        expect(response).to have_http_status(:bad_request)
      end
    end
  end
end