# `jj` workspace root

This empty directory is a convenient "workspace root" to place your various
different `jj` workspaces. The idea is something like this &mdash; while you are
in a clean, empty working copy commit, execute the following:

```bash
cd $(jj workspace root) # go to the root of the default workspace
jj sparse set --clear --add work # only leave work/ in in the working copy
```

This removes all files except the top-level `work/` directory, which is empty,
but it retains all the historical content of the repository. That's ideal. Now:

```bash
jj workspace add work/new-feature # create first new workspace
jj workspace add work/fix-bug-123 # create second new workspace
```

Now, your working copy is empty, but the the directory `work/new-feature` has a
copy of the whole repository instead, "linked" with the sparse copy above it.
`work/fix-bug-123` also is a copy of the repository, and they both share the
same root-level `.jj` directory. You can run `jj log` in either workspace and
see it connected to the top level repository, and work on the two workspaces
independently. You can run `jj workspace add` many more times to keep creating
entirely new build directories that are all sharing the root `.jj` repo.

This kind of workflow is useful for scenarios where you want to e.g. execute
some long running test or other tool while having another set of commits being
worked on separately. It also conceptually can replace any workflow where you
might have multiple copies of a repository checked out in different directories
for some reason.

In a sense, this turns the Git model for change management on its head, since
instead of branches you are just using whole checkouts in subdirectories.
Instead it looks more like the way **[Darcs]** works, where every branch of a
project was its own separate repository entirely.

[Darcs]: https://darcs.net

Run `jj workspace forget work/new-feature` when you are done with a workspace,
and the commits will still exist in the top level repository, but the workspace
is gone. You can delete the directories after that.
