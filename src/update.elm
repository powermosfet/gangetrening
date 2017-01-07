port module Update exposing (..)

import Html exposing (Attribute)
import Message exposing (Msg(..))
import Model exposing (Model, isCorrect, Multiplication, GameState(..))
import Commands exposing (createShuffledMultiplications)


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        Start ->
            ( model, createShuffledMultiplications model )

        ChangeLanguage lang ->
            ( { model | language = lang, gameState = NotStarted }, Cmd.none )

        NewMultiplications mults ->
            ( { model | multiplications = mults, gameState = Running }, Cmd.none )

        ChangeMaximum n ->
            ( { model | maximum = n, gameState = NotStarted }
            , Cmd.none
            )

        NewAnswer newAnswer ->
            ( { model | multiplications = updateFirst (changeAnswer newAnswer) model.multiplications }, Cmd.none )

        SubmitAnswer ->
            let
                mults =
                    rotate model.multiplications
                        |> rotateUntil (not << isCorrect)

                gameState =
                    if List.all isCorrect mults then
                        Finished
                    else
                        model.gameState
            in
                ( { model
                    | multiplications = mults
                    , gameState = gameState
                  }
                , Cmd.none
                )


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
