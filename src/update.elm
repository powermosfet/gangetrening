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
            let
                ( oldA, _, _ ) =
                    model.current

                newHistory =
                    if oldA < 0 then
                        model.history
                    else
                        model.current :: model.history
            in
                ( { model | current = ( a, b, "" ), history = newHistory }, Cmd.none )

        NewNumbers _ ->
            ( model, Cmd.none )

        ChangeMaxNum n ->
            ( { model | maxNum = n }, Cmd.none )

        NewInput c ->
            ( model, Cmd.none )

        NewAnswer newAnswer ->
            let
                ( f1, f2, _ ) =
                    model.current

                newCurrent =
                    ( f1, f2, newAnswer )
            in
                ( { model | current = newCurrent }, Cmd.none )

        SubmitAnswer ->
            let
                ( f1, f2, answer ) =
                    model.current
            in
                if toString (f1 * f2) == answer then
                    ( { model | wrongAnswer = False }, createNumbers model )
                else
                    ( { model | wrongAnswer = True }, Cmd.none )
