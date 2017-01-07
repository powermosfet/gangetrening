module Main exposing (main)

import Html
import Message
import Init
import Model
import Update
import View


main =
    Html.program { init = Init.init, view = View.view, update = Update.update, subscriptions = subscriptions }


subscriptions : Model.Model -> Sub Message.Msg
subscriptions model =
    Sub.none
