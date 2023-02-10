port module Navigator exposing (copy, vibrate)


port vibrate : List Int -> Cmd message


port copy : String -> Cmd message
