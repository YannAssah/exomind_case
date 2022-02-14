part of 'forecast_bloc.dart';

abstract class ForecastState extends Equatable {
  const ForecastState();

  @override
  List<Object> get props => [];
}

class ForecastLoading extends ForecastState {}

class ForecastLoaded extends ForecastState {
  late final List<Forecast> forecast;

  ForecastLoaded(this.forecast);
  @override
  List<Object> get props => [forecast];
}
