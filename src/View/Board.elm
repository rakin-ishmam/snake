module View.Board exposing (..)

import Model.Board as MBoard
import Data.Board as DBoard
import Data.Snake as DSnake
import Data.Const as Const
import Html exposing (Html, table, tr, td, div, text)
import Html.Attributes as Attributes
import Msg.Board as Msg exposing (Msg)
import Style
import Bootstrap.Grid as Grid
import Bootstrap.Grid.Col as Col
import Bootstrap.Button as Button
import Html.Events as Events


blue : List Style.Style
blue =
    [ Style.backgroundColor "BLUE" ]


black : List Style.Style
black =
    [ Style.backgroundColor "BLACK" ]


red : List Style.Style
red =
    [ Style.backgroundColor "RED" ]


box : List Style.Style
box =
    [ Style.width (Style.px 15)
    , Style.height (Style.px 15)
    , Style.border "1px solid white"
    ]


colorToTd : Const.Color -> Html Msg.Msg
colorToTd c =
    case c of
        Const.Red ->
            td
                [ Attributes.style box
                , Attributes.style red
                ]
                []

        Const.Blue ->
            td
                [ Attributes.style box
                , Attributes.style blue
                ]
                []

        _ ->
            td
                [ Attributes.style box
                , Attributes.style black
                ]
                []


rows : Int -> MBoard.Model -> List (Html Msg.Msg)
rows row model =
    if row >= model.board.len then
        []
    else
        List.concat
            [ [ tr [] (columns row 0 model) ]
            , rows (row + 1) model
            ]


columns : Int -> Int -> MBoard.Model -> List (Html Msg)
columns row column model =
    if column >= model.board.len then
        []
    else
        List.concat
            [ [ colorToTd <| convColor row column model ]
            , columns row (column + 1) model
            ]


convColor : Int -> Int -> MBoard.Model -> Const.Color
convColor row column board =
    let
        pos =
            { row = row, column = column }

        bpos =
            DBoard.findCell pos board.board

        isSnake =
            DSnake.hasBody pos board.snake
    in
        if isSnake then
            Const.Red
        else
            case bpos of
                Just p ->
                    DBoard.cellToColor p

                Nothing ->
                    Const.Black


view : MBoard.Model -> Html Msg
view model =
    let
        colorCell =
            DBoard.colorCell model.board
    in
        Grid.row
            []
            [ Grid.col [ Col.md12 ]
                [ div
                    []
                    [ table
                        []
                        (rows 0 model)
                    ]
                ]
            , Grid.col
                [ Col.md4 ]
                [ Button.button [ Button.primary, Button.attrs [ Events.onClick Msg.Reload ] ] [ text "Reload" ]
                ]
            ]
