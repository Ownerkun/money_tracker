import 'package:graduation_project_app/data/category_item.dart';
import 'package:graduation_project_app/data/transaction_item.dart';
import 'package:hive/hive.dart';

class TransactionTypeAdapter extends TypeAdapter<TransactionType> {
  @override
  final typeId = 0; // You can choose any positive integer as the type id

  @override
  TransactionType read(BinaryReader reader) {
    return TransactionType.values[reader.readByte()];
  }

  @override
  void write(BinaryWriter writer, TransactionType obj) {
    writer.writeByte(obj.index);
  }
}

class CategoryTypeAdapter extends TypeAdapter<CategoryType> {
  @override
  final typeId = 1; // You can choose any positive integer as the type id

  @override
  CategoryType read(BinaryReader reader) {
    return CategoryType.values[reader.readByte()];
  }

  @override
  void write(BinaryWriter writer, CategoryType obj) {
    writer.writeByte(obj.index);
  }
}
