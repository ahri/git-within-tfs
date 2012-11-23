ILB-focused feature-based development workflow for a git-tfs bridge
===================================================================

Scripts and aliases set up to enable the use of a feature-based development
workflow leveraging git's easy branch/merge functionality whilst working within
the pre-existing project's TFS environment.

There's nothing revolutionary here; it's just wrapping up git functionality and
hoping to make things easier for people unfamiliar with git.

Initialise your PowerShell Env
------------------------------
    > . path_to_tfs-git-ilb\commands.ps1
    Setting aliases:
         branch-feature
         checkin-feature
         tfs-strip
         update-feature
         update-repo

Unroll the Initial Repo (currently need to get this off Adam)
-----------------------
    > cd ILB_Workdir
    > path_to_tfs-git-ilb\init-repo.ps1

Workflow Thereafter
-------------------
    Create feature branches for stories:
    > branch-feature LCSIL-1234

    Or Epics/themes:
    > branch-feature MyEpic
    > branch-feature LCSIL-4321 MyEpic

Update the base repository
--------------------------
    > update-repo

Update the current feature
--------------------------
    > update-feature

Check your changes into TFS
---------------------------
    > checkin-feature
