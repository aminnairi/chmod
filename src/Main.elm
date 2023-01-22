module Main exposing (main)

import Browser
import Html exposing (Html)
import Html.Attributes
import Html.Events
import String.Extra


type alias Permissions =
    { read : Bool
    , write : Bool
    , execute : Bool
    }


type alias UsersPermissions =
    { owner : Permissions
    , group : Permissions
    , others : Permissions
    }


permissionsToLitteral : Permissions -> String
permissionsToLitteral { read, write, execute } =
    [ ( "r", read ), ( "w", write ), ( "x", execute ) ]
        |> List.map
            (\( permissionLetter, permission ) ->
                if permission then
                    permissionLetter

                else
                    "-"
            )
        |> String.join ""


usersPermissionsToLitteral : UsersPermissions -> String
usersPermissionsToLitteral { owner, group, others } =
    [ owner, group, others ]
        |> List.map permissionsToLitteral
        |> String.join ""


litteralToUsersPermissions : String -> Maybe UsersPermissions
litteralToUsersPermissions litteral =
    litteral
        |> String.Extra.break 3
        |> List.map
            (\permissions ->
                if permissions == "r--" then
                    { read = True
                    , write = False
                    , execute = False
                    }

                else if permissions == "rw-" then
                    { read = True
                    , write = True
                    , execute = False
                    }

                else if permissions == "r-x" then
                    { read = True
                    , write = False
                    , execute = True
                    }

                else if permissions == "rwx" then
                    { read = True
                    , write = True
                    , execute = True
                    }

                else if permissions == "-w-" then
                    { read = False
                    , write = True
                    , execute = False
                    }

                else if permissions == "-wx" then
                    { read = False
                    , write = True
                    , execute = True
                    }

                else if permissions == "--x" then
                    { read = False
                    , write = False
                    , execute = True
                    }

                else
                    { read = False
                    , write = False
                    , execute = False
                    }
            )
        |> (\permissions ->
                case permissions of
                    [ owner, group, others ] ->
                        Just { owner = owner, group = group, others = others }

                    _ ->
                        Nothing
           )


permissionsToOctal : Permissions -> String
permissionsToOctal { read, write, execute } =
    [ ( 4, read ), ( 2, write ), ( 1, execute ) ]
        |> List.map
            (\( permissionValue, permission ) ->
                if permission then
                    permissionValue

                else
                    0
            )
        |> List.sum
        |> String.fromInt


octalToPermissions : String -> Maybe UsersPermissions
octalToPermissions octal =
    if String.length octal /= 3 then
        Nothing

    else
        String.split "" octal
            |> List.map
                (\letter ->
                    if letter == "7" then
                        { read = True
                        , write = True
                        , execute = True
                        }

                    else if letter == "6" then
                        { read = True
                        , write = True
                        , execute = False
                        }

                    else if letter == "5" then
                        { read = True
                        , write = False
                        , execute = True
                        }

                    else if letter == "4" then
                        { read = True
                        , write = False
                        , execute = False
                        }

                    else if letter == "3" then
                        { read = False
                        , write = True
                        , execute = True
                        }

                    else if letter == "2" then
                        { read = False
                        , write = True
                        , execute = False
                        }

                    else if letter == "1" then
                        { read = False
                        , write = False
                        , execute = True
                        }

                    else
                        { read = False
                        , write = False
                        , execute = False
                        }
                )
            |> (\permissions ->
                    case permissions of
                        [ owner, group, others ] ->
                            Just { owner = owner, group = group, others = others }

                        _ ->
                            Nothing
               )


usersPermissionsToOctal : UsersPermissions -> String
usersPermissionsToOctal { owner, group, others } =
    [ owner, group, others ]
        |> List.map permissionsToOctal
        |> String.join ""


type alias Model =
    { permissions : UsersPermissions
    , octal : String
    , litteral : String
    }


initialPermissions : UsersPermissions
initialPermissions =
    { owner =
        { write = False
        , read = False
        , execute = False
        }
    , group =
        { write = False
        , read = False
        , execute = False
        }
    , others =
        { write = False
        , read = False
        , execute = False
        }
    }


init : Model
init =
    { permissions = initialPermissions
    , octal = usersPermissionsToOctal initialPermissions
    , litteral = usersPermissionsToLitteral initialPermissions
    }


type Message
    = UpdateOwnerWritePermission Bool
    | UpdateOwnerReadPermission Bool
    | UpdateOwnerExecutePermission Bool
    | UpdateGroupWritePermission Bool
    | UpdateGroupReadPermission Bool
    | UpdateGroupExecutePermission Bool
    | UpdateOthersWritePermission Bool
    | UpdateOthersReadPermission Bool
    | UpdateOthersExecutePermission Bool
    | UpdateOctalPermissions String
    | UpdateLitteralPermissions String


