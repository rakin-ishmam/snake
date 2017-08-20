module Update.Board exposing (..)

import Msg.Board as Msg exposing (Msg)
import Model.Board as Model exposing (Model)
import Data.Snake as Snake
import Data.Const as Const
import Data.Board as Board exposing (Board)
import Data.Pos as Pos exposing (Pos)


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        Msg.Tick time ->
            updateSnake model

        Msg.Direction dir ->
            ( Model.updateSnakeDir dir model, Cmd.none )

        Msg.NoOp ->
            ( model, Cmd.none )

        Msg.Reload ->
            ( Model.init, Cmd.none )


updateSnake : Model -> ( Model, Cmd Msg )
updateSnake m =
    if not (Snake.isAlive m.snake) then
        ( m, Cmd.none )
    else
        case (Snake.nextHeadPos m.snake) of
            Nothing ->
                ( m, Cmd.none )

            Just pos ->
                if (isBlockedPos pos m.board) || (Snake.hasBody pos m.snake) then
                    ( { m | snake = Snake.die m.snake }, Cmd.none )
                else
                    ( { m | snake = Snake.forward m.snake }, Cmd.none )


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
