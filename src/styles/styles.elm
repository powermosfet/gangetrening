module Styles.Styles exposing (..)

import Css exposing (..)
import Css.Elements exposing (div, body, li)
import Styles.Colors as Color
import Styles.Classes as Class


css =
    stylesheet
        [ body
            [ backgroundColor Color.background
            ]
        , (.) Class.PassphrasePanel
            [ children
                [ div
                    [ backgroundColor Color.panel
                    , border zero
                    ]
                ]
            ]
        , (.) Class.PassphraseText
            [ color Color.background
            ]
        , (.) Class.PassphraseListItem
            [ listStyle none
            ]
        , (.) Class.PassphraseInput
            [ color Color.panel
            , paddingTop <| Css.rem 0.3
            , paddingBottom <| Css.rem 0.3
            , paddingLeft <| Css.rem 1
            , paddingRight <| Css.rem 1
            ]
        , (.) Class.WrongAnswer
            [ backgroundColor Color.error
            ]
        ]
