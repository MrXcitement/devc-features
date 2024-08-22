# Devcontainer Features

![Codespaces](https://img.shields.io/static/v1?style=for-the-badge&message=Codespaces&color=181717&logo=GitHub&logoColor=FFFFFF&label=)
![Devcontainers](https://img.shields.io/static/v1?style=for-the-badge&message=Devcontainers&color=2496ED&logo=Docker&logoColor=FFFFFF&label=)

Additional add-in features for
[devcontainers](https://code.visualstudio.com/docs/devcontainers/containers) and
[GitHub Codespaces](https://github.com/features/codespaces)

- Works with devcontainers
- Works with GitHub Codespaces
- Don't see your feature here?   [🔥Suggest a new feature!🔥](https://github.com/mrxcitement/devc-features/issues/new?template=suggest-feature.yaml)

## Usage

Just add a `.devcontainer/devcontainer.json` file with a `features` key. It's
very similar to `package.json`'s `dependencies` object, just with the addition
of an `options` object.

📚 Make sure to inspect each feature for feature-specific options!

```json
{
  "image": "mcr.microsoft.com/devcontainers/universal",
  "features": {
    "ghcr.io/mrxcitement/devc-features/exercism-cli:1": {},
    "ghcr.io/mrxcitement/devc-features/glab:1": {}
  }
}
```

Then, after adding your devcontainer config file, you can open it in GitHub
Codespaces, or [open it locally using VS Code]. Be warned some features will
compile things from source code and may take a while!

## Found a bug?

[🐞Open an bug report!🐞](https://github.com/mrxcitement/devc-features/issues/new?template=feature-bug-report.yaml)

## Authors and Acknowledgment

The *Devcontainers Features* repository was created by **[Mike Barker](https://github.com/MrXcitement)**

It was created from the Microsoft template repository [Feature quick start repository](https://github.com/devcontainers/feature-starter)

The [Dev Containers Project](https://github.com/devcontainers-contrib) was used as a starting point for this README and many of the features being hosted here.

### Additional contributors include

Thank you to all the contributors for their hard work and dedication to the project.
