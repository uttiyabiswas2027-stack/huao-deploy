# huao-deploy

Container build used to deploy `huao` (a private repo). The image clones the repo over SSH with a build-time deploy key, installs dependencies with pnpm, then runs the app server together with its Telegram adapter. Runtime state is kept on a mounted volume (`/data`).

This repo holds only the Dockerfile; there is no application code here.
