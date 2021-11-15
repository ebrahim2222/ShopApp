import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/cubit/home_cubit.dart';
import 'package:shop_app/cubit/home_states.dart';
import 'package:shop_app/model/shop_get_favorite.dart';
import 'package:shop_app/network/local/shared_helper.dart';

class FavoriteScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var homeCubit = HomeCubit.get(context);
        var model = homeCubit.getFavoriteModel!.data;
        return Scaffold(
          appBar: AppBar(
            title: Text("Favorites"),
          ),
          body: Container(
              height: double.infinity,
              width: double.infinity,
              child: ConditionalBuilder(
                condition: homeCubit.getFavoriteModel!.data!.data != null,
                fallback: (BuildContext context) {
                  return CircularProgressIndicator();
                },
                builder: (BuildContext context) {
                  return ListView.separated(
                      itemBuilder: (context , index){
                        return Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Image(
                              image:NetworkImage("${model!.data![index].product!.image}",),
                              width: 100,
                              height: 120,

                            ),
                            SizedBox(width: 20,),
                            Container(
                              width: 250,
                              height: 120,
                              child: Padding(
                                padding: const EdgeInsets.only(top: 10),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(width: 250,child: Text("${model.data![index].product!.name}",)),
                                    Spacer(),
                                    Row(
                                      children: [
                                        Text("${model.data![index].product!.price}",style: TextStyle(color: Colors.blue)),
                                        Container(
                                            margin: EdgeInsets.only(left: 5),
                                            child: Text("${model.data![index].product!.oldPrice}",style: TextStyle(
                                              decoration: TextDecoration.lineThrough,
                                              color: Colors.black
                                            ),)),
                                        Spacer(),
                                        IconButton(
                                          icon: CircleAvatar(
                                            backgroundColor: Colors.blue ,
                                            radius: 15,
                                            child: const Icon(Icons.favorite_border,
                                              color: Colors.white,
                                            ),
                                          ),
                                          onPressed: (){
                                            homeCubit.changeFavorite(path:"favorites",id: model.data![index].product!.id,token: SharedHelper.getToken());
                                          },
                                        )
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            )

                          ],
                        );
                      },
                      separatorBuilder: (context , index) {
                        return const Divider(height: 1, color:Colors.grey);
                      },
                      itemCount: model!.data!.length
                  );
                },
              )),
        );
      },
    );
  }
}
