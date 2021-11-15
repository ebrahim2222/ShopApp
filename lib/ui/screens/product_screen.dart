import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shop_app/cubit/home_cubit.dart';
import 'package:shop_app/cubit/home_states.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:shop_app/network/local/shared_helper.dart';

class ProductsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeStates>(
      listener: (context, state) {
        if(state is ShopChangeFavoriteState){
          if(!state.model.status){
            Fluttertoast.showToast(
                msg:state.model.message! ,
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.BOTTOM,
                timeInSecForIosWeb: 1,
                backgroundColor: Colors.red,
                textColor: Colors.white,
                fontSize: 16.0
            );
          }
        }
      },
      builder: (context, state) {
        return Scaffold(
            appBar: AppBar(
              title: const Text("Products"),
            ),
            body: ConditionalBuilder(
              condition: HomeCubit.get(context).model != null && HomeCubit.get(context).categoriesModel !=null,
              builder: (context) {
                var homeCubit = HomeCubit.get(context);
                var model = homeCubit.model!.data!;
                var categoryModel = homeCubit.categoriesModel!.data;
                var token = SharedHelper.getToken();
                return Column(
                  children: [
                    CarouselSlider(
                        items: homeCubit.model!.data!.banners.map((e) {
                          return Image.network("${e.image}");
                        }).toList(),
                        options: CarouselOptions(
                          height: 250,
                          viewportFraction: 0.9,
                          initialPage: 0,
                          enableInfiniteScroll: true,
                          autoPlay: true,
                          autoPlayInterval: const Duration(seconds: 3),
                          autoPlayAnimationDuration:
                              const Duration(milliseconds: 800),
                          autoPlayCurve: Curves.fastOutSlowIn,
                          enlargeCenterPage: true,
                          scrollDirection: Axis.horizontal,
                        )),
                    const SizedBox(
                      height: 10,
                    ),
                    Container(
                      height: 100,
                      child: ListView.separated(
                        scrollDirection:Axis.horizontal,
                        itemBuilder: (context , index){
                          return Padding(
                            padding: const EdgeInsets.symmetric(vertical: 1, horizontal: 5),
                            child: Container(
                              width: 150,
                              child: Stack(
                                alignment: AlignmentDirectional.bottomCenter,
                                children: [
                                  Image(image: NetworkImage("${categoryModel!.itemModel[index].image}")),
                                  Container(
                                    width: double.infinity,
                                    color: Colors.black54,
                                    child: Text(
                                      "${categoryModel.itemModel[index].name}",
                                      textAlign: TextAlign.center,
                                      style: const TextStyle(
                                        fontSize: 16,
                                        color: Colors.white
                                      ),
                                      maxLines: 4,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  )
                                ],
                              ),
                            ),
                          );
                        },
                        separatorBuilder: (context,index)=> const SizedBox(height: 10,),
                        itemCount: categoryModel!.itemModel.length,
                      ),
                    ),
                    const SizedBox( height:20),
                    Expanded(
                      child: GridView.count(
                        shrinkWrap: true,
                        crossAxisCount: 2,
                        mainAxisSpacing: 5,
                        crossAxisSpacing: 5,
                        childAspectRatio: 1 / 1.6,
                        children: List.generate(
                            model.products.length,
                            (index) => Container(
                                  color: Colors.white,
                                  child: Column(
                                    children: [
                                      Image(
                                        image: NetworkImage(
                                            "${model.products[index].image}"),
                                        height: 200,
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(left: 7),
                                        child: Text(
                                          "${model.products[index].name}",
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                          style: const TextStyle(
                                              color: Colors.black, fontSize: 14),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(left: 7),
                                        child: Row(
                                            children: [
                                              Text(
                                                "${model.products[index].price}",
                                                style: const TextStyle(
                                                    color: Colors.blue,
                                                    fontSize: 14),
                                              ),
                                              const SizedBox(
                                                width: 10,
                                              ),
                                              Text(
                                                "${model.products[index].old_price}",
                                                style: const TextStyle(
                                                    decoration: TextDecoration
                                                        .lineThrough,
                                                    color: Colors.grey),
                                              ),
                                              const Spacer(),

                                              IconButton(
                                                icon: CircleAvatar(
                                                  backgroundColor: homeCubit.favoriteList[model.products[index].id] ? Colors.blue : Colors.grey,
                                                  radius: 15,
                                                  child: const Icon(Icons.favorite_border,
                                                    color: Colors.white,
                                                  ),
                                                ),
                                                onPressed: (){
                                                  homeCubit.changeFavorite(path: "favorites",id:model.products[index].id,token: token);
                                                },
                                              )
                                            ]),
                                      )
                                    ],
                                  ),
                                )),
                      ),
                    )
                  ],
                );
              },
              fallback: (context) => const Center(
                child: CircularProgressIndicator(),
              ),
            ));
      },
    );
  }

  checkFavorite(bool favoriteList) {

  }

}
