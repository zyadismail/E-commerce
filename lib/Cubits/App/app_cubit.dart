import 'package:bloc/bloc.dart';
import 'package:e_commerceitsharks/Models/Authentication/authentication_model.dart';
import 'package:e_commerceitsharks/Models/Category/category_model.dart';
import 'package:e_commerceitsharks/Models/CategoryDetailsModel/categorydetails_model.dart';
import 'package:e_commerceitsharks/Models/ChangeCartmodel/change_cart.dart';
import 'package:e_commerceitsharks/Models/Favourite/favourite_model.dart';
import 'package:e_commerceitsharks/Models/GetCartmodel/getcart_model.dart';
import 'package:e_commerceitsharks/Models/Home/home_model.dart';
import 'package:e_commerceitsharks/Models/Search/search_model.dart';
import 'package:e_commerceitsharks/Models/changeFavourite/change_favouritemodel.dart';
import 'package:e_commerceitsharks/Network/Local/CashHelper.dart';
import 'package:e_commerceitsharks/Network/Remote/dio_helper.dart';
import 'package:e_commerceitsharks/Network/end_points.dart';
import 'package:e_commerceitsharks/Screen/Cart/cart_screen.dart';
import 'package:e_commerceitsharks/Screen/Category/category_screen.dart';
import 'package:e_commerceitsharks/Screen/CategoryDetails/categorydetails_screen.dart';
import 'package:e_commerceitsharks/Screen/Favourite/favourite_screen.dart';
import 'package:e_commerceitsharks/Screen/Home/home_screen.dart';
import 'package:e_commerceitsharks/Screen/Profile/profile_screen.dart';
import 'package:meta/meta.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
part 'app_state.dart';
class AppCubit extends Cubit<AppState> {
  AppCubit() : super(AppInitial());

  static AppCubit get(context)=>BlocProvider.of(context);
  HomeModel? homeModel;
  SearchModel?searchModel;
  CategoryModel?categoryModel;
  CategoryDetailsModel?categoryDetailsModel;
  FavouriteModel?favouriteModel;
  ChangeFavouriteModel?changeFavouriteModel;
  ChangeCartModel?changeCartModel;
  CartModel?cartModel;
  AuthenticationModel?authenticationModel;


  int currentIndexslider = 0;
  int indexscreen = 0;

  List<Widget> myScreens = [
    HomeScreen(),
    CategoryScreen(),
    FavouriteScreen(),
    CartScreen(),
    ProfileScreen(),
  ];
  
  void changeIndeXScreen(int index){
    indexscreen = index;
    emit(ChangeIndexScreen());
    if(index == 2){
      getFavourite();
    }
    else if(index == 3){
      getCart();
    }
  }
  void changeIndexSlider(int index){
    currentIndexslider = index;
    emit(ChangeIndexSlider());
  }
  
  void getHomeData(){
    emit(GetHomeLoading());
    DioHelper.getData(
      end_point: HOME,
      token: CashHelper.getData(key: 'token')??'',
    ).then((value){
      homeModel = HomeModel.fromJson(value.data);
      emit(GetHomeSuccess());
    }).catchError((error){
     print(error.toString());
     emit(GetHomeError());
    });
  }


  void getSearch(String text){
   emit(SearchLoading());
   DioHelper.postData(
       end_point: SEARCH,
       data: {
         'text':text
       },
       token: CashHelper.getData(key: 'token')??'',
       ).then((value){
         searchModel = SearchModel.fromJson(value.data);
         emit(SearchSuccess());
   }).catchError((error){
     print(error.toString());
     emit(SearchError());
   });

  }

  void getCategory(){
    emit(GetCategoryLoading());
   DioHelper.getData(
     end_point: CATEGORY,
   ).then((value){
     categoryModel = CategoryModel.fromJson(value.data);
     emit(GetHomeSuccess());
   }).catchError((error){
     print(error.toString());
     emit(GetHomeError());
   });
  }

  void getCategoryDetails({required int id}){
    categoryDetailsModel = null;
    emit(GetCategoryDetailsLoading());
    DioHelper.getData(
        end_point: CATEGORYDETAILS,
         token: CashHelper.getData(key: 'token')??'',
      query: {
          'category_id':id,
      }
    ).then((value){
      categoryDetailsModel = CategoryDetailsModel.fromJson(value.data);
      emit(GetCategoryDetailsSuccess());
    }).catchError((error){
      print(error.toString());
      emit(GetCategoryDetailsError());
    });
}


Future <void> postChangeFavourite({required int id})async{
    emit(ChangeFavouriteLoading());
    await DioHelper.postData(
        end_point: FAVOURITE,
      data: {
        'product_id' : id,
      },
      token: CashHelper.getData(key: 'token')?? '',
    ).then((value){
      changeFavouriteModel = ChangeFavouriteModel.fromJson(value.data);
      emit(ChangeFavouriteSuccess());
    }).catchError((error){
      print(error.toString());
      emit(ChangeFavouriteError());
    });
  }

  void changeFavouriteInHomeProduct({required int index}){

    if(homeModel!.data!.products![index].inFavorites!){
      homeModel!.data!.products![index].inFavorites = false;
    }
    else
    {
      homeModel!.data!.products![index].inFavorites = true;
    }

    emit(ChangeFavourite());
  }

  void changeFavouriteInSales({required int index}){

    if(homeModel!.data!.salesProducts[index].inFavorites!){
      homeModel!.data!.salesProducts[index].inFavorites = false;
    }
    else
    {
      homeModel!.data!.salesProducts[index].inFavorites = true;
    }

    emit(ChangeFavourite());
  }

  void changeFavouriteInCategoryProduct({required int index}){

    if(categoryDetailsModel!.data!.products![index].inFavorites!){
      categoryDetailsModel!.data!.products![index].inFavorites = false;
    }
    else
    {
      categoryDetailsModel!.data!.products![index].inFavorites = true;
    }

    emit(ChangeFavourite());
  }

  Future<void> getFavourite()async{
    emit(GetFavouriteLoading());
    DioHelper.getData(
      end_point: FAVOURITE,
      token: CashHelper.getData(key: 'token')??'',
    ).then((value){

      favouriteModel = FavouriteModel.fromJson(value.data);
      emit(GetFavouriteSuccess());

    }).catchError((error){
      print(error.toString());
      emit(GetFavouriteError());
    });
  }

  Future<void> postChangeCart({required int id})async{
    emit(ChangeCartLoading());
    await DioHelper.postData(
      end_point: CARTS,
      data: {
        'product_id' : id,
      },
      token: CashHelper.getData(key: 'token')?? '',
    ).then((value){
      changeCartModel = ChangeCartModel.fromJson(value.data);
      emit(ChangeCartSuccess());

    }).catchError((error){
      print((error.toString()));
      emit(ChangeCartError());

    });
  }

  Future<void> getCart()async{
    emit(GetCartLoading());
    DioHelper.getData(
      end_point: CARTS,
      token: CashHelper.getData(key: 'token')??'',
    ).then((value){

      cartModel = CartModel.fromJson(value.data);
      emit(GetCartSuccess());

    }).catchError((error){
      print(error.toString());
      emit(GetCartError());
    });
  }
}
