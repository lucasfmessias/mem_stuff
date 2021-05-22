import 'package:get_it/get_it.dart';
import 'package:mem_stuff/services/calls_and_messages_service.dart';

GetIt locator = GetIt.instance;

void setupLocator() {
  locator.registerSingleton(CallsAndMessagesService());
}
