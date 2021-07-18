import 'package:flutter/material.dart';
import 'package:url_navigation_web/ui/main_screen.dart';

class LandingPage extends StatefulWidget {

  final String extra;

  const LandingPage({Key key, this.extra}) : super(key: key);
  @override
  _LandingPageState createState() => _LandingPageState();
}


class _LandingPageState extends State<LandingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:MainScreen(widget.extra) ,
    );
  }
}




/// u can see the url is not working perfectly.....ryt?
/// this flutter beta is not working fine....
/// for u to see this working fine...
/// run in release mode... 
/// will show u how to do that....
/// 
/// thats it.... u can do the same... to see the perfect output... or else u can change the flutter channel to dev....
/// its working fine in dev channel.... 
/// 
/// :)