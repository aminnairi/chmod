module Main exposing (main)

import Browser
import Html exposing (Html)
import Html.Builder
import Navigator
import Permissions exposing (UsersPermissions)
import Permissions.Litteral
import Permissions.Octal
import Random
import Random.Char
import Random.String


type alias OwnerIdentifiers =
    { read : String
    , write : String
    , execute : String
    }


type alias GroupIdentifiers =
    { read : String
    , write : String
    , execute : String
    }


type alias OthersIdentifiers =
    { read : String
    , write : String
    , execute : String
    }


type alias Identifiers =
    { owner : OwnerIdentifiers
    , group : GroupIdentifiers
    , others : OthersIdentifiers
    }


type alias Model =
    { permissions : UsersPermissions
    , octal : String
    , litteral : String
    , identifiers : Identifiers
    }


randomIdentifierGenerator : Random.Generator String
randomIdentifierGenerator =
    Random.String.string 10 Random.Char.english


randomIdentifiersGenerator : Random.Generator (List String)
randomIdentifiersGenerator =
    Random.list 9 randomIdentifierGenerator


init : Flags -> ( Model, Cmd Message )
init flags =
    ( { permissions = Permissions.initial
      , octal = Permissions.Octal.fromUsersPermissions Permissions.initial
      , litteral = Permissions.Litteral.fromUsersPermissions Permissions.initial
      , identifiers =
            { owner =
                { read = ""
                , write = ""
                , execute = ""
                }
            , group =
                { read = ""
                , write = ""
                , execute = ""
                }
            , others =
                { read = ""
                , write = ""
                , execute = ""
                }
            }
      }
    , Random.generate GotRandomIdentifiers randomIdentifiersGenerator
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
    | GotRandomIdentifiers (List String)


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
            , Navigator.vibrate ()
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
            , Navigator.vibrate ()
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
            , Navigator.vibrate ()
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
            , Navigator.vibrate ()
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
            , Navigator.vibrate ()
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
            , Navigator.vibrate ()
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
            , Navigator.vibrate ()
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
            , Navigator.vibrate ()
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
            , Navigator.vibrate ()
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
            , Navigator.vibrate ()
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
            , Navigator.vibrate ()
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
            , Navigator.vibrate ()
            )

        CopyToClipboard ->
            let
                chmodCommandAsText : String
                chmodCommandAsText =
                    "chmod " ++ model.octal
            in
            ( model
            , Cmd.batch
                [ Navigator.copy chmodCommandAsText
                , Navigator.vibrate ()
                ]
            )

        GotRandomIdentifiers identifiers ->
            case identifiers of
                [ ownerReadIdentifier, ownerWriteIdentifier, ownerExecuteIdentifier, groupReadIdentifier, groupWriteIdentifier, groupExecuteIdentifier, othersReadIdentifier, othersWriteIdentifier, othersExecuteIdentifier ] ->
                    let
                        newModel : Model
                        newModel =
                            { model
                                | identifiers =
                                    { owner =
                                        { read = ownerReadIdentifier
                                        , write = ownerWriteIdentifier
                                        , execute = ownerExecuteIdentifier
                                        }
                                    , group =
                                        { read = groupReadIdentifier
                                        , write = groupWriteIdentifier
                                        , execute = groupExecuteIdentifier
                                        }
                                    , others =
                                        { read = othersReadIdentifier
                                        , write = othersWriteIdentifier
                                        , execute = othersExecuteIdentifier
                                        }
                                    }
                            }
                    in
                    ( newModel, Cmd.none )

                _ ->
                    ( model, Cmd.none )


