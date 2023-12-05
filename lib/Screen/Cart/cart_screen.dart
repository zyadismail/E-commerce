import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../Cubits/App/app_cubit.dart';
import '../../Shared/Colors/colors.dart';
import '../../Shared/Components/components.dart';
import '../../Shared/Widgets/Text/text.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
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
          backgroundColor: Colors.black,
          appBar: AppBar(
            backgroundColor: Colors.black,
            title: BuildText(text: "Shopping Cart",color: Colors.white,size: 20,),
            leading: Icon(Icons.arrow_back),
          ),
          body:cubit.cartModel==null?buildLoadingWidget():
              cubit.cartModel!.data!.cartItems == 0?
              Column(
                children: [
                  buildImage(
                      image: 'https://d2gg9evh47fn9z.cloudfront.net/1600px_COLOURBOX5559874.jpg',
                      fit: 'cover',
                  ),
                ],
              )
                  : Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ListView.builder(
                  physics: BouncingScrollPhysics(),
              itemCount:cubit.cartModel!.data!.cartItems!.length,
              itemBuilder: (context,index){
                return SizedBox(
                    height: height*0.17,
                    width: width,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        decoration: BoxDecoration(
                         color: Colors.grey[900],
                          borderRadius: BorderRadius.circular(20)
                        ),
                        child: Row(
                          children: [
                            SizedBox(width: width*0.02,),
                            SizedBox(
                              height: height*0.1,
                              width: width*0.2,
                              child: buildImage(
                                  image: cubit.cartModel!.data!.cartItems![index].product!.image!,
                                  fit: 'cover',
                                radius: 10,

                              ),

                            ),
                            SizedBox(width: width*0.02,),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  child: BuildText(
                                      text: cubit.cartModel!.data!.cartItems![index].product!.name!,
                                      size: 15,
                                    maxLines: 1,
                                    color: Colors.white,
                                  ),
                                  width: width*0.3,
                                ),
                                SizedBox(height: height*0.01,),
                                BuildText(text: cubit.cartModel!.data!.cartItems![index].product!.price.toString(),color: Colors.white),
                                Row(
                                  children: [
                                    BuildText(text: 'REMOVE',color: Colors.white,),

                                    IconButton(
                                      onPressed: (){
                                        cubit.postChangeCart(
                                          id: cubit.cartModel!.data!.cartItems![index].product!.id!,
                                        ).then((value){
                                          cubit.getHomeData();
                                        });

                                        setState(() {
                                          cubit.cartModel!.data!.cartItems!.removeAt(index);
                                        });

                                      },
                                      icon: Icon(Icons.delete,color: Colors.red,size: 25,),
                                    ),
                                  ],
                                ),

                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                );
          }),
                  ) ,
        );
      },
    );
  }
}
