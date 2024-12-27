import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_common_module/constants/color_constants.dart';
import 'package:flutter_common_module/pages/pages.dart';
import 'package:flutter_common_module/providers/auth_provider.dart';
import 'package:provider/provider.dart';

class SplashPage extends StatefulWidget {
  SplashPage({super.key});

  @override
  SplashPageState createState() => SplashPageState();
}

class SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 1), () {
      // just delay for showing this slash page clearer because it's too fast
    //  _checkSignedIn();

     ChatPageArguments args = ChatPageArguments(
        peerId: kIsWeb ? "2" : "1",
        peerNickname: kIsWeb ? "Shivam" : "Customer Support",
        peerAvatar: kIsWeb
            ? "https://cdn-icons-png.flaticon.com/512/958/958417.png":"https://media.licdn.com/dms/image/v2/D5603AQGWT74bIPx4Ew/profile-displayphoto-shrink_200_200/profile-displayphoto-shrink_200_200/0/1729153302022?e=1740009600&v=beta&t=EUpfd_BYoQtHrOx2yredq4Plxn6OEWKkfMmSxOs3Wkw"
             ,
      );
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (context) => ChatPage(
                  arguments: args,
                )),
      );
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset(
              "images/app_icon.png",
              width: 100,
              height: 100,
            ),
            SizedBox(height: 20),
            Container(
              width: 20,
              height: 20,
              child:
                  CircularProgressIndicator(color: ColorConstants.themeColor),
            ),
          ],
        ),
      ),
    );
  }
}
