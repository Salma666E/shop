import '/models/change_fav_mdl.dart';
import '/models/login_model.dart';

abstract class HomeStates {}

class HomeInitialState extends HomeStates {}

class HomeChangeBottomNavBarState extends HomeStates {}

class HomeLoadingHomeDataState extends HomeStates {}

//Products

class HomeSuccessHomeDataState extends HomeStates {}

class HomeErrorHomeDataState extends HomeStates {}

//Categories

class CategoriesLoadingState extends HomeStates {}

class SuccessCategoriesDataState extends HomeStates {}

class ErrorCategoriesDataState extends HomeStates {
  final String error;

  ErrorCategoriesDataState(this.error);
}

//Favorites
class FavoritesLoadingState extends HomeStates {}

class GetSuccessFavoritesState extends HomeStates {}

class GetErrorFavoritesState extends HomeStates {
  final String error;

  GetErrorFavoritesState(this.error);
}

//Change-Favorites
class SuccessFavoritesChangeState extends HomeStates {}

class SuccessFavoritesDataState extends HomeStates {
  final ChangeFavoriteModel favModel;
  SuccessFavoritesDataState(this.favModel);
}

class ErrorFavoritesDataState extends HomeStates {
  final String error;

  ErrorFavoritesDataState(this.error);
}

//Update-Profile
//Name-Update/Email-Update/Phone-Update
class UpdateUserDataLoadingState extends HomeStates {}
class SuccessUpdatedUserDataState extends HomeStates {}

class ErrorUpdatedUserDataState extends HomeStates {
  final String error;

  ErrorUpdatedUserDataState(this.error);
}

//Profile-User
class UserLoadingState extends HomeStates {}

class SuccessUserDataState extends HomeStates {
 final LoginModel? userModel;

  SuccessUserDataState(this.userModel);
  }

class ErrorUserDataState extends HomeStates {
  final String error;

  ErrorUserDataState(this.error);
}

//logout
class LogOutLoadingState extends HomeStates {}



//
//Change Cart
class ChangeCartLocalState extends HomeStates {}

class ChangeCartLoadingState extends HomeStates {}

class ChangeCartSuccessState extends HomeStates {}

class ChangeCartErrorState extends HomeStates
{
  final String error;

  ChangeCartErrorState(this.error);
}

//Cart
class CartLoadingState extends HomeStates {}

class CartSuccessState extends HomeStates {}

class CartErrorState extends HomeStates
{
  final String error;

  CartErrorState(this.error);
}
//UpdateCart
class UpdateCartLoadingState extends HomeStates {}

class UpdateCartErrorState extends HomeStates
{
  final String error;

  UpdateCartErrorState(this.error);
}