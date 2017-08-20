module Data.Snake
    exposing
        ( Snake
        , init
        , addHead
        , hasBody
        , addTail
        , forward
        , updateDir
        , nextHeadPos
        , die
        , isAlive
        )

import Data.Const as Const
import Data.Pos as Pos exposing (Pos)
import Data.LinkedList as LinkedList


type alias Snake =
    { body : LinkedList.List Pos.Pos
    , dir : Const.Direction
    , status : Status
    }


type Status
    = Live
    | Die


init : Snake
init =
    { body = LinkedList.init
    , dir = Const.Left
    , status = Live
    }


die : Snake -> Snake
die s =
    { s | status = Die }


isAlive : Snake -> Bool
isAlive s =
    case s.status of
        Live ->
            True

        Die ->
            False


headPos : Snake -> Maybe Pos
headPos s =
    LinkedList.leftMost s.body


nextHeadPos : Snake -> Maybe Pos
nextHeadPos s =
    let
        hpos =
            headPos s
    in
        case hpos of
            Nothing ->
                Nothing

            Just p ->
                Just <| Pos.forward s.dir p


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
        nhead =
            nextHeadPos s
    in
        case nhead of
            Nothing ->
                s

            Just pos ->
                let
                    nbody =
                        LinkedList.moveLeft s.body
                in
                    addHead { s | body = nbody } pos
