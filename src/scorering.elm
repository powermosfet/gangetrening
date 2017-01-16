module ScoreRing exposing (scoreRing)

import Html exposing (Html, div, figure)
import Html.Attributes exposing (style)
import Svg exposing (svg, circle)
import Svg.Attributes exposing (r, cx, cy, class, viewBox)
import Message exposing (Msg(..))
import Model exposing (Model, isCorrect, isWrong)
import Model exposing (GameState(..))
import Styles.Classes as Cls
import Styles.Constants as C
import Html.CssHelpers as Hlp


class_ : List Cls.CssClasses -> Html.Attribute Msg
class_ =
    List.map
        (toString
            >> ((++) C.gangetrening)
        )
        >> String.join " "
        >> class


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
        figure [ class_ [ Cls.CircleFigure ] ]
            [ div []
                [ svg
                    [ viewBox <| spaceList [ 0, 0, viewBoxSize, viewBoxSize ] ]
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

        NotStarted ->
            [ makeCircle 1 1 radius Cls.Neutral ]

        Finished ->
            [ makeCircle 1 1 radius Cls.Correct ]


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
            , class_ [ Cls.Circle, cls ]
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
