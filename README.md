<p align="center">
   <img src="https://github.com/SD10/Nora/blob/master/Screenshots/NoraBanner.png"/>
 </p>
 
 <p align="center">
     <a href="https://codebeat.co/projects/github-com-sd10-nora-master">
         <img src="https://codebeat.co/badges/222038d6-dd5d-4253-94a6-63f00d3a1ae9" 
              alt="codebeat badge">
     </a>
     <a href="https://travis-ci.org/SD10/Nora">
         <img src="https://travis-ci.org/SD10/Nora.svg?branch=master"
              alt="Build Status">
     </a>
     <a href="https://swift.org">
       <img src="https://img.shields.io/badge/Swift-4.1-orange.svg"
            alt="Swift" />
     </a>
     <a href="https://developer.apple.com/xcode">
         <img src="https://img.shields.io/badge/Xcode-9.3-blue.svg"
              alt="Xcode">
     </a>
     <a href="https://opensource.org/licenses/MIT">
         <img src="https://img.shields.io/badge/License-MIT-red.svg"
              alt="MIT">
     </a>
     <a href="https://github.com/SD10/Nora/issues">
         <img src="https://img.shields.io/badge/contributions-welcome-brightgreen.svg?style=flat"
              alt="Contributions Welcome">
     </a>
     <a href="https://github.com/ellerbrock/open-source-badge/">
         <img src="https://badges.frapsoft.com/os/v1/open-source.svg?v=102"
              alt="Open Source Love">
     </a>
 </p>

---

Nora is a Firebase abstraction layer for working with FirebaseDatabase and FirebaseStorage.

Stop spending all that time cleaning up your view controllers and trying to write reusable Firebase code.

Let Nora handle that for you. Your time is better spent on what you do best. Writing great Apps!

Simply put, working with Firebase just got whole lot easier.

---

## Installation

### [CocoaPods](https://cocoapods.org) Recommended

```rb
  pod 'Nora'
```

## Example

### Working with FirebaseDatabase

After [setting up a target](https://github.com/SD10/Nora/blob/master/Documentation/Examples/DatabaseProviderExample.md) making requests is simple.

```swift

let database = DatabaseProvider<Users>()

database.request(.getUser(id: "1")) { result in
  switch result {
  case .success(let response):
    let snapshot = response.snapshot
  case .failure(let error):
    print(error.localizedDescription)
  }
}

```

### Database Response Decoding

Provide a JSON initializer for your custom types and easily convert the database response:

```swift

let database = DatabaseProvider<Users>()

database.request(.getUser(id: "1")) { result in
  switch result {
  case .success(let response):
    let user = try? response.mapTo(User.init)
  case .failure(let error):
    print(error.localizedDescription)
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
    print("Upload Success!")
  case .failure(let error):
    print(error.localizedDescription)
  }
}

```

---

## Documentation (In Progress)

[DatabaseTarget Documentation](https://github.com/SD10/Nora/blob/master/Documentation/Documentation/DatabaseTargetDocs.md)

[DatabaseProvider Documentation](https://github.com/SD10/Nora/blob/master/Documentation/Documentation/DatabaseProviderDocs.md)

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

---

## Inspiration

This project was inspired and based off the [Moya](https://github.com/Moya/Moya) networking abstraction layer in Swift.

Check out their project if you're using traditional networking!

---

## License

Nora is released under an MIT license. See [LICENSE.md](https://github.com/SD10/Nora/blob/master/LICENSE.md) for more information.
