import 'package:flutter/material.dart';
import 'package:flutter_pract/features/menu/screens/menu_screen.dart';
import 'package:go_router/go_router.dart';

class AuthScreen extends StatelessWidget {
  const AuthScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.pink.shade50,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const CircleAvatar(
                radius: 60,
                backgroundColor: Colors.pink,
                child: Icon(
                  Icons.cake,
                  size: 40,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 16),

              const Text(
                'Sweet Delights',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.pink,
                ),
              ),
              const SizedBox(height: 4),
              const Text(
                'Кондитерская',
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey,
                ),
              ),
              const SizedBox(height: 24),

              TextField(
                decoration: InputDecoration(
                  labelText: 'Email',
                  prefixIcon: const Icon(Icons.email),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
              const SizedBox(height: 8),
              TextField(
                obscureText: true,
                decoration: InputDecoration(
                  labelText: 'Пароль',
                  prefixIcon: const Icon(Icons.lock),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
              const SizedBox(height: 16),

              SizedBox(
                width: double.infinity,
                height: 32,
                child: ElevatedButton(
                  onPressed: () {
                    context.pushReplacement('/menu');
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.pink,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text(
                    'Войти',
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 8),

              TextButton(
                onPressed: () {
                  context.pushReplacement('/menu');
                },
                child: const Text(
                  'Нет аккаунта? Зарегистрироваться',
                  style: TextStyle(
                    color: Colors.pink,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}