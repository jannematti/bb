# bb
A Fish shell plugin for opening active git repository based bitbucket.org pages.

## Installation

With [fisher](https://github.com/jorgebucaran/fisher)

```sh
$ fisher add jannematti/bb
```

## Usage

### Source
```sh
$ bb
$ bb [directory/file]
```

#### Commits
```sh
$ bb commits
$ bb c
```

#### Branches
```sh
$ bb branches
$ bb b
```

#### Open pull requests
```sh
$ bb pull-requests
$ bb pr
```

#### Pipelines
```sh
$ bb pipelines
$ bb pl 
```

#### Deployments
```sh
$ bb deployments
```

#### Downloads
```sh
$ bb downloads
```

#### Trello boards
```sh
$ bb boards
```

#### Settings
```sh
$ bb settings
```

## Configuration
### Change default browser

Add a new line to `config.fish`:
```sh
set bb_browser "Google Chrome"
```
