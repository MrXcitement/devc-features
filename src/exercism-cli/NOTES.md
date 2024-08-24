# Exercism CLI

Provides the `exercism` command at the shell. Using this tool requires authentication.

```shell
exercism configure --token=[TOKEN]
```

Please visit Exercism's [working locally](https://exercism.org/docs/using/solving-exercises/working-locally)
documentation for further usage information.

## Shell Completion Files

The shell completion files have been copied to the system at `/usr/local/share/exercism`.
There is a `README.md` file that has instructions on how to use these completion
files with the Bash, Fish and Zsh shells.

## The Working Directory

The Exercism CLI usually uses a working directory in the `$HOME` directory of
the user.  To use the workspace directory of the devcontainer as Exercism's
working directory, append the following to the `exercism configure` command:
`--workspace="$(pwd)"`.

## OS Support

This feature currently only supports Debian based containers (where APT is used
as package manager).  `bash` is required to run the install script.

## Processor Architecture Support

The Exercism CLI is provided as a native application for a variety of processor
architectures.  This feature tries to determine the architecture of the current
system and download the appropriate binary.  As there is currently no need to
support architectures other than arm64/aarch64 (e.g. Apple Silicon) and x86_64
these are the only supported architectures.
