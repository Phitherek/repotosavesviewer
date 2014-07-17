require 'sinatra/base'
require 'haml'
require 'yaml'

class RepotoSavesViewer < Sinatra::Base
    set :haml, :format => :html5
    get "/" do
        if File.exists?("config.yml")
            @config = YAML.load_file("config.yml")
        else
            @config = {}
        end
        haml :index
    end
    get "/:key" do
        if File.exists?("config.yml")
            @config = YAML.load_file("config.yml")
        else
            @config = {}
        end
        if @config[params[:key].to_sym].nil?
            halt 404, "Configuration for this key not found"
        else
            @savefile = YAML.load_file(@config[params[:key].to_sym][:path])
            haml :show
        end
    end
    run! if app_file == $0
end
