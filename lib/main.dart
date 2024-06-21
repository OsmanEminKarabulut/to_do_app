import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:to_do_app/core/navigation.dart';
import 'package:to_do_app/core/service/firebase_service.dart';
import 'package:to_do_app/core/task_model.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => FirebaseService(),
        ),
        ChangeNotifierProvider(
          create: (context) => TaskModel(),
        )
      ],
      builder: (context, child) => const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      routerDelegate: Navigation.router.routerDelegate,
      routeInformationParser: Navigation.router.routeInformationParser,
      routeInformationProvider: Navigation.router.routeInformationProvider,
      title: 'To Do',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFFF4C27F)),
        useMaterial3: true,
      ),
    );
  }
}
