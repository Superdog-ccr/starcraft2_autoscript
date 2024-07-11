
#MaxThreadsPerHotkey 3
checkstatus()
{
    if flag < 0
    {
        exit
    }
}

flag:=-1
F5::
{
    global flag
    flag:=flag*-1
}

F6::
{
    global flag
    flag :=flag*-1
    checkstatus()
    loop 30
    {
        checkstatus()

        Send "{v}"
        sleep 1000
    }
}
;vvvvvv
;vvvvvvvvvvvvvvvvv