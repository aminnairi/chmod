port module Main exposing (main)

import Browser
import Html exposing (Html)
import Html.Attributes
import Html.Builder
import Html.Events
import Permissions exposing (UsersPermissions)
import Permissions.Litteral
import Permissions.Octal


port vibrateCommand : () -> Cmd message


port copyToClipboardCommand : String -> Cmd message


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
    | CopyToClipboard


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

        CopyToClipboard ->
            let
                chmodCommandAsText : String
                chmodCommandAsText =
                    "chmod " ++ model.octal
            in
            ( model
            , Cmd.batch
                [ copyToClipboardCommand chmodCommandAsText
                , vibrateCommand ()
                ]
            )


view : Model -> Html Message
view model =
    Html.Builder.new "div"
        |> Html.Builder.withAttribute (Html.Attributes.class "container")
        |> Html.Builder.withChild
            (Html.Builder.new "h1"
                |> Html.Builder.withText "Chmod"
                |> Html.Builder.build
            )
        |> Html.Builder.withChild
            (Html.Builder.new "hr"
                |> Html.Builder.withAttribute (Html.Attributes.class "horizontal-line")
                |> Html.Builder.build
            )
        |> Html.Builder.withChild
            (Html.Builder.new "h2"
                |> Html.Builder.withText "Permissions"
                |> Html.Builder.build
            )
        |> Html.Builder.withChild
            (Html.Builder.new "div"
                |> Html.Builder.withAttribute (Html.Attributes.class "row")
                |> Html.Builder.withChild
                    (Html.Builder.new "button"
                        |> Html.Builder.withAttribute (Html.Attributes.class "action")
                        |> Html.Builder.withAttribute (Html.Events.onClick ResetPermissions)
                        |> Html.Builder.withText "Reset"
                        |> Html.Builder.build
                    )
                |> Html.Builder.withChild
                    (Html.Builder.new "button"
                        |> Html.Builder.withAttribute (Html.Attributes.class "action")
                        |> Html.Builder.withAttribute (Html.Events.onClick SetFilePermissions)
                        |> Html.Builder.withText "File"
                        |> Html.Builder.build
                    )
                |> Html.Builder.withChild
                    (Html.Builder.new "button"
                        |> Html.Builder.withAttribute (Html.Attributes.class "action")
                        |> Html.Builder.withAttribute (Html.Events.onClick SetFolderPermissions)
                        |> Html.Builder.withText "Folder"
                        |> Html.Builder.build
                    )
                |> Html.Builder.build
            )
        |> Html.Builder.withChild
            (Html.Builder.new "h3"
                |> Html.Builder.withText "Owner"
                |> Html.Builder.build
            )
        |> Html.Builder.withChild
            (Html.Builder.new "div"
                |> Html.Builder.withAttribute (Html.Attributes.class "row")
                |> Html.Builder.withChild
                    (Html.Builder.new "label"
                        |> Html.Builder.withAttribute (Html.Attributes.for "owner-permission-read")
                        |> Html.Builder.withText "Read"
                        |> Html.Builder.build
                    )
                |> Html.Builder.withChild
                    (Html.Builder.new "input"
                        |> Html.Builder.withAttribute (Html.Attributes.type_ "checkbox")
                        |> Html.Builder.withAttribute (Html.Attributes.id "owner-permission-read")
                        |> Html.Builder.withAttribute (Html.Attributes.checked (Permissions.canOwnerRead model.permissions))
                        |> Html.Builder.withAttribute (Html.Events.onCheck UpdateOwnerReadPermission)
                        |> Html.Builder.build
                    )
                |> Html.Builder.withChild
                    (Html.Builder.new "label"
                        |> Html.Builder.withAttribute (Html.Attributes.for "owner-permission-write")
                        |> Html.Builder.withText "Write"
                        |> Html.Builder.build
                    )
                |> Html.Builder.withChild
                    (Html.Builder.new "input"
                        |> Html.Builder.withAttribute (Html.Attributes.type_ "checkbox")
                        |> Html.Builder.withAttribute (Html.Attributes.id "owner-permission-write")
                        |> Html.Builder.withAttribute (Html.Attributes.checked (Permissions.canOwnerWrite model.permissions))
                        |> Html.Builder.withAttribute (Html.Events.onCheck UpdateOwnerWritePermission)
                        |> Html.Builder.build
                    )
                |> Html.Builder.withChild
                    (Html.Builder.new "label"
                        |> Html.Builder.withAttribute (Html.Attributes.for "owner-permission-execute")
                        |> Html.Builder.withText "Execute"
                        |> Html.Builder.build
                    )
                |> Html.Builder.withChild
                    (Html.Builder.new "input"
                        |> Html.Builder.withAttribute (Html.Attributes.type_ "checkbox")
                        |> Html.Builder.withAttribute (Html.Attributes.id "owner-permission-execute")
                        |> Html.Builder.withAttribute (Html.Attributes.checked (Permissions.canOwnerExecute model.permissions))
                        |> Html.Builder.withAttribute (Html.Events.onCheck UpdateOwnerExecutePermission)
                        |> Html.Builder.build
                    )
                |> Html.Builder.build
            )
        |> Html.Builder.withChild
            (Html.Builder.new "h3"
                |> Html.Builder.withText "Group"
                |> Html.Builder.build
            )
        |> Html.Builder.withChild
            (Html.Builder.new "div"
                |> Html.Builder.withAttribute (Html.Attributes.class "row")
                |> Html.Builder.withChild
                    (Html.Builder.new "label"
                        |> Html.Builder.withAttribute (Html.Attributes.for "group-permission-read")
                        |> Html.Builder.withText "Read"
                        |> Html.Builder.build
                    )
                |> Html.Builder.withChild
                    (Html.Builder.new "input"
                        |> Html.Builder.withAttribute (Html.Attributes.type_ "checkbox")
                        |> Html.Builder.withAttribute (Html.Attributes.id "group-permission-read")
                        |> Html.Builder.withAttribute (Html.Attributes.checked (Permissions.canGroupRead model.permissions))
                        |> Html.Builder.withAttribute (Html.Events.onCheck UpdateGroupReadPermission)
                        |> Html.Builder.build
                    )
                |> Html.Builder.withChild
                    (Html.Builder.new "label"
                        |> Html.Builder.withAttribute (Html.Attributes.for "group-permission-write")
                        |> Html.Builder.withText "Write"
                        |> Html.Builder.build
                    )
                |> Html.Builder.withChild
                    (Html.Builder.new "input"
                        |> Html.Builder.withAttribute (Html.Attributes.type_ "checkbox")
                        |> Html.Builder.withAttribute (Html.Attributes.id "group-permission-write")
                        |> Html.Builder.withAttribute (Html.Attributes.checked (Permissions.canGroupWrite model.permissions))
                        |> Html.Builder.withAttribute (Html.Events.onCheck UpdateGroupWritePermission)
                        |> Html.Builder.build
                    )
                |> Html.Builder.withChild
                    (Html.Builder.new "label"
                        |> Html.Builder.withAttribute (Html.Attributes.for "group-permission-execute")
                        |> Html.Builder.withText "Execute"
                        |> Html.Builder.build
                    )
                |> Html.Builder.withChild
                    (Html.Builder.new "input"
                        |> Html.Builder.withAttribute (Html.Attributes.type_ "checkbox")
                        |> Html.Builder.withAttribute (Html.Attributes.id "group-permission-execute")
                        |> Html.Builder.withAttribute (Html.Attributes.checked (Permissions.canGroupExecute model.permissions))
                        |> Html.Builder.withAttribute (Html.Events.onCheck UpdateGroupExecutePermission)
                        |> Html.Builder.build
                    )
                |> Html.Builder.build
            )
        |> Html.Builder.withChild
            (Html.Builder.new "h3"
                |> Html.Builder.withText "Others"
                |> Html.Builder.build
            )
        |> Html.Builder.withChild
            (Html.Builder.new "div"
                |> Html.Builder.withAttribute (Html.Attributes.class "row")
                |> Html.Builder.withChild
                    (Html.Builder.new "label"
                        |> Html.Builder.withAttribute (Html.Attributes.for "others-permission-read")
                        |> Html.Builder.withText "Read"
                        |> Html.Builder.build
                    )
                |> Html.Builder.withChild
                    (Html.Builder.new "input"
                        |> Html.Builder.withAttribute (Html.Attributes.type_ "checkbox")
                        |> Html.Builder.withAttribute (Html.Attributes.id "others-permission-read")
                        |> Html.Builder.withAttribute (Html.Attributes.checked (Permissions.canOthersRead model.permissions))
                        |> Html.Builder.withAttribute (Html.Events.onCheck UpdateOthersReadPermission)
                        |> Html.Builder.build
                    )
                |> Html.Builder.withChild
                    (Html.Builder.new "label"
                        |> Html.Builder.withAttribute (Html.Attributes.for "others-permission-write")
                        |> Html.Builder.withText "Write"
                        |> Html.Builder.build
                    )
                |> Html.Builder.withChild
                    (Html.Builder.new "input"
                        |> Html.Builder.withAttribute (Html.Attributes.type_ "checkbox")
                        |> Html.Builder.withAttribute (Html.Attributes.id "others-permission-write")
                        |> Html.Builder.withAttribute (Html.Attributes.checked (Permissions.canOthersWrite model.permissions))
                        |> Html.Builder.withAttribute (Html.Events.onCheck UpdateOthersWritePermission)
                        |> Html.Builder.build
                    )
                |> Html.Builder.withChild
                    (Html.Builder.new "label"
                        |> Html.Builder.withAttribute (Html.Attributes.for "others-permission-execute")
                        |> Html.Builder.withText "Execute"
                        |> Html.Builder.build
                    )
                |> Html.Builder.withChild
                    (Html.Builder.new "input"
                        |> Html.Builder.withAttribute (Html.Attributes.type_ "checkbox")
                        |> Html.Builder.withAttribute (Html.Attributes.id "others-permission-execute")
                        |> Html.Builder.withAttribute (Html.Attributes.checked (Permissions.canOthersExecute model.permissions))
                        |> Html.Builder.withAttribute (Html.Events.onCheck UpdateOthersExecutePermission)
                        |> Html.Builder.build
                    )
                |> Html.Builder.build
            )
        |> Html.Builder.withChild
            (Html.Builder.new "hr"
                |> Html.Builder.withAttribute (Html.Attributes.class "horizontal-line")
                |> Html.Builder.build
            )
        |> Html.Builder.withChild
            (Html.Builder.new "h2"
                |> Html.Builder.withText "Litteral"
                |> Html.Builder.build
            )
        |> Html.Builder.withChild
            (Html.Builder.new "div"
                |> Html.Builder.withAttribute (Html.Attributes.class "input-with-label")
                |> Html.Builder.withChild
                    (Html.Builder.new "label"
                        |> Html.Builder.withAttribute (Html.Attributes.for "litteral-permissions")
                        |> Html.Builder.withText "Value"
                        |> Html.Builder.build
                    )
                |> Html.Builder.withChild
                    (Html.Builder.new "input"
                        |> Html.Builder.withAttribute (Html.Attributes.value model.litteral)
                        |> Html.Builder.withAttribute (Html.Events.onInput UpdateLitteralPermissions)
                        |> Html.Builder.withAttribute (Html.Attributes.id "litteral-permissions")
                        |> Html.Builder.build
                    )
                |> Html.Builder.build
            )
        |> Html.Builder.withChild
            (Html.Builder.new "hr"
                |> Html.Builder.withAttribute (Html.Attributes.class "horizontal-line")
                |> Html.Builder.build
            )
        |> Html.Builder.withChild
            (Html.Builder.new "h2"
                |> Html.Builder.withText "Octal"
                |> Html.Builder.build
            )
        |> Html.Builder.withChild
            (Html.Builder.new "div"
                |> Html.Builder.withAttribute (Html.Attributes.class "input-with-label")
                |> Html.Builder.withChild
                    (Html.Builder.new "label"
                        |> Html.Builder.withAttribute (Html.Attributes.for "octal-permissions")
                        |> Html.Builder.withText "Value"
                        |> Html.Builder.build
                    )
                |> Html.Builder.withChild
                    (Html.Builder.new "input"
                        |> Html.Builder.withAttribute (Html.Attributes.value model.octal)
                        |> Html.Builder.withAttribute (Html.Events.onInput UpdateOctalPermissions)
                        |> Html.Builder.withAttribute (Html.Attributes.id "octal-permissions")
                        |> Html.Builder.build
                    )
                |> Html.Builder.build
            )
        |> Html.Builder.withChild
            (Html.Builder.new "button"
                |> Html.Builder.withAttribute (Html.Attributes.class "action")
                |> Html.Builder.withAttribute (Html.Events.onClick CopyToClipboard)
                |> Html.Builder.withText "copy"
                |> Html.Builder.build
            )
        |> Html.Builder.build


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
