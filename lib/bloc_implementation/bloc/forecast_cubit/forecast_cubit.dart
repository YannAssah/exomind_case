import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'forecast_state.dart';

class ForecastCubit extends Cubit<ForecastState> {
  ForecastCubit() : super(ForecastInitial());
}
