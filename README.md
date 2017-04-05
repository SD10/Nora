# Nora

![Nora](https://github.com/SD10/Nora/blob/master/NoraBanner.png)

---

Nora is a Firebase abstraction layer for working with FirebaseDatabase and FirebaseStorage.

You shouldn't have to spend all your time cleaning up your view controllers and trying to write reusable Firebase code. 
Let Nora handle that for you. Your time is better spent on what you do best. Writing great Apps!

Simply put, working with Firebase just got whole lot easier.

---

## Installation

Firebase is currently shipped as a static framework - which prevents Nora from having Cocoapods support.

Don't fret though! This just means the installation process is even simpler!

You just have to download Nora, drag the `Sources` folder into your project, and download the dependencies.

---

### Step 1

Click Download Zip to download the Nora project

![Step 1](https://github.com/SD10/Nora/blob/master/Screen%20Shot%202017-04-05%20at%204.07.48%20AM.png)

---

### Step 2

Open the Nora.xcodeproj project and drag the `Sources` folder into your App

![Step 2](https://github.com/SD10/Nora/blob/master/Screen%20Shot%202017-04-05%20at%204.10.29%20AM.png)

---

### Step 3

Download Nora's dependencies using Cocoapods. Add them to your podfile

```rb

pod `FirebaseDatabase`

pod `FirebaseStorage`

```

Then run `pod install`

And that's it!

---

## Example

### Working with FirebaseDatabase

```swift

let database = DatabaseProvider<Users>()

database.request(.getUser(id: "1")) { result in
	switch result {
	case .success(let response):
		print("Nora: Download Success!")
		let snapshot = response.snapshot
	case .failure(let error):
		print("We failed")
	}
}

```

---

### Working with FirebaseStorage

```swift

let storage = StorageProvider<Avatars>()
let avatarData = Data()
var meta = FIRStorageMetadata?

storage.request(.upload(avatarData, meta)) { result in 
	switch result {
	case .success(_):
		print("Nora: Upload Success!")
	case .failure(let error):
		print("Something went wrong")
	}
}

```

---

## Get involved

You can contribute to this project in more ways than just code:

- Improving the README
- Improving Documentation
- Bug reporting
- New feature suggestions
- Answering questions

We really encourage everyone to get involved in open source. 

Your feedback is always welcome and much appreciated!

REGARDLESS, of your level of experience.

You will never be put down for having an opinion. So take a chance, open a pull request, or submit that issue!




