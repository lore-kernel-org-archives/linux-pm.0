From: Andy Lutomirski <luto@amacapital.net>
Subject: Re: [PATCH] x86: General protection fault after STR (32 bit systems only)
Date: Thu, 11 Jun 2015 23:48:12 -0700
Message-ID: <CALCETrWjckJqfBdvhjGk81-tOOKu8QVeT6WC=hjtXYURvJ7dmA@mail.gmail.com>
References: <1434066338-6619-1-git-send-email-srinivas.pandruvada@linux.intel.com>
 <20150612060747.GA25024@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-lb0-f173.google.com ([209.85.217.173]:36476 "EHLO
	mail-lb0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753205AbbFLGse (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 12 Jun 2015 02:48:34 -0400
Received: by lbbqq2 with SMTP id qq2so14572792lbb.3
        for <linux-pm@vger.kernel.org>; Thu, 11 Jun 2015 23:48:32 -0700 (PDT)
In-Reply-To: <20150612060747.GA25024@gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Ingo Molnar <mingo@redhat.com>, Thomas Gleixner <tglx@linutronix.de>, "H. Peter Anvin" <hpa@zytor.com>, Pavel Machek <pavel@ucw.cz>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, X86 ML <x86@kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Denys Vlasenko <dvlasenk@redhat.com>, Borislav Petkov <bp@alien8.de>, Brian Gerst <brgerst@gmail.com>, Linus Torvalds <torvalds@linux-foundation.org>

On Thu, Jun 11, 2015 at 11:07 PM, Ingo Molnar <mingo@kernel.org> wrote:
>
> * Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com> wrote:
>
>> Suspend to RAM process is returning to userspsace with DS set to KERNEL_DS
>> after resume, this cause general protection fault. [...]
>
> But s2ram has no influence on 'returning to user-space'. So unless I'm missing
> something this changelog makes no sense.
>
> Unfortunately the patch seems to be completely bogus as well:
>
>> [...] This is very difficult to reproduce, but this does happen on 32 bit
>> systems. This crash is not reproduced after save/restore DS during calls to
>> _save_processor_state/ __restore_processor_state respectively.
>>
>> Similar issue was reported in the past
>> https://bugzilla.kernel.org/show_bug.cgi?id=61781, for which the root cause
>> was not identified.
>>
>> Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
>> Reviewed-by: Andi Kleen <ak@linux.intel.com>
>> ---
>>  arch/x86/include/asm/suspend_32.h | 2 +-
>>  arch/x86/power/cpu.c              | 2 ++
>>  2 files changed, 3 insertions(+), 1 deletion(-)
>>
>> diff --git a/arch/x86/include/asm/suspend_32.h b/arch/x86/include/asm/suspend_32.h
>> index 552d6c9..3503d0b 100644
>> --- a/arch/x86/include/asm/suspend_32.h
>> +++ b/arch/x86/include/asm/suspend_32.h
>> @@ -11,7 +11,7 @@
>>
>>  /* image of the saved processor state */
>>  struct saved_context {
>> -     u16 es, fs, gs, ss;
>> +     u16 ds, es, fs, gs, ss;
>>       unsigned long cr0, cr2, cr3, cr4;
>>       u64 misc_enable;
>>       bool misc_enable_saved;
>> diff --git a/arch/x86/power/cpu.c b/arch/x86/power/cpu.c
>> index 757678f..e0dfb01 100644
>> --- a/arch/x86/power/cpu.c
>> +++ b/arch/x86/power/cpu.c
>> @@ -79,6 +79,7 @@ static void __save_processor_state(struct saved_context *ctxt)
>>        * segment registers
>>        */
>>  #ifdef CONFIG_X86_32
>> +     savesegment(ds, ctxt->ds);
>>       savesegment(es, ctxt->es);
>>       savesegment(fs, ctxt->fs);
>>       savesegment(gs, ctxt->gs);
>> @@ -198,6 +199,7 @@ static void notrace __restore_processor_state(struct saved_context *ctxt)
>>        * segment registers
>>        */
>>  #ifdef CONFIG_X86_32
>> +     loadsegment(ds, ctxt->ds);
>>       loadsegment(es, ctxt->es);
>>       loadsegment(fs, ctxt->fs);
>>       loadsegment(gs, ctxt->gs);
>
> So save_processor_state() is used by 32-bit s2ram in the following place:
>
> arch/x86/kernel/acpi/wakeup_32.S:       call    save_processor_state
>
> Other uses are:
>
> arch/x86/kernel/acpi/wakeup_64.S:       call    save_processor_state
> arch/x86/kernel/apm_32.c:       save_processor_state();
> arch/x86/kernel/machine_kexec_32.c:             save_processor_state();
> arch/x86/kernel/machine_kexec_64.c:             save_processor_state();
> arch/x86/platform/olpc/xo1-wakeup.S:    call    save_processor_state
> kernel/power/hibernate.c:       save_processor_state();
> kernel/power/hibernate.c:       save_processor_state();
>
> but neither of these call sites seems to matter to the bug: the 32-bit system does
> not use APM, kexec, is not an OLPC and does not use hibernation.
>
> And if we look at arch/x86/kernel/acpi/wakeup_32.S it's a straightforward full
> state save/restore before ACPI (BIOS) downcalls.
>
> Furthermore, the bug report in:
>
>     https://bugzilla.kernel.org/show_bug.cgi?id=61781
>
> talks about SIGSEGVs, and claims that this regression triggers in v3.11 but does
> not trigger in v3.10.
>
> 1)
>
> So the first critical question is: if the ACPI/BIOS suspend code corrupts the
> kernel's DS, how can we get so far as to resume fully, return to user-space, and
> segfault there so that it can all be reported?
>
> So neither the explanation nor the code makes any sense in the context of the
> reported bugs. Can anyone else offer any plausible theory about why this patch
> would fix 32-bit user-space segfaults?

I'm too tired to look at this intelligently right now, but this
reminds me of the sysret_ss_attrs thing.  What if we have a situation
where, after suspend/resume, we end up with a perfectly valid ss
*selector* (or, on 64-bit kernels, a ds selector that does not matter
one whit) but a somehow-screwed-up ds *cached hidden descriptor*.  (On
32-bit kernels, this could be something exotic like grows-down limit
2^31.)

Now we do the very first return.  If we're on AMD hardware and that
return is SYSRET, then we end up with some complete random garbage
loaded in the hidden DS descriptor if SYSRET on 32-bit mode is indeed
screwed up on AMD.

Of course, this is apparently DS and not SS, but maybe something
similar is happening.  How easily reproducible is this, and what cpu
is it on?  Would something like 'push %ds; pop %ds' after SYSENTER in
vdso32/sysenter.S fix it?

Also, damnit systemd, stop catching SEGV.  I want to know all the SEGV
details, and you helpfully threw them away.  Good job.

>
> 2)
>
> Btw., I don't mind the idea of the patch itself per se: saving/restoring DS is
> prudent to avoid the BIOS stomping on our DS.
>
> But the restoration done in this patch is bogus, it's done way too late in a C
> function, there's a number of places where we might use the kernel DS before it's
> restored, such as restore_registers():
>
> restore_registers:
>         movl    saved_context_ebp, %ebp
>         movl    saved_context_ebx, %ebx
>         movl    saved_context_esi, %esi
>         movl    saved_context_edi, %edi
>         pushl   saved_context_eflags
>         popfl
>         ret
>
> this is called before restore_processor_state().
>
> those 'saved_context_*' references are already using the kernel DS! So if it's
> corrupted, we'll crash there already. So your patch seems totally nonsensical.

Don't even bother saving it.  Just load the known value on resume.

This is a bit odd, in that we don't do the X86_BUG_SYSRET_SS_ATTRS
fixup on 32-bit kernels, and yet no one reported the
sysret_ss_attrs_32 test failing on 32-bit kernels.  I assume that
what's going on is that 32-bit kernels don't have any ways to enter
the kernel with SS=0 (because ss0 is in the TSS and it isn't zero),
but we never thought of the other way to have a bogus SS descriptor in
kernel mode: change the GDT without reloading SS.

I'm presently mystified about DS.  The 32-bit sysenter path loads
__KERNEL_DS into ds (in a macro helpfully called SAVE_ALL), but what,
if anything, restores DS on return?  Could we actually be executing in
32-bit userspace with DS & 3 == 0 after every SYSEXIT on 32-bit
kernels?  If so, yikes!

Should we load __USER_DS into DS and ES right before SYSEXIT?

Here's my full-fledged half-asleep theory:

We suspend to RAM.  We resume.  DS and/or ES contains something
unusual but not unusual enough to crash us.  Our first entry to
userspace is via SYSEXIT.  Because we're daft, we don't reload DS or
ES at any point along the way.  Now we're in userspace with an even
more screwed up DS or ES than usual.  We get SIGSEGV (presumably #GP)
and try to deliver the signal.  We end up with impossible pt_regs
(bogus RPL) but who cares?  We get to __setup_frame, which fixes the
garbage in pt_regs and we re-enter user mode through an IRET patch, so
we finally reload DS and ES.  As a result, we successfully deliver the
signal.  The saved regs would reveal the damage, but systemd throws
them away, and we remain confused for a full ten kernel versions.

--Andy
