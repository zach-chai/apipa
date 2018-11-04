require './controllers/base.rb'

class IndexController < Base
  set :views, './views/index'

  get '/' do
    yajl :index
  end
end
