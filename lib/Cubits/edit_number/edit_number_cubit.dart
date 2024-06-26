import 'package:emas/Cubits/edit_number/edit_number_state.dart';
import 'package:emas/Screen/Splash_Screen.dart';
import 'package:emas/data/Repository/dio_helper.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EditNmberCubit extends Cubit<EditNumberStates> {
  EditNmberCubit() : super(InitialEditState());

  static EditNmberCubit get(context) => BlocProvider.of(context);
  void update({
    required String phone,
  }) {
    emit(EditNumberLoadingState());
    DioHelper.updata(
      url: 'rest/v1/users',
      query: {
        'id': 'eq.${employeer_id}',
      },
      data: {
        'phone': phone,
      },
    ).then((value) {
      emit(EditNumberSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(EditNumberErrorState(error: error.toString()));
    });
  }
}
