module Init exposing (init)

import Message exposing (Msg)
import Model exposing (..)
import Translations.Types exposing (Language(Eng))
import Commands exposing (createShuffledMultiplications)
import Routing exposing (Route(..), parseLocation)
import Navigation exposing (Location)


init : Location -> ( Model, Cmd Msg )
init loc =
    let
        route =
            parseLocation loc

        ( lang, max ) =
            case route of
                SettingsRoute lang max ->
                    ( lang, max )

                _ ->
                    ( Eng, 4 )
    in
        ( { language = lang
          , maximum = max
          , multiplications = []
          , gameState = NotStarted
          }
        , Cmd.none
        )
