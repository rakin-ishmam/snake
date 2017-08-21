module Data.Food exposing (..)

import Data.Pos as Pos exposing (Pos)
import Data.Board as Board exposing (Board)
import Data.Snake as Snake exposing (Snake)
import Random
import Data.Const as Const
import Array


type Food
    = Empty
    | Where Pos


ithCell : Board -> Snake -> Random.Generator Int
ithCell b s =
    Random.int 1 <|
        (-) (Board.countEmptyCell b) <|
            Snake.length s


init : Food
init =
    Empty


getFood : Board -> Snake -> Int -> Food
getFood b s ithCell =
    let
        cells =
            List.filter (emptyCell s) b.cells
    in
        case Array.get ithCell (Array.fromList cells) of
            Nothing ->
                Empty

            Just c ->
                Where c.pos


emptyCell : Snake -> Board.Cell -> Bool
emptyCell s c =
    case c.cellType of
        Const.Empty ->
            not <| Snake.hasBody c.pos s

        _ ->
            False


eat : Food
eat =
    Empty


hasFood : Food -> Pos -> Bool
hasFood f p =
    case f of
        Empty ->
            False

        Where pos ->
            Pos.equal pos p
