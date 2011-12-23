/*
Copyright(C) Francesco Strozzi <francesco.strozzi@gmail.com>
*/

#include <zlib.h>
#include <stdio.h>
#include <errno.h>
#include "ruby.h"
#include "kseq.h"

KSEQ_INIT(gzFile, gzread)

static VALUE method_parse(VALUE self, VALUE file) {
	VALUE filename = StringValue(file);
	gzFile fp;
	FILE *check_file;
	if ((check_file = fopen(RSTRING_PTR(filename), "r+")) == NULL) {
			printf("No file found!");
	}
	else {
		fclose(check_file);
		fp = gzopen(RSTRING_PTR(filename), "r");
		kseq_t *seq;
		seq = kseq_init(fp);
		while (kseq_read(seq) >= 0) {
			VALUE arr = rb_ary_new();
			rb_ary_push(arr, rb_str_new2(seq->name.s));
			if (seq->comment.l) rb_ary_push(arr, rb_str_new2(seq->comment.s));
			rb_ary_push(arr, rb_str_new2(seq->seq.s));
			if (seq->qual.l) rb_ary_push(arr, rb_str_new2(seq->qual.s));
			rb_yield(arr);
		}
		kseq_destroy(seq);
		gzclose(fp);
		return Qtrue;
	}
		

}

void Init_faster() {
	VALUE Faster = rb_define_module("Faster");
	rb_define_singleton_method(Faster,"parse",method_parse,1);
}
