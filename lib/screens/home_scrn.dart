import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '/constants/colors.dart';
import '/cubit/shop_home/home_cubit.dart';
import '/cubit/shop_home/home_states.dart';
import '/screens/badge_scrn.dart';
import '/screens/search_scrn.dart';
import '/widgets/components.dart';

class HomeScrn extends StatelessWidget {
  const HomeScrn({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = HomeCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            title: const Text(
              'Shop',
            ),
            actions: [
              IconButton(
                icon: const Icon(
                  Icons.search,
                ),
                onPressed: () {
                  navigateTo(
                    context,
                    SearchScrn(),
                  );
                },
              ),
              Padding(
                padding: const EdgeInsets.only(right: 10.0),
                child: IconButton(
                  icon: const Icon(
                    Icons.badge,
                  ),
                  onPressed: () {
                    navigateTo(
                      context,
                      const BadgeScrn(),
                    );
                  },
                ),
              ),
            ],
          ),
          body: cubit.bottomScreens[cubit.currentIndex],
          bottomNavigationBar: ConvexAppBar(
            onTap: (index) {
              cubit.changeBottom(index);
            },
            height: 60,
            elevation: 4,
            activeColor: white,
            backgroundColor: defaultColor,
            initialActiveIndex: cubit.currentIndex,
            items: const [
              TabItem(icon: Icons.home, title: 'Home'),
              TabItem(icon: Icons.widgets, title: 'Categories'),
              TabItem(icon: Icons.favorite, title: 'Favorites'),
              TabItem(icon: Icons.settings, title: 'Settings'),
            ],
            //  const [
            //   BottomNavigationBarItem(
            //     icon: Icon( Icons.home),
            //     label: 'Home'),
            //   BottomNavigationBarItem(
            //     icon: Icon(Icons.apps),
            //     label: 'Categories',
            //   ),
            //   BottomNavigationBarItem(
            //     icon: Icon(Icons.favorite),
            //     label: 'Favorites',
            //   ),
            //   BottomNavigationBarItem(
            //     icon: Icon(
            //       Icons.settings,
            //     ),
            //     label: 'Settings',
            //   ),
            // ],
          ),
        );
      },
    );
  }
}
