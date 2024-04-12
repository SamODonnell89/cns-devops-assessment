### Contribution guidelines ###

* Do not comment out blocks of code and commit.
* All commits should have a commit message relevant to the work, no "update".
* Commit 'clean' code, no unnecessary comments
* Use 2 space characters as indentation
* Use short form as much as possible to save on character spacing
* Primarily use YAML
* Separate out your code with adequate spacing for ease of use and readability
* Commit code that has been linted - use proper linting tools like `cfn-lint` and [CloudFormation Linter VSCode Extension](https://marketplace.visualstudio.com/items?itemName=kddejong.vscode-cfn-lint)
* Use sensible template Outputs and exports
* Use CamelCase
* Numbering should be 01 not 1 messages.
* Make use of: https://canstar.atlassian.net/wiki/spaces/CLOUD/pages/10350529/Resource+naming+scheme
* Use tags and ensure adherence to [Canstar Tagging Strategy](https://canstar.atlassian.net/wiki/spaces/CLOUD/pages/10350536/AWS+Resource+Tagging)

### Tips for writing good git commit messages ###

1. Specify the type of commit:
    * feat: The new feature you're adding to a particular application
    * fix: A bug fix
    * style: Feature and updates related to styling
    * refactor: Refactoring a specific section of the codebase
    * test: Everything related to testing
    * docs: Everything related to documentation
    * chore: Regular code maintenance. (You can also use emojis to represent
      commit types)
2. Separate the subject from the body with a blank line
3. Your commit message should not contain any whitespace errors
4. Remove unnecessary punctuation marks
5. Do not end the subject line with a period
6. Capitalize the subject line and each paragraph
7. Use the imperative mood in the subject line
8. Use the body to explain what changes you have made and why you made them.
9. Do not assume the reviewer understands what the original problem was, ensure you add it.
10. Do not think your code is self-explanatory
11. Follow the commit convention defined by your team

Source:
[freecodecamp.org](https://www.freecodecamp.org/news/writing-good-commit-messages-a-practical-guide/)

