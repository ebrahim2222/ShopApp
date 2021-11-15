import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shop_app/cubit/register_cubit.dart';
import 'package:shop_app/cubit/register_states.dart';
import 'package:shop_app/network/local/shared_helper.dart';
import 'package:shop_app/ui/screens/home_screen.dart';
import 'package:shop_app/ui/screens/login_screen.dart';
import 'package:shop_app/ui/widgets/widgets.dart';

class RegisterScreen extends StatelessWidget {
  var nameController = TextEditingController();
  var phoneController = TextEditingController();
  var emailController = TextEditingController();
  var passController = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return BlocProvider<RegisterCubit>(
      create: (context) => RegisterCubit(),
      child: BlocConsumer<RegisterCubit, RegisterStates>(
        listener: (context, state) {
          if(state is SuccessRegisterState){
            Fluttertoast.showToast(
                msg: state.loginModel.message.toString(),
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.BOTTOM,
                timeInSecForIosWeb: 1,
                backgroundColor: state.loginModel.status == true ? Colors.green:Colors.red,
                textColor: Colors.white,
                fontSize: 16.0
            );
            SharedHelper.saveToken(value: RegisterCubit.get(context).loginModel!.data!.token);
            Navigator.push(context,
                MaterialPageRoute(builder: (context) {
                  return HomeScreen();
                }));

          }
        },
        builder: (context, state) {
          var registerCubit = RegisterCubit.get(context);
          return Scaffold(
            appBar: AppBar(
              title: const Text("Registration"),
            ),
            body: Center(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Form(
                  key: formKey,
                  child: Column(
                    children: [
                      TextFormField(
                        controller: nameController,
                        validator: (validaitor) {
                          if (validaitor!.isEmpty) {
                            return "enter this field";
                          } else {
                            return null;
                          }
                        },
                        decoration: InputDecoration(
                            hintText: "enter your name",
                            suffixIcon:
                                const Icon(Icons.drive_file_rename_outline),
                            enabledBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                    color: Colors.black, width: 0),
                                borderRadius: BorderRadius.circular(10)),
                            focusedBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                  color: Colors.black, width: 0),
                              borderRadius: BorderRadius.circular(10),
                            )),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        controller: emailController,
                        validator: (validaitor) {
                          if (validaitor!.isEmpty) {
                            return "enter this field";
                          } else {
                            return null;
                          }
                        },
                        decoration: InputDecoration(
                            hintText: "enter your email",
                            suffixIcon: const Icon(Icons.email_outlined),
                            enabledBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                    color: Colors.black, width: 0),
                                borderRadius: BorderRadius.circular(10)),
                            focusedBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                  color: Colors.black, width: 0),
                              borderRadius: BorderRadius.circular(10),
                            )),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        controller: phoneController,
                        validator: (validaitor) {
                          if (validaitor!.isEmpty) {
                            return "enter this field";
                          } else {
                            return null;
                          }
                        },
                        decoration: InputDecoration(
                            hintText: "enter your phone",
                            suffixIcon: const Icon(Icons.phone),
                            enabledBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                    color: Colors.black, width: 0),
                                borderRadius: BorderRadius.circular(10)),
                            focusedBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                  color: Colors.black, width: 0),
                              borderRadius: BorderRadius.circular(10),
                            )),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        key: key,
                        controller: passController,
                        validator: (validaitor) {
                          if (validaitor!.isEmpty) {
                            return "enter this field";
                          } else {
                            return null;
                          }
                        },
                        decoration: InputDecoration(
                            hintText: "enter your pass",
                            suffixIcon: const Icon(Icons.password_rounded),
                            enabledBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                    color: Colors.black, width: 0),
                                borderRadius: BorderRadius.circular(10)),
                            focusedBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                  color: Colors.black, width: 0),
                              borderRadius: BorderRadius.circular(10),
                            )),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      ConditionalBuilder(
                          builder: (BuildContext context) {
                            return  Container(
                                width: double.infinity,
                                child: ElevatedButton(
                                    child: const Text("Register"),
                                    onPressed: () {
                                      submit(context);
                                    })
                            );
                          },
                          fallback: (BuildContext context) {
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          },
                          condition: state is !LoadingRegisterState,

                      ),
                      InkWell(
                        child: const Text("have account click here to login"),
                        onTap: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) {
                            return LoginScreen();
                          }));
                        },
                      )
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  void submit(BuildContext context) {
    if(formKey.currentState!.validate()){
      RegisterCubit.get(context).register(path: "register", name: nameController.text,phone: phoneController.text,email: emailController.text,pass: passController.text);
    }else{

    }
  }
}
