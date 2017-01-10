module Styles.Styles exposing (..)

import Css exposing (..)
import Css.Elements exposing (div, body, a)
import Styles.Constants
import Styles.Classes as Class


css =
    let
        circle =
            Styles.Constants.circle

        colors =
            Styles.Constants.colors

        margins =
            Styles.Constants.margins
    in
        stylesheet
            [ a
                [ cursor pointer
                ]
            , body
                [ backgroundColor colors.background
                ]
            , (.) Class.PassphrasePanel
                [ children
                    [ div
                        [ backgroundColor colors.panel
                        , border zero
                        ]
                    ]
                ]
            , (.) Class.PassphraseText
                [ color colors.background
                ]
            , (.) Class.PassphraseListItem
                [ listStyle none
                ]
            , (.) Class.PassphraseInput
                [ color colors.panel
                , paddingTop margins.small
                , paddingBottom margins.small
                , paddingLeft margins.medium
                , paddingRight margins.medium
                ]
            , (.) Class.PanelBody
                [ property "display" "flex"
                , property "justify-content" "center"
                ]
            , (.) Class.WrongAnswer
                [ backgroundColor colors.error
                ]
            , (.) Class.CircleFigure
                [ margin <| Css.rem 5
                , maxWidth <| Css.rem 50
                , flexGrow <| num 1
                ]
            , (.) Class.Circle
                [ property "fill" "transparent"
                , property "stroke-width" (toString circle.stroke)
                ]
            , (.) Class.Wrong
                [ property "stroke" colors.wrong.value
                ]
            , (.) Class.Correct
                [ property "stroke" colors.correct.value
                ]
            , (.) Class.Neutral
                [ property "stroke" colors.neutral.value
                ]
            , (.) Class.RingContent
                [ position absolute
                , property "display" "flex"
                , top zero
                , left zero
                , height <| pct 100
                , width <| pct 100
                , property "justify-content" "center"
                , alignItems center
                , textAlign center
                ]
            , (.) Class.AnswerInput
                [ border3 (px 1) solid colors.background
                , color colors.background
                , backgroundColor transparent
                , width <| Css.rem 10
                , padding margins.small
                ]
            ]
