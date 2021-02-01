import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hala_app_sample/common/app_constants_or_strings/strings_or_constants.dart';
import 'package:hala_app_sample/common/widgets/widgets.dart';
import 'package:hala_app_sample/localization/app_localizations.dart';
import 'package:lottie/lottie.dart';

class LottieAnimationSample extends StatefulWidget {
  @override
  _LottieAnimationSampleState createState() => _LottieAnimationSampleState();
}

class _LottieAnimationSampleState extends State<LottieAnimationSample> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Container(
        decoration: new BoxDecoration(
            image: new DecorationImage(image:
            new AssetImage(CommonImagePaths().backgroundImage), fit: BoxFit.cover)
        ),
        child: ListView(
          children: <Widget>[
            Container(
              child: CommonWidgets(title: AppLocalizations.of(context).translate('LottieAnimationSample'),imgPath: CommonImagePaths().iconBack,),
            ),
            Lottie.asset('assets/lottie_json/lottie_motorcycle.json',
            frameRate: FrameRate(60)),
            Container( // load lottie animation from json
              padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
              child: SizedBox(
                width: (MediaQuery.of(context).size.width),
                height: (MediaQuery.of(context).size.height) * 0.03,
                child: Lottie.asset('assets/lottie_json/lottie-slow-loading.json',
                repeat: true,
                reverse: false,
                animate: true,
                frameRate: FrameRate(60)),
              ),
            ),
            Container( // load lottie animation from net
              padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
              child: SizedBox(
                width: (MediaQuery.of(context).size.width),
                height: (MediaQuery.of(context).size.height) * 0.25,
                child: Lottie.network(
                    'https://raw.githubusercontent.com/xvrh/lottie-flutter/master/example/assets/Mobilo/A.json'
                ),
              ),
            ),
            Container( // load lottie animation from zip file
              padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
              child: SizedBox(
                width: (MediaQuery.of(context).size.width),
                height: (MediaQuery.of(context).size.height) * 0.10,
                child: Lottie.asset('assets/lottie_json/lottie-slow-loading_zip.zip'),
              ),
            ),
            Container( // load lottie animation from zip file
              padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
              child: SizedBox(
                width: (MediaQuery.of(context).size.width),
                height: (MediaQuery.of(context).size.height) * 0.20,
                child: Lottie.asset('assets/lottie_json/fast-slow-loading.json'),
              ),
            ),
          ],
       ),
      ),
    );

  }
}