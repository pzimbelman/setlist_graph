Rails.application.routes.draw do
  root :to => redirect('http://www.peterzimbelman.com')
  post "/graph", to: "graphql#execute"
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
