describe MoviesController, type: :controller do
    
    describe 'create' do
        it 'should call the model method that creates a movie' do
            new_movie =  double(title: "A Movie", rating: "R", description: "Documentary", release_date: "1987-05-15", director: "Me")
            post :create, movie: {title: new_movie.title}
            expect(flash[:notice]).to eq("#{new_movie.title} was successfully created.")
            expect(response).to redirect_to(movies_path)
        end
        it 'should call the model method that creates a movie' do
            new_movie =  double(title: "Another Movie", rating: "PG", description: "Action", release_date: "1999-01-01", director: "Another Me")
            post :create, movie: {title: new_movie.title}
            expect(flash[:notice]).to eq("#{new_movie.title} was successfully created.")
            expect(response).to redirect_to(movies_path)
        end
    end
    
    describe 'index' do
        it 'should call the model method index' do
            get :index
            expect(response.status).to eq(200)
        end
        
        it 'should call the model method index and sort by title' do
            get :index, :sort => 'title'
            controller.params[:sort].should_not be_nil
            controller.params[:sort].should eql 'title'
        end
        
        it 'should call the model method index and sort by release date' do
            get :index, :sort => 'release_date'
            controller.params[:sort].should_not be_nil
            controller.params[:sort].should eql 'release_date'
        end
    end
    
    describe 'edit' do
        it 'should call the model method edit' do
            my_movie = Movie.create(title: "New Movie", director: "Bob")
            get  :edit, {id: "1"}
            expect(Movie.find("1")).to eq(my_movie)
            
        end
    end
    
    describe 'show' do
        it 'should call the model method show' do
            my_movie1 = Movie.create(title: "Movie 234", director: "Andrew")
            my_movie2 = Movie.create(title: "Ape", director: "")
            get  :show, {id: "2"}
            expect(Movie.find("2")).to eq(my_movie2)
        end
    end
    
    describe 'movie has no director' do
        it 'should call the model method same_director' do
            my_movie = Movie.create(title: "Movie 456")
            get  :same_director, {id: "1"}
            expect(flash[:notice]).to eq("Director of movie #{my_movie.title} was unspecified.")
            expect(response).to redirect_to(movies_path)
        end
    end
    
end