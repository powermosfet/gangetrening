module Routing exposing (..)

import Navigation exposing (Location)
import Translations.Types exposing (Language(..))
import UrlParser exposing (..)


type Route
    = RootRoute
    | SettingsRoute Language Int
    | NotFoundRoute


matchers : Parser (Route -> a) a
matchers =
    oneOf
        [ map RootRoute top
        , map SettingsRoute (lang </> int)
        ]


toUrl : Route -> String
toUrl route =
    let
        parts =
            case route of
                SettingsRoute lang max ->
                    [ lang |> toString |> String.toLower
                    , max |> toString
                    ]

                _ ->
                    []
    in
        ("#" :: parts)
            |> String.join "/"


parseLocation : Location -> Route
parseLocation location =
    case (parseHash matchers location) of
        Just route ->
            route

        Nothing ->
            NotFoundRoute


parseLang : String -> Result String Language
parseLang lang =
    case lang of
        "nor" ->
            Ok Nor

        "eng" ->
            Ok Eng

        _ ->
            Err ("Could not parse language '" ++ lang ++ "'.")


lang : Parser (Language -> a) a
lang =
    custom "LANGUAGE" parseLang
