import 'package:flutter_bloc/flutter_bloc.dart';
import '/constants/const_variables.dart';
import '/cubit/shop_home/home_cubit.dart';
import '/cubit/single_category/single_category_states.dart';
import '/models/single_category_model.dart';
import '/utils/dio_helper.dart';
import '/utils/end_points.dart';

class SingleCategoryCubit extends Cubit<SingleCategoryStates>
{

  SingleCategoryCubit() : super(SingleCategoryInitialState());

  static SingleCategoryCubit get(context) => BlocProvider.of(context);

  SingleCategoryModel? singleCategoryModel;

  getCategories(int id, context)
  {
    emit(SingleCategoryLoadingState());

    DioHelper.getData(
      url: GET_PRODUCTS,
      token: token,
      query: {
        'category_id':id,
      },
    ).then((value)
    {
      singleCategoryModel = SingleCategoryModel.fromJson(value.data);

      singleCategoryModel!.data!.data.forEach((element)
      {
        if(!HomeCubit.get(context).favList.containsKey(element.id))
        {
          HomeCubit.get(context).favList.addAll({
            element.id as int: element.inFavorites as bool
          });
        }

        if(!HomeCubit.get(context).cart.containsKey(element.id))
        {
          HomeCubit.get(context).cart.addAll({
            element.id as int: element.inCart  as bool
          });

          if(element.inCart as bool)
          {
            HomeCubit.get(context).cartProductsNumber++;
          }
        }

      });

      emit(SingleCategorySuccessState());

      print(value.data.toString());
    }).catchError((error) {
      print(error.toString());
      emit(SingleCategoryErrorState(error.toString()));
    });
  }
}