enum BuildConfig { staging, release }

const buildConfig = String.fromEnvironment(
          'BUILD_TYPE',
          defaultValue: 'staging',
        ) ==
        'staging'
    ? BuildConfig.staging
    : BuildConfig.release;

const baseUrl = (String.fromEnvironment(
          'BUILD_TYPE',
          defaultValue: 'staging',
        ) ==
        'staging')
    ? 'https://stage.athletex.io/#/'
    : 'https://app.athletex.io/#/';

const kCollateralizationMultiplier = 1000;
