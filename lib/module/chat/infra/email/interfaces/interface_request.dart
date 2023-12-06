abstract class IRequest<T>{
  Future<dynamic>get({required T headers}) async{}
  Future<dynamic>post({required T headers}) async{}
  Future<dynamic>update({required T headers}) async{}
  Future<dynamic>delete({required T headers}) async{}
}