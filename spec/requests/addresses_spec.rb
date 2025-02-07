require 'rails_helper'

RSpec.describe "Addresses", type: :request do
  let(:admin_user) { create(:user, :admin_user) }
  let(:regular_user) { create(:user, :regular_user) }
  let(:teacher_user) { create(:user, :teacher_user) }
  let(:speaker_user) { create(:user, :speaker_user) }
  let(:address) { create(:address, addressable: regular_user) }

  describe "POST /create" do
    let(:address) { create(:address, addressable: regular_user) }

    context "when the user is regular user" do
      it "creates new address" do
        sign_in regular_user
        address_params = {
          address: {
            street_address: "123 St",
            city: "City1",
            state: "State1",
            postal_code: "12345",
            save_to_user: true
          }
        }
        expect {
          post "/api/v1/users/#{regular_user.id}/addresses", params: address_params, headers: { 'Authorization': "Bearer #{@auth_token}" }
        }.to change(Address, :count).by(1)
        expect(response).to have_http_status(:created)
      end
    end

    context "when the user is admin user" do
      it "can create new address for user" do
        sign_in admin_user
        address_params = {
          address: {
            street_address: "123 St",
            city: "City1",
            state: "State1",
            postal_code: "12345",
            save_to_user: true
          }
        }

        expect {
          post "/api/v1/users/#{admin_user.id}/addresses", params: address_params, headers: { 'Authorization': "Bearer #{@auth_token}" }
        }.to change(Address, :count).by(1)
        expect(response).to have_http_status(:created)
      end
    end

    context "when the user is teacher_user" do
      it "can create new address for teacher user" do
        sign_in teacher_user
        address_params = {
          address: {
            street_address: "123 St",
            city: "City1",
            state: "State1",
            postal_code: "12345",
            save_to_user: true
          }
        }

        expect {
          post "/api/v1/users/#{teacher_user.id}/addresses", params: address_params, headers: { 'Authorization': "Bearer #{@auth_token}" }
        }.to change(Address, :count).by(1)
        expect(response).to have_http_status(:created)
      end
    end

    context "when the user is speaker user" do
      it "can create new address for speaker user" do
        sign_in speaker_user
        address_params = {
          address: {
            street_address: "123 St",
            city: "City1",
            state: "State1",
            postal_code: "12345",
            save_to_user: true
          }
        }

        expect {
          post "/api/v1/users/#{speaker_user.id}/addresses", params: address_params, headers: { 'Authorization': "Bearer #{@auth_token}" }
        }.to change(Address, :count).by(1)
        expect(response).to have_http_status(:created)
      end
    end
  end

  describe "PUT /update" do
    let(:address) { create(:address, addressable: regular_user) }
    let(:updated_address_params) {
      { address: {
        street_address: "456 St",
        city: "City1",
        state: "State1",
        postal_code: "12345",
        save_to_user: true
      } }
    }

    context "when the user is regular user" do
      it "can update their own address" do
        sign_in regular_user
        put "/api/v1/users/#{regular_user.id}/addresses/#{address.id}", params: updated_address_params, headers: { 'Authorization': "Bearer #{@auth_token}" }
        expect(response).to have_http_status(:ok)
      end
    end

    context "when the user is admin user" do
      it "can update an address" do
        sign_in admin_user
        put "/api/v1/users/#{regular_user.id}/addresses/#{address.id}", params: updated_address_params, headers: { 'Authorization': "Bearer #{@auth_token}" }
        expect(response).to have_http_status(:ok)
      end
    end

    context "when the user is teacher user" do
      it "can update an address" do
        sign_in teacher_user
        put "/api/v1/users/#{regular_user.id}/addresses/#{address.id}", params: updated_address_params, headers: { 'Authorization': "Bearer #{@auth_token}" }
        expect(response).to have_http_status(:ok)
      end
    end

    context "when the user is speaker user" do
      it "can update an address" do
        sign_in speaker_user
        put "/api/v1/users/#{regular_user.id}/addresses/#{address.id}", params: updated_address_params, headers: { 'Authorization': "Bearer #{@auth_token}" }
        expect(response).to have_http_status(:ok)
      end
    end
  end

  describe "DELETE /destroy" do
    let!(:address) { create(:address, addressable: regular_user) }

    context "when the user is regular user" do
      it "can delete their own address" do
        sign_in regular_user
        expect {
          delete "/api/v1/users/#{regular_user.id}/addresses/#{address.id}", headers: { 'Authorization': "Bearer #{@auth_token}" }
        }.to change(Address, :count).by(-1)
        expect(response).to have_http_status(:no_content)
      end
    end

    context "when the user is admin user" do
      it "can delete any address" do
        sign_in admin_user
        expect {
          delete "/api/v1/users/#{regular_user.id}/addresses/#{address.id}", headers: { 'Authorization': "Bearer #{@auth_token}" }
        }.to change(Address, :count).by(-1)
        expect(response).to have_http_status(:no_content)
      end
    end

    context "when the user is teacher user" do
      it "can delete an address" do
        sign_in teacher_user
        expect {
          delete "/api/v1/users/#{regular_user.id}/addresses/#{address.id}", headers: { 'Authorization': "Bearer #{@auth_token}" }
        }.to change(Address, :count).by(-1)
        expect(response).to have_http_status(:no_content)
      end
    end

    context "when the user is speaker user" do
      it "can delete an address" do
        sign_in speaker_user
        expect {
          delete "/api/v1/users/#{regular_user.id}/addresses/#{address.id}", headers: { 'Authorization': "Bearer #{@auth_token}" }
        }.to change(Address, :count).by(-1)
        expect(response).to have_http_status(:no_content)
      end
    end
  end
end
