import 'package:equatable/equatable.dart';
import 'package:Steward_flutter/models/models.dart';

abstract class AccountTransactionsEvent extends Equatable {
  const AccountTransactionsEvent();
  @override
  List<Object> get props => [];
}

class FetchAccountTransactions extends AccountTransactionsEvent {
  final GetTransactionsInput input;

  const FetchAccountTransactions({required this.input});

  @override
  List<Object> get props => [input];
}

class FilterAccountTransactions extends AccountTransactionsEvent {
  final String query;

  const FilterAccountTransactions(this.query);
}
