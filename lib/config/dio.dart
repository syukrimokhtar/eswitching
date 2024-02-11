
import 'package:dio/dio.dart';
import 'package:dio_cache_interceptor/dio_cache_interceptor.dart';

// Global options
final cacheOptions = CacheOptions(
  store: MemCacheStore(),
  policy: CachePolicy.noCache,
  hitCacheOnErrorExcept: [401, 403],
  priority: CachePriority.normal,
  keyBuilder: CacheOptions.defaultCacheKeyBuilder,
  allowPostMethod: false,
);

BaseOptions options = BaseOptions(
  receiveDataWhenStatusError: true,
  connectTimeout: const Duration(seconds: 30),
  receiveTimeout: const Duration(seconds: 30)
);

// Singleton
final dio = Dio(options)..interceptors.add(
  DioCacheInterceptor(options: cacheOptions));