module View exposing (view)

import Html exposing (Html, h1, label, button, div, text, input)
import Html.Attributes exposing (attribute, for, type_, value, checked)
import Html.Attributes as H exposing (min, max)
import Html.Events exposing (onClick, onInput)
import Message exposing (Msg(..))
import Model exposing (Model)
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
            , div [ class [ Cls.PassphrasePanel ] ]
                [ div [ class [ "panel", "panel-default", "col-md-12" ] ]
                    [ div [ class [ "panel-body" ] ]
                        [ h1 [ class [ Cls.PassphraseText ] ]
                            [ text <| toString model.numberOne
                            , text " · "
                            , text <| toString model.numberTwo
                            ]
                        ]
                    ]
                ]
            ]
