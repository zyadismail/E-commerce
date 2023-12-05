part of 'app_cubit.dart';

@immutable
abstract class AppState {}

class AppInitial extends AppState {}
class ChangeIndexScreen extends AppState {}


class GetHomeLoading extends AppState {}
class GetHomeSuccess extends AppState {}
class GetHomeError extends AppState {}


class SearchLoading extends AppState{}
class SearchSuccess extends AppState{}
class SearchError extends AppState{}


class GetCategoryLoading extends AppState {}
class GetCategorySuccess extends AppState {}
class GetCategoryError extends AppState {}


class GetCategoryDetailsLoading extends AppState {}
class GetCategoryDetailsSuccess extends AppState {}
class GetCategoryDetailsError extends AppState {}

class ChangeFavouriteLoading extends AppState {}
class ChangeFavouriteSuccess extends AppState {}
class ChangeFavouriteError extends AppState {}


class ChangeFavourite extends AppState {}


class GetFavouriteLoading extends AppState {}
class GetFavouriteSuccess extends AppState {}
class GetFavouriteError extends AppState {}


class ChangeCartLoading extends AppState {}
class ChangeCartSuccess extends AppState {}
class ChangeCartError extends AppState {}

class GetCartLoading extends AppState {}
class GetCartSuccess extends AppState {}
class GetCartError extends AppState {}





class ChangeIndexSlider extends AppState {}
