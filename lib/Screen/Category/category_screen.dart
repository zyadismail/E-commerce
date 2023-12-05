import 'package:e_commerceitsharks/Cubits/App/app_cubit.dart';
import 'package:e_commerceitsharks/Screen/CategoryDetails/categorydetails_screen.dart';
import 'package:e_commerceitsharks/Shared/Colors/colors.dart';
import 'package:e_commerceitsharks/Shared/Components/components.dart';
import 'package:e_commerceitsharks/Shared/Widgets/Text/text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CategoryScreen extends StatelessWidget {
  const CategoryScreen({super.key});

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
          backgroundColor:AppColor.primaryColor,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0.0,
            title: Text("categoryScreen",style: TextStyle(color: Colors.white),),
            centerTitle: true,
          ),

          body:cubit.categoryModel==null?buildLoadingWidget():
          SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: SizedBox(
              height: height,
              width: width,
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    BuildText(text: 'Choose \n Category',color: Colors.white,size:30 ,bold: true,),
                    SizedBox(height: height*0.03,),
                    Expanded(
                      child: GridView.builder(
                        physics: BouncingScrollPhysics(),
                          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            mainAxisSpacing: 10,
                            crossAxisSpacing: 9,
                            mainAxisExtent: 300,
                          ),
                          itemCount: cubit.categoryModel!.data!.data!.length,
                          itemBuilder: (context, index) {
                            return GestureDetector(
                              onTap: (){
                                cubit.getCategoryDetails(
                                    id: cubit.categoryModel!.data!.data![index].id!
                                );
                                navigateTo(context, CategoryDetailsScreen(
                                  title:cubit.categoryModel!.data!.data![index].name!,));
                              },
                              child: Card(
                                child: Stack(
                                  children: [
                                    SizedBox(
                                      width: width,
                                      height: height*0.3,
                                      child: buildImage(
                                          image: cubit.categoryModel!.data!.data![index].image,
                                          fit: 'cover'
                                      ),
                                    ),
                                    Container(
                                      width: width,
                                      height: height*0.5,
                                      color: Colors.black54,
                                    ),
                                    Center(
                                      child: BuildText(
                                        text:  cubit.categoryModel!.data!.data![index].name!,
                                        size: 15,
                                        color: Colors.white,
                                        bold: true,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          }
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
