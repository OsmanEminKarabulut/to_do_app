import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:to_do_app/core/service/firebase_service.dart';
import 'package:to_do_app/view/shared/constants.dart';
import 'package:to_do_app/view/shared/widgets/card_button.dart';
import 'package:to_do_app/view/shared/widgets/textfield_card.dart';

class SignInView extends StatelessWidget with ColorPalette {
  SignInView({super.key});

  final TextEditingController _emailController = TextEditingController();

  final TextEditingController _passwordController = TextEditingController();

  void goToSignUp(BuildContext context) {
    context.go("/sign_up");
  }

  @override
  Widget build(BuildContext context) {
    Future<void> signIn() async {
      if (_emailController.text.isNotEmpty &&
          _passwordController.text.isNotEmpty) {
        try {
          await Provider.of<FirebaseService>(context, listen: false)
              .signIn(_emailController.text, _passwordController.text);
          _emailController.clear();
          _passwordController.clear();
          context.go("/home");
        } catch (e) {
          ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text("Yanlış şifre veya email")));
        }
      }
    }

    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: backgroundColor,
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
        child: Center(
          child: bodyColumn(context, signIn, goToSignUp),
        ),
      ),
    );
  }

  Column bodyColumn(
      BuildContext context, VoidCallback signIn, Function goToSignUp) {
    return Column(
      children: [
        Image.asset("assets/images/Done.png"),
        Text(
          "Welcome back \n to",
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.bodyLarge,
        ),
        const Gap(15),
        Text(
          "OUR REMINDER",
          style: Theme.of(context).textTheme.headlineMedium,
        ),
        const Gap(80),
        TextfieldCard(
          label: "Enter your email",
          controller: _emailController,
        ),
        const Gap(15),
        TextfieldCard(
          label: "Enter password",
          controller: _passwordController,
        ),
        const Spacer(),
        TextButton(
            onPressed: () {},
            child: Text(
              "Forgot Password",
              style: Theme.of(context).textTheme.labelLarge,
            )),
        const Spacer(),
        CardButton(
          text: "Sign in",
          onPressed: signIn,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text("Don't have an account?"),
            TextButton(
                onPressed: () {
                  context.go("/sign_up");
                },
                child: const Text("Sign up"))
          ],
        )
      ],
    );
  }
}
