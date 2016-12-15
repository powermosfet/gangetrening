module Translations.English exposing (..)

import Translations.Types as T


getText : T.Label -> Maybe String
getText label =
    case label of
        T.CurrentLanguage ->
            Just "Language: English"

        T.Title ->
            Just "Multiplication practice"

        T.CurrentMaxnum ->
            Just "Use numbers up to "
