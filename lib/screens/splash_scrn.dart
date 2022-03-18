import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import '/cubit/app/cubit.dart';
import '/constants/colors.dart';
import '/constants/const_variables.dart';
import '/screens/home_scrn.dart';
import '/screens/login_scrn.dart';
import '/utils/cache_helper.dart';

import 'onboarding_scrn.dart';

class SplashScrn extends StatefulWidget {
  const SplashScrn({Key? key}) : super(key: key);

  @override
  State<SplashScrn> createState() => _SplashScrnState();
}

class _SplashScrnState extends State<SplashScrn> {
  late bool showSpinner;
  late bool onBoarding ;
    late Widget child;
  @override
  void initState() {
    super.initState();
    showSpinner = true;
      onBoarding = CacheHelper.getData(key: 'onBoarding')?? false;
token = CacheHelper.getData(key: 'token');

    Timer(const Duration(seconds: 2), () {
      setState(() {
        showSpinner = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
   
    if (showSpinner == false) {
      if (onBoarding) {
        if(token != '') {
          child = const HomeScrn();
        } else {child =  LoginScrn();}
      } else {
        child = const OnBoardingScrn();
      }
    } else {
      child = SpinKitCircle(
        color: AppCubit.get(context).isDark ? white : defaultColor,
        size: 150.0,
      );
    }

    return SafeArea(
      child: Scaffold(
        body: Center(
          child: child,
        ),
      ),
    );
  }
}
