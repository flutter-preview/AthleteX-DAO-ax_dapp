enum BuildConfig { staging, release }

const buildConfig = String.fromEnvironment(
          'BUILD_TYPE',
          defaultValue: 'staging',
        ) ==
        'staging'
    ? BuildConfig.staging
    : BuildConfig.release;

const baseApiUrl = (String.fromEnvironment(
          'BUILD_TYPE',
          defaultValue: 'staging',
        ) ==
        'staging')
    ? 'https://api-stage.athletex.io'
    : 'https://api.athletex.io';

const defaultFrom = '2023-01-01';
const defaultUntil = '2023-12-31';

const kCollateralizationMultiplier = 1000;
