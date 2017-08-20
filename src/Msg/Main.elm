module Msg.Main exposing (..)

import Msg.Board as MBoard


type Msg
    = NoOp
    | Board MBoard.Msg
