class App < Sinatra::Application
  use IndexController
  use MessagesController
end
