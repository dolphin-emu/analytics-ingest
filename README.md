# Analytics ingest server

This small Python (bottle) server receives analytics events from Dolphin
instances in the wild, deserializes them, and writes records to ClickHouse. It
dynamically maintains the ClickHouse table schema in order to support some
amount of schema agility, where new analytics fields can be added in the client
without requiring server side changes.

## Requirements

- Python 3 and uv
- ClickHouse

## Setup

### Using Nix

Note: this requires Nix Flakes to be enabled on your system.

```bash
nix run github:dolphin-emu/analytics-ingest
```

### Without Nix

This project uses [uv](https://github.com/astral-sh/uv) for dependency
management.

```bash
# Install dependencies.
uv sync

# Run the server
uv run analytics-ingest
```

## License

Licensed under the MIT License. See [LICENSE](LICENSE).
