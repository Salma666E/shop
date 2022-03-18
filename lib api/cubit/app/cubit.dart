import 'package:flutter_bloc/flutter_bloc.dart';
import '/utils/cache_helper.dart';
import 'states.dart';

class AppCubit extends Cubit<AppStates> {
  AppCubit() : super(AppInitialState());

  static AppCubit get(context) => BlocProvider.of(context);
  // /////////////////////////isDark///////////////////////////////////

  bool isDark = false;

  void changeAppMode({required bool fromShared}) {
    print(fromShared.toString());
     isDark = !isDark;
      CacheHelper.putBoolean(key: 'isDark', value: isDark).then((value) {
        emit(AppChangeModeState());
      });
  }
  // /////////////////////////////Language///////////////////////////////
  // List<bool> selectedLanguage =
  // [
  //   false,
  //   false,
  // ];
  // int selectedLanguageIndex=0;
  // void changeSelectedLanguage(int index) {
  //   selectedLanguageIndex = index;

  //   for (int i = 0; i < selectedLanguage.length; i++) {
  //     if (i == index) {
  //       selectedLanguage[i] = true;
  //     } else {
  //       selectedLanguage[i] = false;
  //     }
  //   }

  //   emit(AppSelectLanguageState());
  // }
  // AppLanguageModel? languageModel;
  // TextDirection appDirection = TextDirection.ltr;

  // Future<void> setLanguage({
  //   required String translationFile,
  //   required String code,
  // }) async {
  //   languageModel = AppLanguageModel.fromJson(json.decode(translationFile));
  //   appDirection = code == 'ar' ? TextDirection.rtl : TextDirection.ltr;

  //   emit(AppSetLanguageState());
  // }
  // /////////////////////////////Language///////////////////////////////
}
