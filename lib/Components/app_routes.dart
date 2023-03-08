import 'dart:developer';

import 'package:flutter/material.dart';

class AppRoutes {
  static const String homeRoute = '/';
  static const String addNotesRoute = '/add-notes';
  static const String profileRoute = '/profile-page';



  void navigateTo(BuildContext context, String routeName) {
    switch (routeName) {
      case AppRoutes.homeRoute:
        Navigator.pushNamed(context, AppRoutes.homeRoute);
        break;
      case AppRoutes.addNotesRoute:
        Navigator.pushNamed(context, AppRoutes.addNotesRoute);
        break;
    
      default:
       log('Invalid route');
    }
  }
}



