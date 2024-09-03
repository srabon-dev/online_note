import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:online_note/view/screen/home/home_screen.dart';
import 'package:online_note/view/screen/login/login_screen.dart';
import 'package:online_note/view/screen/note/note_add_screen.dart';
import 'package:online_note/view/screen/register/register_screen.dart';
import 'package:online_note/view/screen/splash/splash_screen.dart';

class AppRoute {
  static final AppRoute _instance = AppRoute._internal();

  factory AppRoute() {
    return _instance;
  }

  AppRoute._internal();

  final GoRouter router = GoRouter(
    initialLocation: "/",
    routes: [
      GoRoute(
        path: "/",
        builder: (BuildContext context, GoRouterState state) => const SplashScreen(),
      ),
      GoRoute(
        path: "/login",
        builder: (BuildContext context, GoRouterState state) => const LoginScreen(),
      ),
      GoRoute(
        path: "/register",
        builder: (BuildContext context, GoRouterState state) => const RegisterScreen(),
      ),
      GoRoute(
        path: "/home",
        builder: (BuildContext context, GoRouterState state) => const HomeScreen(),
      ),
      GoRoute(
        path: "/add_note",
        builder: (BuildContext context, GoRouterState state) => const NoteAddScreen(),
      ),
    ],
  );
}
