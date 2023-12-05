import 'package:bloc/bloc.dart';
import 'package:e_commerceitsharks/Models/Authentication/authentication_model.dart';
import 'package:e_commerceitsharks/Network/Remote/dio_helper.dart';
import 'package:e_commerceitsharks/Network/end_points.dart';
import 'package:meta/meta.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../Network/Local/CashHelper.dart';
part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitial());

  static AuthCubit get(context)=>BlocProvider.of(context);
  
  AuthenticationModel?authenticationModel;
  
  Future <void> postRegister({required name,required password,required email,required phone})
  async{
    emit(RegisterLoading());
    DioHelper.postData(
        end_point: REGISTER,
        data:{
          'name' : name,
          'password' : password,
          'email' : email,
          'phone' : phone,
        }).then((value){
          authenticationModel = AuthenticationModel.fromJson(value.data);
          print(value.data);
          emit(RegisterSuccess(
              state: authenticationModel!.status!,
              message: authenticationModel!.message!,
              token: authenticationModel!.status!? authenticationModel!.data!.token!:null,
          ));
        }).catchError((error){
      print(error.toString());
      emit(RegisterError());
    });
  }



  Future <void> postLogin({ required email, required password})
  async{
    emit(LoginLoading());
    DioHelper.postData(
        end_point: LOGIN,
        data:{
          'email' : email,
          'password' : password,
        }).then((value){
      authenticationModel = AuthenticationModel.fromJson(value.data);
      emit(LoginSuccess(
        state: authenticationModel!.status!,
        message: authenticationModel!.message!,
        token: authenticationModel!.status!? authenticationModel!.data!.token!:null,
      ));
    }).catchError((error){
      print(error.toString());
      emit(LoginError());
    });
  }

  void getProfileData(){
    emit(GetProfileLoading());
    DioHelper.getData(
      end_point: Profile,
      token: CashHelper.getData(key: 'token')??'',
    ).then((value){
      authenticationModel = AuthenticationModel.fromJson(value.data);
      emit(GetProfileSuccess());
    }).catchError((error){
      print(error.toString());
      emit(GetProfileError());
    });
  }


  void updateProfile({
    required String name,
    required String email,
    required String phone,} ){
    emit(GetUpdateProfileLoading());
    print(CashHelper.getData(key: 'token'));
    DioHelper.putData(
        end_point: Updated_Profile,
        token: CashHelper.getData(key: 'token')??'',
        data: {
          'name': name,
          'email': email,
          'phone': phone,
        }
    ).then((value){
      if(value.data["status"]){
        emit(GetUpdateProfileSuccess());
      }else{
        emit(GetUpdateProfileError());
      }
      authenticationModel = AuthenticationModel.fromJson(value.data);
      emit(GetUpdateProfileSuccess());
    }).catchError((error){
      print(error.toString());
      emit(GetUpdateProfileError());
    });
  }
}
