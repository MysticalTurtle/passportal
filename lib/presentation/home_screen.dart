import 'package:flutter/material.dart';
import 'package:passportal/presentation/register/register_page.dart';

import 'view_flights/passports_page.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          color: Colors.white,
        ),
        SizedBox.expand(
          child: Image.asset(
            "assets/background.jpg",
            fit: BoxFit.cover,
            opacity: const AlwaysStoppedAnimation(0.4),
          ),
        ),
        Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            centerTitle: true,
            title: const Text("PassPortal"),
          ),
          body: Align(
            alignment: Alignment.topCenter,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 70.0),
                  child: Image.asset(
                    "assets/passport.png",
                    width: 150,
                  ),
                ),
                const _HomeButton(
                  pageToPush: RegisterPage(),
                  icon: Icons.flight,
                  text: "Registrar abordo",
                ),
                const SizedBox(height: 20),
                const _HomeButton(
                  pageToPush: PassportsPage(),
                  icon: Icons.app_registration_rounded,
                  text: "Ver registros",
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _HomeButton extends StatelessWidget {
  const _HomeButton({required this.pageToPush, required this.icon, required this.text});
  final Widget pageToPush;
  final IconData icon;
  final String text;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        Navigator.of(context).push(MaterialPageRoute(builder: (_) => pageToPush));
      },
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon),
          const SizedBox(width: 10),
          Text(text),
        ],
      ),
    );
  }
}