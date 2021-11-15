import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/cubit/home_cubit.dart';
import 'package:shop_app/cubit/login_cubit.dart';
import 'package:shop_app/cubit/states.dart';
import 'package:shop_app/network/local/shared_helper.dart';
import 'package:shop_app/ui/screens/home_screen.dart';
import 'package:shop_app/ui/screens/register_screen.dart';
import 'package:shop_app/ui/widgets/widgets.dart';
import 'package:fluttertoast/fluttertoast.dart';

class LoginScreen extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    bool isShown = true;
    var globalKey = GlobalKey<FormState>();
    var emailController = TextEditingController();
    var passController = TextEditingController();
    var value = SharedHelper.getOnBoardingValue();
    print(value);
    return BlocConsumer<LoginScreenCubit,ShopStates>(
      listener:(context, state){
        if(state is shopLoginSuccessState){
          if(state.model.status!){
            print(state.model.data!.name);
            Fluttertoast.showToast(
                msg: state.model.message!,
                toastLength: Toast.LENGTH_LONG,
                gravity: ToastGravity.BOTTOM,
                timeInSecForIosWeb: 1,
                backgroundColor: Colors.green,
                textColor: Colors.white,
                fontSize: 16.0
            );
            SharedHelper.saveToken(value :state.model.data!.token).then((value) => print(value));
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context){
              return HomeScreen();
            }));
          }else{
            Fluttertoast.showToast(
                msg: state.model.message!,
                toastLength: Toast.LENGTH_LONG,
                gravity: ToastGravity.BOTTOM,
                timeInSecForIosWeb: 1,
                backgroundColor: Colors.red,
                textColor: Colors.white,
                fontSize: 16.0
            );
          }
        }
      },
      builder:(context , state) => Scaffold(
        appBar: AppBar(
          title: const Text("Shop App"),
        ),
        body: Center(
          child: Form(
            key: globalKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
               InputFields(emailController, IconButton(onPressed: (){}, icon: const Icon(Icons.email_outlined)), "enter your email",),
               InputFields(passController, IconButton(onPressed: (){}, icon: const Icon(Icons.password_rounded)), "enter your password"),
                ConditionalBuilder(
                  condition: state is! shopLoginLoadingState ,
                  builder: (context) => Buttons("Login",(){
                    if(globalKey.currentState!.validate()){
                      LoginScreenCubit.get(context).userLogin(emailController.text, passController.text);
                    }
                  }),
                  fallback: (context) => const CircularProgressIndicator(),
                ),
                InkWell(child: const Text("don't have email click here!"), onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context){
                    return RegisterScreen();
                  }));
                },)
              ],
            ),
          ),
        ),
      ),
    );
  }

}