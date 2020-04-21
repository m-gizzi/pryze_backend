class GamesController < ApplicationController

    def create
        if params[:user]
            user = params[:user]
        else
            user = User.first
        end

        if params[:postal_code] != '' && params[:nonce]
            result = Game.save_card_and_pay(params, user)
        else
            result = Game.create_square_payment(params, user)
        end
        # debugger
        if result["payment"]

            game_attributes = {amount: (params[:amount].to_f / 100), user_id: user[:id], square_payment_id: result["payment"]["id"]}
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
