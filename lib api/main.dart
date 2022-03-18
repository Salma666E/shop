// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '/cubit/app/cubit.dart';
import '/cubit/app/states.dart';
import '/cubit/shop_home/home_cubit.dart';
import '/constants/style.dart';
import '/screens/splash_scrn.dart';
import '/utils/bloc_observer.dart';
import 'package:bloc/bloc.dart';
import '/utils/cache_helper.dart';
import '/utils/dio_helper.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  Bloc.observer = MyBlocObserver();
  DioHelper.init();
  await CacheHelper.init();

  bool? isDark = CacheHelper.getData(key: 'isDark') ?? false;

  runApp(MyApp(isDark!));
}

class MyApp extends StatelessWidget {
  final bool isDark;

  const MyApp(this.isDark, {Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (BuildContext context) => AppCubit(),
        ),
        BlocProvider(
          create: (BuildContext context) => HomeCubit()
            ..getHomeData()
            ..getCategoriesData()
            ..getFavoritesData()
            ..getUserData()
            ..getCart(),
        ),
      ],
      child: BlocConsumer<AppCubit, AppStates>(
        listener: (context, state) {},
        builder: (context, state) {
          print('isDark $isDark');
          return MaterialApp(
            title: 'Shop',
            debugShowCheckedModeBanner: false,
            themeMode:
                AppCubit.get(context).isDark ? ThemeMode.dark : ThemeMode.light,
            theme: themeLight,
            darkTheme: themeDark,
            home: const SplashScrn(),
          );
        },
      ),
    );
  }
}
