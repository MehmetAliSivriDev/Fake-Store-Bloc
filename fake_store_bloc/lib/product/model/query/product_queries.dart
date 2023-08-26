enum ProductQueries { limit }

extension ProductQueriesExtenison on ProductQueries {
  MapEntry<String, String> toMapEntry(String value) {
    switch (this) {
      case ProductQueries.limit:
        return MapEntry('limit', value);
    }
  }
}
