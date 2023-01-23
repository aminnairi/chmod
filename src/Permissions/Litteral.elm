module Permissions.Litteral exposing (disabled, execute, fromGroupExecutePermission, fromGroupPermissions, fromGroupReadPermission, fromGroupWritePermission, fromOthersExecutePermission, fromOthersPermissions, fromOthersReadPermission, fromOthersWritePermission, fromOwnerExecutePermission, fromOwnerPermissions, fromOwnerReadPermission, fromOwnerWritePermission, fromUsersPermissions, read, toGroupExecutePermission, toGroupPermissions, toGroupReadPermission, toGroupWritePermission, toOthersExecutePermission, toOthersPermissions, toOthersReadPermission, toOthersWritePermission, toOwnerExecutePermission, toOwnerPermissions, toOwnerReadPermission, toOwnerWritePermission, toUsersPermissions, write)

import Permissions exposing (..)
import String.Extra


read : String
read =
    "r"


write : String
write =
    "w"


execute : String
execute =
    "x"


disabled : String
disabled =
    "-"


fromOwnerReadPermission : OwnerReadPermission -> String
fromOwnerReadPermission ownerReadPermission =
    case ownerReadPermission of
        OwnerReadPermissionEnabled ->
            read

        OwnerReadPermissionDisabled ->
            disabled


fromGroupReadPermission : GroupReadPermission -> String
fromGroupReadPermission groupReadPermission =
    case groupReadPermission of
        GroupReadPermissionEnabled ->
            read

        GroupReadPermissionDisabled ->
            disabled


fromOthersReadPermission : OthersReadPermission -> String
fromOthersReadPermission othersReadPermission =
    case othersReadPermission of
        OthersReadPermissionEnabled ->
            read

        OthersReadPermissionDisabled ->
            disabled


fromOwnerWritePermission : OwnerWritePermission -> String
fromOwnerWritePermission ownerWritePermission =
    case ownerWritePermission of
        OwnerWritePermissionEnabled ->
            write

        OwnerWritePermissionDisabled ->
            disabled


fromGroupWritePermission : GroupWritePermission -> String
fromGroupWritePermission groupWritePermission =
    case groupWritePermission of
        GroupWritePermissionEnabled ->
            write

        GroupWritePermissionDisabled ->
            disabled


fromOthersWritePermission : OthersWritePermission -> String
fromOthersWritePermission othersWritePermission =
    case othersWritePermission of
        OthersWritePermissionEnabled ->
            write

        OthersWritePermissionDisabled ->
            disabled


fromOwnerExecutePermission : OwnerExecutePermission -> String
fromOwnerExecutePermission ownerExecutionPermission =
    case ownerExecutionPermission of
        OwnerExecutePermissionEnabled ->
            execute

        OwnerExecutePermissionDisabled ->
            disabled


fromGroupExecutePermission : GroupExecutePermission -> String
fromGroupExecutePermission groupExecutionPermission =
    case groupExecutionPermission of
        GroupExecutePermissionEnabled ->
            execute

        GroupExecutePermissionDisabled ->
            disabled


fromOthersExecutePermission : OthersExecutePermission -> String
fromOthersExecutePermission othersExecutionPermission =
    case othersExecutionPermission of
        OthersExecutePermissionEnabled ->
            execute

        OthersExecutePermissionDisabled ->
            disabled


fromOwnerPermissions : OwnerPermissions -> String
fromOwnerPermissions (OwnerPermissions ownerReadPermission ownerWritePermission ownerExecutePermission) =
    fromOwnerReadPermission ownerReadPermission
        ++ fromOwnerWritePermission ownerWritePermission
        ++ fromOwnerExecutePermission ownerExecutePermission


fromGroupPermissions : GroupPermissions -> String
fromGroupPermissions (GroupPermissions groupReadPermission groupWritePermission groupExecutePermission) =
    fromGroupReadPermission groupReadPermission
        ++ fromGroupWritePermission groupWritePermission
        ++ fromGroupExecutePermission groupExecutePermission


fromOthersPermissions : OthersPermissions -> String
fromOthersPermissions (OthersPermissions othersReadPermission othersWritePermission othersExecutePermission) =
    fromOthersReadPermission othersReadPermission
        ++ fromOthersWritePermission othersWritePermission
        ++ fromOthersExecutePermission othersExecutePermission


fromUsersPermissions : UsersPermissions -> String
fromUsersPermissions (UsersPermissions ownerPermissions groupPermissions othersPermissions) =
    fromOwnerPermissions ownerPermissions
        ++ fromGroupPermissions groupPermissions
        ++ fromOthersPermissions othersPermissions


