// ignore_for_file: avoid_print

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '/models/add_cart_mdl.dart';
import '/models/cart_mdl.dart';
import '/cubit/shop_home/home_states.dart';
import '/models/category_mdl.dart';
import '/models/change_fav_mdl.dart';
import '/models/favorite_mdl.dart';
import '/models/login_model.dart';
import '/utils/func_helper.dart';
import '/constants/const_variables.dart';
import '/models/home_mdl.dart';
import '/utils/dio_helper.dart';
import '/utils/end_points.dart';
import '/screens/categories_scrn.dart';
import '/screens/favorites_scrn.dart';
import '/screens/products_scrn.dart';
import '/screens/settings_scrn.dart';

class HomeCubit extends Cubit<HomeStates> {
  HomeCubit() : super(HomeInitialState());

  static HomeCubit get(context) => BlocProvider.of(context);

  int currentIndex = 0;

  List<Widget> bottomScreens = [
    const ProductsScrn(),
    const CategoriesScrn(),
    const FavoritesScrn(),
    SettingsScrn(),
  ];

  void changeBottom(int index) {
    currentIndex = index;
    emit(HomeChangeBottomNavBarState());
  }

//Favorites
  FavModel? favoriteModel;

  void getFavoritesData() {
    emit(FavoritesLoadingState());
    DioHelper.getData(
      url: ADD_FAVOURITE,
      token: token,
    ).then((value) {
      favoriteModel = FavModel.fromJson(value.data);
      emit(GetSuccessFavoritesState());
    }).catchError((error) {
      emit(GetErrorFavoritesState(error));
    });
  }

//Change-Favorites
  Map<int, bool> favList = {};
  ChangeFavoriteModel? _changeFavorite;
  void changeFavorites(int productId) {
    print("favList[productId]");
    print(favList[productId].toString());
    print(favList);
    favList[productId] = !(favList[productId] as bool);
    print(favList);
    emit(SuccessFavoritesChangeState());

    DioHelper.postData(
            url: ADD_FAVOURITE, data: {'product_id': productId}, token: token)
        .then((value) {
      _changeFavorite = ChangeFavoriteModel.fromjson(value.data);
      print(_changeFavorite!.status);
      print(value);
      if (!(_changeFavorite!.status)) {
        favList[productId] = !(favList[productId] as bool);
      } else {
        getFavoritesData();
      }
      emit(SuccessFavoritesDataState(_changeFavorite!));
    }).catchError((error) {
      print(error.toString());
      emit(ErrorFavoritesDataState(error.toString()));
    });
  }

  ///Cart
  Map<int, bool> cart = {};
  int cartProductsNumber = 0;

  CartModel? cartModel;

  getCart() {
    emit(UpdateCartLoadingState());
    DioHelper.getData(
      url: ADD_CART,
      token: token,
    ).then((value) {
      cartModel = CartModel.fromJson(value.data);
      emit(CartSuccessState());
      print('success cart');
    }).catchError((error) {
      print('error cart ${error.toString()}');
      emit(CartErrorState(error.toString()));
    });
  }

  AddCartModel? addCartModel;

  changeCart({
    required int id,
  }) {
    print(id);

    changeLocalCart(id);

    emit(ChangeCartLoadingState());
    DioHelper.postData(
      url: ADD_CART,
      token: token,
      data: {
        'product_id': id,
      },
    ).then((value) {
      print(value.data);
      addCartModel = AddCartModel.fromJson(value.data);

      if (addCartModel!.status == false) {
        changeLocalCart(id);
      }

      emit(ChangeCartSuccessState());

      getCart();
    }).catchError((error) {
      changeLocalCart(id);

      emit(ChangeCartErrorState(error.toString()));
    });
  }

  updateCart({
    required int id,
    required int quantity,
  }) {
    emit(UpdateCartLoadingState());

    DioHelper.putData(
      url: '$ADD_CART/$id',
      token: token,
      data: {
        'quantity': quantity,
      },
    ).then((value) {
      print(value.data);

      getCart();
    }).catchError((error) {
      emit(UpdateCartErrorState(error.toString()));
    });
  }

  void changeLocalCart(id) {
    cart[id] = !(cart[id] as bool);

    if (cart[id] == true) {
      cartProductsNumber++;
    } else {
      cartProductsNumber--;
    }

    emit(ChangeCartLocalState());
  }

//Products
  HomeModel? homeModel;
  void getHomeData() {
    emit(HomeLoadingHomeDataState());
    DioHelper.getData(
      url: HOME,
      token: token,
    ).then((value) {
      homeModel = HomeModel.fromJson(value.data);
      homeModel!.data!.products.forEach((element) {
        favList.addAll({
          element.id as int: element.inFavorites as bool,
        });
        cart.addAll({
          element.id as int: element.inCart as bool,
        });

        if (element.inCart = true) {
          cartProductsNumber++;
        }
      });
      print(favList);
      emit(HomeSuccessHomeDataState());
    }).catchError((error) {
      print(error.toString());
      emit(HomeErrorHomeDataState());
    });
  }

  // Categorie
  CategoriesModel? categoriesModel;
  void getCategoriesData() {
    emit(CategoriesLoadingState());
    DioHelper.getData(
      url: CATEGORIES,
      token: token,
    ).then((value) {
      categoriesModel = CategoriesModel.fromJson(value.data);
      emit(SuccessCategoriesDataState());
    }).catchError((error) {
      print(error.toString());
      emit(ErrorCategoriesDataState(error.toString()));
    });
  }

//Get-Profile-Data
  LoginModel? userModel;
  void getUserData() {
    emit(UserLoadingState());
    DioHelper.getData(
      url: PROFILE,
      token: token,
    ).then((value) {
      userModel = LoginModel.fromJson(value.data);
      print(userModel!.data!.name);
      emit(SuccessUserDataState(userModel!));
    }).catchError((error) {
      print(error.toString());
      emit(ErrorUserDataState(error));
    });
  }

  //Updated-profile-user
  void updateUserData(
      {required String name, required String email, required String phone}) {
    emit(UpdateUserDataLoadingState());
    DioHelper.putData(
      url: UPDATED_PROFILE,
      token: token,
      data: {'name': name, 'email': email, 'phone': phone},
    ).then((value) {
      userModel = LoginModel.fromJson(value.data);
      printFullText(userModel!.data!.name.toString());
      emit(SuccessUpdatedUserDataState());
    }).catchError((error) {
      print(error.toString());
      emit(ErrorUpdatedUserDataState(error));
    });
  }
}
