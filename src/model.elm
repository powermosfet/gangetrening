module Model exposing (..)

import Translations.Types exposing (Language)


type alias Multiplication =
    ( Int, Int, String )


isCorrect : Multiplication -> Bool
isCorrect ( f1, f2, ans ) =
    toString (f1 * f2) == ans


isWrong : Multiplication -> Bool
isWrong m =
    not (isEmpty m || isCorrect m)


isEmpty : Multiplication -> Bool
isEmpty ( _, _, ans ) =
    String.isEmpty ans


type GameState
    = NotStarted
    | Running
    | Finished


type alias Model =
    { language : Language
    , maximum : Int
    , multiplications : List Multiplication
    , gameState : GameState
    }
