import 'package:e_commerceitsharks/Cubits/App/app_cubit.dart';
import 'package:e_commerceitsharks/Screen/Home/home_screen.dart';
import 'package:e_commerceitsharks/Screen/HomeLayout/home_layout.dart';
import 'package:e_commerceitsharks/Shared/Components/components.dart';
import 'package:e_commerceitsharks/Shared/Widgets/Buttom/button.dart';
import 'package:e_commerceitsharks/Shared/Widgets/Text/text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:carousel_slider/carousel_controller.dart';

import '../../Models/Home/home_model.dart';

class ProductDetails extends StatefulWidget {
  late Products products;
   ProductDetails({super.key,required this.products});
  @override
  State<ProductDetails> createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
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
        return Scaffold(
          backgroundColor: Colors.white70,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0.0,
            title: BuildText(text: 'Product Details', color: Colors.black,),
            centerTitle: true,
            leading: IconButton(onPressed: (){
                navigateTo(context, HomeLayout());},
             icon: Icon(Icons.arrow_back),
            ),
          ),
          body:SingleChildScrollView(
            child: Column(
              children: [
              BuildSlider(
                  width: width,
                  height: height*0.4,
                  carouselController: carouselController,
                  cubit: cubit,
                  length: widget.products!.images!.length,
                  items: widget.products!.images
              ),
                SizedBox(height: height*0.7,
                  child: Container(
                    height: height*0.6,
                    width: width,
                    decoration: BoxDecoration(
                    color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(50),
                        topRight: Radius.circular(50),
                      ),
                  ), child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(height: height*0.05,),
                              BuildText(text:"${widget.products.name}",bold: true,maxLines: 1,),
                              SizedBox(height: height*0.02,),
                              Row(
                                children: [
                                  Icon(
                                    Icons.star,
                                    color: Colors.yellow,
                                  ),
                                  Icon(
                                    Icons.star,
                                    color: Colors.yellow,
                                  ),
                                  Icon(
                                    Icons.star,
                                    color: Colors.yellow,
                                  ),
                                  Icon(
                                    Icons.star,
                                    color: Colors.yellow,
                                  ),
                                  Icon(
                                    Icons.star,
                                    color: Colors.yellow,
                                  ),
                                  BuildText(text: '  | 500 reviews',bold: true,)
                                ],
                              ),
                              SizedBox(height: height*0.02,),
                              BuildText(text: '${widget.products.price}\$'),
                              SizedBox(height: height*0.02,),
                              BuildText(text: '${widget.products.description}\$',maxLines: 7,),
                              SizedBox(height: height*0.02),
                              Row(
                                children: [
                                  GestureDetector(
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: widget.products.inCart!? Colors.black:Colors.white,
                                        shape: BoxShape.circle,
                                      ),
                                      child: Icon(
                                        Icons.add_shopping_cart_outlined,
                                        color: widget.products.inCart!? Colors.white : Colors.black,
                                        size: 30,
                                      ),
                                    ),
                                    onTap: (){
                                      setState(() {
                                        widget.products.inCart = !widget.products.inCart!;
                                      });
                                      cubit.postChangeCart(id:widget.products.id!).then((value){ //to take the item to the cart screen
                                        cubit.getCart();
                                      });

                                    },
                                  ),
                                  SizedBox(width: width*0.03,),
                                  Center(
                                    child: MaterialButton(
                                      color: Colors.red,
                                      height: height*0.07,
                                      minWidth: width*0.4,
                                      onPressed: (){
                                        cubit.postChangeCart(id:widget.products.id!).then((value){ //to move the item to the cart screen
                                          cubit.getCart();
                                        });
                                      },
                                      child: Text('add to Cart',style: TextStyle(color: Colors.white),),
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                ),
              ],
            ),
          )
        );
      },
    );
  }
}
