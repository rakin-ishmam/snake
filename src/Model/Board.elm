module Model.Board exposing (..)

import Data.Const as Const
import Data.Board as Board
import Service.Board as SBoard
import Service.Snake as SSnake
import Msg.Main as Msg
import Data.Snake as Snake


type alias Model =
    { board : Board.Board
    , snake : Snake.Snake
    }


init : Model
init =
    { board = SBoard.findBoard Const.strBoard
    , snake = SSnake.findSnake Const.strBoard
    }


updateSnakeDir : Const.Direction -> Model -> Model
updateSnakeDir dir m =
    if m.snake.dir == (opositeDir dir) then
        m
    else
        let
            snk =
                Snake.updateDir m.snake dir
        in
            { m | snake = snk }


opositeDir : Const.Direction -> Const.Direction
opositeDir dir =
    case dir of
        Const.Up ->
            Const.Down

        Const.Down ->
            Const.Up

        Const.Left ->
            Const.Right

        Const.Right ->
            Const.Left
