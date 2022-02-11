part of 'forecast_bloc.dart';

abstract class ForecastState extends Equatable {
  const ForecastState([List<Forecast>? list]);

  @override
  List<Object> get props => [];
}

class ForecastInitial extends ForecastState {}

class ForecastLoading extends ForecastState {}

// Only the ForecastLoaded event needs to contain data
class ForecastLoaded extends ForecastState {
  final List<Forecast> forecast;

  ForecastLoaded(this.forecast) : super([]);
}
