import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/cubit/home_cubit.dart';
import 'package:shop_app/cubit/home_states.dart';
import 'package:shop_app/network/local/shared_helper.dart';

import 'login_screen.dart';

class SettingScreen extends StatelessWidget{
  var emailController = TextEditingController();
  var nameController = TextEditingController();
  var phoneController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit,HomeStates>(
      listener: (context , state){

      },
      builder: (context , state){
        var homeCubit = HomeCubit.get(context);
        nameController.text = homeCubit.loginModel!.data!.name!;
        emailController.text = homeCubit.loginModel!.data!.email!;
        phoneController.text = homeCubit.loginModel!.data!.phone!;
       return  Scaffold(
         appBar: AppBar(
           title: Text("Profile"),
         ),
         body: Padding(
           padding: const EdgeInsets.all(8.0),
           child: Container(
             child: Column(
               children: [
                 TextFormField(
                   controller: nameController,
                   validator: (validaitor){
                     if(validaitor!.isEmpty){
                       return "enter this field";
                     }else{
                       return null;
                     }
                   },
                   decoration: InputDecoration(
                       suffixIcon: const Icon(Icons.person),
                       enabledBorder: OutlineInputBorder(
                           borderSide: const BorderSide(
                               color: Colors.black,
                               width: 0
                           ),
                           borderRadius: BorderRadius.circular(10)
                       ),
                       focusedBorder: OutlineInputBorder(
                         borderSide: const BorderSide(
                             color: Colors.black,
                             width: 0
                         ),
                         borderRadius: BorderRadius.circular(10),
                       )
                   ),
                 ),
                 const SizedBox(height:20),
                 TextFormField(
                     controller: emailController,
                     validator: (validaitor){
                       if(validaitor!.isEmpty){
                         return "enter this field";
                       }else{
                         return null;
                       }
                     },
                     decoration: InputDecoration(
                     suffixIcon: const Icon(Icons.email_outlined),
                     enabledBorder: OutlineInputBorder(
                         borderSide: const BorderSide(
                             color: Colors.black,
                             width: 0
                         ),
                         borderRadius: BorderRadius.circular(10)
                     ),
                     focusedBorder: OutlineInputBorder(
                       borderSide: const BorderSide(
                           color: Colors.black,
                           width: 0
                       ),
                       borderRadius: BorderRadius.circular(10),
                     )
                 ),
                 ),
                 const SizedBox(height:20),
                 TextFormField(
                   controller: phoneController,
                   validator: (validaitor){
                     if(validaitor!.isEmpty){
                       return "enter this field";
                     }else{
                       return null;
                     }
                   },
                   decoration: InputDecoration(
                       suffixIcon: const Icon(Icons.phone_android),
                       enabledBorder: OutlineInputBorder(
                           borderSide: const BorderSide(
                               color: Colors.black,
                               width: 0
                           ),
                           borderRadius: BorderRadius.circular(10)
                       ),
                       focusedBorder: OutlineInputBorder(
                         borderSide: const BorderSide(
                             color: Colors.black,
                             width: 0
                         ),
                         borderRadius: BorderRadius.circular(10),
                       )
                   ),
                 ),
                 SizedBox(height: 20,),
                 SizedBox(width:double.infinity,child: ElevatedButton(onPressed: (){
                   SharedHelper.removToken();
                   Navigator.push(context, MaterialPageRoute(builder: (context){
                     return LoginScreen();
                   }));
                 }, child: Text("Logout")))
               ],
             ),
           ),
         ) ,
       );
      },
    );
  }

}