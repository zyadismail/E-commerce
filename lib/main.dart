import 'package:flutter_bloc/flutter_bloc.dart';

import 'Cubits/App/app_cubit.dart';
import 'Cubits/Auth/auth_cubit.dart';
import 'package:flutter/material.dart';

import 'Cubits/bloc_observer.dart';
import 'Network/Local/CashHelper.dart';
import 'Network/Remote/dio_helper.dart';
import 'Screen/HomeLayout/home_layout.dart';
import 'Screen/Login/login_screen.dart';

void main() async{
  await WidgetsFlutterBinding.ensureInitialized();
  await CashHelper.init();
  DioHelper.init();
  Bloc.observer = MyBlocObserver();
  var token = await CashHelper.getData(key: 'token');
  Widget MyWidget;
  if(token == null){
    MyWidget = LoginScreen();
  }else{
    print(CashHelper.getData(key: 'token'));
    MyWidget = HomeLayout();
  }
  runApp(MyApp(widget: MyWidget,));
}

class MyApp extends StatelessWidget {
  final widget;
  const MyApp({required this.widget});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
            create: (context)=>AuthCubit()..getProfileData()
        ),
        BlocProvider(
          create: (context)=>AppCubit()..getHomeData()..getSearch('')..getCategory()..getFavourite()..getCart(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home:widget,
      ),
    );
  }
}