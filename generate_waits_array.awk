#!/usr/bin/awk -f
# this script parses: src/backend/utils/activity/wait_event_names.txt
# which is generated after compiling postgres.
# this is used to build the list of wait events with their class number and wait event number
#
# FIXME: the wait order in wait_event_names.txt is incorrect for buffile_write and buffile_truncate: these are reversed (?)
{
    wait_class_number["WaitEventActivity"]="0x05000000";
    wait_class_number["WaitEventClient"]="0x06000000";
    wait_class_number["WaitEventIPC"]="0x08000000";
    wait_class_number["WaitEventTimeout"]="0x09000000";
    wait_class_number["WaitEventIO"]="0x0A000000";
    wait_class_number["WaitEventBufferPin"]="0x04000000";
    wait_class_number["WaitEventExtension"]="0x07000000";
    wait_class_number["WaitEventLWLock"]="0x01000000";
    wait_class_number["WaitEventLock"]="0x03000000";

    if ( $1 == "Section:" && $2 == "ClassName" )
    {
        current_class = wait_class_number[$4]
	current_wait_number = 0;
	next;
    }
    if ( NF != 0 && $1 !~ /^#/ )
    {
	printf("@wait_name[%s,%i]=\"%s\";\n", current_class, current_wait_number, $1);
	current_wait_number++;
    }
}
