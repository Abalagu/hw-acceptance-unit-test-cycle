describe MoviesController, type: :controller do
    
    context 'create' do
        it 'should call the model method that creates a movie' do
            new_movie =  double(title: "Gurren Lagann", rating: "R", description: "Anime", release_date: "1987-05-15", director: "Bob")
            post :create, movie: {title: new_movie.title}
            expect(flash[:notice]).to eq("#{new_movie.title} was successfully created.")
            expect(response).to redirect_to(movies_path)
        end
        it 'should call the model method that creates a movie' do
            new_movie =  double(title: "Steins Gate", rating: "PG", description: "Anime", release_date: "1974-05-25", director: "")
            post :create, movie: {title: new_movie.title}
            expect(flash[:notice]).to eq("#{new_movie.title} was successfully created.")
            expect(response).to redirect_to(movies_path)
        end
    end
    
    context 'index' do
        it 'should call the model method index' do
            get :index
            expect(response.status).to eq(200)
        end
        
        it 'should call the model method index and sort by title' do
            Movie.create!(title: "Gurren Lagann", director: "Bob", rating: "R")
            get :index, :sort => 'title'
            controller.params[:sort].should_not be_nil
            controller.params[:sort].should eql 'title'
        end
        
        it 'should call the model method index and sort by release date' do
            Movie.create(title: "Gurren Lagann", director: "Bob", release_date: "1987-05-15")
            get :index, :sort => 'release_date'
            controller.params[:sort].should_not be_nil
            controller.params[:sort].should eql 'release_date'
        end
    end
    
    context 'edit' do
        it 'should call the model method edit' do
            my_movie = Movie.create(title: "Gurren Lagann", director: "Bob")
            get  :edit, {id: "1"}
            expect(Movie.find("1")).to eq(my_movie)
            
        end
    end
    
    context 'show' do
        it 'should call the model method show' do
            my_movie1 = Movie.create(title: "Gurren Lagann", director: "Bob")
            my_movie2 = Movie.create(title: "Steins Gate", director: "")
            get  :show, {id: "2"}
            expect(Movie.find("2")).to eq(my_movie2)
        end
    end
    
    context 'movie has no director' do
        it 'should call the model method same_director' do
            my_movie = Movie.create(title: "Gurren Lagann")
            get  :same_director, {id: "1"}
            expect(flash[:notice]).to eq("'#{my_movie.title}' Has No Director Info")
            expect(response).to redirect_to(movies_path)
        end
    end
    
end