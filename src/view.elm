module View exposing (view)

import Html exposing (Html, h1, button, div, text, input, form, node)
import Html.Attributes exposing (class, value, href)
import Html.Events exposing (onClick, onInput, onSubmit)
import Message as M
import Model exposing (Model, GameState(..))
import Internationalization
import Translations.Types as T
import Html.CssHelpers as Hlp
import Css
import Styles.Styles as S
import Styles.Classes as Cls
import Styles.Constants
import Navbar
import ScoreRing


helpers =
    Hlp.withNamespace Styles.Constants.gangetrening


class_ =
    helpers.class


view : Model -> Html M.Msg
view model =
    let
        t =
            Internationalization.getText model.language
    in
        div []
            [ node "style" [] [ Css.compile [ S.css ] |> .css |> text ]
            , Navbar.navbar model
            , div
                [ class_ [ Cls.PassphrasePanel ]
                ]
                [ div [ class "panel panel-default col-md-12" ]
                    [ div [ class_ [ Cls.PanelBody ] ]
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
                    button [ class_ [ Cls.TextButton ], onClick M.Start ] [ text (t T.Start) ]

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
                                    [ class_ [ Cls.AnswerInput ]
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
                        , button [ class_ [ Cls.TextButton ], onClick M.Start ] [ text (t T.Restart) ]
                        ]
    in
        div [ class_ [ Cls.RingContent ] ]
            [ h1 [ class_ [ Cls.PassphraseText ] ] [ innerContent ] ]
