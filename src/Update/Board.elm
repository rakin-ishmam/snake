module Update.Board exposing (..)

import Msg.Board as Msg exposing (Msg)
import Model.Board as Model exposing (Model)
import Data.Snake as Snake


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case (Debug.log "v" msg) of
        Msg.Tick time ->
            ( { model | snake = Snake.forward model.snake }, Cmd.none )

        Msg.Direction dir ->
            ( Model.updateSnakeDir dir model, Cmd.none )

        Msg.NoOp ->
            ( model, Cmd.none )

        Msg.Reload ->
            ( Model.init, Cmd.none )
