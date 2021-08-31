Rails.application.routes.draw do
  #create a nested route - artists HAVE songs - Artists are the PARENT
  #give the song the ability to show the index, show, new and edit paths 
  #if it is not nested, show the songs resource
  resources :artists do 
    resources :songs, only: [:index, :show, :new, :edit]
  end
  resources :songs
end
