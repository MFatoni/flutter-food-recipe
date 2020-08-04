import 'package:foodrecipes_flutter/model/data_food.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

class MockClient extends Mock implements http.Client {}

main() {
  group('getPost', () {
    test('menampilkan sebuat Post jika panggil API berhasil', () async {
      final client = MockClient();
      // Gunakan Mockito untuk menampilkan respon berhasil
      when(client.get('https://jsonplaceholder.typicode.com/posts/1'))
          .thenAnswer((_) async => http.Response('{"title": "Test"}', 200));
      expect(await Post().getPost(client), isInstanceOf<FoodDetail>());
    });
    test('throws sebuah exception jika terdapat error', () {
      final client = MockClient();
      // Use Mockito to return an unsuccessful response when it calls the
      // provided http.Client.
      when(client.get('https://jsonplaceholder.typicode.com/posts/1'))
          .thenAnswer((_) async => http.Response('Not Found', 404));
      expect(Post().getPost(client), throwsException);
    });
  });
}
class Post{
  Future<FoodDetail> getPost(http.Client client) async {
    final response =
        await client.get('https://jsonplaceholder.typicode.com/posts/1');

    if (response.statusCode == 200) {
      // Jika pemanggilan API berhasil, parse JSON.
      return FoodDetail.fromJson(json.decode(response.body));
    } else {
      // Jika gagal, munculkan error.
      throw Exception('Gagal menampilkan data');
    }
  }
}