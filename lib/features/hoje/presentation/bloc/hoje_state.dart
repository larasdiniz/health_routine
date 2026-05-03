import 'package:equatable/equatable.dart';
import '../../domain/entities/activity_entity.dart';

abstract class HojeState extends Equatable {
  const HojeState();

  @override
  List<Object> get props => [];
}

class HojeInitial extends HojeState {}

class HojeLoading extends HojeState {}

class HojeSuccess extends HojeState {
  final List<ActivityEntity> activities;
  final bool isLowEnergyMode; // Já preparando o terreno pra sua feature genial do Figma!

  const HojeSuccess({
    required this.activities,
    this.isLowEnergyMode = false,
  });

  @override
  List<Object> get props => [activities, isLowEnergyMode];
}

class HojeError extends HojeState {
  final String message;

  const HojeError({required this.message});

  @override
  List<Object> get props => [message];
}