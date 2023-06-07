import 'package:realm/realm.dart';

part 'schemas.g.dart';

@RealmModel()
class _Item {
  @PrimaryKey()
  late ObjectId id;
  bool isComplete = false;
  late String summary;
  late String todo;
}
