module View exposing (view)

import Html exposing (Html, h1, a, label, button, div, text, input, ul, li, form)
import Html.Attributes exposing (attribute, for, type_, value, checked, href)
import Html.Attributes as H exposing (min, max)
import Html.Events exposing (onClick, onInput, onSubmit)
import Message as M
import Model exposing (Multiplication, Model, GameState(..))
import Internationalization
import Translations.Types as T
import Html.CssHelpers as Hlp
import Styles.Styles as Styles
import Styles.Classes as Cls
import Navbar
import ScoreRing


{ id, class, classList } =
    Hlp.withNamespace ""


view : Model -> Html M.Msg
view model =
    let
        t =
            Internationalization.getText model.language
    in
        div []
            [ Navbar.navbar model
            , div
                [ class [ Cls.PassphrasePanel ]
                ]
                [ div [ class [ "panel", "panel-default", "col-md-12" ] ]
                    [ div [ class [ Cls.PanelBody ] ]
                        [ ScoreRing.scoreRing model
                        , (ringContent model)
                        ]
                    ]
                ]
            ]


ringContent model =
    let
        t =
            Internationalization.getText model.language

        innerContent =
            case model.gameState of
                NotStarted ->
                    a [ href "#", onClick M.Start ] [ text (t T.Start) ]

                Running ->
                    case model.multiplications of
                        ( f1, f2, ans ) :: _ ->
                            form
                                [ onSubmit M.SubmitAnswer
                                ]
                                [ text <| toString f1
                                , text <| t T.MultiplicationSymbol
                                , text <| toString f2
                                , text " = "
                                , input
                                    [ class [ Cls.AnswerInput ]
                                    , value ans
                                    , onInput M.NewAnswer
                                    ]
                                    []
                                ]

                        _ ->
                            div [] []

                Finished ->
                    div []
                        [ div [] [ text (t T.Finished) ]
                        , a [ href "#", onClick M.Start ] [ text (t T.Restart) ]
                        ]
    in
        div [ class [ Cls.RingContent ] ]
            [ h1 [ class [ Cls.PassphraseText ] ] [ innerContent ] ]


numberLi : List (Html M.Msg) -> Html M.Msg
numberLi content =
    li [ class [ Cls.PassphraseListItem ] ]
        [ h1 [ class [ Cls.PassphraseText ] ]
            content
        ]


oldNumber : Multiplication -> Html M.Msg
oldNumber ( f1, f2, answer ) =
    numberLi
        [ text <| toString f1
        , text " · "
        , text <| toString f2
        , text " = "
        , text answer
        ]



-- currentNumbers : Model -> Html Msg
-- currentNumbers model =
--     let
--         ( f1, f2, answer ) =
--             model.current
--     in
--         numberLi
--             [ text <| toString f1
--             , text " · "
--             , text <| toString f2
--             , text " = "
--             , input
--                 [ class <| inputCssClasses model.wrongAnswer
--                 , value answer
--                 , onInput NewAnswer
--                 , autofocus True
--                 ]
--                 []
--             ]
--


inputCssClasses wrongAnswer =
    if wrongAnswer then
        [ Cls.PassphraseInput, Cls.WrongAnswer ]
    else
        [ Cls.PassphraseInput ]
