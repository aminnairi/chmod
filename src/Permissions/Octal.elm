module Permissions.Octal exposing (disabled, execute, fromGroupExecutePermission, fromGroupPermissions, fromGroupReadPermission, fromGroupWritePermission, fromOthersExecutePermission, fromOthersPermissions, fromOthersReadPermission, fromOthersWritePermission, fromOwnerExecutePermission, fromOwnerPermissions, fromOwnerReadPermission, fromOwnerWritePermission, fromUsersPermissions, read, readExecute, readWrite, readWriteExecute, toGroupExecutePermission, toGroupPermissions, toGroupReadPermission, toGroupWritePermission, toOthersExecutePermission, toOthersPermissions, toOthersReadPermission, toOthersWritePermission, toOwnerExecutePermission, toOwnerPermissions, toOwnerReadPermission, toOwnerWritePermission, toUsersPermissions, write, writeExecute)

import Permissions exposing (..)


disabled : Int
disabled =
    0


read : Int
read =
    4


write : Int
write =
    2


execute : Int
execute =
    1


readWrite : Int
readWrite =
    read + write


readExecute : Int
readExecute =
    read + execute


writeExecute : Int
writeExecute =
    write + execute


readWriteExecute : Int
readWriteExecute =
    read + write + execute


toOwnerReadPermission : Int -> OwnerReadPermission
toOwnerReadPermission octalReadPermission =
    if octalReadPermission == read then
        OwnerReadPermissionEnabled

    else
        OwnerReadPermissionDisabled


toGroupReadPermission : Int -> GroupReadPermission
toGroupReadPermission octalReadPermission =
    if octalReadPermission == read then
        GroupReadPermissionEnabled

    else
        GroupReadPermissionDisabled


toOthersReadPermission : Int -> OthersReadPermission
toOthersReadPermission octalReadPermission =
    if octalReadPermission == read then
        OthersReadPermissionEnabled

    else
        OthersReadPermissionDisabled


toOwnerWritePermission : Int -> OwnerWritePermission
toOwnerWritePermission octalWritePermission =
    if octalWritePermission == write then
        OwnerWritePermissionEnabled

    else
        OwnerWritePermissionDisabled


toGroupWritePermission : Int -> GroupWritePermission
toGroupWritePermission octalWritePermission =
    if octalWritePermission == write then
        GroupWritePermissionEnabled

    else
        GroupWritePermissionDisabled


toOthersWritePermission : Int -> OthersWritePermission
toOthersWritePermission octalWritePermission =
    if octalWritePermission == write then
        OthersWritePermissionEnabled

    else
        OthersWritePermissionDisabled


toOwnerExecutePermission : Int -> OwnerExecutePermission
toOwnerExecutePermission octalExecutePermission =
    if octalExecutePermission == execute then
        OwnerExecutePermissionEnabled

    else
        OwnerExecutePermissionDisabled


toGroupExecutePermission : Int -> GroupExecutePermission
toGroupExecutePermission octalExecutePermission =
    if octalExecutePermission == execute then
        GroupExecutePermissionEnabled

    else
        GroupExecutePermissionDisabled


toOthersExecutePermission : Int -> OthersExecutePermission
toOthersExecutePermission octalExecutePermission =
    if octalExecutePermission == execute then
        OthersExecutePermissionEnabled

    else
        OthersExecutePermissionDisabled


