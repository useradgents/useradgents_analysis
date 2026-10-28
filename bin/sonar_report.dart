import 'dart:convert';
import 'dart:io';

import 'package:useradgents_analysis/src/dcm_to_sonar.dart';

const String _outputPath = 'dcm-quality-report.json';

/// Runs DCM and writes its issues for SonarQube, keeping the DCM severity.
///
/// Usage: `dart run useradgents_analysis:sonar_report [dcm options] [paths]`
/// e.g. `dart run useradgents_analysis:sonar_report --ci-key=$DCM_CI_KEY --email=$DCM_EMAIL lib`
Future<void> main(List<String> args) async {
  final Directory tempDir = await Directory.systemTemp.createTemp('dcm');
  final File dcmReport = File('${tempDir.path}/dcm-report.json');

  final ProcessResult result = await Process.run('dcm', [
    'run',
    '--analyze',
    '--reporter=json',
    '--no-fatal-found',
    '--output-to=${dcmReport.path}',
    ...args,
  ]);
  if (result.exitCode != 0) {
    stdout.write(result.stdout);
    stderr.write(result.stderr);
    exit(result.exitCode);
  }

  final Map<String, List<Map<String, Object?>>> sonarReport = toSonarReport(
    jsonDecode(await dcmReport.readAsString()),
  );
  await File(_outputPath).writeAsString(jsonEncode(sonarReport));
  await tempDir.delete(recursive: true);

  stdout.writeln(
    '${sonarReport['issues']?.length} issues, '
    '${sonarReport['rules']?.length} rules → $_outputPath',
  );
}
