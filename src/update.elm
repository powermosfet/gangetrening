port module Update exposing (..)

import Html exposing (Attribute)
import Message exposing (Msg(..))
import Model exposing (Model, isCorrect, Multiplication, GameState(..))
import Commands exposing (createShuffledMultiplications)
import Routing exposing (parseLocation)
import Init exposing (init)


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    let
        nop m =
            ( m, Cmd.none )
    in
        case msg of
            ChangeLocation loc ->
                let
                    ( initModel, _ ) =
                        init loc
                in
                    { model
                        | language = initModel.language
                        , maximum = initModel.maximum
                    }
                        |> nop

            Start ->
                ( model, createShuffledMultiplications model )

            ChangeLanguage lang ->
                { model
                    | language = lang
                    , gameState = NotStarted
                }
                    |> nop

            NewMultiplications mults ->
                { model
                    | multiplications = mults
                    , gameState = Running
                }
                    |> nop

            ChangeMaximum n ->
                { model
                    | maximum = n
                    , gameState = NotStarted
                }
                    |> nop

            NewAnswer newAnswer ->
                { model | multiplications = updateFirst (changeAnswer newAnswer) model.multiplications } |> nop

            SubmitAnswer ->
                let
                    mults =
                        rotate model.multiplications
                            |> rotateUntil (not << isCorrect)

                    gameState =
                        model.gameState
                            |> changeIf (List.all isCorrect mults) Finished
                in
                    { model
                        | multiplications = mults
                        , gameState = gameState
                    }
                        |> nop


changeIf : Bool -> a -> a -> a
changeIf test changed original =
    if test then
        changed
    else
        original


rotateUntil : (a -> Bool) -> List a -> List a
rotateUntil f list =
    rotateUntil_ f (List.length list) list


rotateUntil_ : (a -> Bool) -> Int -> List a -> List a
rotateUntil_ f max list =
    case list of
        x :: xs ->
            let
                rotated =
                    rotate list

                done =
                    (max <= 0) || (f x)
            in
                if done then
                    list
                else
                    rotateUntil_ f (max - 1) rotated

        _ ->
            []


rotate : List a -> List a
rotate list =
    case list of
        x :: xs ->
            xs ++ [ x ]

        _ ->
            []


updateFirst : (a -> a) -> List a -> List a
updateFirst f list =
    case list of
        x :: xs ->
            (f x) :: xs

        _ ->
            []


changeAnswer : String -> Multiplication -> Multiplication
changeAnswer ans ( f1, f2, _ ) =
    ( f1, f2, ans )
