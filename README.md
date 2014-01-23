conduit-persistent-example
===

This code demonstrates how to use Conduit together with Persistent to stream data in constant memory in Haskell. Have a look at the accompanying weblog post [here]().

# Usage

Make sure you have the following packages installed in your Haskell distribution:

+ persistent-1.3.0.2
+ persistent-template-1.3.1
+ persistent-sqlite-1.3.0.1
+ conduit-1.0.12

From the command line, run:

```console
$ make
```

To compare the memory usage between `selectList` and `selectSource` programs, run:

```console
$ ./selectList +RTS -s
$ ./selectSource +RTS -s
```

Finally, when you are done, and want to clean up, run:

```console
$ make clean
```

# License

License information can be found in [LICENSE](LICENSE).