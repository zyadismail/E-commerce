import 'package:e_commerceitsharks/Cubits/App/app_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:awesome_icons/awesome_icons.dart';
import '../../Shared/Colors/colors.dart';


class HomeLayout extends StatelessWidget {
  const HomeLayout({super.key});

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return BlocConsumer<AppCubit, AppState>(
  listener: (context, state) {
    // TODO: implement listener
  },
  builder: (context, state) {
    var cubit = AppCubit.get(context);
    return Scaffold(
      backgroundColor: Colors.white,
      body: cubit.myScreens[cubit.indexscreen],
      bottomNavigationBar:  Container(
        child: Padding(
          padding:  EdgeInsets.symmetric(horizontal: width * 0.02, vertical: height * 0.01),
          child: GNav(
            selectedIndex: 0,
            backgroundColor: Colors.transparent,
            hoverColor: Colors.white, // tab button hover color
            haptic: true, // haptic feedback
            tabBorderRadius: 10, // tab animation curves
            duration: const Duration(milliseconds: 400) ,// tab animation duration
            gap: width*0.03, // the tab button gap between icon and text
            color: Colors.grey, // unselected icon color
            activeColor: AppColor.primaryColor, // selected icon and text color
            iconSize: 24, // tab button icon size
            tabBackgroundColor: Colors.white.withOpacity(0.2), // selected tab background color
            padding:  EdgeInsets.symmetric(horizontal: width*0.04, vertical: height*0.015), // navigation bar padding
            tabs: const [
              GButton(
                icon: FontAwesomeIcons.home,
              ),
              GButton(
                icon: FontAwesomeIcons.shoppingBag,
              ),
              GButton(
                icon: FontAwesomeIcons.heart,
              ),
              GButton(
                icon: FontAwesomeIcons.shoppingBasket,
              ),
              GButton(
                icon: Icons.settings,
                iconSize: 25,
              )
            ],
            onTabChange: (index){
              cubit.changeIndeXScreen(index);
            },
          ),
        ),
      ),
    );
  },
);
  }
}
