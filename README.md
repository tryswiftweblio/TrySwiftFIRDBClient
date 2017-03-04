TrySwiftFIRDBClient
==========
Simple Firebase Database Client

https://devpost.com/software/firebase-realtime-database-rest-api-client


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

    # Fetch / from another Firebase Database
    $ ./build/TrySwiftFIRDBClient --db-url='https://friendlychat-deadbeef.firebaseio.com/' --api-secret='deadbeef' get /

    # Fetch data by path
    $ ./build/TrySwiftFIRDBClient get <path>

    # Post/Put/Patch data to the path specified
    $ ./build/TrySwiftFIRDBClient post <path> '<<json>>'

    # Delete data
    $ ./build/TrySwiftFIRDBClient delete <path>


## External Libs/Sources

- [ArgParse.swift](https://github.com/apple/swift/blob/master/benchmark/utils/ArgParse.swift)
