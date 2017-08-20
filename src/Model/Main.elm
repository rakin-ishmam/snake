module Model.Main exposing (..)

import Msg.Main as Msg
import Model.Board as Board


type alias Model =
    { board : Board.Model }


init : ( Model, Cmd Msg.Msg )
init =
    ( { board = Board.init }, Cmd.none )
