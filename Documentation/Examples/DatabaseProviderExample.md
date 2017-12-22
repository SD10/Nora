# Setting Up A DatabaseTarget

This library revolves around using enums to model endpoints in your Firebase database. 

The enums must conform to the DatabaseTarget protocol.

The `DatabaseTarget` protocol requires you to implement 3 properties:
- baseReference: this is the base reference for all database tasks in this target
- path: the path to be appended onto the base reference
- task: this is an enum that represents FirebaseDatabase methods (eg. observe, observeOnce, setValue, etc.)

---

```swift

enum Users: NRDatabaseTarget {
	
	case getUser(id: String)
	case createUser(email: String, name: String)
	case deleteUser(id: String)

	var baseReference: FIRDatabaseReference {
		return Database.database().reference().child("users")
	}

	var path: String {

		switch self {
		case .getUser(let id), .deleteUser(let id):
			return id
		case .createUser:
			return uniqueID()
		}

	}

	var task: NRDatabaseTask {

		switch self {
		case .getUser:
			return .observeOnce(.value)
		case .deleteUser:
			return .removeValue
		case .createUser(let email, let name):
			return .setValue(["email": email, "name": name])
		}

	}

}

```

---
