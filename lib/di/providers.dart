import 'package:positive_conversion_reframing/models/db/database_manager.dart';
import 'package:positive_conversion_reframing/models/repositories/user_repository.dart';
import 'package:positive_conversion_reframing/view_models/login_view_model.dart';
import 'package:positive_conversion_reframing/view_models/reframing_view_model.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

List<SingleChildWidget> globalProviders = [
  ...independentModels,
  ...dependentModels,
  ...viewModels
];

List<SingleChildWidget> independentModels = [
  Provider<DatabaseManager>(
    create: (_) => DatabaseManager(),
  ),
];

List<SingleChildWidget> dependentModels = [
  ProxyProvider<DatabaseManager, UserRepository>(
    update: (_, dbManager, repo) => UserRepository(databaseManager: dbManager),
  ),
];

List<SingleChildWidget> viewModels = [
  ChangeNotifierProvider<LoginViewModel>(
    create: (context) => LoginViewModel(
      userRepository: context.read<UserRepository>(),
    ),
  ),
  ChangeNotifierProvider<ReframingViewModel>(
    create: (context) => ReframingViewModel(),
  ),
];
