From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: Re: [PATCH] x86: General protection fault after STR (32 bit systems
 only)
Date: Fri, 12 Jun 2015 09:15:24 -0700
Message-ID: <1434125724.2353.19.camel@spandruv-DESK3.jf.intel.com>
References: <1434066338-6619-1-git-send-email-srinivas.pandruvada@linux.intel.com>
	 <20150612060747.GA25024@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:16820 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753259AbbFLQRZ (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Fri, 12 Jun 2015 12:17:25 -0400
In-Reply-To: <20150612060747.GA25024@gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: mingo@redhat.com, tglx@linutronix.de, hpa@zytor.com, pavel@ucw.cz, rjw@rjwysocki.net, x86@kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Denys Vlasenko <dvlasenk@redhat.com>, Andy Lutomirski <luto@amacapital.net>, Borislav Petkov <bp@alien8.de>, Brian Gerst <brgerst@gmail.com>, Linus Torvalds <torvalds@linux-foundation.org>, "Kleen, Andi" <andi.kleen@intel.com>

On Fri, 2015-06-12 at 08:07 +0200, Ingo Molnar wrote:
> * Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com> wrote:
> 
> > Suspend to RAM process is returning to userspsace with DS set to KERNEL_DS
> > after resume, this cause general protection fault. [...]
> 
> But s2ram has no influence on 'returning to user-space'. So unless I'm missing 
> something this changelog makes no sense.
> 
> Unfortunately the patch seems to be completely bogus as well:
> 
> > [...] This is very difficult to reproduce, but this does happen on 32 bit 
> > systems. This crash is not reproduced after save/restore DS during calls to 
> > _save_processor_state/ __restore_processor_state respectively.
> >
> > Similar issue was reported in the past
> > https://bugzilla.kernel.org/show_bug.cgi?id=61781, for which the root cause
> > was not identified.
> > 
> > Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
> > Reviewed-by: Andi Kleen <ak@linux.intel.com>
> > ---
> >  arch/x86/include/asm/suspend_32.h | 2 +-
> >  arch/x86/power/cpu.c              | 2 ++
> >  2 files changed, 3 insertions(+), 1 deletion(-)
> > 
> > diff --git a/arch/x86/include/asm/suspend_32.h b/arch/x86/include/asm/suspend_32.h
> > index 552d6c9..3503d0b 100644
> > --- a/arch/x86/include/asm/suspend_32.h
> > +++ b/arch/x86/include/asm/suspend_32.h
> > @@ -11,7 +11,7 @@
> >  
> >  /* image of the saved processor state */
> >  struct saved_context {
> > -	u16 es, fs, gs, ss;
> > +	u16 ds, es, fs, gs, ss;
> >  	unsigned long cr0, cr2, cr3, cr4;
> >  	u64 misc_enable;
> >  	bool misc_enable_saved;
> > diff --git a/arch/x86/power/cpu.c b/arch/x86/power/cpu.c
> > index 757678f..e0dfb01 100644
> > --- a/arch/x86/power/cpu.c
> > +++ b/arch/x86/power/cpu.c
> > @@ -79,6 +79,7 @@ static void __save_processor_state(struct saved_context *ctxt)
> >  	 * segment registers
> >  	 */
> >  #ifdef CONFIG_X86_32
> > +	savesegment(ds, ctxt->ds);
> >  	savesegment(es, ctxt->es);
> >  	savesegment(fs, ctxt->fs);
> >  	savesegment(gs, ctxt->gs);
> > @@ -198,6 +199,7 @@ static void notrace __restore_processor_state(struct saved_context *ctxt)
> >  	 * segment registers
> >  	 */
> >  #ifdef CONFIG_X86_32
> > +	loadsegment(ds, ctxt->ds);
> >  	loadsegment(es, ctxt->es);
> >  	loadsegment(fs, ctxt->fs);
> >  	loadsegment(gs, ctxt->gs);
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
> 
> 3)
> 
> So the patch below (totally untested) does the DS restoration early on, as the 
> first thing after we emerge from the sleep. This should be equivalent to your 
> patch, but is more robust and much simpler: there's no need to save DS, because we 
> know that it has to be __KERNEL_DS.
> 
> Could you please test whether this solves the problem as well? Also, could you 
> please describe how the failure triggers in your system: how many times do you 
> have to suspend/resume to trigger the segfaults, and is there anything that makes 
> the failures less or more likely?
It is very random. Sometimes only few hundred trys reproduce this issue.
Some other times it requires thousands of trys (sometimes not
reproducible at all for days)
It is very time sensitive. A small delay or some debug code in resume
path prevents this to crash.
The BIOS folks created special version to check if they are corrupting
any DS, but they were not able to catch any corruption.
Since these are special deployed systems running critical application,
need to request the tests again with your changes. May take long time.

Thanks,
Srinivas
> 
> Thanks,
> 
> 	Ingo
> 
> =================>
>  arch/x86/kernel/acpi/wakeup_32.S | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/arch/x86/kernel/acpi/wakeup_32.S b/arch/x86/kernel/acpi/wakeup_32.S
> index 665c6b7d2ea9..9a3ce66e0dd8 100644
> --- a/arch/x86/kernel/acpi/wakeup_32.S
> +++ b/arch/x86/kernel/acpi/wakeup_32.S
> @@ -81,6 +81,10 @@ ENTRY(do_suspend_lowlevel)
>  	jmp	ret_point
>  	.p2align 4,,7
>  ret_point:
> +	/* In case the BIOS corrupted DS, make the kernel context minimally functional: */
> +	movl	$__KERNEL_DS, %eax
> +	movl	%eax, %ds
> +
>  	call	restore_registers
>  	call	restore_processor_state
>  	ret


