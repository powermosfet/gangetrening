module Commands exposing (..)

import Random exposing (int, list)
import Message exposing (..)


createNumbers model =
    Random.generate NewNumbers (list 2 (int 0 model.maxNum))
