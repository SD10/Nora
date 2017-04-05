# Setting Up A DatabaseTarget

This library revolves around using enums to model endpoints in your Firebase database. 

The enums must conform to the DatabaseTarget protocol.

The `DatabaseTarget` protocol requires you to implement 4 properties:
- baseReference: this is the base reference for all database tasks in this target
- path: the path to be appended onto the base reference
- databaseTask: this is an enum that represents FirebaseDatabase methods (eg. observe, observeOnce, setValue, etc.)
- parameters: optional data to upload for a write task

---

```swift

enum Users: DatabaseTarget {
	
	case getUser(id: String)
	case deleteUser(id: String)
	case addFriend(id: String, userID: String)

	var baseReference: FIRDatabaseReference {
		return FIRDatabase.database().reference().child("users")
	}

	var path: String {

		switch self {
		case .getUser(let id), .deleteUser(let id):
			return "users/\(id)"
		case .addFriend(let id, let userid):
			return "users/\(userid)/\(id)"
		}

	}

	var task: DatabaseTask {

		switch self {
		case .getUser:
			return .observeOnce(.value)
		case .deleteUser:
			return .removeValue
		case .addFriend:
			return .setValue
		}

	}

	var parameters: [String: Any]? {

		switch self {
		case .getUser, .deleteUser:
			return nil
		case .addFriend(let friendID):
			return ["\(friendID)" : true ]
		}

	}

}

```

---
