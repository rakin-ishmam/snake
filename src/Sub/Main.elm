module Sub.Main exposing (..)

import Msg.Main as Msg exposing (Msg)
import Sub.Board as SBoard
import Model.Main exposing (Model)


sub : Model -> Sub Msg
sub m =
    Sub.batch
        [ Sub.map Msg.Board SBoard.sub
        ]
