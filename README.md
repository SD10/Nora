# Nora

Nora is a Firebase abstraction layer for working with FirebaseDatabase and FirebaseStorage.

You shouldn't have to spend all your time cleaning up your view controllers and trying to write reusable Firebase code. 
Let Nora handle that for you. Your time is better spent on what you do best. Writing great Apps!

Simply put, working with Firebase just got whole lot easier.

---

## Installation

Firebase is currently shipped as a static framework - which prevents Nora from having Cocoapods support.

Don't fret though! This just means the installation process is even simpler!

You just have to download Nora, drag the `Sources` folder into your project, and download the dependencies.

### Step 1

Click Download Zip to download the Nora project

![Step 1](https://github.com/SD10/Nora/blob/master/Screen%20Shot%202017-04-05%20at%204.07.48%20AM.png)

### Step 2

Open the Nora.xcodeproj project and drag the `Sources` folder into your App

![Step 2](https://github.com/SD10/Nora/blob/master/Screen%20Shot%202017-04-05%20at%204.10.29%20AM.png)

### Step 3

Download Nora's dependencies using Cocoapods. Add them to your podfile

```rb

pod `FirebaseDatabase`

pod `FirebaseStorage`

```

Then run `pod install`

And that's it!

---

