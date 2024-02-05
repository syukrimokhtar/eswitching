
import 'package:dio/dio.dart';
import 'package:dio_cache_interceptor/dio_cache_interceptor.dart';

// Global options
final options = CacheOptions(
  store: MemCacheStore(),
  policy: CachePolicy.noCache,
  hitCacheOnErrorExcept: [401, 403],
  priority: CachePriority.normal,
  keyBuilder: CacheOptions.defaultCacheKeyBuilder,
  allowPostMethod: false,
);

// Singleton
final dio = Dio()..interceptors.add(DioCacheInterceptor(options: options));