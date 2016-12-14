module Dictionary exposing (..)


type Dictionary
    = Nrk
    | ProgrammingBooks


getUrl : Dictionary -> String
getUrl dict =
    case dict of
        Nrk ->
            "nrk.json"

        ProgrammingBooks ->
            "programmingbooks.json"
