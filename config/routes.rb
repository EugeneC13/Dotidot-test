Rails.application.routes.draw do
  get '/data', to: 'scraping#fetch_data'
end
