import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/cubit/home_cubit.dart';
import 'package:shop_app/cubit/home_states.dart';

class CategoryScreen extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit , HomeStates>(
      listener:(context , state){} ,
      builder:(context , state) {
        var categpryModel = HomeCubit.get(context).categoriesModel!.data;
        return  Scaffold(
          appBar: AppBar(
            title: Text("Category"),
          ),
          body: Container(
            height: double.infinity,
            width: double.infinity,
            child: ListView.separated(
              itemBuilder: (BuildContext context, int index) {
                return Padding(
                  padding:EdgeInsets.symmetric(vertical: 5,horizontal: 1),
                  child: SizedBox(
                    height:100,
                    child: Row(
                      children: [
                        Image(image: NetworkImage("${categpryModel!.itemModel[index].image}"), width: 100,height: 80,),
                        const SizedBox(width:20),
                        Text("${categpryModel.itemModel[index].name}",style:const TextStyle(fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color:Colors.black)),
                        const Spacer(),
                        const Icon(Icons.arrow_forward_ios)
                      ],
                    ),
                  ),
                );
              },
              itemCount: categpryModel!.itemModel.length,
              separatorBuilder: (BuildContext context, int index) { return Divider(height:1,color:Colors.grey); },

            ),
          ),
        );
      }
    );
  }

}