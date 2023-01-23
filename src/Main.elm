port module Main exposing (main)

import Browser
import Html exposing (Html)
import Html.Attributes
import Html.Events
import Permissions exposing (UsersPermissions)
import Permissions.Litteral
import Permissions.Octal


port vibrateCommand : () -> Cmd message


type alias Model =
    { permissions : UsersPermissions
    , octal : String
    , litteral : String
    }


init : Flags -> ( Model, Cmd Message )
init flags =
    ( { permissions = Permissions.initial
      , octal = Permissions.Octal.fromUsersPermissions Permissions.initial
      , litteral = Permissions.Litteral.fromUsersPermissions Permissions.initial
      }
    , Cmd.none
    )


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
    | ResetPermissions
    | SetFilePermissions
    | SetFolderPermissions


update : Message -> Model -> ( Model, Cmd Message )
update message model =
    case message of
        UpdateOwnerReadPermission newOwnerReadPermission ->
            let
                newPermissions : UsersPermissions
                newPermissions =
                    Permissions.updateOwnerReadPermission newOwnerReadPermission model.permissions
            in
            ( { model
                | permissions = newPermissions
                , octal = Permissions.Octal.fromUsersPermissions newPermissions
                , litteral = Permissions.Litteral.fromUsersPermissions newPermissions
              }
            , vibrateCommand ()
            )

        UpdateOwnerWritePermission newOwnerWritePermission ->
            let
                newPermissions : UsersPermissions
                newPermissions =
                    Permissions.updateOwnerWritePermission newOwnerWritePermission model.permissions
            in
            ( { model
                | permissions = newPermissions
                , octal = Permissions.Octal.fromUsersPermissions newPermissions
                , litteral = Permissions.Litteral.fromUsersPermissions newPermissions
              }
            , vibrateCommand ()
            )

        UpdateOwnerExecutePermission newOwnerExecutePermission ->
            let
                newPermissions : UsersPermissions
                newPermissions =
                    Permissions.updateOwnerExecutePermission newOwnerExecutePermission model.permissions
            in
            ( { model
                | permissions = newPermissions
                , octal = Permissions.Octal.fromUsersPermissions newPermissions
                , litteral = Permissions.Litteral.fromUsersPermissions newPermissions
              }
            , vibrateCommand ()
            )

        UpdateGroupReadPermission newGroupReadPermission ->
            let
                newPermissions : UsersPermissions
                newPermissions =
                    Permissions.updateGroupReadPermission newGroupReadPermission model.permissions
            in
            ( { model
                | permissions = newPermissions
                , octal = Permissions.Octal.fromUsersPermissions newPermissions
                , litteral = Permissions.Litteral.fromUsersPermissions newPermissions
              }
            , vibrateCommand ()
            )

        UpdateGroupWritePermission newGroupWritePermission ->
            let
                newPermissions : UsersPermissions
                newPermissions =
                    Permissions.updateGroupWritePermission newGroupWritePermission model.permissions
            in
            ( { model
                | permissions = newPermissions
                , octal = Permissions.Octal.fromUsersPermissions newPermissions
                , litteral = Permissions.Litteral.fromUsersPermissions newPermissions
              }
            , vibrateCommand ()
            )

        UpdateGroupExecutePermission newGroupExecutePermission ->
            let
                newPermissions : UsersPermissions
                newPermissions =
                    Permissions.updateGroupExecutePermission newGroupExecutePermission model.permissions
            in
            ( { model
                | permissions = newPermissions
                , octal = Permissions.Octal.fromUsersPermissions newPermissions
                , litteral = Permissions.Litteral.fromUsersPermissions newPermissions
              }
            , vibrateCommand ()
            )

        UpdateOthersReadPermission newOthersReadPermission ->
            let
                newPermissions : UsersPermissions
                newPermissions =
                    Permissions.updateOthersReadPermission newOthersReadPermission model.permissions
            in
            ( { model
                | permissions = newPermissions
                , octal = Permissions.Octal.fromUsersPermissions newPermissions
                , litteral = Permissions.Litteral.fromUsersPermissions newPermissions
              }
            , vibrateCommand ()
            )

        UpdateOthersWritePermission newOthersWritePermission ->
            let
                newPermissions : UsersPermissions
                newPermissions =
                    Permissions.updateOthersWritePermission newOthersWritePermission model.permissions
            in
            ( { model
                | permissions = newPermissions
                , octal = Permissions.Octal.fromUsersPermissions newPermissions
                , litteral = Permissions.Litteral.fromUsersPermissions newPermissions
              }
            , vibrateCommand ()
            )

        UpdateOthersExecutePermission newOthersExecutePermission ->
            let
                newPermissions : UsersPermissions
                newPermissions =
                    Permissions.updateOthersExecutePermission newOthersExecutePermission model.permissions
            in
            ( { model
                | permissions = newPermissions
                , octal = Permissions.Octal.fromUsersPermissions newPermissions
                , litteral = Permissions.Litteral.fromUsersPermissions newPermissions
              }
            , vibrateCommand ()
            )

        UpdateOctalPermissions newOctalPermissions ->
            let
                newPermissions : UsersPermissions
                newPermissions =
                    Permissions.Octal.toUsersPermissions newOctalPermissions
            in
            ( { model
                | octal = newOctalPermissions
                , litteral = Permissions.Litteral.fromUsersPermissions newPermissions
                , permissions = newPermissions
              }
            , Cmd.none
            )

        UpdateLitteralPermissions newLitteralPermissions ->
            let
                newLitteralPermissionsToLowerCase : String
                newLitteralPermissionsToLowerCase =
                    String.toLower newLitteralPermissions

                newPermissions : UsersPermissions
                newPermissions =
                    Permissions.Litteral.toUsersPermissions newLitteralPermissionsToLowerCase
            in
            ( { model
                | octal = Permissions.Octal.fromUsersPermissions newPermissions
                , litteral = newLitteralPermissionsToLowerCase
                , permissions = newPermissions
              }
            , Cmd.none
            )

        ResetPermissions ->
            let
                newPermissions : UsersPermissions
                newPermissions =
                    Permissions.initial
            in
            ( { model
                | permissions = newPermissions
                , octal = Permissions.Octal.fromUsersPermissions newPermissions
                , litteral = Permissions.Litteral.fromUsersPermissions newPermissions
              }
            , vibrateCommand ()
            )

        SetFilePermissions ->
            let
                newPermissions : UsersPermissions
                newPermissions =
                    Permissions.file
            in
            ( { model
                | permissions = newPermissions
                , octal = Permissions.Octal.fromUsersPermissions newPermissions
                , litteral = Permissions.Litteral.fromUsersPermissions newPermissions
              }
            , vibrateCommand ()
            )

        SetFolderPermissions ->
            let
                newPermissions : UsersPermissions
                newPermissions =
                    Permissions.folder
            in
            ( { model
                | permissions = newPermissions
                , octal = Permissions.Octal.fromUsersPermissions newPermissions
                , litteral = Permissions.Litteral.fromUsersPermissions newPermissions
              }
            , vibrateCommand ()
            )


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
        , Html.div
            [ Html.Attributes.class "row" ]
            [ Html.button
                [ Html.Attributes.class "action"
                , Html.Events.onClick ResetPermissions
                ]
                [ Html.text "Reset" ]
            , Html.button
                [ Html.Attributes.class "action"
                , Html.Events.onClick SetFilePermissions
                ]
                [ Html.text "File" ]
            , Html.button
                [ Html.Attributes.class "action"
                , Html.Events.onClick SetFolderPermissions
                ]
                [ Html.text "Folder" ]
            ]
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


subscriptions : Model -> Sub Message
subscriptions =
    always Sub.none


type alias Flags =
    ()


main : Program Flags Model Message
main =
    Browser.element
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions
        }
