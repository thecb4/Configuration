
@_exported import TSCUtility

public enum ConfigurationError: Error {
  case error(description: String)
}

public class Configuration {
  
  public struct Argument<Kind: ArgumentKind> {
    
    typealias ArgumentType = Kind
    
    let name: String

    var posix: String {
      "--\(name)"
    }
    
    var kind: ArgumentType.Type {
      ArgumentType.self
    }
    
    public init(name: String) {
      self.name = name
    }
    
  }

  private static let shared: Configuration = {
    Configuration()
  }()
  
  internal let parser = ArgumentParser(usage: "<options>", overview: "This is what this tool is for")
  internal var results: ArgumentParser.Result?
  
  func parse(_ arguments: [String]) throws {
    print("parsing arguments")
    results = try parser.parse(arguments)
  }
  
  public static func add<T: ArgumentKind>(argument: Configuration.Argument<T>) {
    _ = shared.parser.add(option: argument.posix, kind: T.self)
  }
  
  public static func get<T>(argument: Configuration.Argument<T>) -> T? {
    try? shared.results?.get(argument.posix)
  }
  
  public static func get<T>(argument: Configuration.Argument<T>) -> [T]? {
    try? shared.results?.get(argument.posix)
  }
  
  public static func parse(_ arguments: [String]) throws {
    
    do {
      print(arguments)
      try shared.parse(arguments)
    }
    catch let error as ArgumentParserError {
      print(error.description)
      throw ConfigurationError.error(description: error.description)
    }
  }
  
}
