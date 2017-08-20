module View.Main exposing (..)

import Model.Main as Model
import Msg.Main as Msg
import Html exposing (Html, div, text)
import Bootstrap.Grid as Grid
import Bootstrap.Grid.Row as Row
import Bootstrap.Grid.Col as Col
import Style
import Html.Attributes as Attributes
import View.Board as VBoard


testStyle : List Style.Style
testStyle =
    [ Style.width (Style.px 2)
    , Style.height (Style.px 2)
    , Style.backgroundColor "RED"
    ]


view : Model.Model -> Html Msg.Msg
view model =
    Grid.container []
        [ Grid.row []
            [ Grid.col [ Col.md4 ]
                [ text "Snake Game" ]
            , Grid.col [ Col.md12 ]
                [ Html.map Msg.Board (VBoard.view model.board)
                ]
            ]
        ]
