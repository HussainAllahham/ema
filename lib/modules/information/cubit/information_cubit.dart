import 'package:emas/models/information_model.dart';
import 'package:emas/modules/information/cubit/information_states.dart';
import 'package:emas/shared/network/remot/dio_helper.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class InformationCubit extends Cubit<InformationStates> {
  InformationCubit() : super(InatialInforamtionState());

  static InformationCubit get(context) => BlocProvider.of(context);

  InformationModel? informationModel;
  void getData({
    required String id,
  }) {
    DioHelper.getdata(
      url: 'rest/v1/users',
      query: {
        'id': id,
      },
    ).then((value) {
      informationModel = InformationModel.fromJson(value.data[0]);
      emit(GetDataSuccess());
    }).catchError((error) {
      print(error.toString());
      emit(GetDataError(error: error));
    });
  }
}
