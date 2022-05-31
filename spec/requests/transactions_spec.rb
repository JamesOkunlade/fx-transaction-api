# frozen_string_literal: true

require "rails_helper"

RSpec.describe("Transactions", type: :request) do
  # initialize test data
  let!(:transactions) { create_list(:transaction, 10) }
  let(:transaction_id) { transactions.first.id }

  # Test suite for GET /transactions
  describe "GET /transactions" do
    # make HTTP get request before each example
    before { get "/transactions" }

    it "returns transactions" do
      # Note `json` is a custom helper to parse JSON responses
      expect(json).not_to(be_empty)
      expect(json.size).to(eq(10))
    end

    it "returns status code 200" do
      expect(response).to(have_http_status(200))
    end
  end

  # Test suite for GET /transactions/:id
  describe "GET /transactions/:id" do
    before { get "/transactions/#{transaction_id}" }

    context "when the record exists" do
      it "returns the a transaction" do
        expect(json).not_to(be_empty)
        expect(json["id"]).to(eq(transaction_id))
      end

      it "returns status code 200" do
        expect(response).to(have_http_status(200))
      end
    end

    context "when the record does not exist" do
      let(:transaction_id) { 100 }

      it "returns status code 404" do
        expect(response).to(have_http_status(404))
      end

      it "returns a not found message" do
        expect(response.body).to(match(/Couldn't find Transaction/))
      end
    end
  end

  # Test suite for POST /transactions
  describe "POST /transactions" do
    # valid payload
    let(:valid_attributes) do
      { transaction: { created_by_id: 44, input_amount_currency: "EUr", input_amount_cents: 1000_00,
                       output_amount_currency: "nGN", output_amount_cents: 700000_00, date_of_transaction: Time.now, } }
    end

    # invalid payload
    let(:invalid_attributes) { { transaction: { input_amount_currency: "DKR", input_amount_cents: -40 } } }

    context "when the request is valid" do
      before { post "/transactions", params: valid_attributes }

      it "creates a transaction" do
        expect(json["input_amount_currency"]).to(eq("eur"))
        expect(json["input_amount_cents"]).to(eq(1000_00))
        expect(json["output_amount_currency"]).to(eq("ngn"))
        expect(json["output_amount_cents"]).to(eq(700000_00))
      end

      it "returns status code 201" do
        expect(response).to(have_http_status(201))
      end
    end

    context "when the request is invalid" do
      before { post "/transactions", params: invalid_attributes }

      it "returns status code 422" do
        expect(response).to(have_http_status(422))
      end

      it "returns a validation failure message" do
        expect(response.body)
          .to(match(/Validation failed: Created by can't be blank, Output amount currency can't be blank, Output amount cents can't be blank, Date of transaction can't be blank, Input amount cents must be greater than 0, Output amount cents is not a number/))
      end
    end
  end

  describe "PUT /transactions<:id>" do
    let(:valid_attributes) { { transaction: { input_amount_currency: "cAD"} } }
    let(:invalid_attributes) { { transaction: { input_amount_cents: -40} } }

    context "when record exists" do
      before { put "/transactions/#{transaction_id}", params: valid_attributes }

      it "updated the record" do
        expect(response.body).to be_empty
      end

      it "should return a status 204" do
        expect(response).to(have_http_status(204))
      end

      context "when attribute is invalid" do
        before { put "/transactions/#{transaction_id}", params: invalid_attributes }
        
        it "shoult return a status code 422" do
          expect(response).to(have_http_status(422))
        end
      end
    end
  end
end
