# frozen_string_literal: true

Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  scope module: :v1, constraints: ApiVersion.new("v1", true) do
    resources :transactions, only: [:create, :index, :show, :update]
  end
end
