import 'package:e_commerceitsharks/Screen/Home/home_screen.dart';
import 'package:e_commerceitsharks/Screen/HomeLayout/home_layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../Cubits/App/app_cubit.dart';
import '../../Shared/Colors/colors.dart';
import '../../Shared/Components/components.dart';
import '../../Shared/Widgets/Text/text.dart';

class FavouriteScreen extends StatefulWidget {
  const FavouriteScreen({Key? key}) : super(key: key);

  @override
  State<FavouriteScreen> createState() => _FavouriteScreenState();
}

class _FavouriteScreenState extends State<FavouriteScreen> {
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
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0.0,
            title: BuildText(text: 'Favourite',
                size: 30,
              bold: true,
            ),),
          backgroundColor:Colors.black,
          body:  cubit.favouriteModel == null? buildLoadingWidget():
          cubit.favouriteModel!.data!.details!.length == 0 ? Center(
            child: SizedBox(
              width: width*0.75,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Center(child: buildImage(image: 'https://cdn-icons-png.flaticon.com/512/7314/7314003.png', fit: 'cover',radius: 12)),
                  SizedBox(height: height*0.03,),
                  BuildText(
                    text: 'No Favourite yet !',
                    size: 25,
                    bold:  true,
                  ),
                  SizedBox(height: height*0.02),
                  SizedBox(
                    width: width*0.5,
                    child: BuildText(
                      text: 'Like a recipe you see? Save them here to your favourites',
                      size: 18,
                      color: Colors.grey,
                    ),
                  ),
                  SizedBox(height: height*0.04),
                ],
              ),
            ),
          ):
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: ListView.builder(
              itemBuilder: (context,index){
                return SizedBox(
                  height: height*0.17,
                  width: width,
                  child: Card(
                    color: Colors.grey[900],
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          SizedBox(
                            width: width*0.35,
                            height: height*0.25,
                            child: buildImage(
                              image:  cubit.favouriteModel!.data!.details![index].product!.image!,
                              fit: 'cover',
                            ),
                          ),

                          Expanded(
                            child: Padding(
                              padding:  EdgeInsets.symmetric(vertical: 12,horizontal: 6),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  BuildText(
                                    text: cubit.favouriteModel!.data!.details![index].product!.name!,
                                    maxLines: 1,
                                    bold: true,
                                    color: Colors.white,
                                    size: 15,
                                  ),
                                  Row(
                                    children: [
                                      BuildText(
                                        text: '${cubit.favouriteModel!.data!.details![index].product!.price!.toString()}\$',
                                        size: 15,
                                        bold: true,
                                        color: Colors.white,

                                      ),
                                      Spacer(),
                                      IconButton(
                                        onPressed: (){//study
                                          cubit.postChangeFavourite(id: cubit.favouriteModel!.data!.details![index].product!.id!).then((value){
                                            cubit.getHomeData();
                                          });
                                          setState(() {
                                            cubit.favouriteModel!.data!.details!.removeAt(index);
                                          });
                                          },
                                        icon: Icon(Icons.delete,color: Colors.red,size: 25,),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                );
              },
              itemCount:cubit.favouriteModel!.data!.details!.length,
            ),
          ),
        );
      },
    );
  }
}
