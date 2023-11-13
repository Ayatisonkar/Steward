import 'package:equatable/equatable.dart';
import 'package:Steward_flutter/models/models.dart';

// TODO(abhith): need to re-visit filters handling in states
abstract class CategoryTransactionsState extends Equatable {
  final GetTransactionsInput? filters;

  const CategoryTransactionsState(this.filters);
  @override
  List<Object?> get props => [];
}

class CategoryTransactionsEmpty extends CategoryTransactionsState {
  const CategoryTransactionsEmpty(super.filters);
}

class CategoryTransactionsLoading extends CategoryTransactionsState {
  const CategoryTransactionsLoading(GetTransactionsInput super.filters);
}

class CategoryTransactionsLoaded extends CategoryTransactionsState {
  final TransactionsResult allCategoryTransactions;
  final TransactionsResult filterdCategoryTransactions;
  @override
  final GetTransactionsInput? filters;

  const CategoryTransactionsLoaded(
      {required this.allCategoryTransactions,
      required this.filterdCategoryTransactions,
      required this.filters})
      : super(filters);

  @override
  List<Object?> get props =>
      [allCategoryTransactions, filterdCategoryTransactions, filters];
}

class CategoryTransactionsError extends CategoryTransactionsState {
  const CategoryTransactionsError(GetTransactionsInput super.filters);
}
