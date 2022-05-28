require 'rails_helper'

RSpec.describe "Transactions", type: :request do
  # initialize test data
  let!(:transactions) { create_list(:transaction, 10) }
  let(:transaction_id) { transactions.first.id }

  # Test suite for GET /transactions
  describe 'GET /transactions' do
    # make HTTP get request before each example
    before { get '/transactions' }

    it 'returns transactions' do
      # Note `json` is a custom helper to parse JSON responses
      expect(json).not_to be_empty
      expect(json.size).to eq(10)
    end

    it 'returns status code 200' do
      expect(response).to have_http_status(200)
    end
  end

  # Test suite for GET /transactions/:id
  describe 'GET /transactions/:id' do
    before { get "/transactions/#{transaction_id}" }

    context 'when the record exists' do
      it 'returns the todo' do
        expect(json).not_to be_empty
        expect(json['id']).to eq(transaction_id)
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end
    end

    context 'when the record does not exist' do
      let(:transaction_id) { 100 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find Transaction/)
      end
    end
  end

  # Test suite for POST /transactions
  describe 'POST /transactions' do
    # valid payload
    let(:valid_attributes) { { :transaction => { :created_by_id => 44, :input_amount_currency => 'EUr', :input_amount => 1000,
      :output_amount_currency => 'nGN', :output_amount => 700000, :date_of_transaction => DateTime.now() } } }
    
      # invalid payload
    let(:invalid_attributes) { { :transaction => { :input_amount_currency => 'DKR' } } }

    context 'when the request is valid' do
      before { post '/transactions', params: valid_attributes }

      it 'creates a transaction' do
        expect(json['input_amount_currency']).to eq('eur')
        expect(json['input_amount']).to eq(1000)
        expect(json['output_amount_currency']).to eq('ngn')
        expect(json['output_amount']).to eq(700000)
      end

      it 'returns status code 201' do
        expect(response).to have_http_status(201)
      end
    end

    context 'when the request is invalid' do
      before { post '/transactions', params: invalid_attributes }

      it 'returns status code 422' do
        expect(response).to have_http_status(422)
      end

      it 'returns a validation failure message' do
        expect(response.body)
          .to match(/Validation failed: Created by can't be blank, Input amount can't be blank, Output amount currency can't be blank, Output amount can't be blank, Date of transaction can't be blank/)
      end
    end
  end
end
