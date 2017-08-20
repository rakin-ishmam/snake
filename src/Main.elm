module Main exposing (..)

import Model.Main as Model
import Msg.Main as Msg
import View.Main as View
import Update.Main as Update
import Html exposing (program)
import Sub.Main exposing (sub)


main : Program Never Model.Model Msg.Msg
main =
    program
        { init = Model.init
        , view = View.view
        , update = Update.update
        , subscriptions = sub
        }
