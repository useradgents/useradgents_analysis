import 'package:flutter_test/flutter_test.dart';
import 'package:useradgents_analysis/src/dcm_to_sonar.dart';

Map<String, Object?> _issue(String id, String severity) => {
      'id': id,
      'severity': severity,
      'message': '$id message',
      'documentation': 'https://dcm.dev/docs/rules/common/$id',
      'effortInMinutes': 5,
      'location': {
        'startLine': 3,
        'endLine': 4,
        'startColumn': 11,
        'endColumn': 33,
        'startOffset': 120,
      },
    };

void main() {
  final Map<String, List<Map<String, Object?>>> report = toSonarReport({
    'analyzeResults': [
      {
        'path': 'lib/a.dart',
        'issues': [
          _issue('style-rule', 'style'),
          _issue('warning-rule', 'warning'),
        ],
      },
      {
        'path': 'lib/b.dart',
        'issues': [
          _issue('style-rule', 'style'),
          _issue('error-rule', 'error'),
        ],
      },
    ],
  });
  final List<Map<String, Object?>> rules = report['rules'] ?? [];
  final List<Map<String, Object?>> issues = report['issues'] ?? [];

  final Map<Object?, Map<String, Object?>> rulesById = {
    for (final Map<String, Object?> rule in rules) rule['id']: rule,
  };

  Object? severityOf(String ruleId) => switch (rulesById[ruleId]) {
        {'impacts': [{'severity': final String severity}]} => severity,
        _ => null,
      };

  test('one rule per DCM rule, one issue per DCM issue', () {
    expect(rules, hasLength(3));
    expect(issues, hasLength(4));
  });

  test('keeps the DCM severity', () {
    expect(severityOf('style-rule'), 'LOW');
    expect(severityOf('warning-rule'), 'MEDIUM');
    expect(severityOf('error-rule'), 'HIGH');
  });

  test('converts the location to Sonar (0-based columns)', () {
    expect(
      issues,
      contains(
        equals({
          'ruleId': 'style-rule',
          'effortMinutes': 5,
          'primaryLocation': {
            'filePath': 'lib/a.dart',
            'message': 'style-rule message',
            'textRange': {
              'startLine': 3,
              'endLine': 4,
              'startColumn': 10,
              'endColumn': 32,
            },
          },
        }),
      ),
    );
  });

  test('throws on an unexpected report', () {
    expect(() => toSonarReport({'files': []}), throwsFormatException);
  });
}
