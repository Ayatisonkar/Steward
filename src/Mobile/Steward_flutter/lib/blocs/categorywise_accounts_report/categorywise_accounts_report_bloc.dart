import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:Steward_flutter/models/models.dart';
import 'package:Steward_flutter/repositories/report_repository.dart';
import './bloc.dart';

class CategorywiseAccountsReportBloc extends Bloc<
    CategorywiseAccountsReportEvent, CategorywiseAccountsReportState> {
  CategorywiseAccountsReportBloc({required this.reportRepository})
      : super(CategorywiseAccountsReportLoading());

  final ReportRepository reportRepository;

  @override
  Stream<CategorywiseAccountsReportState> mapEventToState(
    CategorywiseAccountsReportEvent event,
  ) async* {
    if (event is CategorywiseAccountsReportLoad) {
      yield CategorywiseAccountsReportLoading();
      try {
        final List<CategoryReportGroupedListItem> result =
            await reportRepository.getCategoryReport(event.input);
        yield CategorywiseAccountsReportLoaded(result: result);
      } catch (error) {
        yield CategorywiseAccountsReportError();
      }
    }
  }
}
