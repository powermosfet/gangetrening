module Translations.Norwegian exposing (..)

import Translations.Types as T


getText : T.Label -> Maybe String
getText label =
    Just <|
        case label of
            T.CurrentLanguage ->
                "Språk: Norsk"

            T.Title ->
                "Gangetrening"

            T.CurrentMaximum ->
                "Bruk tall opp til "

            T.Start ->
                "Start"

            T.MultiplicationSymbol ->
                " · "

            T.Finished ->
                "Du klarte alle! Bra jobba!"

            T.Restart ->
                "Start på nytt"
