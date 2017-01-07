module Translations.English exposing (..)

import Translations.Types as T


getText : T.Label -> String
getText label =
    case label of
        T.CurrentLanguage ->
            "Language: English"

        T.Title ->
            "Multiplication practice"

        T.CurrentMaximum ->
            "Use numbers up to "

        T.Start ->
            "Start"

        T.MultiplicationSymbol ->
            " · "

        T.Finished ->
            "You made it! Well done!"

        T.Restart ->
            "Restart"
