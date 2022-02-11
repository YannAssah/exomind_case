part of 'forecast_bloc.dart';

abstract class ForecastEvent extends Equatable {
  const ForecastEvent(List list);

  @override
  List<Object> get props => [];
}

class GetForecast extends ForecastEvent {
  var cityName;

  GetForecast(this.cityName) : super([cityName]);
}
