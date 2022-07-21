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
                        UINavigationController  KSTabHomeViewController  KSTabFlutterViewController
                               |
                    KSModalFlutterViewController

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
    - it commicates to `KSRootTabBarController` with `KSModalFlutterViewControllerListener` to open left drawer and close itself

5. `KSTabHomeViewController` is the content VC of first tab
    - it communicates to `KSRootTabBarController` with `KSTabHomeViewControllerListener` to open drawer and present full screen modal flutter vc

6. `KSTabFlutterViewController` is the cotent VC of second tab
    - it communicates to `KSRootTabBarController` with `KSTabFlutterViewControllerListener` to open left drawer


