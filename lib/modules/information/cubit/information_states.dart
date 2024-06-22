abstract class InformationStates {}

class InatialInforamtionState extends InformationStates {}

class GetDataSuccess extends InformationStates {}

class GetDataError extends InformationStates {
  final String error;

  GetDataError({required this.error});
}
