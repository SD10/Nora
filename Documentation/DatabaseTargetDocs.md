# DatabaseProvider

## Table of Contents
| Name | Type |
|:--- | :--- |
| [**`request(_ target: DatabaseTarget, completion: DatabaseCompletion)`**](#) | Method |
| [**`request(_ target: DatabaseTarget)`**](#) | Method |

---

## `request(_ target: DatabaseTarget, completion: DatabaseCompletion)`
Make a request to FirebaseDatabase.

- **type**: Method
- **parameters**:
    - **target**: target for the request.
    - **completion**: completion block with result of the request.
    - **returns**: a handle in the case of an observe request, used to unregister the observer (optional)
- **return type**: UInt? (@discardableResult)

Example

```swift
let provider = DatabaseProvider<Users>()

provider.request(.allUsers) { result in 
	switch result {
	case .success(let response):
	    let snapshot = response.snapshot
	case .failure(let error):
		print(error.localizedDescription)
	}
}

```

---

## `request(_ target: DatabaseTarget, completion: DatabaseCompletion = { _ in })`
Make a request to FirebaseDatabase without a completion block. (Note: Do not use this for read requests)

- **type**: Method
- **parameters**:
    - **target**: target for the request.
    - **completion**: completion block with result of the request.
    - **returns**: a handle in the case of an observe request, used to unregister the observer (optional).
- **return type**: UInt? (@discardableResult)

Example

```swift
let provider = DatabaseProvider<Users>()
provider.request(.createUser(id: "1", email: "nora@email.com"))

```
