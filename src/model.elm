module Model exposing (..)

import Maybe exposing (withDefault)
import Message exposing (Msg)
import Commands exposing (createNumbers)


type alias Multiplication =
    ( Int, Int, String )


type alias Model =
    { language : String
    , maxNum : Int
    , history : List Multiplication
    , current : Multiplication
    , wrongAnswer : Bool
    }


init : Maybe Model -> ( Model, Cmd Msg )
init mayModel =
    let
        initModel =
            { language = "en"
            , maxNum = 4
            , history = []
            , current = ( -1, -1, "" )
            , wrongAnswer = False
            }

        model =
            withDefault initModel mayModel
    in
        ( model
        , createNumbers model
        )
