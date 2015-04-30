class SearchController < ApplicationController
  def index
    query_results = params[:q]
    puts "THIS IS THE RESULT ------------------------- #{query_results}"
    if query_results != nil 
      resp = Typhoeus.get("http://www.omdbapi.com", :params => {:s => query_results})
      json_resp = JSON.parse(resp.body)
      puts json_resp
      
      if json_resp["Response"] == "False"
        @movies = nil
        redirect_to '/search'
      end

      @movies = json_resp
    end
  end

  def movie
    id = params[:id]
    resp = resp = Typhoeus.get("http://www.omdbapi.com", :params => {:i => id})
    json_resp = JSON.parse(resp.body)

    @movie = json_resp
  end
end
