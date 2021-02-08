set fail 1
set success 0

# basic commands

@test 'create pond succeeds' (pond create test >/dev/null 2>&1) $status -eq $success

@test 'create pond fails when pond already exists' (pond create test >/dev/null 2>&1) $status -eq $fail

@test 'list ponds succeeds when ponds exist' (pond list >/dev/null 2>&1) $status -eq $success

@test 'remove pond succeeds when pond exists' (echo 'y' | pond remove test >/dev/null 2>&1) $status -eq $success

@test 'remove pond fails when pond does not exist' (echo 'y' | pond remove test >/dev/null 2>&1) $status -eq $fail

@test 'list ponds fails when no ponds exist' (pond list >/dev/null 2>&1) $status -eq $fail

# stdout tests

@test 'create pond reports correctly' (pond create test) = "pond: Created an empty pond named 'test'"

@test 'create pond reports correctly when pond already exists' (pond create test 2>&1) = "pond: A pond named 'test' already exists"

@test 'list pond reports correctly when ponds exist' (pond list | string collect) = "pond: Found the following ponds:
  test"

@test 'remove pond reports correctly when pond exists' (echo 'y' | pond remove test) = "pond: Removed pond 'test'"

@test 'remove pond reports correctly when pond does not exist' (pond remove test 2>&1) = "pond: A pond named 'test' does not exist"

@test 'list pond reports correctly when no ponds exist' (pond list 2>&1) = "pond: No ponds found; create one with 'create'"
