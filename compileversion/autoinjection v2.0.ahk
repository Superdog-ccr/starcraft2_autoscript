
#Requires AutoHotkey v2.0
#MaxThreadsPerHotkey 2
;press f5 to start script
;The script can automatically help zerg players spawn Larva.
;If you want use this script,you need to make "TownCamera=space","CameraSaveX=Control+F6","ControlGroupAssignX=Ctrl+9","ControlGroupRecallX=9"(where X can be any number from 0 to 9)
;Apparently, "SpawnLarva=V(I forget its English name.whatever you definitely know what am i talking about)"
;It's better to place your base at "1" and main army at "3" and they must be Group buttons similar to "9" above.
;If the settings above are not available, something may go wrong.
;Of course,u can change the settings according to your preference

flag:=-1

checkstatus()
{
    if flag < 0
    {
        exit
    }
}


F5::
{
    global flag
    flag:=flag*-1
    if flag==1
    {
        SoundBeep 1000, 100
    }
    else
    {
        SoundBeep 500, 100
    }
    checkstatus()
    loop{
        checkstatus()
        BlockInput True ;Avoid interfence

        ;Record status
        Send "^{F6}" ;ctrl+F6 record current camera
        Send "^{9}"  ;ctrl+9 record current units
        MouseGetPos &xpos, &ypos ;Record current mouse-position

        loop 5{ ;Injection
            Send "{space}" ;TownCamera
            sleep 10 ;Interrupt
            
            Click A_ScreenWidth/2-400 ,A_ScreenHeight/2-400 , "Down"
            Click A_ScreenWidth/2+300 ,A_ScreenHeight/2+300,"Up " ;Drag the mouse
            
            Click A_ScreenWidth/2  , A_ScreenHeight/2 ,0 ;Center the mouse
            Send "{v}" ;Inject/Spawn Larva
            Click 

        }

        ;Recover status and try to avoid empty groups
        Send "{F6}" ;Recover camera
        Send "{1}"  ;Recover base
        Send "{3}"  ;Recover army
        Send "{9}"  ;Recover current units 

        sleep 10    
        Click xpos  , ypos ,0 ;Recover mouse-position

        BlockInput False 

        loop 33
        {
            checkstatus()
            sleep 1000    
        }
        
    }
}   

