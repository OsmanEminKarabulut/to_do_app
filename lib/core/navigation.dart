import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:to_do_app/view/home_view.dart';
import 'package:to_do_app/view/sign_in_view.dart';
import 'package:to_do_app/view/sign_up_view.dart';
import 'package:to_do_app/view/welcome_view.dart';

class Navigation {
  static final GoRouter router = GoRouter(routes: [
    GoRoute(
      path: "/",
      pageBuilder: (context, state) => buildPageWithDefaultTransition(
          context: context, state: state, child: WelcomeView()),
    ),
    GoRoute(
      path: "/sign_in",
      pageBuilder: (context, state) => buildPageWithDefaultTransition(
          context: context, state: state, child: SignInView()),
    ),
    GoRoute(
      path: "/sign_up",
      pageBuilder: (context, state) => buildPageWithDefaultTransition(
          context: context, state: state, child: SignUpView()),
    ),
    GoRoute(
      path: "/home",
      pageBuilder: (context, state) => buildPageWithDefaultTransition(
          context: context, state: state, child: HomeView()),
    ),
  ]);

  static CustomTransitionPage buildPageWithDefaultTransition({
    required BuildContext context,
    required GoRouterState state,
    required Widget child,
  }) {
    return CustomTransitionPage(
      key: state.pageKey,
      child: child,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const begin = Offset(1.0, 0.0);
        const end = Offset.zero;
        const curve = Curves.easeInOut;

        var tween =
            Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
        var offsetAnimation = animation.drive(tween);

        return SlideTransition(
          position: offsetAnimation,
          child: child,
        );
      },
    );
  }
}
