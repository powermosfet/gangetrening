module View exposing (view)

import Html exposing (Html, h1, a, div, text, input, form)
import Html.Attributes exposing (value, href)
import Html.Events exposing (onClick, onInput, onSubmit)
import Message as M
import Model exposing (Model, GameState(..))
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
                    a [ onClick M.Start ] [ text (t T.Start) ]

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
                        , a [ onClick M.Start ] [ text (t T.Restart) ]
                        ]
    in
        div [ class [ Cls.RingContent ] ]
            [ h1 [ class [ Cls.PassphraseText ] ] [ innerContent ] ]
