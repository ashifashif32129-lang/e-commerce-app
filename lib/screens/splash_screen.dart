import 'dart:async';

import 'package:flutter/material.dart';

import 'onboarding_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    super.initState();

    Timer(
      const Duration(seconds: 3),
          () {
        if (!mounted) return;

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const OnboardingScreen(),
          ),
        );
      },
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [

              // Shopping Bag Icon
              Container(
                width: 110,
                height: 110,
                decoration: BoxDecoration(
                  color: const Color(0xFF6938EF),
                  borderRadius: BorderRadius.circular(18),
                ),
                child: const Icon(
                  Icons.shopping_bag,
                  color: Colors.white,
                  size: 70,
                ),
              ),

              const SizedBox(height: 25),

              // Logo Name
              RichText(
                text: const TextSpan(
                  style: TextStyle(
                    fontSize: 42,
                    fontWeight: FontWeight.bold,
                  ),
                  children: [
                    TextSpan(
                      text: 'Shop',
                      style: TextStyle(
                        color: Color(0xFF07142D),
                      ),
                    ),
                    TextSpan(
                      text: 'Ease',

                      style: TextStyle(
                        color: Color(0xFF6938EF),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 8),

              const Text(
                'Shop Smarter',
                style: TextStyle(
                  fontSize: 17,
                  color: Color(0xFF777777),
                  fontWeight: FontWeight.w400,
                ),
              ),

              const Text(
                'Live Better',
                style: TextStyle(
                  fontSize: 16,
                  color: Color(0xFF777777),
                  fontWeight: FontWeight.w400,
                ),
              ),

              const SizedBox(height: 80),

              SizedBox(
                width: 120,
                child: LinearProgressIndicator(
                  minHeight: 4,
                  color: const Color(0xFF6938EF),
                  backgroundColor: Colors.grey.shade300,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}