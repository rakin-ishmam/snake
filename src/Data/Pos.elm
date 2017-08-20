module Data.Pos exposing (..)

import Data.Const as Const


type alias Pos =
    { row : Int
    , column : Int
    }


empty : Pos
empty =
    { row = 0
    , column = 0
    }


equal : Pos -> Pos -> Bool
equal x y =
    x.row == y.row && x.column == y.column


forward : Const.Direction -> Pos -> Pos
forward dir pos =
    case dir of
        Const.Up ->
            { pos | row = (pos.row - 1) }

        Const.Down ->
            { pos | row = (pos.row + 1) }

        Const.Left ->
            { pos | column = (pos.column - 1) }

        Const.Right ->
            { pos | column = (pos.column + 1) }
