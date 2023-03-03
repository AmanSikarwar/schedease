import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:schedease/firebase_options.dart';
import 'package:schedease/src/features/authentication/firebase_auth_repo.dart';
import 'package:schedease/src/features/authentication/sign_in_page.dart';
import 'package:schedease/src/features/home/home_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform);
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return const ProviderScope(
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: InitializerPage(),
      ),
    );
  }
}

class InitializerPage extends ConsumerWidget {
  const InitializerPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authProvider = ref.watch(firebaseAuthProvider);
    final currentUser = authProvider.currentUser;
    if (currentUser != null) {
      if (currentUser.email!.endsWith("iitmandi.ac.in")) {
        return const HomePage();
      } else {
        authProvider.signOut();
        return const SignInPage();
      }
    } else {
      return const SignInPage();
    }
  }
}
