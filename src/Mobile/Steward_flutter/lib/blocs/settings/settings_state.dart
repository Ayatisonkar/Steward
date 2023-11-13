import 'package:equatable/equatable.dart';
import 'package:Steward_flutter/models/models.dart';

abstract class SettingsState extends Equatable {
  const SettingsState();
  @override
  List<Object> get props => [];
}

class SettingsLoading extends SettingsState {}

class SettingsLoaded extends SettingsState {
  final UserSettings settings;

  const SettingsLoaded({required this.settings});

  @override
  List<Object> get props => [settings];
}

class SettingsError extends SettingsState {
  final String errorMessage;

  const SettingsError({required this.errorMessage});

  @override
  String toString() => 'SettingsError { error: $errorMessage }';

  @override
  List<Object> get props => [errorMessage];
}
