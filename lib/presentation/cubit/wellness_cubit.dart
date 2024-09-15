import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:payuung_pribadi_duplicate/data/models/wellness_model.dart';
import 'package:payuung_pribadi_duplicate/helpers/database_helper.dart';

class WellnessCubit extends Cubit<WellnessState> {
  final DatabaseHelper _databaseHelper = DatabaseHelper();

  WellnessCubit() : super(WellnessInitial());

  Future<void> loadwellness() async {
    emit(WellnessLoading());
    try {
      final wellness = await _databaseHelper.getWellness();
      emit(WellnessLoaded(wellness));
    } catch (e) {
      emit(WellnessError(e.toString()));
    }
  }

  Future<void> addWellness(List<WellnessModel> wellness) async {
    emit(WellnessLoading());
    try {
      final List<WellnessModel> dataWellness =
          await _databaseHelper.getWellness();

      if (dataWellness.isEmpty) {
        for (WellnessModel data in wellness) {
          await _databaseHelper.insertWellness(data);
        }
      }
      loadwellness();
    } catch (e) {
      emit(WellnessError(e.toString()));
    }
  }
}

abstract class WellnessState extends Equatable {
  const WellnessState();

  @override
  List<Object> get props => [];
}

class WellnessInitial extends WellnessState {}

class WellnessLoading extends WellnessState {}

class WellnessLoaded extends WellnessState {
  final List<WellnessModel> wellness;

  const WellnessLoaded(this.wellness);

  @override
  List<Object> get props => [wellness];
}

class WellnessError extends WellnessState {
  final String message;

  const WellnessError(this.message);

  @override
  List<Object> get props => [message];
}
