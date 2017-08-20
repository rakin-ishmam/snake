module Service.Board exposing (findBoard)

import Data.Board as Board
import Array
import Data.Const as Const
import Data.Pos as Pos


findBoard : List String -> Board.Board
findBoard rows =
    let
        len =
            findLength rows

        cells =
            List.concat <|
                List.indexedMap strToCells rows
    in
        Board.init 2 len cells


strToCells : Int -> String -> List Board.Cell
strToCells row str =
    let
        map =
            \col c -> (charToCell c row col 3)
    in
        String.toList str
            |> List.indexedMap map


charToCell : Char -> Int -> Int -> Int -> Board.Cell
charToCell c row column length =
    let
        pos =
            { row = row, column = column }

        cell =
            { cellType = boardCellType c
            , pos = pos
            , left = leftIndex pos length
            , up = upIndex pos length
            , right = rightIndex pos length
            , down = downIndex pos length
            }
    in
        if c == '#' then
            { cell | cellType = Const.Block }
        else
            cell


upIndex : Pos.Pos -> Int -> Board.Next
upIndex pos length =
    case pos.row of
        0 ->
            Board.Empty

        _ ->
            Board.Index <|
                calIndex { pos | row = (pos.row - 1) } length


leftIndex : Pos.Pos -> Int -> Board.Next
leftIndex pos length =
    case pos.column of
        0 ->
            Board.Empty

        _ ->
            Board.Index <|
                calIndex { pos | column = (pos.column - 1) } length


downIndex : Pos.Pos -> Int -> Board.Next
downIndex pos length =
    if pos.row == (length - 1) then
        Board.Empty
    else
        Board.Index <|
            calIndex { pos | row = (pos.row + 1) } length


rightIndex : Pos.Pos -> Int -> Board.Next
rightIndex pos length =
    if pos.column == (length - 1) then
        Board.Empty
    else
        Board.Index <|
            calIndex { pos | column = (pos.column + 1) } length


calIndex : Pos.Pos -> Int -> Int
calIndex pos length =
    (+) pos.column <| (*) pos.row length


boardCellType : Char -> Const.Cell
boardCellType c =
    case c of
        '#' ->
            Const.Block

        _ ->
            Const.Empty


findLength : List String -> Int
findLength list =
    case Array.get 0 <| Array.fromList list of
        Just val ->
            String.length val

        Nothing ->
            0
