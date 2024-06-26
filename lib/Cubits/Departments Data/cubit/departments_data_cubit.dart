import 'package:bloc/bloc.dart';
import 'package:emas/data/Repository/get_departments_repo.dart';
import 'package:flutter/foundation.dart';

part 'departments_data_state.dart';

class DepartmentsDataCubit extends Cubit<DepartmentsDataState> {
  DepartmentsDataCubit() : super(DepartmentsDataInitial());
  GetDepartmentsRepo departmentsRepo = GetDepartmentsRepo();

  Future<void> getDepartmentsData() async {
    emit(DepartmentsDataLoading());

    try {
      await departmentsRepo.getDepartmentsData().then((value) {
        if (value != null) {
          emit(DepartmentsDataSuccess());
        } else {
          emit(DepartmentsDataError('Failed to fetch Department\'s'));
        }
      });
    } catch (error) {
      emit(DepartmentsDataError('An error occurred'));
    }
  }
}
