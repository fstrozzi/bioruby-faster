
/*
  Copyright(C) 2012 Francesco Strozzi <francesco.strozzi@gmail.com>
                    Yury Pirola
*/
#include <stdio.h>
#include <string.h>
#include <stdlib.h>

#define _BSIZE 100000

typedef struct {
    char *id;
    char *comment;
    char *seq;
    char *quality;
    char *filename;
    char *line;
    char *bad_chars;
    FILE *stream;

}Record;

static char*
alloc_and_copy(char *dst, char *src) {
  if (dst==NULL || strlen(dst)<strlen(src)) {
     if (dst!=NULL)
        free(dst);
     dst= malloc(sizeof (char)*(strlen(src)+1));
  }
  strcpy(dst, src);
  return dst;
}


int check_bad_chars(char *invalid_chars, char *string_to_check) {

   char *c = string_to_check;
   while (*c) {
       if (strchr(invalid_chars, *c))
          return 1;
       c++;
   }

   return 0;
}

int check_header(char *header, char *firstline) {
    if (*header == *firstline)
        return 1;
    else {
        return 0;
    }
}

int fastQ_iterator(Record *seq) {

    if (!seq->stream)
      seq->stream = fopen(seq->filename,"r");
    if (!seq->line)
      seq->line = malloc(sizeof (char)* _BSIZE);
    if (!seq->bad_chars)
      seq->bad_chars = " \x1F\x7F\t\v\e";

    char *header = "@";
    for (int i = 0; i < 4; i++)
    {
      if (fgets(seq->line, _BSIZE, seq->stream) == NULL) return 0;

      if (i==0) {
        if (!check_header(header,seq->line)) return -1;
        seq->id = alloc_and_copy(seq->id, seq->line);
      }
      else {
        if (check_bad_chars(seq->bad_chars,seq->line)) return -1;
        if (i==1) seq->seq = alloc_and_copy(seq->seq, seq->line);
        if (i==3) seq->quality = alloc_and_copy(seq->quality, seq->line);
      }
    }

    return 1;

}

#undef _BSIZE
