import 'package:emas/modules/information/edit_number/cubit/edit_number_state.dart';
import 'package:emas/shared/network/remot/dio_helper.dart';
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
        'id': 'eq.1',
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
