import 'package:e_commerceitsharks/Cubits/App/app_cubit.dart';
import 'package:e_commerceitsharks/Screen/product%20details/product_details.dart';
import 'package:e_commerceitsharks/Shared/Components/components.dart';
import 'package:e_commerceitsharks/Shared/Widgets/Text/text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CategoryDetailsScreen extends StatelessWidget {
  late String title;
  CategoryDetailsScreen({super.key, required this.title});


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
      body:cubit.categoryDetailsModel==null?buildLoadingWidget():
      GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            childAspectRatio: 2,
        mainAxisExtent: height * 0.3,
        crossAxisCount: 2, // number of items in each row
        mainAxisSpacing: 1, // spacing between rows
        crossAxisSpacing: 1, // spacing between column
      ),
          itemCount: cubit.categoryDetailsModel!.data!.products!.length,
          itemBuilder: (context,index){
           return GestureDetector(
             onTap: (){
               navigateTo(context, ProductDetails(products: cubit.categoryDetailsModel!.data!.products![index]));
             },
             child: Container(
               width: width,
              child: Stack(
                children: [
                  buildImage(
                    image:cubit.categoryDetailsModel!.data!.products![index].image,
                      fit: 'cover',
                  ),
                  Container(
                   decoration: BoxDecoration(
                     gradient: LinearGradient(
                       begin: Alignment.bottomCenter,
                       end: Alignment.topCenter,
                       colors: [
                         Colors.black,
                         Colors.transparent
                       ]
                     )
                   ),
                  ),
                  Positioned(
                    right: 3,
                      bottom: 0,
                      child: Padding(
                        padding: const EdgeInsets.all(5.0),
                       child: GestureDetector(
                          onTap: (){
                            cubit.changeFavouriteInCategoryProduct(index: index);
                            cubit.postChangeFavourite(id: cubit.categoryDetailsModel!.data!.products![index].id!).then((value){
                              cubit.getHomeData();
                            });
                            },
                          child: Icon(
                            cubit.categoryDetailsModel!.data!.products![index].inFavorites!? Icons.favorite : Icons.favorite_border,
                            color:cubit.categoryDetailsModel!.data!.products![index].inFavorites!? Colors.red: Colors.grey,
                            size: 30,
                          ),
                      ),
                      ),
                  ),
                ],
              ),
             ),
           );
          }
          ),
    );
  },
);
  }
}
