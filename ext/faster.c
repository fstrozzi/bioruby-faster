/*
Copyright(C) 2011 Francesco Strozzi <francesco.strozzi@gmail.com>
*/

#include <zlib.h>
#include <stdio.h>
#include "ruby.h"
#include "kseq.h"

KSEQ_INIT(gzFile, gzread)

static VALUE method_parse(VALUE self, VALUE file) {

	if (!(rb_block_given_p())) {
		rb_raise(rb_eArgError,"You must pass a valid block!");
	}

	gzFile fp;
	if (!(fp = gzopen(RSTRING_PTR(file), "r"))) {
		rb_raise(rb_eArgError,"File %s not found!", RSTRING_PTR(file));
	}
	else {
		kseq_t *seq;
		seq = kseq_init(fp);
		while (kseq_read(seq) >= 0) {
			VALUE arr = rb_ary_new();
			rb_ary_push(arr, rb_str_new2(seq->name.s));
			if (seq->comment.l) rb_ary_push(arr, rb_str_new2(seq->comment.s));
			rb_ary_push(arr, rb_str_new2(seq->seq.s));
			if (seq->qual.l) {
				VALUE rb_quality = rb_ary_new();
				int unsigned i = 0;
				while(i < seq->qual.l) {
					rb_ary_push(rb_quality,INT2FIX(*(seq->qual.s + i) - 33));
					i++;
				}
				rb_ary_push(arr,rb_quality);
			}
			rb_yield(arr);
		}
		kseq_destroy(seq);
		gzclose(fp);
		return Qtrue;
	}
}
 
void Init_faster() {
	VALUE Bio = rb_define_module("Bio");
	VALUE Faster = rb_define_module_under(Bio,"Faster");
	rb_define_singleton_method(Faster,"parse",method_parse,1);
}
