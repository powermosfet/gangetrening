module Translations.Norwegian exposing (..)

import Translations.Types as T


getText : T.Label -> Maybe String
getText label =
    case label of
        T.CurrentLanguage ->
            Just "Språk: Norsk"

        T.Title ->
            Just "Gangetrening"

        T.CurrentMaxnum ->
            Just "Bruk tall opp til "
