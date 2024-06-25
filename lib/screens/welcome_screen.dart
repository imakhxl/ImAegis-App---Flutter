import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:app3/constants.dart';


class WelcomePage extends StatefulWidget {
  const WelcomePage({super.key});
  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage>{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kColor1,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              children: [
                Hero(
                  tag: 'logo',
                  child: Container(
                    height: 100.0,
                    child: Image.asset('assets/img1.png'),
                  ),
                ),
                Container(
                  child: TextLiquidFill(
                    text: 'IMAEGIS',
                    waveColor: kColor4,
                    boxBackgroundColor: kColor1,
                    loadDuration: Duration(seconds: 2),
                    boxHeight: 81,
                    boxWidth: 250,
                    textStyle: TextStyle(
                      fontSize: 45.0,
                      fontFamily: 'Pacifico',
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 35.0,
            ),
            Row(
              children: [
                kIcon,
                Text('   Select a file',
                    textAlign: TextAlign.center, style: kStepTextStyle),
              ],
            ),
            SizedBox(height: 20),
            Row(
              children: [
                kIcon,
                Text('   Choose whether to Encrypt \n   or Decrypt',
                    textAlign: TextAlign.start, style: kStepTextStyle),
              ],
            ),
            SizedBox(height: 20.0),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                kIcon,
                Text("   Check 'MyEncFolder' in your \n   Internal Storage",
                    textAlign: TextAlign.start, style: kStepTextStyle),
              ],
            ),
            SizedBox(
              height: 25.0,
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/first');
              },
              child: Text(
                "LET'S GO!",
                style: TextStyle(color: kColor4, fontWeight: FontWeight.w500),
              ),
              style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(kColor2)),
            ),
          ],
        ),
      ),
    );
  }
}