toOwnerReadPermission : String -> OwnerReadPermission
toOwnerReadPermission stringPermission =
    if stringPermission == read then
        OwnerReadPermissionEnabled

    else
        OwnerReadPermissionDisabled


toGroupReadPermission : String -> GroupReadPermission
toGroupReadPermission stringPermission =
    if stringPermission == read then
        GroupReadPermissionEnabled

    else
        GroupReadPermissionDisabled


toOthersReadPermission : String -> OthersReadPermission
toOthersReadPermission stringPermission =
    if stringPermission == read then
        OthersReadPermissionEnabled

    else
        OthersReadPermissionDisabled


toOwnerWritePermission : String -> OwnerWritePermission
toOwnerWritePermission stringPermission =
    if stringPermission == write then
        OwnerWritePermissionEnabled

    else
        OwnerWritePermissionDisabled


toGroupWritePermission : String -> GroupWritePermission
toGroupWritePermission stringPermission =
    if stringPermission == write then
        GroupWritePermissionEnabled

    else
        GroupWritePermissionDisabled


toOthersWritePermission : String -> OthersWritePermission
toOthersWritePermission stringPermission =
    if stringPermission == write then
        OthersWritePermissionEnabled

    else
        OthersWritePermissionDisabled


toOwnerExecutePermission : String -> OwnerExecutePermission
toOwnerExecutePermission stringPermission =
    if stringPermission == execute then
        OwnerExecutePermissionEnabled

    else
        OwnerExecutePermissionDisabled


toGroupExecutePermission : String -> GroupExecutePermission
toGroupExecutePermission stringPermission =
    if stringPermission == execute then
        GroupExecutePermissionEnabled

    else
        GroupExecutePermissionDisabled


toOthersExecutePermission : String -> OthersExecutePermission
toOthersExecutePermission stringPermission =
    if stringPermission == execute then
        OthersExecutePermissionEnabled

    else
        OthersExecutePermissionDisabled


toOwnerPermissions : String -> OwnerPermissions
toOwnerPermissions stringPermission =
    case String.split "" stringPermission of
        [ stringReadPermission, stringWritePermission, stringExecutePermission ] ->
            OwnerPermissions
                (toOwnerReadPermission stringReadPermission)
                (toOwnerWritePermission stringWritePermission)
                (toOwnerExecutePermission stringExecutePermission)

        _ ->
            OwnerPermissions OwnerReadPermissionDisabled OwnerWritePermissionDisabled OwnerExecutePermissionDisabled


toGroupPermissions : String -> GroupPermissions
toGroupPermissions stringGroupPermissions =
    case String.split "" stringGroupPermissions of
        [ stringReadPermission, stringWritePermission, stringExecutePermission ] ->
            GroupPermissions
                (toGroupReadPermission stringReadPermission)
                (toGroupWritePermission stringWritePermission)
                (toGroupExecutePermission stringExecutePermission)

        _ ->
            GroupPermissions GroupReadPermissionDisabled GroupWritePermissionDisabled GroupExecutePermissionDisabled


toOthersPermissions : String -> OthersPermissions
toOthersPermissions stringOthersPermissions =
    case String.split "" stringOthersPermissions of
        [ stringReadPermission, stringWritePermission, stringExecutePermission ] ->
            OthersPermissions
                (toOthersReadPermission stringReadPermission)
                (toOthersWritePermission stringWritePermission)
                (toOthersExecutePermission stringExecutePermission)

        _ ->
            OthersPermissions OthersReadPermissionDisabled OthersWritePermissionDisabled OthersExecutePermissionDisabled


toUsersPermissions : String -> UsersPermissions
toUsersPermissions usersPermissions =
    case String.Extra.break 3 usersPermissions of
        [ stringOwnerPermissions, stringGroupPermissions, stringOthersPermissions ] ->
            UsersPermissions
                (toOwnerPermissions stringOwnerPermissions)
                (toGroupPermissions stringGroupPermissions)
                (toOthersPermissions stringOthersPermissions)

        _ ->
            UsersPermissions
                (OwnerPermissions OwnerReadPermissionDisabled OwnerWritePermissionDisabled OwnerExecutePermissionDisabled)
                (GroupPermissions GroupReadPermissionDisabled GroupWritePermissionDisabled GroupExecutePermissionDisabled)
                (OthersPermissions OthersReadPermissionDisabled OthersWritePermissionDisabled OthersExecutePermissionDisabled)
