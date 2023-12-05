part of 'auth_cubit.dart';

@immutable
abstract class AuthState {}

class AuthInitial extends AuthState {}


class RegisterLoading extends AuthState {}
class RegisterSuccess extends AuthState {
  late bool state;
  late String message;
  String? token;
  RegisterSuccess({required this.state, required this.message, required this.token});
}
class RegisterError extends AuthState {}


class LoginLoading extends AuthState {}
class LoginSuccess extends AuthState {
  late bool state;
  late String message;
  String? token;
  LoginSuccess({required this.state, required this.message, required this.token});
}
class LoginError extends AuthState {}

class GetProfileLoading extends AuthState {}
class GetProfileSuccess extends AuthState {}
class GetProfileError extends AuthState {}


class GetUpdateProfileLoading extends AuthState {}
class GetUpdateProfileSuccess extends AuthState {}
class GetUpdateProfileError extends AuthState {}

