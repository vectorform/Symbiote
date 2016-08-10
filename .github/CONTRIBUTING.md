# Contributing to Vectorform Projects
 
Third party contributions are encouraged! However, we have a few guidelines we require contributors to follow.
 
### Issues
When writing a bug report, please make sure it has enough <a href="http://yourbugreportneedsmore.info" target="_blank">information</a> and follows <a href="http://www.github.com/vectorform/Symbiote/.github/ISSUE_TEMPLATE.md" target="_blank">this template</a>.
 
 
### Gitflow
We use Fork & Pull and <a href="http://nvie.com/posts/a-successful-git-branching-model/">Gitflow</a> as our branching system. Please follow gitflow's guidelines while contributing to any Vectorform project.
 
 
### Pull Requests
* Please follow the repositories for all code and documentation.
* Pull Requests should follow <a href="http://www.github.com/vectorform/Symbiote/.github/PULL_REQUEST_TEMPLATE.md" target="_blank">this template</a>.
* All feature branches should be based on `develop` and have the format `feature/branch_name`.
* Minor bug fixes that do not change, add, or remove any public API; should be based on `master` and have the format `hotfix/branch_name`.
* All pull requests should implement a single feature or fix a single bug. Pull Requests that involve multiple changes can be rejected.
* All commits should separated into logical units, i.e. unrelated changes should be in different commits within a pull request.
* Work in progress pull requests should have "[WIP]" in front of the Pull Request title. When you believe the pull request is ready to merge, remove this tag and @mention the appropriate Vectorform developer to trigger a review.
* All new code *must* include unit tests. Bug fixes should have a test that fails previously and now passes. All new features should be covered. If your code does not have tests, or regresses old tests, it will be rejected.
