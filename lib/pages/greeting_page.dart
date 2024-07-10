import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:seesights/colors.dart';
import 'package:seesights/pages/welcome_screen.dart';
import 'package:seesights/widget/app_large_text.dart';
import 'package:seesights/widget/app_text.dart';
import 'package:seesights/widget/button.dart';


class GreetingPage extends StatefulWidget {
  const GreetingPage({Key? key});

  @override
  State<GreetingPage> createState() => _GreetingPageState();
}

class _GreetingPageState extends State<GreetingPage> {
  List<String> images = [
    "sunset.png",
    "scenery.png",
    "mountain.png",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: images.length,
        itemBuilder: (_, index) {
          return Container(
            width: double.maxFinite,
            height: double.maxFinite,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/images/" + images[index]),
                fit: BoxFit.cover,
              ),
            ),
            child: Container(
              margin: const EdgeInsets.only(top: 150, left: 20, right: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children:[
                  Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  AppLargeText(text: "Trips"),
                  AppText(text: "Mountain", size: 30),
                  SizedBox(height: 20),
                  Container(
                    width: 250,
                    child: AppText(
                      text: "A text or quote about Mountain",
                      color: Appcolors.textColor2,
                      size: 18,
                    ),
                  ),
                  /*SizedBox(height: 20),
                  Align(
                    alignment: Alignment.bottomRight, // Adjust alignment here
                    child: Text(
                      "Next>>",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 30, // Same size as "Mountain" text
                      ),
                    ),
                  ),*/
                  SizedBox(height: 40),

                  ElevatedButton(onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context)=> WelcomeScreen()));
                  },
                      child: ResponsiveButton(width: 120,),),

                ],
              ),
                 //
                 Column(
                   children: List.generate(3, (indexDots){
                     return Container(
                       margin: const EdgeInsets.only(bottom: 2),
                       width:8,
                       height: index == indexDots?25:8,
                         decoration: BoxDecoration(
                           borderRadius: BorderRadius.circular(8),
                           color:index == indexDots?Appcolors.maincolor:Appcolors.maincolor.withOpacity(0.3)
                         ),
                     );
                   }),
                 )
              ],
            ),
            ),
          );
        },
      ),
    );
  }
}
