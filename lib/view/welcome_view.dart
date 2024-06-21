import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:to_do_app/view/shared/constants.dart';
import 'package:to_do_app/view/shared/widgets/card_button.dart';

class WelcomeView extends StatelessWidget with ColorPalette, Paddings {
  WelcomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      body: Padding(
        padding: bodyPadding,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Spacer(),
            Image.asset(
              "assets/images/Done.png",
              fit: BoxFit.cover,
              width: 500,
            ),
            Text(
              "Welcome to",
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            const Gap(5),
            Text(
              "OUR REMINDER",
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const Gap(15),
            const Text(
              "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Interdum dictum tempus, interdum at dignissim metus. Ultricies sed nunc.",
              textAlign: TextAlign.center,
            ),
            const Spacer(),
            CardButton(
                onPressed: () {
                  context.go("/sign_in");
                },
                text: "Get Start ->")
          ],
        ),
      ),
    );
  }
}
