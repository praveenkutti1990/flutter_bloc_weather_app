part of 'location_bloc.dart';

abstract class LocationState extends Equatable {
  const LocationState();

  @override
  List<Object> get props => [];
}

class LocationInitial extends LocationState {}

class LocationLoadingState extends LocationState {}

class LocationLoadedState extends LocationState {
  final Location location;
  LocationLoadedState(this.location);

  @override
  List<Object> get props => [location];
}

class LocationLoadErrorState extends LocationState {
  final String error;
  LocationLoadErrorState(this.error);

  @override
  List<Object> get props => [error];
}
