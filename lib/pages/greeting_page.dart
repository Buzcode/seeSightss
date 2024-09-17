import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:seesights/colors.dart';
import 'package:seesights/pages/welcome_screen.dart';
import 'package:seesights/widget/app_large_text.dart';
import 'package:seesights/widget/app_text.dart';

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

  List<String> titles = [
    "Mountain Hiking",
    "Ocean Shores",
    "Frozen Worlds",
  ];

  List<String> tips = [
    "• Pack warm clothes.\n• Wear comfortable shoes for hiking.\n• Bring a camera to capture stunning scenery.",
    "• Protect yourself from the sun with sunscreen and a hat.\n• Pack light clothing and swimwear.\n• Consider snorkeling or diving.",
    "• Pack layers of warm clothing, including a hat and gloves.\n• Be cautious on icy surfaces.\n• Pack waterproof boots for snowy conditions.",
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
            child: Stack(
              children: [
                Container(
                  margin: const EdgeInsets.only(top: 150, left: 20, right: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          AppLargeText(text: "Trips"),
                          AppText(text: titles[index], size: 30),
                          SizedBox(height: 20),
                          Container(
                            width: 280,
                            child: Text(
                              tips[index],
                              style: TextStyle(
                                color: Appcolors.textColor2,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                              textAlign: TextAlign.left,
                            ),
                          ),
                          SizedBox(height: 40),
                          // Show button only on the last image
                          if (index == images.length - 1)
                            Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                gradient: LinearGradient(
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter,
                                  colors: [
                                    Appcolors.maincolor.withOpacity(0.8),
                                    Appcolors.maincolor.withOpacity(0.6),
                                  ],
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.5),
                                    spreadRadius: 2,
                                    blurRadius: 5,
                                    offset: Offset(0, 3),
                                  ),
                                ],
                              ),
                              child: InkWell(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => WelcomeScreen(),
                                    ),
                                  );
                                },
                                child: Container(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 40,
                                    vertical: 15,
                                  ),
                                  child: Center(
                                    child: AppText(
                                      text: "Next",
                                      color: Colors.white,
                                      size: 20,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                        ],
                      ),
                    ],
                  ),
                ),
                // Position the dots at the bottom center
                Positioned(
                  bottom: 20,
                  left: 0,
                  right: 0,
                  child: Align(
                    alignment: Alignment.bottomCenter, // Align to bottom center
                    child: Row( // Changed to Row for vertical dots
                      mainAxisAlignment: MainAxisAlignment.center, // Center horizontally
                      children: List.generate(3, (indexDots) {
                        return Padding(
                          padding: const EdgeInsets.only(right: 10), // Add spacing between dots
                          child: Container(
                            height: 10, // Make height and width equal for circular dots
                            width: 10, // Make height and width equal for circular dots
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(100), // Make them circular
                              color: index == indexDots
                                  ? Appcolors.maincolor
                                  : Appcolors.maincolor.withOpacity(0.3),
                            ),
                          ),
                        );
                      }),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}