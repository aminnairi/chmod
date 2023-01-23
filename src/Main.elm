module Main exposing (main)

import Browser
import Html exposing (Html)
import Html.Attributes
import Html.Events
import Permissions exposing (UsersPermissions)
import Permissions.Litteral
import Permissions.Octal


type alias Model =
    { permissions : UsersPermissions
    , octal : String
    , litteral : String
    }


init : Model
init =
    { permissions = Permissions.initial
    , octal = Permissions.Octal.fromUsersPermissions Permissions.initial
    , litteral = Permissions.Litteral.fromUsersPermissions Permissions.initial
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
        UpdateOwnerReadPermission newOwnerReadPermission ->
            let
                newPermissions : UsersPermissions
                newPermissions =
                    Permissions.updateOwnerReadPermission newOwnerReadPermission model.permissions
            in
            { model
                | permissions = newPermissions
                , octal = Permissions.Octal.fromUsersPermissions newPermissions
                , litteral = Permissions.Litteral.fromUsersPermissions newPermissions
            }

        UpdateOwnerWritePermission newOwnerWritePermission ->
            let
                newPermissions : UsersPermissions
                newPermissions =
                    Permissions.updateOwnerWritePermission newOwnerWritePermission model.permissions
            in
            { model
                | permissions = newPermissions
                , octal = Permissions.Octal.fromUsersPermissions newPermissions
                , litteral = Permissions.Litteral.fromUsersPermissions newPermissions
            }

        UpdateOwnerExecutePermission newOwnerExecutePermission ->
            let
                newPermissions : UsersPermissions
                newPermissions =
                    Permissions.updateOwnerExecutePermission newOwnerExecutePermission model.permissions
            in
            { model
                | permissions = newPermissions
                , octal = Permissions.Octal.fromUsersPermissions newPermissions
                , litteral = Permissions.Litteral.fromUsersPermissions newPermissions
            }

        UpdateGroupReadPermission newGroupReadPermission ->
            let
                newPermissions : UsersPermissions
                newPermissions =
                    Permissions.updateGroupReadPermission newGroupReadPermission model.permissions
            in
            { model
                | permissions = newPermissions
                , octal = Permissions.Octal.fromUsersPermissions newPermissions
                , litteral = Permissions.Litteral.fromUsersPermissions newPermissions
            }

        UpdateGroupWritePermission newGroupWritePermission ->
            let
                newPermissions : UsersPermissions
                newPermissions =
                    Permissions.updateGroupWritePermission newGroupWritePermission model.permissions
            in
            { model
                | permissions = newPermissions
                , octal = Permissions.Octal.fromUsersPermissions newPermissions
                , litteral = Permissions.Litteral.fromUsersPermissions newPermissions
            }

        UpdateGroupExecutePermission newGroupExecutePermission ->
            let
                newPermissions : UsersPermissions
                newPermissions =
                    Permissions.updateGroupExecutePermission newGroupExecutePermission model.permissions
            in
            { model
                | permissions = newPermissions
                , octal = Permissions.Octal.fromUsersPermissions newPermissions
                , litteral = Permissions.Litteral.fromUsersPermissions newPermissions
            }

        UpdateOthersReadPermission newOthersReadPermission ->
            let
                newPermissions : UsersPermissions
                newPermissions =
                    Permissions.updateOthersReadPermission newOthersReadPermission model.permissions
            in
            { model
                | permissions = newPermissions
                , octal = Permissions.Octal.fromUsersPermissions newPermissions
                , litteral = Permissions.Litteral.fromUsersPermissions newPermissions
            }

        UpdateOthersWritePermission newOthersWritePermission ->
            let
                newPermissions : UsersPermissions
                newPermissions =
                    Permissions.updateOthersWritePermission newOthersWritePermission model.permissions
            in
            { model
                | permissions = newPermissions
                , octal = Permissions.Octal.fromUsersPermissions newPermissions
                , litteral = Permissions.Litteral.fromUsersPermissions newPermissions
            }

        UpdateOthersExecutePermission newOthersExecutePermission ->
            let
                newPermissions : UsersPermissions
                newPermissions =
                    Permissions.updateOthersExecutePermission newOthersExecutePermission model.permissions
            in
            { model
                | permissions = newPermissions
                , octal = Permissions.Octal.fromUsersPermissions newPermissions
                , litteral = Permissions.Litteral.fromUsersPermissions newPermissions
            }

        UpdateOctalPermissions newOctalPermissions ->
            let
                newPermissions : UsersPermissions
                newPermissions =
                    Permissions.Octal.toUsersPermissions newOctalPermissions
            in
            { model
                | octal = newOctalPermissions
                , litteral = Permissions.Litteral.fromUsersPermissions newPermissions
                , permissions = newPermissions
            }

        UpdateLitteralPermissions newLitteralPermissions ->
            let
                newLitteralPermissionsToLowerCase : String
                newLitteralPermissionsToLowerCase =
                    String.toLower newLitteralPermissions

                newPermissions : UsersPermissions
                newPermissions =
                    Permissions.Litteral.toUsersPermissions newLitteralPermissionsToLowerCase
            in
            { model
                | octal = Permissions.Octal.fromUsersPermissions newPermissions
                , litteral = newLitteralPermissionsToLowerCase
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
                , Html.Attributes.checked (Permissions.canOwnerRead model.permissions)
                , Html.Events.onCheck UpdateOwnerReadPermission
                ]
                []
            , Html.label
                [ Html.Attributes.for "owner-permission-write" ]
                [ Html.text "Write" ]
            , Html.input
                [ Html.Attributes.type_ "checkbox"
                , Html.Attributes.id "owner-permission-write"
                , Html.Attributes.checked (Permissions.canOwnerWrite model.permissions)
                , Html.Events.onCheck UpdateOwnerWritePermission
                ]
                []
            , Html.label
                [ Html.Attributes.for "owner-permission-execute" ]
                [ Html.text "Execute" ]
            , Html.input
                [ Html.Attributes.type_ "checkbox"
                , Html.Attributes.id "owner-permission-execute"
                , Html.Attributes.checked (Permissions.canOwnerExecute model.permissions)
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
                , Html.Attributes.checked (Permissions.canGroupRead model.permissions)
                , Html.Events.onCheck UpdateGroupReadPermission
                ]
                []
            , Html.label
                [ Html.Attributes.for "group-permission-write" ]
                [ Html.text "Write" ]
            , Html.input
                [ Html.Attributes.type_ "checkbox"
                , Html.Attributes.id "group-permission-write"
                , Html.Attributes.checked (Permissions.canGroupWrite model.permissions)
                , Html.Events.onCheck UpdateGroupWritePermission
                ]
                []
            , Html.label
                [ Html.Attributes.for "group-permission-execute" ]
                [ Html.text "Execute" ]
            , Html.input
                [ Html.Attributes.type_ "checkbox"
                , Html.Attributes.id "group-permission-execute"
                , Html.Attributes.checked (Permissions.canGroupExecute model.permissions)
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
                , Html.Attributes.checked (Permissions.canOthersRead model.permissions)
                , Html.Events.onCheck UpdateOthersReadPermission
                ]
                []
            , Html.label
                [ Html.Attributes.for "others-permission-write" ]
                [ Html.text "Write" ]
            , Html.input
                [ Html.Attributes.type_ "checkbox"
                , Html.Attributes.id "others-permission-write"
                , Html.Attributes.checked (Permissions.canOthersWrite model.permissions)
                , Html.Events.onCheck UpdateOthersWritePermission
                ]
                []
            , Html.label
                [ Html.Attributes.for "others-permission-execute" ]
                [ Html.text "Execute" ]
            , Html.input
                [ Html.Attributes.type_ "checkbox"
                , Html.Attributes.id "others-permission-execute"
                , Html.Attributes.checked (Permissions.canOthersExecute model.permissions)
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
