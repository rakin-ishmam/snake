module Msg.Board exposing (..)

import Time
import Data.Const exposing (Direction)


type Msg
    = Tick Time.Time
    | Direction Direction
    | NoOp
    | Reload
    | RandFood Int
