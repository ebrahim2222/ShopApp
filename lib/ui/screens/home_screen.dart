import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/cubit/home_cubit.dart';
import 'package:shop_app/cubit/home_states.dart';

class HomeScreen extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeStates>(
      listener: (context, state){},
      builder: (context, state){
        var homeCubit = HomeCubit.get(context);
        return Scaffold(
          body:homeCubit.screensWidget[homeCubit.currentIndex]  ,
          bottomNavigationBar: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            items: homeCubit.items,
            onTap: (index){
              HomeCubit.get(context).changeNavBarIndex(index);
            },
            currentIndex: homeCubit.currentIndex,
          ),
        );
      },

    );
  }

}