update : Message -> Model -> Model
update message model =
    case message of
        UpdateOwnerWritePermission newOwnerWritePermission ->
            let
                oldPermissions =
                    model.permissions

                oldOwner =
                    oldPermissions.owner

                newOwner =
                    { oldOwner | write = newOwnerWritePermission }

                newPermissions =
                    { oldPermissions | owner = newOwner }
            in
            { model
                | permissions = newPermissions
                , octal = usersPermissionsToOctal newPermissions
                , litteral = usersPermissionsToLitteral newPermissions
            }

        UpdateOwnerReadPermission newOwnerReadPermission ->
            let
                oldPermissions =
                    model.permissions

                oldOwner =
                    oldPermissions.owner

                newOwner =
                    { oldOwner | read = newOwnerReadPermission }

                newPermissions =
                    { oldPermissions | owner = newOwner }
            in
            { model
                | permissions = newPermissions
                , octal = usersPermissionsToOctal newPermissions
                , litteral = usersPermissionsToLitteral newPermissions
            }

        UpdateOwnerExecutePermission newOwnerExecutePermission ->
            let
                oldPermissions =
                    model.permissions

                oldOwner =
                    oldPermissions.owner

                newOwner =
                    { oldOwner | execute = newOwnerExecutePermission }

                newPermissions =
                    { oldPermissions | owner = newOwner }
            in
            { model
                | permissions = newPermissions
                , octal = usersPermissionsToOctal newPermissions
                , litteral = usersPermissionsToLitteral newPermissions
            }

        UpdateGroupWritePermission newGroupWritePermission ->
            let
                oldPermissions =
                    model.permissions

                oldGroup =
                    oldPermissions.group

                newGroup =
                    { oldGroup | write = newGroupWritePermission }

                newPermissions =
                    { oldPermissions | group = newGroup }
            in
            { model
                | permissions = newPermissions
                , octal = usersPermissionsToOctal newPermissions
                , litteral = usersPermissionsToLitteral newPermissions
            }

        UpdateGroupReadPermission newGroupReadPermission ->
            let
                oldPermissions =
                    model.permissions

                oldGroup =
                    oldPermissions.group

                newGroup =
                    { oldGroup | read = newGroupReadPermission }

                newPermissions =
                    { oldPermissions | group = newGroup }
            in
            { model
                | permissions = newPermissions
                , octal = usersPermissionsToOctal newPermissions
                , litteral = usersPermissionsToLitteral newPermissions
            }

        UpdateGroupExecutePermission newGroupExecutePermission ->
            let
                oldPermissions =
                    model.permissions

                oldGroup =
                    oldPermissions.group

                newGroup =
                    { oldGroup | execute = newGroupExecutePermission }

                newPermissions =
                    { oldPermissions | group = newGroup }
            in
            { model
                | permissions = newPermissions
                , octal = usersPermissionsToOctal newPermissions
                , litteral = usersPermissionsToLitteral newPermissions
            }

        UpdateOthersWritePermission newOthersWritePermission ->
            let
                oldPermissions =
                    model.permissions

                oldOthers =
                    oldPermissions.others

                newOthers =
                    { oldOthers | write = newOthersWritePermission }

                newPermissions =
                    { oldPermissions | others = newOthers }
            in
            { model
                | permissions = newPermissions
                , octal = usersPermissionsToOctal newPermissions
                , litteral = usersPermissionsToLitteral newPermissions
            }

        UpdateOthersReadPermission newOthersReadPermission ->
            let
                oldPermissions =
                    model.permissions

                oldOthers =
                    oldPermissions.others

                newOthers =
                    { oldOthers | read = newOthersReadPermission }

                newPermissions =
                    { oldPermissions | others = newOthers }
            in
            { model
                | permissions = newPermissions
                , octal = usersPermissionsToOctal newPermissions
                , litteral = usersPermissionsToLitteral newPermissions
            }

        UpdateOthersExecutePermission newOthersExecutePermission ->
            let
                oldPermissions =
                    model.permissions

                oldOthers =
                    oldPermissions.others

                newOthers =
                    { oldOthers | execute = newOthersExecutePermission }

                newPermissions =
                    { oldPermissions | others = newOthers }
            in
            { model
                | permissions = newPermissions
                , octal = usersPermissionsToOctal newPermissions
                , litteral = usersPermissionsToLitteral newPermissions
            }

        UpdateOctalPermissions newOctalPermissions ->
            let
                newPermissions =
                    newOctalPermissions
                        |> octalToPermissions
                        |> Maybe.withDefault initialPermissions
            in
            { model
                | octal = newOctalPermissions
                , litteral = usersPermissionsToLitteral newPermissions
                , permissions = newPermissions
            }

        UpdateLitteralPermissions newLitteralPermissions ->
            let
                newPermissions =
                    newLitteralPermissions
                        |> litteralToUsersPermissions
                        |> Maybe.withDefault initialPermissions
            in
            { model
                | octal = usersPermissionsToOctal newPermissions
                , litteral = newLitteralPermissions
                , permissions = newPermissions
            }


