module Permissions exposing (GroupExecutePermission(..), GroupPermissions(..), GroupReadPermission(..), GroupWritePermission(..), OthersExecutePermission(..), OthersPermissions(..), OthersReadPermission(..), OthersWritePermission(..), OwnerExecutePermission(..), OwnerPermissions(..), OwnerReadPermission(..), OwnerWritePermission(..), UsersPermissions(..), canGroupExecute, canGroupRead, canGroupWrite, canOthersExecute, canOthersRead, canOthersWrite, canOwnerExecute, canOwnerRead, canOwnerWrite, file, folder, initial, updateGroupExecutePermission, updateGroupReadPermission, updateGroupWritePermission, updateOthersExecutePermission, updateOthersReadPermission, updateOthersWritePermission, updateOwnerExecutePermission, updateOwnerReadPermission, updateOwnerWritePermission)


type OwnerReadPermission
    = OwnerReadPermissionEnabled
    | OwnerReadPermissionDisabled


type OwnerWritePermission
    = OwnerWritePermissionEnabled
    | OwnerWritePermissionDisabled


type OwnerExecutePermission
    = OwnerExecutePermissionEnabled
    | OwnerExecutePermissionDisabled


type GroupReadPermission
    = GroupReadPermissionEnabled
    | GroupReadPermissionDisabled


type GroupWritePermission
    = GroupWritePermissionEnabled
    | GroupWritePermissionDisabled


type GroupExecutePermission
    = GroupExecutePermissionEnabled
    | GroupExecutePermissionDisabled


type OthersReadPermission
    = OthersReadPermissionEnabled
    | OthersReadPermissionDisabled


type OthersWritePermission
    = OthersWritePermissionEnabled
    | OthersWritePermissionDisabled


type OthersExecutePermission
    = OthersExecutePermissionEnabled
    | OthersExecutePermissionDisabled


type OwnerPermissions
    = OwnerPermissions OwnerReadPermission OwnerWritePermission OwnerExecutePermission


type GroupPermissions
    = GroupPermissions GroupReadPermission GroupWritePermission GroupExecutePermission


type OthersPermissions
    = OthersPermissions OthersReadPermission OthersWritePermission OthersExecutePermission


type UsersPermissions
    = UsersPermissions OwnerPermissions GroupPermissions OthersPermissions


initial : UsersPermissions
initial =
    UsersPermissions
        (OwnerPermissions OwnerReadPermissionDisabled OwnerWritePermissionDisabled OwnerExecutePermissionDisabled)
        (GroupPermissions GroupReadPermissionDisabled GroupWritePermissionDisabled GroupExecutePermissionDisabled)
        (OthersPermissions OthersReadPermissionDisabled OthersWritePermissionDisabled OthersExecutePermissionDisabled)


file : UsersPermissions
file =
    UsersPermissions
        (OwnerPermissions OwnerReadPermissionEnabled OwnerWritePermissionEnabled OwnerExecutePermissionDisabled)
        (GroupPermissions GroupReadPermissionEnabled GroupWritePermissionDisabled GroupExecutePermissionDisabled)
        (OthersPermissions OthersReadPermissionEnabled OthersWritePermissionDisabled OthersExecutePermissionDisabled)


folder : UsersPermissions
folder =
    UsersPermissions
        (OwnerPermissions OwnerReadPermissionEnabled OwnerWritePermissionEnabled OwnerExecutePermissionEnabled)
        (GroupPermissions GroupReadPermissionEnabled GroupWritePermissionDisabled GroupExecutePermissionEnabled)
        (OthersPermissions OthersReadPermissionEnabled OthersWritePermissionDisabled OthersExecutePermissionDisabled)


updateOwnerReadPermission : Bool -> UsersPermissions -> UsersPermissions
updateOwnerReadPermission ownerCanRead (UsersPermissions (OwnerPermissions _ writePermission executePermission) groupPermissions othersPermissions) =
    if ownerCanRead then
        UsersPermissions
            (OwnerPermissions OwnerReadPermissionEnabled writePermission executePermission)
            groupPermissions
            othersPermissions

    else
        UsersPermissions
            (OwnerPermissions OwnerReadPermissionDisabled writePermission executePermission)
            groupPermissions
            othersPermissions


updateOwnerWritePermission : Bool -> UsersPermissions -> UsersPermissions
updateOwnerWritePermission ownerCanWrite (UsersPermissions (OwnerPermissions ownerReadPermission _ ownerExecutePermission) groupPermissions othersPermissions) =
    if ownerCanWrite then
        UsersPermissions
            (OwnerPermissions ownerReadPermission OwnerWritePermissionEnabled ownerExecutePermission)
            groupPermissions
            othersPermissions

    else
        UsersPermissions
            (OwnerPermissions ownerReadPermission OwnerWritePermissionDisabled ownerExecutePermission)
            groupPermissions
            othersPermissions


updateOwnerExecutePermission : Bool -> UsersPermissions -> UsersPermissions
updateOwnerExecutePermission ownerCanExecute (UsersPermissions (OwnerPermissions ownerReadPermission ownerWritePermission _) groupPermissions othersPermissions) =
    if ownerCanExecute then
        UsersPermissions
            (OwnerPermissions ownerReadPermission ownerWritePermission OwnerExecutePermissionEnabled)
            groupPermissions
            othersPermissions

    else
        UsersPermissions
            (OwnerPermissions ownerReadPermission ownerWritePermission OwnerExecutePermissionDisabled)
            groupPermissions
            othersPermissions


