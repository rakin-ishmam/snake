module Data.Snake exposing (Snake, init, addHead, hasBody, addTail, forward, updateDir)

import Data.Const as Const
import Data.Pos as Pos
import Data.LinkedList as LinkedList
import Array


type alias Snake =
    { body : LinkedList.List Pos.Pos
    , dir : Const.Direction
    }


init : Snake
init =
    { body = LinkedList.init
    , dir = Const.Left
    }


updateDir : Snake -> Const.Direction -> Snake
updateDir s dir =
    { s | dir = dir }


addHead : Snake -> Pos.Pos -> Snake
addHead snake pos =
    { snake | body = LinkedList.addLeft pos snake.body }


addTail : Snake -> Pos.Pos -> Snake
addTail snake pos =
    { snake | body = LinkedList.addRight pos snake.body }


hasBody : Pos.Pos -> Snake -> Bool
hasBody p s =
    let
        flt =
            \pos -> Pos.equal pos p

        findP =
            LinkedList.find flt s.body
    in
        case findP of
            Nothing ->
                False

            Just v ->
                True


forward : Snake -> Snake
forward s =
    let
        head =
            LinkedList.leftMost s.body
    in
        case head of
            Nothing ->
                s

            Just pos ->
                let
                    nbody =
                        LinkedList.moveLeft s.body

                    nhead =
                        Pos.forward s.dir pos
                in
                    addHead { s | body = nbody } nhead
