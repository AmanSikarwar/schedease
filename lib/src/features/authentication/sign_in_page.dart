import 'package:auth_buttons/auth_buttons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:schedease/src/features/authentication/firebase_auth_repo.dart';

class SignInPage extends ConsumerWidget {
  const SignInPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xFFE0F7FA),
              Color(0xFFB2EBF2),
              Color(0xFF80DEEA),
              Color(0xFF4DD0E1),
              Color(0xFF26C6DA),
              Color(0xFF00BCD4),
              Color(0xFF00ACC1),
              Color(0xFF0097A7),
              Color(0xFF00838F),
              Color(0xFF006064),
            ],
          ),
        ),
        height: size.height,
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              mainAxisSize: MainAxisSize.max,
              children: [
                SizedBox(
                  height: size.height * 0.2,
                ),
                const FlutterLogo(
                  size: 100,
                ),
                SizedBox(
                  height: size.height * 0.1,
                ),
                const Text(
                  'Welcome to Schedease',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  height: size.height * 0.1,
                ),
                GoogleAuthButton(
                  onPressed: () => ref
                      .watch(authRepositoryProvider)
                      .signInWithGoogle()
                      .onError((error, stackTrace) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(error.toString()),
                      ),
                    );
                  }),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
