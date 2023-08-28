import 'package:bookly_app_tharwat/Features/home/data/models/book_model/book_model.dart';
import 'package:bookly_app_tharwat/Features/home/domain/entities/book_entity.dart';
import 'package:bookly_app_tharwat/core/utils/api_service.dart';

abstract class HomeRemoteDataSource{
  Future<List<BookEntity>> fetchFeaturedBooks();

  Future<List<BookEntity>> fetchNewestBooks();
}
class HomeRemoteDataSourceImpl implements HomeRemoteDataSource{
  final ApiService apiService;

  HomeRemoteDataSourceImpl(this.apiService);
  @override
  Future<List<BookEntity>> fetchFeaturedBooks() async{

    var data =await apiService.get(endPoint: 'volumes?Filtering=free-ebooks&q=subject:programming');
    List<BookEntity> books = gitBooksList(data);
    return books;
  }
  @override
  Future<List<BookEntity>> fetchNewestBooks() async {
    var data =await apiService.get(endPoint: 'volumes?filtering:=free&sorting=newest&q=programming');
    List<BookEntity> books = gitBooksList(data);
    return books;
  }
  List<BookEntity> gitBooksList(Map<String, dynamic> data) {
      List<BookEntity> books=[];
    for (var bookMap in data['items']){
      books.add(BookModel.fromJson(bookMap));
    }
    return books;
  }


}