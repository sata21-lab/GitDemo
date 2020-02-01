import 'package:event_bus/event_bus.dart';

EventBus eventBus = EventBus();
class ProductContentEvent {
  String text;
  ProductContentEvent(this.text);
}