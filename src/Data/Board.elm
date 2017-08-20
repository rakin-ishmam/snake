module Data.Board exposing (..)

import Data.Const as Const
import Data.Pos as Pos
import Array


type Next
    = Empty
    | Index Int


type alias Cell =
    { cellType : Const.Cell
    , pos : Pos.Pos
    , left : Next
    , right : Next
    , up : Next
    , down : Next
    }


type alias Board =
    { cells : List Cell
    , dimension : Int
    , len : Int
    }


init : Int -> Int -> List Cell -> Board
init dimension len cells =
    { cells = cells
    , dimension = dimension
    , len = len
    }


colorCell : Board -> List Const.Color
colorCell board =
    List.map cellToColor board.cells


cellToColor : Cell -> Const.Color
cellToColor c =
    case c.cellType of
        Const.Block ->
            Const.Blue

        _ ->
            Const.Black


findCell : Pos.Pos -> Board -> Maybe Cell
findCell pos b =
    let
        match =
            \p -> Pos.equal p.pos pos

        res =
            List.filter match b.cells

        ar =
            Array.fromList res
    in
        Array.get 0 ar
