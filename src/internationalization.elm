module Internationalization exposing (..)

import Maybe exposing (withDefault)
import Translations.Types exposing (..)
import Translations.Norwegian as Nor
import Translations.English as Eng


textGetter : Language -> (Label -> Maybe String)
textGetter lang =
    case lang of
        Nor ->
            Nor.getText

        Eng ->
            Just << Eng.getText


getText : Language -> Label -> String
getText lang label =
    let
        local =
            textGetter lang

        english =
            Eng.getText
    in
        local label
            |> withDefault
                (english label)
