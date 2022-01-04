import 'package:flutter/material.dart';
import 'package:flutterlazyloading/model/passenger.dart';
import 'package:flutterlazyloading/repository/passenger_repository.dart';
import 'package:flutterlazyloading/ui/widgets/exception_indicators/empty_list_indicator.dart';
import 'package:flutterlazyloading/ui/widgets/exception_indicators/error_indicator.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  static const _pageSize = 20;
  final PagingController<int, Passenger> _pagingController =
      PagingController(firstPageKey: 0);

  @override
  void initState() {
    _pagingController.addPageRequestListener((pageKey) {
      _fetchPage(pageKey);
    });
    super.initState();
  }

  Future<void> _fetchPage(int pageKey) async {
    try {
      final passengers = await PassengerRepository.getPassengers(pageKey, _pageSize);
      final isLastPage = passengers.length < _pageSize;

      if (isLastPage) {
        _pagingController.appendLastPage(passengers);
      } else {
        final nextPageKey = pageKey + passengers.length;
        _pagingController.appendPage(passengers, nextPageKey);
      }
    } catch (error) {
      _pagingController.error = error;
    }
  }

  @override
  void dispose() {
    _pagingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lazy loading'),
        centerTitle: true,
        elevation: 0,
      ),
      body: RefreshIndicator(
        onRefresh: () => Future.sync(() => _pagingController.refresh()),
        child: PagedListView<int, Passenger>(
          pagingController: _pagingController,
          builderDelegate: PagedChildBuilderDelegate<Passenger>(
            itemBuilder: (context, passenger, index) {
              return ListTile(
                title: Text(passenger.name ?? 'No name'),
                subtitle: Text(passenger.airline[0].name),
                trailing: Text(passenger.airline[0].country),
              );
            },
            firstPageErrorIndicatorBuilder: (context) => ErrorIndicator(
              error: _pagingController.error,
              onTryAgain: () => _pagingController.refresh(),
            ),
            noItemsFoundIndicatorBuilder: (context) => const EmptyListIndicator(),
          ),
        ),
      ),
    );
  }
}
