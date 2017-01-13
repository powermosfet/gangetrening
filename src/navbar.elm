module Navbar exposing (navbar)

import Html exposing (Html, nav, button, div, span, text, a, ul, li)
import Html.Attributes exposing (id, class, attribute, type_, href)
import Html.Events exposing (onClick)
import Message exposing (Msg(..))
import Model exposing (Model)
import Internationalization
import Translations.Types exposing (..)
import Html.CssHelpers as Hlp
import Routing


toUrl lang max =
    Routing.SettingsRoute lang max
        |> Routing.toUrl


navbar : Model -> Html Msg
navbar model =
    let
        t =
            Internationalization.getText model.language
    in
        nav
            [ class "navbar navbar-default" ]
            [ div
                [ class "container-fluid" ]
                [ div
                    [ class "navbar-header" ]
                    [ button
                        [ type_ "button"
                        , class "navbar-toggle collapsed"
                        , attribute "data-toggle" "collapse"
                        , attribute "data-target" "#bs-navbar-collapsible"
                        , attribute "aria-expanded" "false"
                        ]
                        [ span [ class "sr-only" ] [ text "Toggle navigation" ]
                        , span [ class "icon-bar" ] []
                        , span [ class "icon-bar" ] []
                        , span [ class "icon-bar" ] []
                        ]
                    , a
                        [ class "navbar-brand"
                        , href ""
                        ]
                        [ text (t Title) ]
                    ]
                , div
                    [ class "collapse navbar-collapse"
                    , id "bs-navbar-collapsible"
                    ]
                    [ ul
                        [ class "nav navbar-nav navbar-right" ]
                        [ li
                            [ class "dropdown" ]
                            [ a
                                [ href "#"
                                , class "dropdown-toggle"
                                , attribute "data-toggle" "dropdown"
                                , attribute "role" "button"
                                , attribute "aria-haspopup" "true"
                                , attribute "aria-expanded" "false"
                                ]
                                [ text (t CurrentMaximum)
                                , text <| toString model.maximum
                                , span [ class "caret" ] []
                                ]
                            , ul
                                [ class "dropdown-menu" ]
                                [ li []
                                    (List.map (maximumSelector model.language) [ 2, 3, 4, 5, 6, 7, 8, 9, 10 ])
                                ]
                            ]
                        , li
                            [ class "dropdown" ]
                            [ a
                                [ href ""
                                , class "dropdown-toggle"
                                , attribute "data-toggle" "dropdown"
                                , attribute "role" "button"
                                , attribute "aria-haspopup" "true"
                                , attribute "aria-expanded" "false"
                                ]
                                [ text (t CurrentLanguage)
                                , span [ class "caret" ] []
                                ]
                            , ul
                                [ class "dropdown-menu" ]
                                [ li []
                                    [ a [ href (toUrl Nor model.maximum) ] [ text "Norsk" ]
                                    , a [ href (toUrl Eng model.maximum) ] [ text "English" ]
                                    ]
                                ]
                            ]
                        ]
                    ]
                ]
            ]


maximumSelector lang n =
    a [ href (toUrl lang n) ] [ text (toString n) ]
