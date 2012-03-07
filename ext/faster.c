
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

/*
int main() {

Record *test_seq;

fastQ_iterator(&test_seq);
}
*/

int fastQ_iterator(Record *seq) {

    if (!seq->stream)
      seq->stream = fopen(seq->filename,"r");

    /*if (!seq->line)
      seq->line = malloc(sizeof(char)*(_BSIZE)); */
    char line[_BSIZE];

    for (int i = 0; i < 4; i++)
    {
      if (fgets(line, _BSIZE, seq->stream) == NULL) return 0;
      char *value;
      if (i==0) seq->id = alloc_and_copy(seq->id, line);
      if (i==1) seq->seq = alloc_and_copy(seq->seq, line);
      if (i==3) seq->quality = alloc_and_copy(seq->quality, line);

    }

    return 1;

}

#undef _BSIZE
