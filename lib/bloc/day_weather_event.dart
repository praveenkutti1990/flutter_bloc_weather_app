part of 'day_weather_bloc.dart';

abstract class DayWeatherEvent extends Equatable {
  const DayWeatherEvent();

  @override
  List<Object> get props => [];
}

class LoadDayWeatherEvent extends DayWeatherEvent{}