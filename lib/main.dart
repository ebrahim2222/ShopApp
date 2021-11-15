import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/constants/constants.dart';
import 'package:shop_app/network/local/shared_helper.dart';
import 'package:shop_app/network/remote/dio_helper.dart';
import 'package:shop_app/ui/screens/home_screen.dart';
import 'package:shop_app/ui/screens/login_screen.dart';
import 'package:shop_app/ui/screens/on_boarding_screen.dart';

import 'cubit/home_cubit.dart';
import 'cubit/login_cubit.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  Widget widget;
  DioHelper.init();
  await SharedHelper.init();
  var value =   SharedHelper.getOnBoardingValue();
  var token = SharedHelper.getToken();
  print(token);
  if(value != null ){
    if(token != null) {
      widget = HomeScreen();
    } else {
      widget = LoginScreen();
    }
  }else{
    widget = OnBoardingScreen();
  }
  runApp( MyApp(widget: widget,));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key, required this.widget,}) : super(key: key);
  final Widget widget;
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<LoginScreenCubit>(create: (context) => LoginScreenCubit()),
        BlocProvider<HomeCubit>(  create: (context) => HomeCubit()..getData(path: Constants().HOME)..getCategoryData(path: Constants().CATEGORY)..getFavorite(token: SharedHelper.getToken())..getUserData(path: "profile",token:SharedHelper.getToken() ))
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: widget,
      ),
    );
  }
}
