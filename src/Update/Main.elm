module Update.Main exposing (update)

import Model.Main as Model exposing (Model)
import Msg.Main as Msg exposing (Msg)
import Msg.Board as BMsg
import Update.Board as UBoard


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        Msg.NoOp ->
            ( model, Cmd.none )

        Msg.Board bmsg ->
            updateBoard bmsg model


updateBoard : BMsg.Msg -> Model -> ( Model, Cmd Msg )
updateBoard msg model =
    let
        ( bmodel, bmsg ) =
            UBoard.update msg model.board
    in
        ( { model | board = bmodel }, Cmd.map Msg.Board bmsg )
