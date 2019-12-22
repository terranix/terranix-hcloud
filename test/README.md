# Test for module

This is a test setup to test the current module
with the terraform version.

# How to used

```
nix-shell
shell> test-prepare
shell> test-run
```

Now you should see how the server1 is created and deployed with nix.
This is basically the test.

## Login 

You can login to the machine using

```
nix-shell>
shell> ssh root@$( terraform output nixserver-server1_ipv4_address ) -i ./sshkey
```

## Cleanup

to cleanup just run

```
nix-shell --run test-cleanup
```

