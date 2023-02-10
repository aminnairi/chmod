port module Navigator exposing (copy, vibrate)


port vibrate : () -> Cmd message


port copy : String -> Cmd message
