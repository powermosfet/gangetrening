module Message exposing (Msg(..))

import Model exposing (Multiplication)
import Translations.Types exposing (Language)
import Navigation exposing (Location)


type Msg
    = ChangeLocation Location
    | NewMultiplications (List Multiplication)
    | NewAnswer String
    | SubmitAnswer
    | Start
