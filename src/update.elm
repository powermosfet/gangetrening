port module Update exposing (..)

import Html exposing (Attribute)
import Html.Events exposing (on, keyCode)
import Message exposing (Msg(..))
import Model exposing (Model)
import Commands exposing (createNumbers)
import Platform.Cmd as Cmd exposing (batch)


port setStorage : Model -> Cmd msg


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        CreateNumbers ->
            ( model, createNumbers model )

        ChangeLanguage lang ->
            ( { model | language = lang }, Cmd.none )

        NewNumbers (a :: b :: rest) ->
            ( { model | numberOne = a, numberTwo = b }, Cmd.none )

        NewNumbers _ ->
            ( model, Cmd.none )

        ChangeMaxNum n ->
            ( { model | maxNum = n }, Cmd.none )

        NewInput c ->
            ( model, Cmd.none )
