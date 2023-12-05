import 'package:e_commerceitsharks/Models/Search/search_model.dart';
import 'package:e_commerceitsharks/Screen/product%20details/product_details.dart';
import 'package:e_commerceitsharks/Shared/Colors/colors.dart';
import 'package:e_commerceitsharks/Shared/Widgets/Text/text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:e_commerceitsharks/Cubits/App/app_cubit.dart';
import 'package:e_commerceitsharks/Models/Home/home_model.dart';
import 'package:e_commerceitsharks/Screen/HomeLayout/home_layout.dart';
import 'package:e_commerceitsharks/Shared/Widgets/TextField/text_form_field.dart';
import '../../Shared/Components/components.dart';
class SearchScreen extends StatefulWidget {
  SearchScreen({Key? key}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}
class _SearchScreenState extends State<SearchScreen> {
  TextEditingController searchController = TextEditingController();
  List<SearchModel> searchResults = [];
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return BlocConsumer<AppCubit, AppState>(
      listener: (context, state) {
        // TODO: Implement listener if needed
      },
      builder: (context, state) {
        var cubit = AppCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0.0,
            title: Text(
              'Search',
              style: TextStyle(color: Colors.white),
            ),
            centerTitle: true,
            leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(Icons.arrow_back, color: Colors.black),
            ),
          ),
          body: cubit.searchModel == null
              ? buildLoadingWidget()
              : Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Search',
                    labelStyle: TextStyle(
                      color: Colors.black,
                    ),

                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12.0),
                      borderSide: const BorderSide(
                        width: 1.0,
                        color: Colors.black,
                        style: BorderStyle.solid,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12.0),
                      borderSide: const BorderSide(
                        width: 1.0,
                        color: Colors.black,
                        style: BorderStyle.solid,
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: BorderSide(
                        color: Colors.blue,
                      ),
                    ),
                    suffixIcon: Icon(Icons.search,color: Colors.black,),
                  ),
                  cursorColor: Colors.black,
                  controller: searchController,
                  onChanged: (value){
                    setState(() {
                      AppCubit.get(context).getSearch(value);
                    });
                  },
                ),
                SizedBox(height:height*0.03),
                Expanded(child: GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 8,
                      mainAxisSpacing: 7,
                      mainAxisExtent: 400,
                    ),
                    itemCount: cubit.searchModel!.data!.data!.length,
                    itemBuilder: (context,index){
                      return GestureDetector(
                        onTap: (){
                          navigateTo(context, ProductDetails(products: cubit.homeModel!.data!.products![index]));
                        },
                        child: Container(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                              SizedBox(
                                  child: buildImage(
                                      image: cubit.searchModel!.data!.data![index].image,
                                      fit: "contain",radius: 12
                                  ),
                                height: height*0.2,
                              ),
                                SizedBox(height: height*0.02,),
                                BuildText(text:
                                cubit.searchModel!.data!.data![index].name!,
                                  maxLines: 1,
                                  bold: true,),
                                SizedBox(height: height*0.02,),
                                BuildText(
                                    text: cubit.searchModel!.data!.data![index].price.toString()),
                              ],
                            ),
                          ),
                        ),
                      );
                    }
                ),
                ),
                // Expanded(
                //   child: ListView.separated(
                //     separatorBuilder: (context, index) {
                //       return Divider();
                //     },
                //     itemCount: cubit.searchModel!.data!.data!.length,
                //     itemBuilder: (context, index) {
                //       return Card(
                //         child: ListTile(
                //           leading: Image.network(
                //             cubit.searchModel!.data!.data![index].image!,
                //           ),
                //           title:BuildText(text: '${cubit.searchModel!.data!.data![index].name!.toString()}',maxLines: 1,)
                //         ),
                //       );
                //     },
                //   ),
                // ),
              ],
            ),
          ),
        );
      },
    );
  }
}