updateGroupReadPermission : Bool -> UsersPermissions -> UsersPermissions
updateGroupReadPermission groupCanRead (UsersPermissions ownerPermissions (GroupPermissions _ groupWritePermission groupExecutePermission) othersPermissions) =
    if groupCanRead then
        UsersPermissions
            ownerPermissions
            (GroupPermissions GroupReadPermissionEnabled groupWritePermission groupExecutePermission)
            othersPermissions

    else
        UsersPermissions
            ownerPermissions
            (GroupPermissions GroupReadPermissionDisabled groupWritePermission groupExecutePermission)
            othersPermissions


updateGroupWritePermission : Bool -> UsersPermissions -> UsersPermissions
updateGroupWritePermission groupCanWrite (UsersPermissions ownerPermissions (GroupPermissions groupReadPermission _ groupExecutePermission) othersPermissions) =
    if groupCanWrite then
        UsersPermissions
            ownerPermissions
            (GroupPermissions groupReadPermission GroupWritePermissionEnabled groupExecutePermission)
            othersPermissions

    else
        UsersPermissions
            ownerPermissions
            (GroupPermissions groupReadPermission GroupWritePermissionDisabled groupExecutePermission)
            othersPermissions


updateGroupExecutePermission : Bool -> UsersPermissions -> UsersPermissions
updateGroupExecutePermission groupCanExecute (UsersPermissions ownerPermissions (GroupPermissions groupReadPermission groupWritePermission _) othersPermissions) =
    if groupCanExecute then
        UsersPermissions
            ownerPermissions
            (GroupPermissions groupReadPermission groupWritePermission GroupExecutePermissionEnabled)
            othersPermissions

    else
        UsersPermissions
            ownerPermissions
            (GroupPermissions groupReadPermission groupWritePermission GroupExecutePermissionDisabled)
            othersPermissions


updateOthersReadPermission : Bool -> UsersPermissions -> UsersPermissions
updateOthersReadPermission othersCanRead (UsersPermissions ownerPermissions groupPermissions (OthersPermissions _ othersWritePermission othersExecutePermission)) =
    if othersCanRead then
        UsersPermissions
            ownerPermissions
            groupPermissions
            (OthersPermissions OthersReadPermissionEnabled othersWritePermission othersExecutePermission)

    else
        UsersPermissions
            ownerPermissions
            groupPermissions
            (OthersPermissions OthersReadPermissionDisabled othersWritePermission othersExecutePermission)


updateOthersWritePermission : Bool -> UsersPermissions -> UsersPermissions
updateOthersWritePermission othersCanWrite (UsersPermissions ownerPermissions groupPermissions (OthersPermissions othersReadPermission _ othersExecutePermission)) =
    if othersCanWrite then
        UsersPermissions
            ownerPermissions
            groupPermissions
            (OthersPermissions othersReadPermission OthersWritePermissionEnabled othersExecutePermission)

    else
        UsersPermissions
            ownerPermissions
            groupPermissions
            (OthersPermissions othersReadPermission OthersWritePermissionDisabled othersExecutePermission)


updateOthersExecutePermission : Bool -> UsersPermissions -> UsersPermissions
updateOthersExecutePermission othersCanExecute (UsersPermissions ownerPermissions groupPermissions (OthersPermissions othersReadPermission othersWritePermission _)) =
    if othersCanExecute then
        UsersPermissions
            ownerPermissions
            groupPermissions
            (OthersPermissions othersReadPermission othersWritePermission OthersExecutePermissionEnabled)

    else
        UsersPermissions
            ownerPermissions
            groupPermissions
            (OthersPermissions othersReadPermission othersWritePermission OthersExecutePermissionDisabled)


canOwnerRead : UsersPermissions -> Bool
canOwnerRead (UsersPermissions (OwnerPermissions ownerReadPermission _ _) _ _) =
    case ownerReadPermission of
        OwnerReadPermissionEnabled ->
            True

        _ ->
            False


canOwnerWrite : UsersPermissions -> Bool
canOwnerWrite (UsersPermissions (OwnerPermissions _ ownerWritePermission _) _ _) =
    case ownerWritePermission of
        OwnerWritePermissionEnabled ->
            True

        _ ->
            False


canOwnerExecute : UsersPermissions -> Bool
canOwnerExecute (UsersPermissions (OwnerPermissions _ _ ownerExecutePermission) _ _) =
    case ownerExecutePermission of
        OwnerExecutePermissionEnabled ->
            True

        _ ->
            False


canGroupRead : UsersPermissions -> Bool
canGroupRead (UsersPermissions _ (GroupPermissions groupReadPermission _ _) _) =
    case groupReadPermission of
        GroupReadPermissionEnabled ->
            True

        _ ->
            False


canGroupWrite : UsersPermissions -> Bool
canGroupWrite (UsersPermissions _ (GroupPermissions _ groupWritePermission _) _) =
    case groupWritePermission of
        GroupWritePermissionEnabled ->
            True

        _ ->
            False


canGroupExecute : UsersPermissions -> Bool
canGroupExecute (UsersPermissions _ (GroupPermissions _ _ groupExecutePermission) _) =
    case groupExecutePermission of
        GroupExecutePermissionEnabled ->
            True

        _ ->
            False


canOthersRead : UsersPermissions -> Bool
canOthersRead (UsersPermissions _ _ (OthersPermissions othersReadPermission _ _)) =
    case othersReadPermission of
        OthersReadPermissionEnabled ->
            True

        _ ->
            False


canOthersWrite : UsersPermissions -> Bool
canOthersWrite (UsersPermissions _ _ (OthersPermissions _ othersWritePermission _)) =
    case othersWritePermission of
        OthersWritePermissionEnabled ->
            True

        _ ->
            False


canOthersExecute : UsersPermissions -> Bool
canOthersExecute (UsersPermissions _ _ (OthersPermissions _ _ othersExecutePermission)) =
    case othersExecutePermission of
        OthersExecutePermissionEnabled ->
            True

        _ ->
            False
