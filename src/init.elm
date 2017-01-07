module Init exposing (init)

import Message exposing (Msg)
import Model exposing (..)
import Translations.Types exposing (Language(Eng))
import Commands exposing (createShuffledMultiplications)


init : ( Model, Cmd Msg )
init =
    ( { language = Eng
      , maximum = 4
      , multiplications = []
      , gameState = NotStarted
      }
    , Cmd.none
    )
