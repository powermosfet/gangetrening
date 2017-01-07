module Commands exposing (createShuffledMultiplications)

import Random exposing (generate)
import Random.List exposing (shuffle)
import Model exposing (Model, Multiplication)
import Message exposing (..)


createShuffledMultiplications : Model -> Cmd Msg
createShuffledMultiplications model =
    generate NewMultiplications (createMultiplications model.maximum |> shuffle)


createMultiplications : Int -> List Multiplication
createMultiplications maximum =
    List.range 1 maximum
        |> List.map createMultsforN
        |> List.concat


createMultsforN : Int -> List Multiplication
createMultsforN n =
    List.range 1 10
        |> List.map
            (\m -> ( n, m, "" ))
