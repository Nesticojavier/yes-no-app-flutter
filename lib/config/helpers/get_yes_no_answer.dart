import 'package:yes_no_app/domain/entities/message.dart';
import 'package:dio/dio.dart';

class GetYesNoAnswer {
  final _dio = Dio();
  Future<Message> getAnswer() async {
    final response = await _dio.get("https://www.yesno.wtf/api");

    response.data['answer'];

    return Message(
        fromWho: FromWho.hers,
        text: response.data['answer'],
        imageUrl: response.data['image']);
  }
}
