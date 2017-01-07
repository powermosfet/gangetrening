module ScoreRing exposing (scoreRing)

import Html exposing (Html, nav, h1, label, button, div, span, text, input, a, ul, li, figure)
import Html.Attributes exposing (attribute, for, type_, value, checked, href, style)
import Html.Attributes as H exposing (min, max)
import Html.Events exposing (onClick, onInput)
import Svg exposing (svg, circle)
import Svg.Attributes exposing (r, cx, cy, class, viewBox)
import Message exposing (Msg(..))
import Model exposing (Model, isCorrect, isWrong)
import Internationalization
import Model exposing (Multiplication, GameState(..))
import Translations.Types exposing (..)
import Html.CssHelpers as Hlp
import Styles.Classes as Cls
import Styles.Constants as C


scoreRing : Model -> Html Msg
scoreRing model =
    let
        circleConstants =
            C.circle

        radius =
            16

        count =
            List.length model.multiplications

        viewBoxSize =
            2 * radius + circleConstants.stroke
    in
        figure [ class <| toString Cls.CircleFigure ]
            [ div []
                [ svg
                    [ class "Chart"
                    , viewBox <| spaceList [ 0, 0, viewBoxSize, viewBoxSize ]
                    ]
                    (circles model radius count)
                ]
            ]


circles : Model -> Float -> Int -> List (Html Msg)
circles model radius count =
    case model.gameState of
        Running ->
            model.multiplications
                |> List.reverse
                |> List.foldl (circleFolder radius count) []

        _ ->
            [ makeCircle 1 1 radius Cls.Neutral ]


circleFolder radius count m l =
    let
        cls =
            if isCorrect m then
                Cls.Correct
            else
                (if isWrong m then
                    Cls.Wrong
                 else
                    Cls.Neutral
                )
    in
        (makeCircle (List.length l + 1 |> toFloat) count radius cls) :: l


makeCircle n total radius cls =
    let
        circleConstants =
            C.circle

        circumference =
            2 * pi * radius

        centerOffset =
            radius + (circleConstants.stroke / 2)

        arc =
            circumference / (toFloat total)
    in
        circle
            [ r <| toString radius
            , cx <| toString centerOffset
            , cy <| toString centerOffset
            , style [ ( "stroke-dasharray", commaList [ (n * arc), circumference ] ) ]
            , class ("Circle " ++ (toString cls))
            ]
            []


separatorList : String -> List a -> String
separatorList sep =
    List.map toString >> String.join sep


commaList : List a -> String
commaList =
    separatorList ", "


spaceList : List a -> String
spaceList =
    separatorList " "
