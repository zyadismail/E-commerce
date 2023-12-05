import 'package:e_commerceitsharks/Cubits/App/app_cubit.dart';
import 'package:e_commerceitsharks/Shared/Components/components.dart';
import 'package:e_commerceitsharks/Shared/Widgets/Text/text.dart';
import 'package:flutter/material.dart';
 import 'package:flutter_bloc/flutter_bloc.dart';


class TotalPriceScreen extends StatefulWidget {
  const TotalPriceScreen({super.key});

  @override
  State<TotalPriceScreen> createState() => _TotalPriceScreenState();
}

class _TotalPriceScreenState extends State<TotalPriceScreen> {
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return BlocConsumer<AppCubit, AppState>(
  listener: (context, state) {
    // TODO: implement listener
  },
  builder: (context, state) {
    var cubit  = AppCubit.get(context);
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        centerTitle: true,
        title: BuildText(
          text: 'Shopping Cart',
          color: Colors.white,
          size: 20,
          bold: true,
        ),
      ),
      body:cubit.cartModel==null?buildLoadingWidget():
      Column(
        children: [
        SizedBox(
          height: height*0.6,
          width: width,
          child: ListView.builder(
            physics: BouncingScrollPhysics(),
            itemCount: cubit.cartModel!.data!.cartItems!.length,
            itemBuilder: (context,index){
              return SizedBox(
                height: height*0.15,
                width: width,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Card(
                    color: Colors.grey[900],
                   child: Row(
                     children: [
                       buildImage(
                           image: cubit.cartModel!.data!.cartItems![index].product!.image,
                           fit: 'cover',
                       ),
                       SizedBox(width: width*0.03,),
                       Padding(
                         padding: const EdgeInsets.all(8.0),
                         child: Column(
                           crossAxisAlignment: CrossAxisAlignment.start,
                           children: [
                           SizedBox(
                               child: BuildText(
                                 text: cubit.cartModel!.data!.cartItems![index].product!.name!,
                                 maxLines: 1,
                                 color: Colors.white,
                               ),
                             width: width*0.5,
                           ),
                             Row(
                               children: [
                                 BuildText(
                                   text: cubit.cartModel!.data!.cartItems![index].product!.price.toString(),
                                   color: Colors.white,
                                 ),
                                 SizedBox(width: width*0.32,),
                                 IconButton(
                                     onPressed: (){
                                       cubit.postChangeCart(
                                           id: cubit.cartModel!.data!.cartItems![index].product!.id!
                                       ).then((value){
                                         cubit.getCart();
                                         cubit.getHomeData();
                                       });
                                       setState(() {
                                         cubit.cartModel!.data!.cartItems!.removeAt(index);
                                       });
                                     },
                                     icon: Icon(Icons.delete,color: Colors.red,size: 20,)
                                 ),

                               ],
                             ),
                           ],
                         ),
                       ),
                     ],
                   ),
                  ),
                ),
              );
            },
          ),
        ),

          SizedBox(
            height: height*0.25,
            width: width,
            child: Card(
              color: Colors.grey[900],
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    BuildText(text: 'Total Price :',color: Colors.white,),
                    Spacer(),
                    BuildText(
                      text: '${cubit.cartModel!.data!.total.toString()} EGP',color: Colors.white,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  },
);
  }
}

