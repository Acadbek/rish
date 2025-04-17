#!/usr/bin/env node

import { execSync } from 'child_process';
import { fileURLToPath } from 'url';
import { dirname, join } from 'path';
import { chmodSync } from 'fs';

const __dirname = dirname(fileURLToPath(import.meta.url));
const scriptPath = join(__dirname, 'r.sh');

// chmod +x to make sure script is executable
chmodSync(scriptPath, '755');

// run the bash script
execSync(`bash "${scriptPath}"`, { stdio: 'inherit' });
