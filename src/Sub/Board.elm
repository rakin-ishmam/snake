module Sub.Board exposing (..)

import Msg.Board as Msg exposing (Msg)
import Time
import Keyboard
import Data.Const as Const


sub : Sub Msg
sub =
    Sub.batch
        [ Keyboard.downs toMsg
        , Time.every Time.second Msg.Tick
        ]


toMsg : Keyboard.KeyCode -> Msg
toMsg x =
    case x of
        37 ->
            Msg.Direction Const.Left

        38 ->
            Msg.Direction Const.Up

        39 ->
            Msg.Direction Const.Right

        40 ->
            Msg.Direction Const.Down

        _ ->
            Msg.NoOp