view : Model -> Html Message
view model =
    Html.div
        [ Html.Attributes.class "container" ]
        [ Html.h1
            []
            [ Html.text "Chmod" ]
        , Html.hr [ Html.Attributes.class "horizontal-line" ] []
        , Html.h2
            []
            [ Html.text "Permissions" ]
        , Html.h3
            []
            [ Html.text "Owner" ]
        , Html.div
            [ Html.Attributes.class "row" ]
            [ Html.label
                [ Html.Attributes.for "owner-permission-read" ]
                [ Html.text "Read" ]
            , Html.input
                [ Html.Attributes.type_ "checkbox"
                , Html.Attributes.id "owner-permission-read"
                , Html.Attributes.checked model.permissions.owner.read
                , Html.Events.onCheck UpdateOwnerReadPermission
                ]
                []
            , Html.label
                [ Html.Attributes.for "owner-permission-write" ]
                [ Html.text "Write" ]
            , Html.input
                [ Html.Attributes.type_ "checkbox"
                , Html.Attributes.id "owner-permission-write"
                , Html.Attributes.checked model.permissions.owner.write
                , Html.Events.onCheck UpdateOwnerWritePermission
                ]
                []
            , Html.label
                [ Html.Attributes.for "owner-permission-execute" ]
                [ Html.text "Execute" ]
            , Html.input
                [ Html.Attributes.type_ "checkbox"
                , Html.Attributes.id "owner-permission-execute"
                , Html.Attributes.checked model.permissions.owner.execute
                , Html.Events.onCheck UpdateOwnerExecutePermission
                ]
                []
            ]
        , Html.h3
            []
            [ Html.text "Group" ]
        , Html.div
            [ Html.Attributes.class "row" ]
            [ Html.label
                [ Html.Attributes.for "group-permission-read" ]
                [ Html.text "Read" ]
            , Html.input
                [ Html.Attributes.type_ "checkbox"
                , Html.Attributes.id "group-permission-read"
                , Html.Attributes.checked model.permissions.group.read
                , Html.Events.onCheck UpdateGroupReadPermission
                ]
                []
            , Html.label
                [ Html.Attributes.for "group-permission-write" ]
                [ Html.text "Write" ]
            , Html.input
                [ Html.Attributes.type_ "checkbox"
                , Html.Attributes.id "group-permission-write"
                , Html.Attributes.checked model.permissions.group.write
                , Html.Events.onCheck UpdateGroupWritePermission
                ]
                []
            , Html.label
                [ Html.Attributes.for "group-permission-execute" ]
                [ Html.text "Execute" ]
            , Html.input
                [ Html.Attributes.type_ "checkbox"
                , Html.Attributes.id "group-permission-execute"
                , Html.Attributes.checked model.permissions.group.execute
                , Html.Events.onCheck UpdateGroupExecutePermission
                ]
                []
            ]
        , Html.h3
            []
            [ Html.text "Others" ]
        , Html.div
            [ Html.Attributes.class "row" ]
            [ Html.label
                [ Html.Attributes.for "others-permission-read" ]
                [ Html.text "Read" ]
            , Html.input
                [ Html.Attributes.type_ "checkbox"
                , Html.Attributes.id "others-permission-read"
                , Html.Attributes.checked model.permissions.others.read
                , Html.Events.onCheck UpdateOthersReadPermission
                ]
                []
            , Html.label
                [ Html.Attributes.for "others-permission-write" ]
                [ Html.text "Write" ]
            , Html.input
                [ Html.Attributes.type_ "checkbox"
                , Html.Attributes.id "others-permission-write"
                , Html.Attributes.checked model.permissions.others.write
                , Html.Events.onCheck UpdateOthersWritePermission
                ]
                []
            , Html.label
                [ Html.Attributes.for "others-permission-execute" ]
                [ Html.text "Execute" ]
            , Html.input
                [ Html.Attributes.type_ "checkbox"
                , Html.Attributes.id "others-permission-execute"
                , Html.Attributes.checked model.permissions.others.execute
                , Html.Events.onCheck UpdateOthersExecutePermission
                ]
                []
            ]
        , Html.hr [ Html.Attributes.class "horizontal-line" ] []
        , Html.h2
            []
            [ Html.text "Litteral" ]
        , Html.div
            [ Html.Attributes.class "input-with-label" ]
            [ Html.label
                [ Html.Attributes.for "litteral-permissions" ]
                [ Html.text "Value" ]
            , Html.input
                [ Html.Attributes.value model.litteral
                , Html.Events.onInput UpdateLitteralPermissions
                , Html.Attributes.id "litteral-permissions"
                ]
                []
            ]
        , Html.hr [ Html.Attributes.class "horizontal-line" ] []
        , Html.h2
            []
            [ Html.text "Octal" ]
        , Html.div
            [ Html.Attributes.class "input-with-label" ]
            [ Html.label
                [ Html.Attributes.for "octal-permissions" ]
                [ Html.text "Value" ]
            , Html.input
                [ Html.Attributes.value model.octal
                , Html.Events.onInput UpdateOctalPermissions
                , Html.Attributes.id "octal-permissions"
                ]
                []
            ]
        ]


type alias Flags =
    ()


main : Program Flags Model Message
main =
    Browser.sandbox
        { init = init
        , view = view
        , update = update
        }
