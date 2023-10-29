part of 'location_bloc.dart';

abstract class LocationEvent extends Equatable {
  const LocationEvent();

  @override
  List<Object> get props => [];
}

class LoadLocationEvent extends LocationEvent {
  late final double latitude, longitude;
  LoadLocationEvent(this.latitude, this.longitude);

  @override
  List<Object> get props => [latitude, longitude];
}
