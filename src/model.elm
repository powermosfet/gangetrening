module Model exposing (..)

import Maybe exposing (withDefault)
import Message exposing (Msg)
import Commands exposing (createNumbers)


type alias Model =
    { language : String
    , maxNum : Int
    , numberOne : Int
    , numberTwo : Int
    }


init : Maybe Model -> ( Model, Cmd Msg )
init mayModel =
    let
        initModel =
            { language = "en"
            , maxNum = 4
            , numberOne = 1
            , numberTwo = 1
            }

        model =
            withDefault initModel mayModel
    in
        ( model
        , createNumbers model
        )
