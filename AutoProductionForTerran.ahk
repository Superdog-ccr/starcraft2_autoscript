
#Requires AutoHotkey v2.0
#MaxThreadsPerHotkey 2
;press f5 to start script
;The script can automatically help terran players product units like Marine and Marauder periodically.
;press "-"or "=" to decrease or increase the number of periodic training Marine separately
;press "["or "]" to decrease or increase the number of periodic training Marauder separately
;press "delete" to reset the number
;If you want use this script,you need to make sure Group buttons "9" is available.
;which means you need to set "ControlGroupAssignX=Ctrl+9","ControlGroupRecallX=9"(where X can be any number from 0 to 9).
;It's better to place your Barracks at "5" .
;If the settings above are not available, something may go wrong.
;Of course,you can change the settings according to your preference.

flag:=-1
Marine:=0
Marauder:=0	
-::{
    SoundBeep 500, 100
    global Marine
    Marine:=max(0,Marine-1)
}

=::{
    SoundBeep 1000, 100
    global Marine,MarineTimeCount
    Marine:=Marine+1
    MarineTimeCount:=1
    Send "^{9}"  ;ctrl+9 record current units
    Send "{5}"
    Send "{a}"
    Send "{9}"  ;Recover group

}

[::{
    SoundBeep 500, 100
    global Marauder
    Marauder:=max(0,Marauder-1)
}

]::{
    SoundBeep 1000, 100
    global Marauder,MarauderTimeCount
    Marauder:=Marauder+1
    MarauderTimeCount:=1

    Send "^{9}"  ;ctrl+9 record current units
    Send "{5}"
    Send "{d}"
    Send "{9}"  ;Recover group

}

Del::{
    SoundBeep 500, 100
    global Marauder,Marine
    Marine:=0
    Marauder:=0	

}
checkstatus()
{
    if flag < 0
    {
        exit
    }
}

F5::
{
    MarineTime:=18
    MarauderTime:=21	
    global flag,Marine,Marauder,MarineTimeCount,MarauderTimeCount


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
    
    Marine:=0
    Marauder:=0
    MarineTimeCount:=0
    MarauderTimeCount:=0
    loop{
        checkstatus()


        BlockInput True ;Avoid interfence
        if Marauder==0 
            MarauderTimeCount:=0
        else if Mod(MarauderTimeCount,MarauderTime)==0
        {
            MarauderTimeCount:=0
            Send "^{9}"  ;ctrl+9 record current units

            Send "{5}"
            loop Marauder
            {
                Send "{D}"
            }
            Send "{9}"  ;Recover group

        }
        if Marine==0 
            MarineTimeCount:=0
        else if Mod(MarineTimeCount,MarineTime)==0
        {

            MarineTimeCount:=0
            Send "^{9}"  ;ctrl+9 record current units

            Send "{5}"
            loop Marine
            {
                Send "{a}"
            }
            Send "{9}"  ;Recover group

        }

        BlockInput False 
        
        MarineTimeCount:=MarineTimeCount+1
        MarauderTimeCount:=MarauderTimeCount+1
        sleep 1000    
        
    }
}   
