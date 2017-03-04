TrySwiftFIRDBClient
==========

## How to build

    $ ./build.sh

Binary will be output to `build/TrySwiftFIRDBClient`.


## How to run
Firebase Database is preset, if you'd like to change the DB,
please set the DB Root URL and API secret key by `--db-url` and `--api-secret`.

    # Show help
    $ ./build/TrySwiftFIRDBClient --help

    # Fetch / from default Firebase Database
    $ ./build/TrySwiftFIRDBClient

    # Fetch data by path
    $ ./build/TrySwiftFIRDBClient get <path>

    # Post/Put/Patch data to the path specified
    $ ./build/TrySwiftFIRDBClient post <path> '<<json>>'

    # Delete data
    $ ./build/TrySwiftFIRDBClient delete <path>


