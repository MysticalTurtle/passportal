import 'dart:developer';
import 'package:graphql_flutter/graphql_flutter.dart';

class GraphQLService {
  GraphQLService() {
    final link = HttpLink(
      'https://alert-lemming-19.hasura.app/v1/graphql',
      defaultHeaders: {
        'Content-Type': 'application/json',
        'x-hasura-admin-secret':
            'en7AUc0ze7LlcYI1m4ssslsZUxZduQrdBvQlBBSQhSw24HpvbVknbuykgik3O1MC'
      },
    );

    _graphQLClient = GraphQLClient(
      link: link,
      cache: GraphQLCache(store: InMemoryStore()),
      defaultPolicies: DefaultPolicies(
        query: Policies(
          cacheReread: CacheRereadPolicy.ignoreAll,
          fetch: FetchPolicy.noCache,
        ),
      ),
    );
  }

  late final GraphQLClient _graphQLClient;

  Future<dynamic> performQuery(
    String query, {
    Map<String, dynamic> variables = const {},
  }) async {
    final options = QueryOptions(
      document: gql(query),
      variables: variables,
    );

    final result = await _graphQLClient.query(options);

    if (result.hasException) {
      throw result.exception.toString();
    } else {
      return result.data;
    }
  }

  Future<QueryResult> performMutation(
    String query, {
    Map<String, dynamic> variables = const {},
  }) async {
    final options = MutationOptions(document: gql(query), variables: variables);
    final result = await _graphQLClient.mutate(options);
    log(result.toString());
    return result;
  }
}
