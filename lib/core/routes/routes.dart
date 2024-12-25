import 'package:flutter/material.dart';
import 'package:geeko_app/module/get-started/screen/login.dart';
import 'package:geeko_app/module/homescreen/screen/homescreeen.dart';
import 'package:geeko_app/module/root/screen/root_screen.dart';
import 'package:geeko_app/module/tags-selector.dart/screen/tags_selector.dart';
import 'package:go_router/go_router.dart';

CustomTransitionPage buildPageWithDefaultTransition<T>({
  required BuildContext context,
  required GoRouterState state,
  required Widget child,
}) {
  const begin = Offset(1.0, 0);
  const end = Offset.zero;
  const curve = Curves.ease;

  var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
  return CustomTransitionPage<T>(
    key: state.pageKey,
    child: child,
    transitionsBuilder: (context, animation, secondaryAnimation, child) =>
        SlideTransition(
      position: animation.drive(tween),
      child: child,
    ),
  );
}

final GoRouter router = GoRouter(
  routes: <RouteBase>[
    GoRoute(
      path: '/',
      builder: (BuildContext context, GoRouterState state) {
        return RootScreen();
      },
      routes: <RouteBase>[
        GoRoute(
          path: 'tagSelector',
          pageBuilder: (BuildContext context, GoRouterState state) =>
              buildPageWithDefaultTransition<void>(
            context: context,
            state: state,
            child: const TagsSelector(),
          ),
        ),
        GoRoute(
          path: 'homeScreen',
          pageBuilder: (BuildContext context, GoRouterState state) =>
              buildPageWithDefaultTransition<void>(
            context: context,
            state: state,
            child: HomeScreen(),
          ),
        ),
      ],
    ),
  ],
);
