# DatabaseTarget

## Table of Contents
| Name | Type |
|:--- | :--- |
[**`baseReference`**](#basereference) | Read-Only Property |
[**`path`**](#path) | Read-Only Property |
[**`task`**](#task) | Read-Only Property |
[**`queries`**](#queries) | Read-Only Property |
[**`onDisconnect`**](#ondisconnect) | Read-Only Property |
[**`localEvents`**](#localevents) | Read-Only Property |
[**`transactionBlock`**](#tranasctionblock) | Read-Only Property |
[**`uniqueID()`**](#uniqueid) | Method |

---

## `baseReference`
Base reference for your target in Database.

- **type**: Read-Only Property
- **return type**: FIRDatabaseReference

---

## `path`
Path to be appended to the base reference.

- **type**: Read-Only Property
- **return type**: String

---

## `task`
Type of task you want to perform. ( Firebase method: eg. observe, observeOnce, setValue, etc. )

- **type**: Read-Only Property
- **return type**: DatabaseTask

---

## `queries`
Queries to append to the end of the path in order as listed.

- **type**: Read-Only Property
- **return type**: [DatabaseQuery]?

Default Implementation:

```swift
var queries: [DatabaseQuery]? {
	return nil
}
```

---

## `onDisconnect`
Should task be performed on disconnect. ( Defaults to false )

- **type**: Read-Only Property
- **return type**: Bool

Default Implementation:

```swift
var onDisconnect: Bool {
	return false
}
```

---

## `localEvents`
Allow local events for transaction block. ( Defaults to false )

- **type**: Read-Only Property
- **return type**: Bool

Default Implementation:

```swift
var localEvents: Bool {
	return false
}
```

---

## `transactionBlock`
Transaction block to run for .transaction task.

- **type**: Read-Only Property
- **return type**: (FIRMutableData) -> FIRTransactionResult

Default Implementation:

```swift
var transactionBlock: (FIRMutableData) -> FIRTransactionResult {
    return { (data: FIRMutableData) in
        return FIRTransactionResult.success(withValue: data)
    }
}
```

---

## `uniqueID()`
Generate unique id String.

- **type**: Method
- **return type**: String

