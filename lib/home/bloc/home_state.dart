part of 'home_bloc.dart';

@immutable
sealed class HomeState {}

abstract class HomeActionState extends HomeState {}

final class HomeInitial extends HomeState {}

class HomeLoadingState extends HomeState {}

class HomeSuccessState extends HomeState {
  final LocationData currentLocation;
  final Map<String, dynamic> weatherData;
  final String currAddress;

  HomeSuccessState(
      {required this.currAddress,
      required this.currentLocation,
      required this.weatherData});
}

class HomeErrorState extends HomeState {
  final String message;

  HomeErrorState({this.message = "Error was caught!"});
}

class HomeGetLocationActionState extends HomeState {}