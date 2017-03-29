module.exports = {

  // Validate the environment variable and throw an error if not defined
  validatedEnvVar: (envVar) => {
    const val = process.env[envVar];
    if (val) return val;
    throw new Error(`Environment variable ${envVar} is invalid! (Value is ${val})`);
  },
};
