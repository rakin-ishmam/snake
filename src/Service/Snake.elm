module Service.Snake exposing (findSnake)

import Data.Snake as Snake
import Data.Const as Const
import Array


findSnake : List String -> Snake.Snake
findSnake rows =
    let
        s =
            Snake.init

        len =
            findLength rows
    in
        rowsToSnake 0 rows s


rowsToSnake : Int -> List String -> Snake.Snake -> Snake.Snake
rowsToSnake row strs snake =
    case strs of
        [] ->
            snake

        col :: cols ->
            rowsToSnake (row + 1) cols <| colsToSnake row 0 (String.toList col) snake



-- rowFold : Int -> String -> Snake ->
-- rowToSnake : Int -> String -> Snake.Snake -> Snake.


colsToSnake : Int -> Int -> List Char -> Snake.Snake -> Snake.Snake
colsToSnake row col str snake =
    case str of
        [] ->
            snake

        c :: cs ->
            if (isSnakeBody c) then
                let
                    s =
                        Snake.addTail snake { row = row, column = col }
                in
                    colsToSnake row (col + 1) cs s
            else
                colsToSnake row (col + 1) cs snake


isSnakeBody : Char -> Bool
isSnakeBody c =
    case c of
        'h' ->
            True

        'b' ->
            True

        _ ->
            False


findLength : List String -> Int
findLength list =
    case Array.get 0 <| Array.fromList list of
        Just val ->
            String.length val

        Nothing ->
            0
