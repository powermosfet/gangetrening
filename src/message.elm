module Message exposing (Msg(..))


type Msg
    = CreateNumbers
    | ChangeLanguage String
    | NewNumbers (List Int)
    | NewInput Char
    | ChangeMaxNum Int
    | NewAnswer String
    | SubmitAnswer