toOwnerPermissions : Int -> OwnerPermissions
toOwnerPermissions octalOwnerPermissions =
    if octalOwnerPermissions == read then
        OwnerPermissions OwnerReadPermissionEnabled OwnerWritePermissionDisabled OwnerExecutePermissionDisabled

    else if octalOwnerPermissions == write then
        OwnerPermissions OwnerReadPermissionDisabled OwnerWritePermissionEnabled OwnerExecutePermissionDisabled

    else if octalOwnerPermissions == execute then
        OwnerPermissions OwnerReadPermissionDisabled OwnerWritePermissionDisabled OwnerExecutePermissionEnabled

    else if octalOwnerPermissions == readWrite then
        OwnerPermissions OwnerReadPermissionEnabled OwnerWritePermissionEnabled OwnerExecutePermissionDisabled

    else if octalOwnerPermissions == readExecute then
        OwnerPermissions OwnerReadPermissionEnabled OwnerWritePermissionDisabled OwnerExecutePermissionEnabled

    else if octalOwnerPermissions == writeExecute then
        OwnerPermissions OwnerReadPermissionDisabled OwnerWritePermissionEnabled OwnerExecutePermissionEnabled

    else if octalOwnerPermissions == readWriteExecute then
        OwnerPermissions OwnerReadPermissionEnabled OwnerWritePermissionEnabled OwnerExecutePermissionEnabled

    else
        OwnerPermissions OwnerReadPermissionDisabled OwnerWritePermissionDisabled OwnerExecutePermissionDisabled


toGroupPermissions : Int -> GroupPermissions
toGroupPermissions octalGroupPermissions =
    if octalGroupPermissions == read then
        GroupPermissions GroupReadPermissionEnabled GroupWritePermissionDisabled GroupExecutePermissionDisabled

    else if octalGroupPermissions == write then
        GroupPermissions GroupReadPermissionDisabled GroupWritePermissionEnabled GroupExecutePermissionDisabled

    else if octalGroupPermissions == execute then
        GroupPermissions GroupReadPermissionDisabled GroupWritePermissionDisabled GroupExecutePermissionEnabled

    else if octalGroupPermissions == readWrite then
        GroupPermissions GroupReadPermissionEnabled GroupWritePermissionEnabled GroupExecutePermissionDisabled

    else if octalGroupPermissions == readExecute then
        GroupPermissions GroupReadPermissionEnabled GroupWritePermissionDisabled GroupExecutePermissionEnabled

    else if octalGroupPermissions == writeExecute then
        GroupPermissions GroupReadPermissionDisabled GroupWritePermissionEnabled GroupExecutePermissionEnabled

    else if octalGroupPermissions == readWriteExecute then
        GroupPermissions GroupReadPermissionEnabled GroupWritePermissionEnabled GroupExecutePermissionEnabled

    else
        GroupPermissions GroupReadPermissionDisabled GroupWritePermissionDisabled GroupExecutePermissionDisabled


toOthersPermissions : Int -> OthersPermissions
toOthersPermissions octalOthersPermissions =
    if octalOthersPermissions == read then
        OthersPermissions OthersReadPermissionEnabled OthersWritePermissionDisabled OthersExecutePermissionDisabled

    else if octalOthersPermissions == write then
        OthersPermissions OthersReadPermissionDisabled OthersWritePermissionEnabled OthersExecutePermissionDisabled

    else if octalOthersPermissions == execute then
        OthersPermissions OthersReadPermissionDisabled OthersWritePermissionDisabled OthersExecutePermissionEnabled

    else if octalOthersPermissions == readWrite then
        OthersPermissions OthersReadPermissionEnabled OthersWritePermissionEnabled OthersExecutePermissionDisabled

    else if octalOthersPermissions == readExecute then
        OthersPermissions OthersReadPermissionEnabled OthersWritePermissionDisabled OthersExecutePermissionEnabled

    else if octalOthersPermissions == writeExecute then
        OthersPermissions OthersReadPermissionDisabled OthersWritePermissionEnabled OthersExecutePermissionEnabled

    else if octalOthersPermissions == readWriteExecute then
        OthersPermissions OthersReadPermissionEnabled OthersWritePermissionEnabled OthersExecutePermissionEnabled

    else
        OthersPermissions OthersReadPermissionDisabled OthersWritePermissionDisabled OthersExecutePermissionDisabled


toUsersPermissions : String -> UsersPermissions
toUsersPermissions octalStringUsersPermissions =
    case octalStringUsersPermissions |> String.split "" |> List.map (String.toInt >> Maybe.withDefault 0) of
        [ octalOwnerPermissions, octalGroupPermissions, octalOthersPermissions ] ->
            UsersPermissions
                (toOwnerPermissions octalOwnerPermissions)
                (toGroupPermissions octalGroupPermissions)
                (toOthersPermissions octalOthersPermissions)

        _ ->
            UsersPermissions
                (OwnerPermissions OwnerReadPermissionDisabled OwnerWritePermissionDisabled OwnerExecutePermissionDisabled)
                (GroupPermissions GroupReadPermissionDisabled GroupWritePermissionDisabled GroupExecutePermissionDisabled)
                (OthersPermissions OthersReadPermissionDisabled OthersWritePermissionDisabled OthersExecutePermissionDisabled)


