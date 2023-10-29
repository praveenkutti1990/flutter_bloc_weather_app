part of 'day_weather_bloc.dart';

abstract class DayWeatherState extends Equatable {
  const DayWeatherState();

  @override
  List<Object> get props => [];
}

class DayWeatherInitial extends DayWeatherState {}

class DayWeatherLoadingState extends DayWeatherState {}

class DayWeatherLoadedState extends DayWeatherState {
  final DayWeather dayWeather;
  const DayWeatherLoadedState(this.dayWeather);

  @override
  List<Object> get props => [dayWeather];
}

class DayWeatherErrorState extends DayWeatherState {
  final String error;
  const DayWeatherErrorState(this.error);

  @override
  List<Object> get props => [error];
}
