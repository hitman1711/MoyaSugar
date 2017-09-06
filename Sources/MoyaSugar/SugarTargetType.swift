import struct Foundation.URL

import Moya

public protocol SugarTargetType: TargetType {
  var url: URL { get }

  /// Returns `Route` which contains HTTP method and URL path information.
  ///
  /// Example:
  ///
  /// ```
  /// var route: Route {
  ///   return .get("/me")
  /// }
  /// ```
  var route: Route { get }

  /// Returns `Parameters` which contains parameter encoding and values.
  ///
  /// Example:
  ///
  /// ```
  /// var params: Parameters? {
  ///   return JSONEncoding() => [
  ///     "username": "devxoul",
  ///     "password": "****",
  ///   ]
  /// }
  /// ```
  var params: Parameters? { get }

  /// Returns HTTP header values.
  ///
  /// Example:
  ///
  /// ```
  /// var httpHeaderFields: [String: String]? {
  ///   return ["Accept": "application/json"]
  /// }
  /// ```
  var httpHeaderFields: [String: String]? { get }
}

public extension SugarTargetType {
  public var url: URL {
    return self.defaultURL
  }

  var defaultURL: URL {
    return self.path.isEmpty ? self.baseURL : self.baseURL.appendingPathComponent(self.path)
  }

  public var path: String {
    return self.route.path
  }

  public var method: Moya.Method {
    return self.route.method
  }

  public var parameters: [String: Any]? {
    return self.params?.values
  }

  public var parameterEncoding: ParameterEncoding {
    return self.params?.encoding ?? URLEncoding()
  }

  public var httpHeaderFields: [String: String]? {
    return nil
  }
}
