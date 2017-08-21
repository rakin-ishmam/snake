module Update.Board exposing (..)

import Msg.Board as Msg exposing (Msg)
import Model.Board as Model exposing (Model)
import Data.Snake as Snake
import Data.Const as Const
import Data.Board as Board exposing (Board)
import Data.Pos as Pos exposing (Pos)
import Data.Food as Food


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case (Debug.log "test" msg) of
        Msg.Tick time ->
            updateSnake <| Model.newFood model

        Msg.Direction dir ->
            ( Model.updateSnakeDir dir model, Cmd.none )

        Msg.NoOp ->
            ( model, Cmd.none )

        Msg.Reload ->
            ( Model.init, Cmd.none )

        Msg.RandFood v ->
            ( { model | food = Food.getFood model.board model.snake v }, Cmd.none )


updateSnake : ( Model, Cmd Msg ) -> ( Model, Cmd Msg )
updateSnake ( m, cmd ) =
    if not (Snake.isAlive m.snake) then
        ( m, cmd )
    else
        case (Snake.nextHeadPos m.snake) of
            Nothing ->
                ( m, cmd )

            Just pos ->
                if (isBlockedPos pos m.board) || (Snake.hasBody pos m.snake) then
                    ( { m | snake = Snake.die m.snake }, cmd )
                else if (Model.hasFood pos m) then
                    ( { m | snake = Snake.addHead m.snake pos, food = Food.eat }, cmd )
                else
                    ( { m | snake = Snake.forward m.snake }, cmd )


isBlockedPos : Pos -> Board -> Bool
isBlockedPos p b =
    case (Board.findCell p b) of
        Nothing ->
            True

        Just cell ->
            case cell.cellType of
                Const.Empty ->
                    False

                Const.Block ->
                    True

                _ ->
                    False
