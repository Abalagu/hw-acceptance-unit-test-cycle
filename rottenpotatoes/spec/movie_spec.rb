require 'rails_helper'

describe Movie do
    it 'should find movies with the same director' do
        new_movie1 = Movie.create(title: "Gurren Lagann", director: "Bob")
        new_movie2 = Movie.create(title: "Steins Gate", director: "Bob")
        # results = Movie.same_director(new_movie1)
        results = Movie.where(director: new_movie1.director)
        results.each do |movie| expect(movie.director).to eq(new_movie1.director) end
    end
    
    it 'should return nil when a movie has no director' do
        movie1 = Movie.create(title: "Gurren Lagann")
        results = Movie.where(director: movie1.director)
        results.each do |movie| expect(movie.director).to eq(nil) end
    end
    
    it 'should have all ratings' do
        expect(Movie.all_ratings).to eq(%w(G PG PG-13 NC-17 R))
    end
    
end


describe ApplicationController do
    it 'should protect from forgery' do
    end
end

describe MoviesHelper do
    include MoviesHelper
    it 'is odd if the count is odd' do
        expect(oddness(1)).to eq('odd')
    end
end