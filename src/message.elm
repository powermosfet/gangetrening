module Message exposing (Msg(..))

import Model exposing (Multiplication)
import Translations.Types exposing (Language)


type Msg
    = ChangeLanguage Language
    | NewMultiplications (List Multiplication)
    | ChangeMaximum Int
    | NewAnswer String
    | SubmitAnswer
    | Start