fromOwnerReadPermission : OwnerReadPermission -> Int
fromOwnerReadPermission ownerReadPermission =
    case ownerReadPermission of
        OwnerReadPermissionEnabled ->
            read

        OwnerReadPermissionDisabled ->
            disabled


fromGroupReadPermission : GroupReadPermission -> Int
fromGroupReadPermission groupReadPermission =
    case groupReadPermission of
        GroupReadPermissionEnabled ->
            read

        GroupReadPermissionDisabled ->
            disabled


fromOthersReadPermission : OthersReadPermission -> Int
fromOthersReadPermission othersReadPermission =
    case othersReadPermission of
        OthersReadPermissionEnabled ->
            read

        OthersReadPermissionDisabled ->
            disabled


fromOwnerWritePermission : OwnerWritePermission -> Int
fromOwnerWritePermission ownerWritePermission =
    case ownerWritePermission of
        OwnerWritePermissionEnabled ->
            write

        OwnerWritePermissionDisabled ->
            disabled


fromGroupWritePermission : GroupWritePermission -> Int
fromGroupWritePermission groupWritePermission =
    case groupWritePermission of
        GroupWritePermissionEnabled ->
            write

        GroupWritePermissionDisabled ->
            disabled


fromOthersWritePermission : OthersWritePermission -> Int
fromOthersWritePermission othersWritePermission =
    case othersWritePermission of
        OthersWritePermissionEnabled ->
            write

        OthersWritePermissionDisabled ->
            disabled


fromOwnerExecutePermission : OwnerExecutePermission -> Int
fromOwnerExecutePermission ownerExecutePermission =
    case ownerExecutePermission of
        OwnerExecutePermissionEnabled ->
            execute

        OwnerExecutePermissionDisabled ->
            disabled


fromGroupExecutePermission : GroupExecutePermission -> Int
fromGroupExecutePermission groupExecutePermission =
    case groupExecutePermission of
        GroupExecutePermissionEnabled ->
            execute

        GroupExecutePermissionDisabled ->
            disabled


fromOthersExecutePermission : OthersExecutePermission -> Int
fromOthersExecutePermission othersExecutePermission =
    case othersExecutePermission of
        OthersExecutePermissionEnabled ->
            execute

        OthersExecutePermissionDisabled ->
            disabled


fromOwnerPermissions : OwnerPermissions -> Int
fromOwnerPermissions (OwnerPermissions ownerReadPermission ownerWritePermission ownerExecutePermission) =
    fromOwnerReadPermission ownerReadPermission
        + fromOwnerWritePermission ownerWritePermission
        + fromOwnerExecutePermission ownerExecutePermission


fromGroupPermissions : GroupPermissions -> Int
fromGroupPermissions (GroupPermissions groupReadPermission groupWritePermission groupExecutePermission) =
    fromGroupReadPermission groupReadPermission
        + fromGroupWritePermission groupWritePermission
        + fromGroupExecutePermission groupExecutePermission


fromOthersPermissions : OthersPermissions -> Int
fromOthersPermissions (OthersPermissions othersReadPermission othersWritePermission othersExecutePermission) =
    fromOthersReadPermission othersReadPermission
        + fromOthersWritePermission othersWritePermission
        + fromOthersExecutePermission othersExecutePermission


fromUsersPermissions : UsersPermissions -> String
fromUsersPermissions (UsersPermissions ownerPermissions groupPermissions othersPermissions) =
    String.fromInt (fromOwnerPermissions ownerPermissions)
        ++ String.fromInt (fromGroupPermissions groupPermissions)
        ++ String.fromInt (fromOthersPermissions othersPermissions)
