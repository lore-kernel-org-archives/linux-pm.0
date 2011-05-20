From: Dave Martin <dave.martin@linaro.org>
Subject: Re: [RFC PATCH] ARM hibernation / suspend-to-disk
	support code
Date: Fri, 20 May 2011 16:03:49 +0100
Message-ID: <20110520150348.GB3141__16675.7740466439$1305903893$gmane$org@arm.com>
References: <3DCE2F529B282E4B8F53D4D8AA406A07014FFE@008-AM1MPN1-022.mgdnok.nokia.com>
	<alpine.DEB.2.00.1105181257370.2374@localhost6.localdomain6>
	<20110520113758.GA3141@arm.com>
	<alpine.DEB.2.00.1105201255260.8018@localhost6.localdomain6>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.00.1105201255260.8018@localhost6.localdomain6>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Frank Hofmann <frank.hofmann@tomtom.com>
Cc: linux-pm@lists.linux-foundation.org, tuxonice-devel@tuxonice.net, linux-arm-kernel@lists.infradead.org
List-Id: linux-pm@vger.kernel.org

On Fri, May 20, 2011 at 01:39:37PM +0100, Frank Hofmann wrote:
> On Fri, 20 May 2011, Dave Martin wrote:
> 
> [ ... ]
> >>+/*
> >>+ * Save the current CPU state before suspend / poweroff.
> >>+ */
> >>+ENTRY(swsusp_arch_suspend)
> >>+	ldr	r0, =__swsusp_arch_ctx
> >>+	mrs	r1, cpsr
> >>+	str	r1, [r0], #4		/* CPSR */
> >>+ARM(	msr	cpsr_c, #SYSTEM_MODE					)
> >>+THUMB(	mov	r2, #SYSTEM_MODE					)
> >>+THUMB(	msr	cpsr_c, r2						)
> >
> >For Thumb-2 kernels, you can use the cps instruction to change the CPU
> >mode:
> >	cps	#SYSTEM_MODE
> >
> >For ARM though, this instruction is only supported for ARMv6 and above,
> >so it's best to keep the msr form for compatibility for that case.
> 
> Ah, ok, no problem will make that change, looks good.
> 
> Do all ARMs have cpsr / spsr as used here ? Or is that code
> restricted to ARMv5+ ? I don't have the CPU evolution history there,
> only got involved with ARM when armv6 already was out.

CPSR/SPSR exist from ARMv3 onwards.  I think for linux we can just assume
that they are there (unless someone knows better...)

> 
> I've simply done there what the "setmode" macro from
> <asm/assembler.h> is doing, have chosen not to include that file
> because it overrides "push" on a global scale for no good reason and
> that sort of thing makes me cringe.

Actually, I guess you should be using that header, from a general
standardisation point of view.  In particular, it would be nicer to
use setmode than to copy it.

The setmode macro itself could be improved to use cps for Thumb-2,
but that would be a separate (and low-priority) patch.


Re the push/pop macros, I'm not sure of the history for those.

In the kernel, it seems customary to write stmfd sp!, / ldmfd sp!,
instead of push / pop, so you could always use those mnemonics instead.
They're equivalent.

> 
> 
> >
> >>+	stm	r0!, {r4-r12,lr}	/* nonvolatile regs */
> >
> >Since r12 is allowed to be corrupted across a function call, we
> >probably don't need to save it.
> 
> ah ok thx for clarification. Earlier iterations of the patch just
> saved r0-r14 there, "just to have it all", doing it right is best as
> always.
> 
> >
> [ ... ]
> >>+	bl	__save_processor_state
> >
> ><aside>
> >
> >Structurally, we seem to have:
> >
> >swsusp_arch_suspend {
> >	/* save some processor state */
> >	__save_processor_state();
> >
> >	swsusp_save();
> >}
> >
> >Is __save_processor_state() intended to encapsulate all the CPU-model-
> >specific state saving?  Excuse my ignorance of previous conversations...
> >
> ></aside>
> 
> You're right.
> 
> I've attached the codechanges which implement __save/__restore...
> for TI OMAP3 and Samsung S5P64xx, to illustrate, again (that's the
> stuff referred to in the earlier mail I mentioned in first post;
> beware of code churn in there, those diffs don't readily apply to
> 'just any' kernel).
> 
> These hooks are essentially the same as the machine-specific
> cpu_suspend() except that we substitute "r0" (the save context after
> the generic part) as target for where-to-save-the-state, and we make
> the funcs return instead of switching to OFF mode.
> 
> That's what I meant with "backdoorish". A better way would be to
> change the cpu_suspend interface so that it returns instead of
> directly switching to off mode / powering down.
> 
> Russell has lately been making changes in this area; the current
> kernels are a bit different here since the caller already supplies
> the state-save-buffer, while the older ones used to choose in some
> mach-specific way where to store that state.
> 
> (one of the reasons why these mach-dependent enablers aren't part of
> this patch suggestion ...)
> 
> 
> >
> >>+	pop	{lr}
> >>+	b	swsusp_save
> >>+ENDPROC(swsusp_arch_suspend)
> >
> >I'm not too familiar with the suspend/resume stuff, so I may be asking
> >a dumb question here, but:
> >
> >Where do we save/restore r8_FIQ..r13_FIQ, r13_IRQ, r13_UND and r13_ABT?
> >(I'm assuming there's no reason to save/restore r14 or SPSR for any
> >exception mode, since we presumably aren't going to suspend/resume
> >from inside an exception handler (?))
> >
> >The exception stack pointers might conceivably be reinitialised to
> >sane values on resume, without necessarily needing to save/restore
> >them, providing my assumption in the previous paragraph is correct.
> >
> >r8_FIQ..r12_FIQ can store arbitrary state used by the FIQ handler,
> >if FIQ is in use.  Can we expect any driver using FIQ to save/restore
> >this state itself, rather than doing it globally?  This may be
> >reasonable.
> 
> We don't need to save/restore those, because at the time the
> snapshot is taken interrupts are off and we cannot be in any trap
> handler either. On resume, the kernel that has been loaded has
> initialized them properly already.
> 
> If there's really any driver out there which uses FIQ in such an
> exclusive manner that it expects FIQ register bank contents to

This is exactly how FIQ may be used: by preloading the data for the next
I/O operation in the FIQ banked registers, you can issue the next
operation to the peripheral on the first instruction after taking the
interrupt, without having any delay for accessing memory or executing
other instructions, so:

my_fiq_handler:
	str	r8, [r9]
	/* ... */
	/* set up next transaction in r8,r9 */
	/* return */

This can make a significant difference to throughput when streaming
data to certain types of serial peripheral.

It's mostly of historical interest though, since that advantage
is likely to be swamped by cache effects on modern platforms, plus
it's hard to use FIQ to service more than one device without losing
the advantages.

> remain the same across multiple FIQ events then it's rather that
> driver's responsibility to perform the save/restore via
> suspend/resume callbacks.

I think I agree.  Few drivers use FIQ, and if there are drivers
which use FIQ but don't implement suspend/resume hooks, that sounds
like a driver bug.

Assuming nobody disagrees with that conclusion, it would be a good
idea to stick a comment somewhere explaining that policy.

> 
> See also Russell's mails about that, for previous attempts a year
> and half a year ago to get "something for ARM hibernation" in:
> 
> https://lists.linux-foundation.org/pipermail/linux-pm/2010-July/027571.html
> https://lists.linux-foundation.org/pipermail/linux-pm/2010-December/029665.html

Relying on drivers to save/restore the FIQ state if necessary seems
to correspond to what Russell is saying in his second mail.

> 
> The kernel doesn't do IRQ/FIQ/ABT/UND save / restore for
> suspend-to-ram either. CPU hotplug support (re)initializes those. I
> believe we're fine.

OK, just wanted to make sure I understood that right.

I'll leave it to others to comment on the actual SoC-specific routines,
but thanks for the illustration.

Cheers
---Dave

> 
> 
> >
> >Cheers
> >---Dave
> >
> >
> 
> Thanks,
> FrankH.

> diff --git a/arch/arm/plat-s5p/sleep.S b/arch/arm/plat-s5p/sleep.S
> index 2cdae4a..dd9516b 100644
> --- a/arch/arm/plat-s5p/sleep.S
> +++ b/arch/arm/plat-s5p/sleep.S
> @@ -44,14 +44,32 @@
>  */
>  	.text
>  
> +#ifdef CONFIG_HIBERNATION
> +ENTRY(__save_processor_state)
> +	mov	r1, #0
> +	b	.Ls3c_cpu_save_internal
> +ENDPROC(__save_processor_state)
> +
> +ENTRY(__restore_processor_state)
> +	stmfd	sp!, { r3 - r12, lr }
> +	ldr	r2, =.Ls3c_cpu_resume_internal
> +	mov	r1, #1
> +	str	sp, [r0, #40]		@ fixup sp in restore context
> +	mov	pc, r2
> +ENDPROC(__restore_processor_state)
> +#endif
> +
>  	/* s3c_cpu_save
>  	 *
>  	 * entry:
>  	 *	r0 = save address (virtual addr of s3c_sleep_save_phys)
> -	*/
> +	 *	r1 (_internal_ only) = CPU sleep trampoline (if any)
> +	 */
>  
>  ENTRY(s3c_cpu_save)
>  
> +	ldr	r1, =pm_cpu_sleep	@ set trampoline
> +.Ls3c_cpu_save_internal:
>  	stmfd	sp!, { r3 - r12, lr }
>  
>  	mrc	p15, 0, r4, c13, c0, 0	@ FCSE/PID
> @@ -67,11 +85,15 @@ ENTRY(s3c_cpu_save)
>  
>  	stmia	r0, { r3 - r13 }
>  
> +	mov	r4, r1
>  	@@ write our state back to RAM
>  	bl	s3c_pm_cb_flushcache
>  
> +	movs	r0, r4
> +#ifdef CONFIG_HIBERNATION
> +	ldmeqfd	sp!, { r3 - r12, pc }	@ if there was no trampoline, return
> +#endif
>  	@@ jump to final code to send system to sleep
> -	ldr	r0, =pm_cpu_sleep
>  	@@ldr	pc, [ r0 ]
>  	ldr	r0, [ r0 ]
>  	mov	pc, r0
> @@ -86,6 +108,7 @@ resume_with_mmu:
>  	str	r12, [r4]
>  
>  	ldmfd	sp!, { r3 - r12, pc }
> +ENDPROC(s3c_cpu_save)
>  
>  	.ltorg
>  
> @@ -131,6 +154,7 @@ ENTRY(s3c_cpu_resume)
>  	mcr	p15, 0, r1, c7, c5, 0		@@ invalidate I Cache
>  
>  	ldr	r0, s3c_sleep_save_phys	@ address of restore block
> +.Ls3c_cpu_resume_internal:
>  	ldmia	r0, { r3 - r13 }
>  
>  	mcr	p15, 0, r4, c13, c0, 0	@ FCSE/PID
> @@ -152,6 +176,11 @@ ENTRY(s3c_cpu_resume)
>  	mcr	p15, 0, r12, c10, c2, 0	@ write PRRR
>  	mcr	p15, 0, r3, c10, c2, 1	@ write NMRR
>  
> +#ifdef CONFIG_HIBERNATION
> +	cmp	r1, #0
> +	bne	0f			@ only do MMU phys init
> +					@ not called by __restore_processor_state
> +#endif
>  	/* calculate first section address into r8 */
>  	mov	r4, r6
>  	ldr	r5, =0x3fff
> @@ -175,6 +204,7 @@ ENTRY(s3c_cpu_resume)
>  	str	r10, [r4]
>  
>  	ldr	r2, =resume_with_mmu
> +0:
>  	mcr	p15, 0, r9, c1, c0, 0		@ turn on MMU, etc
>  
>          nop
> @@ -183,6 +213,9 @@ ENTRY(s3c_cpu_resume)
>          nop
>          nop					@ second-to-last before mmu
>  
> +#ifdef CONFIG_HIBERNATION
> +	ldmnefd	sp!, { r3 - r12, pc }
> +#endif
>  	mov	pc, r2				@ go back to virtual address
>  
>  	.ltorg

> diff --git a/arch/arm/mach-omap2/sleep34xx.S b/arch/arm/mach-omap2/sleep34xx.S
> index ea4e498..19ecd8e 100644
> --- a/arch/arm/mach-omap2/sleep34xx.S
> +++ b/arch/arm/mach-omap2/sleep34xx.S
> @@ -358,6 +358,7 @@ logic_l1_restore:
>  	ldr	r4, scratchpad_base
>  	ldr	r3, [r4,#0xBC]
>  	adds	r3, r3, #16
> +.Llogic_l1_restore_internal:
>  	ldmia	r3!, {r4-r6}
>  	mov	sp, r4
>  	msr	spsr_cxsf, r5
> @@ -433,6 +434,10 @@ ttbr_error:
>  	*/
>  	b	ttbr_error
>  usettbr0:
> +#ifdef CONFIG_HIBERNATION
> +	cmp	r1, #1
> +	ldmeqfd	sp!, { r0 - r12, pc }	@ early return from __restore_processor_state
> +#endif
>  	mrc	p15, 0, r2, c2, c0, 0
>  	ldr	r5, ttbrbit_mask
>  	and	r2, r5
> @@ -471,6 +476,25 @@ usettbr0:
>  	mcr	p15, 0, r4, c1, c0, 0
>  
>  	ldmfd	sp!, {r0-r12, pc}		@ restore regs and return
> +
> +#ifdef CONFIG_HIBERNATION
> +ENTRY(__save_processor_state)
> +	stmfd	sp!, {r0-r12, lr}
> +	mov	r1, #0x4
> +	mov	r8, r0
> +	b	l1_logic_lost
> +ENDPROC(__save_processor_state)
> +
> +ENTRY(__restore_processor_state)
> +	stmfd	sp!, { r0 - r12, lr }
> +	str	sp, [r0]		@ fixup saved stack pointer
> +	str	lr, [r0, #8]		@ fixup saved link register
> +	mov	r3, r0
> +	mov	r1, #1
> +	b	.Llogic_l1_restore_internal
> +ENDPROC(__restore_processor_state)
> +#endif
> +
>  save_context_wfi:
>  	/*b	save_context_wfi*/	@ enable to debug save code
>  	mov	r8, r0 /* Store SDRAM address in r8 */
> @@ -545,6 +569,10 @@ l1_logic_lost:
>  	mrc	p15, 0, r4, c1, c0, 0
>  	/* save control register */
>  	stmia	r8!, {r4}
> +#ifdef CONFIG_HIBERNATION
> +	cmp	r1, #4
> +	ldmeqfd	sp!, {r0-r12, pc}	@ early return from __save_processor_state
> +#endif
>  clean_caches:
>  	/* Clean Data or unified cache to POU*/
>  	/* How to invalidate only L1 cache???? - #FIX_ME# */
> diff --git a/arch/arm/plat-omap/Kconfig b/arch/arm/plat-omap/Kconfig
> index df5ce56..b4713ba 100644
> --- a/arch/arm/plat-omap/Kconfig
> +++ b/arch/arm/plat-omap/Kconfig
> @@ -23,6 +23,7 @@ config ARCH_OMAP3
>  	select CPU_V7
>  	select COMMON_CLKDEV
>  	select OMAP_IOMMU
> +	select ARCH_HIBERNATION_POSSIBLE
>  
>  config ARCH_OMAP4
>  	bool "TI OMAP4"
