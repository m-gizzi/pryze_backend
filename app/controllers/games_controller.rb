class GamesController < ApplicationController

    def create
        #   All guest games are assigned to the admin account
        if params[:user]
            user = params[:user]
        else
            user = User.first
        end

        #   Will either save and pay or just pay depending on whether
        #   the user finished the save card form
        if params[:postal_code] != '' && params[:nonce]
            result = Game.save_card_and_pay(params, user)
        else
            result = Game.create_square_payment(params, user)
        end

        #   If there are no errors, create the game and donation instances
        if result["payment"]

            game_attributes = {amount: (params[:amount].to_f / 100), user_id: user[:id], square_payment_id: result["payment"]["id"]}
            game = Game.create(game_attributes)
            game.generate_donations

            render json: {game: GameSerializer.new(game)}

        #   Otherwise, send back the error to be displayed
        else
            render json: result
        end
    end

    def show
        game = Game.find_by(square_payment_id: params[:id])
        render json: {game: GameSerializer.new(game)}
    end
end
