From: Josh Poimboeuf <jpoimboe@redhat.com>
Subject: Re: [PATCH v2 02/10] x86: assembly, FUNC_START for fn, DATA_START
 for data
Date: Wed, 22 Mar 2017 09:11:23 -0500
Message-ID: <20170322141123.opss3u4gpupqgl2q@treble>
References: <9ea5e137-61f9-dccc-bb9d-ac3ff86e5867@suse.cz>
 <20170320123222.15453-1-jslaby@suse.cz>
 <20170320123222.15453-2-jslaby@suse.cz>
 <20170321140840.GA23311@amd>
 <20170322072557.GA13904@gmail.com>
 <ee3242f9-1fab-f3a8-947d-85fc1a660a49@suse.cz>
 <20170322074616.GA10809@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:34359 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S934565AbdCVOLk (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 22 Mar 2017 10:11:40 -0400
Content-Disposition: inline
In-Reply-To: <20170322074616.GA10809@gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: Jiri Slaby <jslaby@suse.cz>, Pavel Machek <pavel@ucw.cz>, mingo@redhat.com, tglx@linutronix.de, hpa@zytor.com, x86@kernel.org, linux-kernel@vger.kernel.org, Boris Ostrovsky <boris.ostrovsky@oracle.com>, Juergen Gross <jgross@suse.com>, xen-devel@lists.xenproject.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>, linux-pm@vger.kernel.org

On Wed, Mar 22, 2017 at 08:46:16AM +0100, Ingo Molnar wrote:
> 
> * Jiri Slaby <jslaby@suse.cz> wrote:
> 
> > On 03/22/2017, 08:25 AM, Ingo Molnar wrote:
> > > 
> > > * Pavel Machek <pavel@ucw.cz> wrote:
> > > 
> > >> Hi!
> > >>
> > >>> -ENTRY(saved_rbp)	.quad	0
> > >>> -ENTRY(saved_rsi)	.quad	0
> > >>> -ENTRY(saved_rdi)	.quad	0
> > >>> -ENTRY(saved_rbx)	.quad	0
> > >>> +SYM_DATA_START(saved_rbp)		.quad	0
> > >>> +SYM_DATA_START(saved_rsi)		.quad	0
> > >>> +SYM_DATA_START(saved_rdi)		.quad	0
> > >>> +SYM_DATA_START(saved_rbx)		.quad	0
> > >>
> > >> Does it make sense to call it SYM_DATA_*START* when there's no
> > >> corresponding end?
> > > 
> > > That looks like a bug - I think we should strive for them to always be in pairs.
> > > 
> > > Jiri, Josh, could objtool help here perhaps, to detect 'non-terminated' 
> > > SYM_*_START() uses? This could be done by emitting debug data into a special 
> > > section and then analyzing that section for unpaired entries. The section can be 
> > > discarded in the final link, it won't show up in the kernel image.
> > 
> > It should be easier than that. No introduction of other info needed --
> > every global symbol without a ".type" or ".size" (i.e. SYM_*_END) should
> > be a bug now.
> 
> I'm all for that!

It would be easy to add this checking to objtool since it already reads
the symbol table.  The hard part is figuring out the logistics. :-)

- Should the warnings be on by default?

- Part of the "objtool check" command or something else?

- Separate config option or just include it with
  CONFIG_STACK_VALIDATION?

- Should all asm files be checked, including those currently skipped by
  objtool with OBJECT_FILES_NON_STANDARD?

> Can we detect double ends as well - i.e. do a build check of the full syntax of 
> these symbol definition primitives?

Detecting double ends would be a little trickier.  The second SYM_*_END
supersedes the first, so that information isn't in the ELF symbol table.

We could use a special section to annotate all the macro uses and have
objtool do the checking, similar to what you suggested earlier.

Or, here's a much easier way to do it, without involving objtool:

--- a/include/linux/linkage.h
+++ b/include/linux/linkage.h
@@ -138,9 +138,17 @@
 	name:
 #endif
 
+#ifndef CHECK_DUP_SYM_END
+#define CHECK_DUP_SYM_END(name)				\
+	.pushsection .discard.sym_func_end ASM_NL	\
+	SYM_END_##name: .byte 0 ASM_NL			\
+	.popsection
+#endif
+
 /* SYM_END -- use only if you have to */
 #ifndef SYM_END
 #define SYM_END(name, sym_type)				\
+	CHECK_DUP_SYM_END(name) ASM_NL			\
 	.type name sym_type ASM_NL			\
 	.size name, .-name
 #endif


If there's an extra SYM_*_END, the build fails.  For example, if I add
an extra SYM_FUNC_END(\name) to the THUNK macro:

    AS      arch/x86/entry/thunk_64.o
  arch/x86/entry/thunk_64.S: Assembler messages:
  arch/x86/entry/thunk_64.S:42: Error: symbol `SYM_END_trace_hardirqs_on_thunk' is already defined
  arch/x86/entry/thunk_64.S:43: Error: symbol `SYM_END_trace_hardirqs_off_thunk' is already defined
  arch/x86/entry/thunk_64.S:47: Error: symbol `SYM_END_lockdep_sys_exit_thunk' is already defined
  arch/x86/entry/thunk_64.S:51: Error: symbol `SYM_END____preempt_schedule' is already defined
  arch/x86/entry/thunk_64.S:52: Error: symbol `SYM_END____preempt_schedule_notrace' is already defined
  scripts/Makefile.build:395: recipe for target 'arch/x86/entry/thunk_64.o' failed

-- 
Josh
