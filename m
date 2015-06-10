From: Josh Poimboeuf <jpoimboe@redhat.com>
Subject: Re: [PATCH v5 07/10] x86/asm/acpi: Fix asmvalidate warnings for
 wakeup_64.S
Date: Wed, 10 Jun 2015 09:08:30 -0500
Message-ID: <20150610140830.GA25848@treble.redhat.com>
References: <cover.1433937132.git.jpoimboe@redhat.com>
 <2817f5690aa760a601a614b738545fd60b087bbb.1433937132.git.jpoimboe@redhat.com>
 <20150610131914.GA25572@amd>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20150610131914.GA25572@amd>
Sender: linux-kernel-owner@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, Michal Marek <mmarek@suse.cz>, Peter Zijlstra <peterz@infradead.org>, Andy Lutomirski <luto@kernel.org>, Borislav Petkov <bp@alien8.de>, Linus Torvalds <torvalds@linux-foundation.org>, Andi Kleen <andi@firstfloor.org>, x86@kernel.org, live-patching@vger.kernel.org, linux-kernel@vger.kernel.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Wed, Jun 10, 2015 at 03:19:14PM +0200, Pavel Machek wrote:
> Hi!
> 
> > Fix the following asmvalidate warnings:
> > 
> >    asmvalidate: arch/x86/kernel/acpi/wakeup_64.o: wakeup_long64()+0x15: unsupported jump to outside of function
> >    asmvalidate: arch/x86/kernel/acpi/wakeup_64.o: wakeup_long64()+0x55: unsupported jump to outside of function
> >    asmvalidate: arch/x86/kernel/acpi/wakeup_64.o: wakeup_long64(): unsupported fallthrough at end of function
> >    asmvalidate: arch/x86/kernel/acpi/wakeup_64.o: do_suspend_lowlevel()+0x9a: unsupported jump to outside of function
> >    asmvalidate: arch/x86/kernel/acpi/wakeup_64.o: do_suspend_lowlevel()+0x116: unsupported jump to outside of function
> >    asmvalidate: arch/x86/kernel/acpi/wakeup_64.o: do_suspend_lowlevel(): unsupported fallthrough at end of function
> >    asmvalidate: arch/x86/kernel/acpi/wakeup_64.o: do_suspend_lowlevel(): missing FP_SAVE/RESTORE macros
> > 
> > 1. wakeup_long64() isn't a function that can be called.  It's actually
> >    redirected to via a return instruction in the entry code.  It
> >    shouldn't be annotated as a callable function.  Change ENDPROC ->
> >    PROC accordingly.
> 
> But I see -> END.

Oops!  It should say -> END.

> > 2. do_suspend_lowlevel() is a non-leaf callable function, so
> >    save/restore the frame pointer with FP_SAVE/RESTORE.
> 
> It does not work with the frame pointer itself. Is FP_SAVE/RESTORE
> still neccessary? Will you need FP_RESTORE to wakeup_long64, then?

wakeup_long64 jumps to .Lresume_point, which does the FP_RESTORE.

> > 3. Remove the unnecessary jump to .Lresume_point, as it just results in
> >    jumping to the next instruction (which is a nop because of the
> >    align).  Otherwise asmvalidate gets confused by the jump.
> 
> It also results in flushing the pipeline. Ok, I guess this one is unneccessary.
> 
> > 4. Change the "jmp restore_processor_state" to a call instruction,
> >    because jumping outside the function's boundaries isn't allowed.  Now
> >    restore_processor_state() will return back to do_suspend_lowlevel()
> >    instead of do_suspend_lowlevel()'s caller.
> > 
> > 5. Remove superfluous rsp changes.
> 
> Did you test the changes?

Yes, I verified that it didn't break suspend/resume on my system.

> Do you plan to make similar changes to wakeup_32.S?

Currently, asmvalidate is x86_64 only, so I'm only fixing the 64-bit
stuff right now.

> > diff --git a/arch/x86/kernel/acpi/wakeup_64.S b/arch/x86/kernel/acpi/wakeup_64.S
> > index 8c35df4..7e442be 100644
> > --- a/arch/x86/kernel/acpi/wakeup_64.S
> > +++ b/arch/x86/kernel/acpi/wakeup_64.S
> > @@ -5,6 +5,7 @@
> >  #include <asm/page_types.h>
> >  #include <asm/msr.h>
> >  #include <asm/asm-offsets.h>
> > +#include <asm/func.h>
> >  
> >  # Copyright 2003 Pavel Machek <pavel@suse.cz>, distribute under GPLv2
> >  
> > @@ -33,13 +34,13 @@ ENTRY(wakeup_long64)
> >  
> >  	movq	saved_rip, %rax
> >  	jmp	*%rax
> > -ENDPROC(wakeup_long64)
> > +END(wakeup_long64)
> >
> 
> This should result in no binary code changes, so that's ok with me...
> 
> >  ENTRY(do_suspend_lowlevel)
> > -	subq	$8, %rsp
> > +	FP_SAVE
> >  	xorl	%eax, %eax
> >  	call	save_processor_state
> >
> 
> Are you sure? Stuff like
>         movq    $saved_context, %rax
>         movq    %rsp, pt_regs_sp(%rax)
> 
> follows. And you did not modify wakeup_long64, which now receives
> different value in saved_rsp.

Hm, I'm looking hard, but I still don't see a problem with that code.
It's saving rsp to the saved_context struct.  As I mentioned above, it's
ok for the wakeup_long64 path to restore the same rsp value, since it
jumps to .Lresume_point which has FP_RESTORE.

> > @@ -108,8 +108,9 @@ ENTRY(do_suspend_lowlevel)
> >  	movq	pt_regs_r15(%rax), %r15
> >  
> >  	xorl	%eax, %eax
> > -	addq	$8, %rsp
> > -	jmp	restore_processor_state
> > +	call	restore_processor_state
> > +	FP_RESTORE
> > +	ret
> >  ENDPROC(do_suspend_lowlevel)
> 
> Umm. I rather liked the direct jump.

Why?

-- 
Josh
