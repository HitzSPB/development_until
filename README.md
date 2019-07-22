# Development Util
**Repository Information**
This repository contains some of the scripts I have made to solve situations in my everyday developer life. Those scripts are not all production ready for all environments, but can be turned into something production ready quite easily. 

Some of them require some refactoring. I will do that in the upcoming weeks, but if you use them before that I recommend you do it yourself as they were made for a special scenario and not a wide range of scenarios.

**List of scripts**

- \SetupDevelopmentEnvironment
  - GitInstall - silent
    - A script I made for developers to install git with the same setup. This was a part of a transition to git from TFVC. Many did not know how to setup git and what to pick.
  - HyperVSetup
    - A script that setups HyperV for windows
  - SetupBuildMachine
    - A script that installs software I use on my build environments. It uses chocolatey to install the packages/programs I've selected
  - SetupComputer
    - A script that install chocolatey and afterwards install/upgrades the packages/programs you have selected. I included my default setup. I use switches to install different programs depending what pc I am on.
- \BuildServerMaintenance
  - AgentCreator
    - This script was created to create 4 agents on multiple of build servers for TFS. I recommend reading the script before executing it. It also requires you to change some parameters in some cases.
  - AgentUrlReplace
    - A quick script that can change the taget URL for agents running with TFS
  - AspNetCleanUpTempFiles
    - It's a script that I run every night on my build servers to clean up temp files from ASP.NET builds
- \Docker
  - DockerKillAndClean
    - It kills all active containers and cleans up all inactive containers
  - Docker prune
    - It cleans up all data that docker stores
- \DotNetScripts
  - DotNetFrameworkUpdater
    - This script replaces the .NET version in csproj files. It is made against the old CSProj format. If you are using 2017 CSProj you have to check how the .NET target version is written. If it is equal to the way it is written in the script you can just execute. If not you have to change the script a bit.
      - I will add support for 2017 csproj soon
  -RemoveAllBuildFolders
    - Simple script that removes all bin and obj folders.
- \GeneralScripts
  - CleanUpEmptyFolders
    - Removes all empty folders in a path and recursive forward
-\PullRequestEnforceSecurity
  -FilePathChecker
    - I made this script to ensure the file length does not exceed maximum. I made it when I had the issue at work, to avoid developers creating paths that a extremely long. We had issues where people made paths so long that we hit the default limit of windows.
