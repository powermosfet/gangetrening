module View exposing (view)

import Html exposing (Html, h1, label, button, div, text, input, ul, li, form)
import Html.Attributes exposing (attribute, for, type_, value, checked)
import Html.Attributes as H exposing (min, max)
import Html.Events exposing (onClick, onInput, onSubmit)
import Message exposing (Msg(..))
import Model exposing (Multiplication, Model)
import Internationalization
import Translations.Types exposing (..)
import Html.CssHelpers as Hlp
import Styles.Styles as Styles
import Styles.Classes as Cls
import Navbar


{ id, class, classList } =
    Hlp.withNamespace ""


view : Model -> Html Msg
view model =
    let
        t =
            Internationalization.getText model.language
    in
        div []
            [ Navbar.navbar model
            , form
                [ class [ Cls.PassphrasePanel ]
                , onSubmit SubmitAnswer
                ]
                [ div [ class [ "panel", "panel-default", "col-md-12" ] ]
                    [ div [ class [ "panel-body" ] ]
                        [ ul [] <| List.map oldNumber (List.reverse model.history) ++ [ currentNumbers model ]
                        ]
                    ]
                ]
            ]


numberLi : List (Html Msg) -> Html Msg
numberLi content =
    li [ class [ Cls.PassphraseListItem ] ]
        [ h1 [ class [ Cls.PassphraseText ] ]
            content
        ]


oldNumber : Multiplication -> Html Msg
oldNumber ( f1, f2, answer ) =
    numberLi
        [ text <| toString f1
        , text " · "
        , text <| toString f2
        , text " = "
        , text answer
        ]


currentNumbers : Model -> Html Msg
currentNumbers model =
    let
        ( f1, f2, answer ) =
            model.current
    in
        numberLi
            [ text <| toString f1
            , text " · "
            , text <| toString f2
            , text " = "
            , input
                [ class <| inputCssClasses model.wrongAnswer
                , value answer
                , onInput NewAnswer
                ]
                []
            ]


inputCssClasses wrongAnswer =
    if wrongAnswer then
        [ Cls.PassphraseInput, Cls.WrongAnswer ]
    else
        [ Cls.PassphraseInput ]
