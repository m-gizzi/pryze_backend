class GamesController < ApplicationController

    def create
        result = Game.create_square_payment(params)
        
        if result["payment"]
            if params[:user]
                user = params[:user][:id]
            else
                user = User.first.id
            end
            game_attributes = {amount: (params[:amount].to_f / 100), user_id: user, square_payment_id: result["payment"]["id"]}
            game = Game.create(game_attributes)
            game.generate_donations

            render json: {game: GameSerializer.new(game)}
        else
            render json: result
        end
    end

    def show
        game = Game.find_by(square_payment_id: params[:id])
        render json: {game: GameSerializer.new(game)}
    end
end
