/// DCM severity → SonarQube impact severity.
///
/// The DCM `sonar` reporter sets MEDIUM (MAJOR) on every rule, so the Sonar
/// report is built from the `json` reporter, which keeps the configured
/// severity of each rule.
const Map<String, String> _sonarSeverities = {
  'error': 'HIGH', // CRITICAL
  'warning': 'MEDIUM', // MAJOR
  'perf': 'MEDIUM', // MAJOR
  'style': 'LOW', // MINOR
};

/// Converts a DCM `json` report into the SonarQube generic format for
/// external issues (`sonar.externalIssuesReportPaths`).
Map<String, List<Map<String, Object?>>> toSonarReport(Object? dcmReport) {
  if (dcmReport case {'analyzeResults': final List<Object?> files}) {
    final Map<String, Map<String, Object?>> rules = {};
    final List<Map<String, Object?>> issues = [];

    for (final Object? file in files) {
      if (file
          case {
            'path': final String path,
            'issues': final List<Object?> fileIssues
          }) {
        for (final Object? issue in fileIssues) {
          if (issue
              case {
                'id': final String ruleId,
                'severity': final String severity,
                'message': final String message,
                'documentation': final String? documentation,
                'effortInMinutes': final int effortMinutes,
                'location': {
                  'startLine': final int startLine,
                  'endLine': final int endLine,
                  'startColumn': final int startColumn,
                  'endColumn': final int endColumn,
                },
              }) {
            rules[ruleId] ??= {
              'id': ruleId,
              'name': ruleId,
              'description': documentation,
              'engineId': 'dcm',
              'cleanCodeAttribute': 'CONVENTIONAL',
              'impacts': [
                {
                  'softwareQuality': 'MAINTAINABILITY',
                  'severity': _sonarSeverities[severity] ?? 'INFO',
                },
              ],
            };

            issues.add({
              'ruleId': ruleId,
              'effortMinutes': effortMinutes,
              'primaryLocation': {
                'filePath': path,
                'message': message,
                'textRange': {
                  'startLine': startLine,
                  'endLine': endLine,
                  // DCM columns start at 1, Sonar columns at 0
                  'startColumn': startColumn - 1,
                  'endColumn': endColumn - 1,
                },
              },
            });
          } else {
            throw FormatException('Unexpected DCM issue', issue);
          }
        }
      } else {
        throw FormatException('Unexpected DCM file result', file);
      }
    }

    return {'rules': rules.values.toList(), 'issues': issues};
  }

  throw FormatException('Unexpected DCM report', dcmReport);
}
