import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:geeko_app/core/shared-prefrences/shared_prefrences_singleton.dart';
import 'package:geeko_app/module/get-started/screen/login.dart';
import 'package:geeko_app/module/homescreen/screen/homescreeen.dart';
import 'package:geeko_app/module/tags-selector.dart/screen/tags_selector.dart';

class RootScreen extends StatefulWidget {
  RootScreen({super.key});

  @override
  State<RootScreen> createState() => _RootScreenState();
}

class _RootScreenState extends State<RootScreen> {
  final FirebaseAuth firebase = FirebaseAuth.instance;

  bool? areTagsChoosen;
  @override
  void initState() {
    areTagsChoosen = Prefs.getBool("areTagsChoosen");
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return firebase.currentUser != null
        ? (areTagsChoosen == true ? HomeScreen() : const TagsSelector())
        : const LoginScreen();
  }
}
