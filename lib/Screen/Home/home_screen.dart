import 'package:e_commerceitsharks/Cubits/App/app_cubit.dart';
import 'package:e_commerceitsharks/Screen/Search/searh_screen.dart';
import 'package:e_commerceitsharks/Screen/product%20details/product_details.dart';
import 'package:e_commerceitsharks/Shared/Colors/colors.dart';
import 'package:e_commerceitsharks/Shared/Widgets/Text/text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:carousel_slider/carousel_controller.dart';
import 'package:badges/badges.dart' as badges;
import '../../Shared/Components/components.dart';
import '../price/price_screen.dart';

class HomeScreen extends StatelessWidget {
   HomeScreen({super.key});

    CarouselController carouselController = CarouselController();
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
        return  Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0.0,
            title: Text('Home', style: TextStyle(color: Colors.black)),
            centerTitle: true,
            actions: [
              badges.Badge(
                position: badges.BadgePosition.topEnd(top: -4, end: -3),
                badgeContent: BuildText(
                  text: cubit.cartModel?.data?.cartItems?.length.toString() ?? '',
                  color: Colors.white,
                  bold: true,
                ),
                child:    IconButton(
                  icon: Icon(Icons.shopping_bag,size: 25,color: Colors.black,),
                  onPressed: (){
                    navigateTo(context, TotalPriceScreen());
                  },
                ),
              ),
              IconButton(onPressed: (){
                navigateTo(context, SearchScreen());
              }, icon: Icon(Icons.search_rounded,color: Colors.black,size: 30,)),
              SizedBox(width:width * 0.04,)
            ],
            leading: Icon(Icons.menu,color: Colors.black,),
          ),
          body:cubit.homeModel==null? buildLoadingWidget():
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  BuildText(text: 'Categories', size: 30,bold: true,),
                  SizedBox(height: height*0.02,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Column(
                        children: [
                          SizedBox(
                            height: height*0.1,
                              width: width*0.2,
                              child: Card(
                                child: Stack(
                                  children: [
                                    Image.network('https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSiWcPA-RnCxEadT8XZKCEc453E79s5NaOXVg&usqp=CAU',fit: BoxFit.cover,),
                                  ],
                                ),
                              )),
                          BuildText(text: 'Apparel')
                        ],
                      ),
                      Column(
                        children: [
                          SizedBox(
                              height: height*0.1,
                              width: width*0.2,
                              child: Card(
                                child: Stack(
                                  children: [
                                    Image.network('https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTo4acEtapXY32xVAsBJrlZNgtFFrFxZo-saA&usqp=CAU',fit: BoxFit.cover,),
                                  ],
                                ),
                              )),
                          BuildText(text: 'electronics')
                        ],
                      ),
                      Column(
                        children: [
                          SizedBox(
                              height: height*0.1,
                              width: width*0.2,
                              child: Card(
                                child: Stack(
                                  children: [
                                    Image.network('https://cdn-icons-png.flaticon.com/512/9404/9404641.png',fit: BoxFit.cover,),
                                  ],
                                ),
                              )),
                          BuildText(text: 'Shoes')
                        ],
                      ),
                      Column(
                        children: [
                          SizedBox(
                              height: height*0.1,
                              width: width*0.2,
                              child: Card(
                                child: Stack(
                                  children: [
                                    Image.network('https://cdn.iconscout.com/icon/premium/png-256-thumb/gym-2811070-2333750.png?f=webp',fit: BoxFit.cover,),
                                  ],
                                ),
                              )),
                          BuildText(text: 'gym')
                        ],
                      ),

                    ],
                  ),
                   SizedBox(height: height*0.02,),
                   BuildText(text: 'Latest',size: 40,bold: true,),
                  SizedBox(height: height*0.03,),
                  Stack(
                    children: [
                      BuildSlider(
                        width: width,
                        height: height * 0.3,
                        carouselController: carouselController,
                        cubit: cubit,
                        length: cubit.homeModel!.data!.banners!.length,
                      ),
                    ],
                  ),
                  SizedBox(height: height*0.02,),
                  BuildText(text: 'BestSeller',size: 30,bold: true,),
                  SizedBox(height: height*0.01,),
                  SizedBox(
                    height: height * 0.25,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      physics: BouncingScrollPhysics(),
                      itemCount: cubit.homeModel!.data!.products!.length,
                        itemBuilder: (context,index){
                         return SizedBox(
                           width: width*0.3,
                           child: InkWell(
                             onTap: (){
                               navigateTo(context, ProductDetails(
                                 products: cubit.homeModel!.data!.products![index],
                               ));
                             },
                             child: Card(
                               child: Padding(
                                 padding: const EdgeInsets.all(8.0),
                                 child: Column(
                                   crossAxisAlignment: CrossAxisAlignment.start,
                                   children: [
                                     Padding(
                                       padding: const EdgeInsets.all(8.0),
                                       child: Stack(
                                         children: [
                                           SizedBox(
                                             height: height*0.12,
                                             width: width,
                                             child: buildImage(
                                                 image: cubit.homeModel!.data!.products![index].image,
                                                 fit: 'contain',
                                               radius: 12,
                                             ),
                                           ),
                                         ],
                                       ),
                                     ),
                                     SizedBox(height: height*0.01,),
                                     BuildText(text: '${cubit.homeModel!.data!.products![index].name}',size: 10,maxLines: 1,overflow: true,),
                                     SizedBox(height: height*0.01,),
                                     Row(
                                       children: [
                                         BuildText(text: '${cubit.homeModel!.data!.products![index].price}\$',size: 9,maxLines: 2,bold: true,),
                                         Spacer(),
                                         GestureDetector(
                                           onTap: (){
                                               cubit.changeFavouriteInHomeProduct(index: index);
                                               cubit.postChangeFavourite(id: cubit.homeModel!.data!.products![index].id!);
                                           },
                                           child: Icon(
                                             cubit.homeModel!.data!.products![index].inFavorites!? Icons.favorite : Icons.favorite_border,
                                             color:cubit.homeModel!.data!.products![index].inFavorites!? Colors.red: Colors.grey,
                                             size: 30,
                                           ),
                                         ),
                                       ],
                                     ),
                                   ],
                                 ),
                               ),
                             ),
                           ),
                         );
                    },
                    ),
                  ),
                  SizedBox(height: height*0.01,),
                  BuildText(text: 'offer',size: 30,bold: true,),
                  SizedBox(height: height *0.02,),
                  SizedBox(
                    height: height * 0.25,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      physics: BouncingScrollPhysics(),
                      itemCount: cubit.homeModel!.data!.salesProducts!.length,
                      itemBuilder: (context,index){
                        return SizedBox(
                          width: width*0.3,
                          child: InkWell(
                            onTap: (){
                              navigateTo(context, ProductDetails(products: cubit.homeModel!.data!.salesProducts![index],
                              ),
                              );
                            },
                            child: Card(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Stack(
                                        children: [
                                          SizedBox(
                                            height: height*0.12,
                                            width: width,
                                            child: buildImage(
                                              image: cubit.homeModel!.data!.salesProducts![index].image,
                                              fit: 'contain',
                                              radius: 12,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(height: height*0.01,),
                                    BuildText(text: '${cubit.homeModel!.data!.salesProducts![index].name}',size: 10,maxLines: 1,overflow: true,),
                                    SizedBox(height: height*0.01,),
                                    Row(
                                      children: [
                                        Column(
                                          children: [
                                            BuildText(text: '${cubit.homeModel!.data!.salesProducts![index].price}\$',size: 9,maxLines: 2,bold: true,),
                                            BuildText(text: '${cubit.homeModel!.data!.salesProducts![index].oldPrice}\$',size: 9,maxLines: 2,bold: true,lineThrow: true,color: Colors.grey,),

                                          ],
                                        ),
                                        Spacer(),
                                        InkWell(
                                          onTap: (){
                                            cubit.changeFavouriteInSales(index: index);
                                            cubit.postChangeFavourite(id: cubit.homeModel!.data!.salesProducts[index].id!);                                          },
                                            child: Icon(
                                              cubit.homeModel!.data!.salesProducts[index].inFavorites!? Icons.favorite :Icons.favorite_border,
                                              color:cubit.homeModel!.data!.salesProducts[index].inFavorites!? Colors.red : Colors.grey,                                            )
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),

                ],
              ),
            ),
          ) ,
        );
      },
    );
  }
}
