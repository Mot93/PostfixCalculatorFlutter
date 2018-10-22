import 'package:flutter/material.dart'; // General purpose
import 'package:firebase_admob/firebase_admob.dart'; // Ads
import 'package:flutter/services.dart'; // Lock screen orientation


import 'home_page.dart';

// TODO: manage the app in portrait mode

// Ads ID
const appId = '1:856342789770:android:5de8aef557c0e13d';

MobileAdTargetingInfo targetingInfo = new MobileAdTargetingInfo(
  keywords: <String>['flutterio', 'beautiful apps'],
  contentUrl: 'https://flutter.io',
  birthday: new DateTime.now(),
  childDirected: false,
  designedForFamilies: false,
  gender: MobileAdGender.male, // or MobileAdGender.female, MobileAdGender.unknown
  testDevices: <String>[], // Android emulators are considered test devices
);

BannerAd myBanner = new BannerAd(
  // Replace the testAdUnitId with an ad unit id from the AdMob dash.
  // https://developers.google.com/admob/android/test-ads
  // https://developers.google.com/admob/ios/test-ads
  // adUnitId: BannerAd.testAdUnitId, // Test
  adUnitId: 'ca-app-pub-4047734154628476/5063815544', // Real and functioning
  size: AdSize.smartBanner,
  targetingInfo: targetingInfo,
  listener: (MobileAdEvent event) {
    print("BannerAd event is $event");
  },
);

// Run the app
void main() => runApp(MyApp());
class MyApp extends StatefulWidget {

  @override
  _MyAppState createState() => _MyAppState();

}// MyApp


// State of my app
class _MyAppState extends State<MyApp>{

  @override
  void initState() {
    super.initState();
    // Initiate the 
    FirebaseAdMob.instance.initialize(appId: appId);
    // Lock the sceen in Portrait up
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  }


  @override
  Widget build(BuildContext context) {

    // Displaying my banner ad
    myBanner
      // typically this happens well before the ad is shown
      ..load()
      ..show(
        // Positions the banner ad 60 pixels from the bottom of the screen
        anchorOffset: 0.0,
        // Banner Position
        anchorType: AnchorType.bottom,
      );

    // Creating the widget
    return Material(
      child: MaterialApp(
        debugShowCheckedModeBanner: true,
        title: "PostfixCalculator",
        // TODO: set the app theme
        theme: ThemeData(
          backgroundColor: Colors.white,
        ),
        home: HomePage(),
        // With this builder the whole app is going to be above the ad
        builder: (BuildContext context, Widget child){
          return Padding(
            padding: EdgeInsets.only(bottom: 50.0), // The ad is only 50 px high
            child: child,
          );
        },
      ),
    );
  }// build

}// _MyAppState