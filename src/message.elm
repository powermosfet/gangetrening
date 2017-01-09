module Message exposing (Msg(..))

import Model exposing (Multiplication)
import Translations.Types exposing (Language)
import Navigation exposing (Location)


type Msg
    = ChangeLocation Location
    | ChangeLanguage Language
    | NewMultiplications (List Multiplication)
    | ChangeMaximum Int
    | NewAnswer String
    | SubmitAnswer
    | Start
