import 'package:flutter/material.dart';
import 'package:intro_screen/home_screen.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class IntroScreen extends StatefulWidget {
  const IntroScreen({super.key});

  @override
  State<IntroScreen> createState() => _IntroScreenState();
}

class _IntroScreenState extends State<IntroScreen> {
  PageController pageController = PageController();
  bool onLastPage = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          PageView(
            onPageChanged: (index) {
              setState(() {
                onLastPage = index == 3;
              });
            },
            controller: pageController,
            children: const [
              ColoredBox(color: Colors.yellow),
              ColoredBox(color: Colors.blue),
              ColoredBox(color: Colors.red),
              ColoredBox(color: Colors.green)
            ],
          ),
          Padding(
            padding: const EdgeInsetsDirectional.only(bottom: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextButton(
                    onPressed: () {
                      pageController.jumpToPage(3);
                    },
                    child: const Text("Skip")),
                SmoothPageIndicator(
                  controller: pageController,
                  count: 4,
                  effect: const JumpingDotEffect(),
                  onDotClicked: (index) {
                    pageController.jumpToPage(index);
                  },
                ),
                onLastPage
                    ? TextButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const HomeScreen(),
                              ));
                        },
                        child: const Text("Done"))
                    : TextButton(
                        onPressed: () {
                          pageController.nextPage(
                              duration: const Duration(milliseconds: 500),
                              curve: Curves.easeInOut);
                        },
                        child: const Text("Next"))
              ],
            ),
          )
        ],
      ),
    );
  }
}
