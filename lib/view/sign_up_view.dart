import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:to_do_app/core/service/firebase_service.dart';
import 'package:to_do_app/view/shared/constants.dart';
import 'package:to_do_app/view/shared/widgets/card_button.dart';
import 'package:to_do_app/view/shared/widgets/textfield_card.dart';

class SignUpView extends StatelessWidget with ColorPalette {
  SignUpView({super.key});

  final TextEditingController _nameController = TextEditingController();

  final TextEditingController _emailController = TextEditingController();

  final TextEditingController _passwordController = TextEditingController();

  final TextEditingController _confirmPasswordController =
      TextEditingController();

  void goToSignIn(BuildContext context) {
    context.go("/sign_in");
  }

  @override
  Widget build(BuildContext context) {
    Future<void> signUp() async {
      if (_nameController.text.isNotEmpty &&
          _emailController.text.isNotEmpty &&
          _passwordController.text.isNotEmpty &&
          _confirmPasswordController.text.isNotEmpty &&
          _passwordController.text == _confirmPasswordController.text) {
        try {
          await Provider.of<FirebaseService>(context, listen: false).register(
              _emailController.text,
              _passwordController.text,
              _nameController.text);
          _emailController.clear();
          _nameController.clear();
          _passwordController.clear();
          _confirmPasswordController.clear();
          context.go("/home");
        } on FirebaseException catch (e) {
          if (e.code == "email-already-in-use") {
            ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text("Email kullanılmış")));
          }
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Tüm alanları doldurunuz.")));
      }
    }

    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: backgroundColor,
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
        child: Center(
          child: bodyColumn(context, signUp, goToSignIn),
        ),
      ),
    );
  }

  Column bodyColumn(
      BuildContext context, VoidCallback signUp, Function goToSignIn) {
    return Column(
      children: [
        Image.asset("assets/images/Done.png"),
        Text(
          "Get's things done \n with TODO",
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.headlineMedium,
        ),
        const Gap(15),
        Text(
          "Let's help you meet your tasks",
          style: Theme.of(context)
              .textTheme
              .labelMedium
              ?.copyWith(color: Colors.blueGrey),
        ),
        const Gap(15),
        TextfieldCard(
          label: "Enter your full name",
          controller: _nameController,
        ),
        const Gap(15),
        TextfieldCard(
          label: "Enter your email",
          controller: _emailController,
        ),
        const Gap(15),
        TextfieldCard(
          label: "Enter password",
          controller: _passwordController,
        ),
        const Gap(15),
        TextfieldCard(
          label: "Confirm password",
          controller: _confirmPasswordController,
        ),
        const Spacer(),
        CardButton(
          text: "Register",
          onPressed: signUp,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text("Already have an account?"),
            TextButton(
                onPressed: () {
                  goToSignIn(context);
                },
                child: const Text("Sign in"))
          ],
        )
      ],
    );
  }
}
