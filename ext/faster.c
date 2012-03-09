
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
    char *seq;
    char *quality;
    char *filename;
    char *line;
    char *bad_chars;
    FILE *stream;

}FastQRecord;

static char* alloc_and_copy(char *dst, char *src) {
  if (dst==NULL || strlen(dst)<strlen(src)) {
     if (dst!=NULL)
        free(dst);
     dst= malloc(sizeof (char)*(strlen(src)+1));
  }
  strcpy(dst, src);
  int len;
  len = strlen(dst);
  if (dst[len-1] == '\n') dst[len-1] = '\0';
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

static char* initialize(char *ptr) {
    if(ptr!=NULL){
        free(ptr);
        ptr = NULL;
    }
    return ptr;
}

int check_header(char *header, char *firstline) {
    if (*header == *firstline)
        return 1;
    else {
        return 0;
    }
}

int fastQ_iterator(FastQRecord *seq) {

    // initialization of structure elements.
    char *header = "@"; // FastQ header

    if (!seq->stream)
      seq->stream = fopen(seq->filename,"r");
    if (!seq->line)
      seq->line = malloc(sizeof (char)* _BSIZE);
    if (!seq->bad_chars)
      seq->bad_chars = " \x1F\x7F\t\v\e";

    // this is done to wipe out data from previous iteration
    seq->id = initialize(seq->id);
    seq->seq = initialize(seq->seq);
    seq->quality = initialize(seq->quality);

    for (int i = 0; i < 4; i++)
    {
      if (fgets(seq->line, _BSIZE, seq->stream) == NULL) {
        // if either sequence or quality is missing the record is truncated
        if((seq->seq != NULL && seq->quality == NULL) || (seq->quality != NULL && seq->seq == NULL)) return -2;
        else return 0;
      }

      if (i==0) {
        if (!check_header(header,seq->line)) return -1; // check if the header format is correct
        seq->id = alloc_and_copy(seq->id, seq->line);
      }
      else {
        if (check_bad_chars(seq->bad_chars,seq->line)) return -1; // check if quality or sequence includes bad characters
        if (i==1) seq->seq = alloc_and_copy(seq->seq, seq->line);
        if (i==3) {
            seq->quality = alloc_and_copy(seq->quality, seq->line);
            if(strlen(seq->seq) != strlen(seq->quality)) return -2;  // if sequence and quality are of different length the record is truncated
        }

      }
    }

    return 1;

}

#undef _BSIZE
