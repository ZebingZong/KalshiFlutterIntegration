## Demos
![Page 1](/Demos/1.png)
![page 2](/Demos/2.png)
![Page 3](/Demos/3.png)
![Page 4](/Demos/4.png)
![Page 4](/Demos/5.png)

## How to run the project
1. go to flutter main project fold and build flutter pages for iOS. From the CLI, run:
```
cd kalshi_flutter
flutter pub get
```
- since we don't need to run on iOS devices for now, just ignore the errors if encountered:
```
It appears that your application still contains the default signing identifier.
Try replacing 'com.example' with your signing id in Xcode:
  open ios/Runner.xcworkspace
Encountered error while building for device.
```
2. go to flutterIntegration main project folder and install necessary dependencies. From the CLI, run:
```
cd ../
pod install
```
3. open `KalshiFlutterIntegration.xcworkspace`, select the appropriate iOS simulator and run


## The overall VC tree


```
                                        Application
                                            |
                                    KSRootTabBarController
                                            |
        -----------------------------------------------------------------------
        |                      |                      |                       |
KSDrawerViewController  presentingContainer  UINavigationController  UINavigationController
                               |                      |                       | 
                    KSModalFlutterViewController  KSTabHomeViewController  KSTabFlutterViewController

```

## The responsibilities of each VC
1. `KSRootTabBarController` is the central hub of the application: 
    - open / close left drawer
    - present / dismiss model flutterVC
    - container for `KSTabHomeViewController` and `KSTabFlutterViewController`

2. `KSDrawerViewController` is the left drawer
    - it communicates to `KSRootTabBarController` with `KSDrawerViewControllerListener` to open/close modelFlutterViewController and close itself

3. presentingContainer is just a transparent VC and pass touch event down to parent
    - it is responsible to present the full screen modal flutter vc

4. `KSModalFlutterViewController` is the full screen presented modal flutter vc
    - it communicates to `KSRootTabBarController` with `KSModalFlutterViewControllerListener` to open left drawer and close itself
    - it also communicates to Flutter client with `MethodChannel`

5. `KSTabHomeViewController` is the content VC of first tab
    - it communicates to `KSRootTabBarController` with `KSTabHomeViewControllerListener` to open drawer and present full screen modal flutter vc

6. `KSTabFlutterViewController` is the cotent VC of second tab
    - it communicates to `KSRootTabBarController` with `KSTabFlutterViewControllerListener` to open left drawer


