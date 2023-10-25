#!/usr/bin/awk -f
# usage: syscall_numbers.awk /usr/include/asm-generic/unistd.h
{
    if ( $1 == "#define" && $2 ~ /^__NR_/ )
    {
	# special case: aliasses
	if ( $3 ~ /^__NR3264_/ )
	{
		next;

        }
	full_text=$2;
	sub(/__NR_/,"",full_text);
	printf("@syscall[%s]=\"%s\";\n", $3, full_text);
    }
}
