import 'package:flutter_bloc/flutter_bloc.dart';
import '/constants/const_variables.dart';
import '/cubit/search/search_states.dart';
import '/models/search_mdl.dart';
import '/utils/dio_helper.dart';
import '/utils/end_points.dart';

class SearchCubit extends Cubit<SearchStates> {
  SearchCubit() : super(SearchInitialState());

  static SearchCubit get(context) => BlocProvider.of(context);
  SearchModel? searchModel;
  void getSearchData(String text) {
    emit(SearchLoadingState());
    DioHelper.postData(url: SEARCH, token: token, data: {
      'text': text,
    }).then((value) {
      searchModel = SearchModel.fromJson(value.data);
      emit(SearchSuccessState());
    }).catchError((error) {
      emit(SearchErrorState());
    });
  }
}
