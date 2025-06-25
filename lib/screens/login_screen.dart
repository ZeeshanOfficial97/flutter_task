import 'package:flutter/material.dart';
import 'package:flutter_task/providers/auth_provider.dart';
import 'package:flutter_task/screens/home_screen.dart';
import 'package:flutter_task/widgets/custom_button.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    final authProvider = Provider.of<AuthProvider>(context);
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const Spacer(),
            const Text(
              "Flutter Task",
              style: TextStyle(
                  color: Colors.indigo,
                  fontWeight: FontWeight.bold,
                  fontSize: 24),
            ),
            const Spacer(),
            CustomButton(
                onPressed: () async {
                  await authProvider.signInAnonymously();
                  if (context.mounted) {
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (_) => const HomeScreen()));
                  } else {
                    return;
                  }
                },
                size: size,
                label: 'Sign in Anonymously')
          ],
        ),
      ),
    );
  }
}
