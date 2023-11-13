import 'package:equatable/equatable.dart';
import 'package:Steward_flutter/models/models.dart';

abstract class RecentTransactionsState extends Equatable {
  final GetTransactionsInput? filters;

  const RecentTransactionsState(this.filters);
  @override
  List<Object?> get props => [filters];
}

class RecentTransactionsEmpty extends RecentTransactionsState {
  const RecentTransactionsEmpty(super.filters);
}

class RecentTransactionsLoading extends RecentTransactionsState {
  const RecentTransactionsLoading(super.filters);
}

class RecentTransactionsLoaded extends RecentTransactionsState {
  final TransactionsResult allTransactions;
  final TransactionsResult filteredTransactions;
  final String latestTransactionDate;
  @override
  final GetTransactionsInput? filters;

  const RecentTransactionsLoaded(
      {required this.allTransactions,
      required this.filteredTransactions,
      required this.latestTransactionDate,
      required this.filters})
      : super(filters);

  @override
  List<Object?> get props => [allTransactions, filteredTransactions, filters];
}

class RecentTransactionsError extends RecentTransactionsState {
  const RecentTransactionsError(super.filters);
}