view : Model -> Html Message
view model =
    Html.Builder.div
        |> Html.Builder.withClass "container"
        |> Html.Builder.withChild
            (Html.Builder.h1
                |> Html.Builder.withText "Chmod"
                |> Html.Builder.build
            )
        |> Html.Builder.withChild
            (Html.Builder.hr
                |> Html.Builder.withClass "horizontal-line"
                |> Html.Builder.build
            )
        |> Html.Builder.withChild
            (Html.Builder.h2
                |> Html.Builder.withText "Permissions"
                |> Html.Builder.build
            )
        |> Html.Builder.withChild
            (Html.Builder.div
                |> Html.Builder.withClass "row"
                |> Html.Builder.withChild
                    (Html.Builder.button
                        |> Html.Builder.withClass "action"
                        |> Html.Builder.withOnClick ResetPermissions
                        |> Html.Builder.withText "Reset"
                        |> Html.Builder.build
                    )
                |> Html.Builder.withChild
                    (Html.Builder.button
                        |> Html.Builder.withClass "action"
                        |> Html.Builder.withOnClick SetFilePermissions
                        |> Html.Builder.withText "File"
                        |> Html.Builder.build
                    )
                |> Html.Builder.withChild
                    (Html.Builder.button
                        |> Html.Builder.withClass "action"
                        |> Html.Builder.withOnClick SetFolderPermissions
                        |> Html.Builder.withText "Folder"
                        |> Html.Builder.build
                    )
                |> Html.Builder.build
            )
        |> Html.Builder.withChild
            (Html.Builder.h3
                |> Html.Builder.withText "Owner"
                |> Html.Builder.build
            )
        |> Html.Builder.withChild
            (Html.Builder.div
                |> Html.Builder.withClass "row"
                |> Html.Builder.withChild
                    (Html.Builder.label
                        |> Html.Builder.withFor model.identifiers.owner.read
                        |> Html.Builder.withText "Read"
                        |> Html.Builder.build
                    )
                |> Html.Builder.withChild
                    (Html.Builder.input
                        |> Html.Builder.withType "checkbox"
                        |> Html.Builder.withId model.identifiers.owner.read
                        |> Html.Builder.withChecked (Permissions.canOwnerRead model.permissions)
                        |> Html.Builder.withOnCheck UpdateOwnerReadPermission
                        |> Html.Builder.build
                    )
                |> Html.Builder.withChild
                    (Html.Builder.label
                        |> Html.Builder.withFor model.identifiers.owner.write
                        |> Html.Builder.withText "Write"
                        |> Html.Builder.build
                    )
                |> Html.Builder.withChild
                    (Html.Builder.input
                        |> Html.Builder.withType "checkbox"
                        |> Html.Builder.withId model.identifiers.owner.write
                        |> Html.Builder.withChecked (Permissions.canOwnerWrite model.permissions)
                        |> Html.Builder.withOnCheck UpdateOwnerWritePermission
                        |> Html.Builder.build
                    )
                |> Html.Builder.withChild
                    (Html.Builder.label
                        |> Html.Builder.withFor model.identifiers.owner.execute
                        |> Html.Builder.withText "Execute"
                        |> Html.Builder.build
                    )
                |> Html.Builder.withChild
                    (Html.Builder.input
                        |> Html.Builder.withType "checkbox"
                        |> Html.Builder.withId model.identifiers.owner.execute
                        |> Html.Builder.withChecked (Permissions.canOwnerExecute model.permissions)
                        |> Html.Builder.withOnCheck UpdateOwnerExecutePermission
                        |> Html.Builder.build
                    )
                |> Html.Builder.build
            )
        |> Html.Builder.withChild
            (Html.Builder.h3
                |> Html.Builder.withText "Group"
                |> Html.Builder.build
            )
        |> Html.Builder.withChild
            (Html.Builder.div
                |> Html.Builder.withClass "row"
                |> Html.Builder.withChild
                    (Html.Builder.label
                        |> Html.Builder.withFor model.identifiers.group.read
                        |> Html.Builder.withText "Read"
                        |> Html.Builder.build
                    )
                |> Html.Builder.withChild
                    (Html.Builder.input
                        |> Html.Builder.withType "checkbox"
                        |> Html.Builder.withId model.identifiers.group.read
                        |> Html.Builder.withChecked (Permissions.canGroupRead model.permissions)
                        |> Html.Builder.withOnCheck UpdateGroupReadPermission
                        |> Html.Builder.build
                    )
                |> Html.Builder.withChild
                    (Html.Builder.label
                        |> Html.Builder.withFor model.identifiers.group.write
                        |> Html.Builder.withText "Write"
                        |> Html.Builder.build
                    )
                |> Html.Builder.withChild
                    (Html.Builder.input
                        |> Html.Builder.withType "checkbox"
                        |> Html.Builder.withId model.identifiers.group.write
                        |> Html.Builder.withChecked (Permissions.canGroupWrite model.permissions)
                        |> Html.Builder.withOnCheck UpdateGroupWritePermission
                        |> Html.Builder.build
                    )
                |> Html.Builder.withChild
                    (Html.Builder.label
                        |> Html.Builder.withFor model.identifiers.group.execute
                        |> Html.Builder.withText "Execute"
                        |> Html.Builder.build
                    )
                |> Html.Builder.withChild
                    (Html.Builder.input
                        |> Html.Builder.withType "checkbox"
                        |> Html.Builder.withId model.identifiers.group.execute
                        |> Html.Builder.withChecked (Permissions.canGroupExecute model.permissions)
                        |> Html.Builder.withOnCheck UpdateGroupExecutePermission
                        |> Html.Builder.build
                    )
                |> Html.Builder.build
            )
        |> Html.Builder.withChild
            (Html.Builder.h3
                |> Html.Builder.withText "Others"
                |> Html.Builder.build
            )
        |> Html.Builder.withChild
            (Html.Builder.div
                |> Html.Builder.withClass "row"
                |> Html.Builder.withChild
                    (Html.Builder.label
                        |> Html.Builder.withFor model.identifiers.others.read
                        |> Html.Builder.withText "Read"
                        |> Html.Builder.build
                    )
                |> Html.Builder.withChild
                    (Html.Builder.input
                        |> Html.Builder.withType "checkbox"
                        |> Html.Builder.withId model.identifiers.others.read
                        |> Html.Builder.withChecked (Permissions.canOthersRead model.permissions)
                        |> Html.Builder.withOnCheck UpdateOthersReadPermission
                        |> Html.Builder.build
                    )
                |> Html.Builder.withChild
                    (Html.Builder.label
                        |> Html.Builder.withFor model.identifiers.others.write
                        |> Html.Builder.withText "Write"
                        |> Html.Builder.build
                    )
                |> Html.Builder.withChild
                    (Html.Builder.input
                        |> Html.Builder.withType "checkbox"
                        |> Html.Builder.withId model.identifiers.others.write
                        |> Html.Builder.withChecked (Permissions.canOthersWrite model.permissions)
                        |> Html.Builder.withOnCheck UpdateOthersWritePermission
                        |> Html.Builder.build
                    )
                |> Html.Builder.withChild
                    (Html.Builder.label
                        |> Html.Builder.withFor model.identifiers.others.execute
                        |> Html.Builder.withText "Execute"
                        |> Html.Builder.build
                    )
                |> Html.Builder.withChild
                    (Html.Builder.input
                        |> Html.Builder.withType "checkbox"
                        |> Html.Builder.withId model.identifiers.others.execute
                        |> Html.Builder.withChecked (Permissions.canOthersExecute model.permissions)
                        |> Html.Builder.withOnCheck UpdateOthersExecutePermission
                        |> Html.Builder.build
                    )
                |> Html.Builder.build
            )
        |> Html.Builder.withChild
            (Html.Builder.hr
                |> Html.Builder.withClass "horizontal-line"
                |> Html.Builder.build
            )
        |> Html.Builder.withChild
            (Html.Builder.h1
                |> Html.Builder.withText "Litteral"
                |> Html.Builder.build
            )
        |> Html.Builder.withChild
            (Html.Builder.div
                |> Html.Builder.withClass "input-with-label"
                |> Html.Builder.withChild
                    (Html.Builder.label
                        |> Html.Builder.withFor "litteral-permissions"
                        |> Html.Builder.withText "Value"
                        |> Html.Builder.build
                    )
                |> Html.Builder.withChild
                    (Html.Builder.input
                        |> Html.Builder.withType "text"
                        |> Html.Builder.withValue model.litteral
                        |> Html.Builder.withOnInput UpdateLitteralPermissions
                        |> Html.Builder.withId "litteral-permissions"
                        |> Html.Builder.build
                    )
                |> Html.Builder.build
            )
        |> Html.Builder.withChild
            (Html.Builder.hr
                |> Html.Builder.withClass "horizontal-line"
                |> Html.Builder.build
            )
        |> Html.Builder.withChild
            (Html.Builder.h2
                |> Html.Builder.withText "Octal"
                |> Html.Builder.build
            )
        |> Html.Builder.withChild
            (Html.Builder.div
                |> Html.Builder.withClass "input-with-label"
                |> Html.Builder.withChild
                    (Html.Builder.label
                        |> Html.Builder.withFor "octal-permissions"
                        |> Html.Builder.withText "Value"
                        |> Html.Builder.build
                    )
                |> Html.Builder.withChild
                    (Html.Builder.input
                        |> Html.Builder.withType "text"
                        |> Html.Builder.withValue model.octal
                        |> Html.Builder.withOnInput UpdateOctalPermissions
                        |> Html.Builder.withId "octal-permissions"
                        |> Html.Builder.build
                    )
                |> Html.Builder.build
            )
        |> Html.Builder.withChild
            (Html.Builder.button
                |> Html.Builder.withClass "action"
                |> Html.Builder.withOnClick CopyToClipboard
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
