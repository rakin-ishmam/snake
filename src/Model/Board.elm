module Model.Board exposing (..)

import Data.Const as Const
import Data.Board as Board exposing (Board)
import Service.Board as SBoard
import Service.Snake as SSnake
import Msg.Board as Msg exposing (Msg)
import Data.Snake as Snake exposing (Snake)
import Data.Food as Food
import Data.Pos as Pos exposing (Pos)
import Random


type alias Model =
    { board : Board
    , snake : Snake
    , food : Food.Food
    }


init : Model
init =
    { board = SBoard.findBoard Const.strBoard
    , snake = SSnake.findSnake Const.strBoard
    , food = Food.init
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


hasFood : Pos -> Model -> Bool
hasFood p m =
    Food.hasFood m.food p


newFood : Model -> ( Model, Cmd Msg )
newFood m =
    case m.food of
        Food.Empty ->
            ( m, (Random.generate Msg.RandFood <| Food.ithCell m.board m.snake) )

        _ ->
            ( m, Cmd.none )
