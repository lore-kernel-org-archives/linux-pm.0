From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Subject: Re: [PATCH v5 07/15] arm64: Change cpu_resume() to enable mmu early
 then access sleep_sp by va
Date: Thu, 18 Feb 2016 18:26:02 +0000
Message-ID: <20160218182602.GA17589@red-moon>
References: <1455637767-31561-1-git-send-email-james.morse@arm.com>
 <1455637767-31561-8-git-send-email-james.morse@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:41667 "EHLO foss.arm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1423389AbcBRSX7 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Thu, 18 Feb 2016 13:23:59 -0500
Content-Disposition: inline
In-Reply-To: <1455637767-31561-8-git-send-email-james.morse@arm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: James Morse <james.morse@arm.com>
Cc: linux-arm-kernel@lists.infradead.org, Will Deacon <will.deacon@arm.com>, Sudeep Holla <sudeep.holla@arm.com>, Geoff Levand <geoff@infradead.org>, Catalin Marinas <catalin.marinas@arm.com>, Mark Rutland <mark.rutland@arm.com>, AKASHI Takahiro <takahiro.akashi@linaro.org>, Marc Zyngier <marc.zyngier@arm.com>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Pavel Machek <pavel@ucw.cz>, linux-pm@vger.kernel.org

On Tue, Feb 16, 2016 at 03:49:19PM +0000, James Morse wrote:
> By enabling the MMU early in cpu_resume(), the sleep_save_sp and stack can
> be accessed by VA, which avoids the need to convert-addresses and clean to
> PoC on the suspend path.
> 
> MMU setup is shared with the boot path, meaning the swapper_pg_dir is
> restored directly: ttbr1_el1 is no longer saved/restored.
> 
> struct sleep_save_sp is removed, replacing it with a single array of
> pointers.
> 
> cpu_do_{suspend,resume} could be further reduced to not restore: cpacr_el1,
> mdscr_el1, tcr_el1, vbar_el1 and sctlr_el1, all of which are set by
> __cpu_setup(). However these values all contain res0 bits that may be used
> to enable future features.
> 
> Signed-off-by: James Morse <james.morse@arm.com>
> ---

[...]

> diff --git a/arch/arm64/kernel/sleep.S b/arch/arm64/kernel/sleep.S
> index dca81612fe90..0e2b36f1fb44 100644
> --- a/arch/arm64/kernel/sleep.S
> +++ b/arch/arm64/kernel/sleep.S
> @@ -73,8 +73,8 @@ ENTRY(__cpu_suspend_enter)
>  	str	x2, [x0, #SLEEP_STACK_DATA_SYSTEM_REGS + CPU_CTX_SP]
>  
>  	/* find the mpidr_hash */
> -	ldr	x1, =sleep_save_sp
> -	ldr	x1, [x1, #SLEEP_SAVE_SP_VIRT]
> +	ldr	x1, =sleep_save_stash
> +	ldr	x1, [x1]
>  	mrs	x7, mpidr_el1
>  	ldr	x9, =mpidr_hash
>  	ldr	x10, [x9, #MPIDR_HASH_MASK]
> @@ -87,40 +87,26 @@ ENTRY(__cpu_suspend_enter)
>  	compute_mpidr_hash x8, x3, x4, x5, x6, x7, x10
>  	add	x1, x1, x8, lsl #3
>  
> +	str	x0, [x1]
> +	add	x0, x0, #SLEEP_STACK_DATA_SYSTEM_REGS

Mmm...this instruction does not really belong in this patch,
it should be part of patch 6, correct ? What I mean is, the new
struct to stash system regs (struct sleep_stack_data) was added in
patch 6, if the offset #SLEEP_STACK_DATA_SYSTEM_REGS (which is 0) had
to be added it had to be added in patch 6 too, it does not belong
in this patch, am I right ?

>  	push	x29, lr
> -	bl	__cpu_suspend_save
> +	bl	cpu_do_suspend
>  	pop	x29, lr
>  	mov	x0, #1
>  	ret
>  ENDPROC(__cpu_suspend_enter)
>  	.ltorg
>  
> -/*
> - * x0 must contain the sctlr value retrieved from restored context
> - */
> -	.pushsection	".idmap.text", "ax"
> -ENTRY(cpu_resume_mmu)
> -	ldr	x3, =cpu_resume_after_mmu
> -	msr	sctlr_el1, x0		// restore sctlr_el1
> -	isb
> -	/*
> -	 * Invalidate the local I-cache so that any instructions fetched
> -	 * speculatively from the PoC are discarded, since they may have
> -	 * been dynamically patched at the PoU.
> -	 */
> -	ic	iallu
> -	dsb	nsh
> -	isb
> -	br	x3			// global jump to virtual address
> -ENDPROC(cpu_resume_mmu)
> -	.popsection
> -cpu_resume_after_mmu:
> -	mov	x0, #0			// return zero on success
> -	ret
> -ENDPROC(cpu_resume_after_mmu)
> -
>  ENTRY(cpu_resume)
>  	bl	el2_setup		// if in EL2 drop to EL1 cleanly
> +	/* enable the MMU early - so we can access sleep_save_stash by va */
> +	adr_l	lr, __enable_mmu	/* __cpu_setup will return here */
> +	ldr	x27, =_cpu_resume	/* __enable_mmu will branch here */
> +	adrp	x25, idmap_pg_dir
> +	adrp	x26, swapper_pg_dir
> +	b	__cpu_setup
> +
> +ENTRY(_cpu_resume)
>  	mrs	x1, mpidr_el1
>  	adrp	x8, mpidr_hash
>  	add x8, x8, #:lo12:mpidr_hash // x8 = struct mpidr_hash phys address
> @@ -130,29 +116,27 @@ ENTRY(cpu_resume)
>  	ldp	w5, w6, [x8, #(MPIDR_HASH_SHIFTS + 8)]
>  	compute_mpidr_hash x7, x3, x4, x5, x6, x1, x2
>          /* x7 contains hash index, let's use it to grab context pointer */
> -	ldr_l	x0, sleep_save_sp + SLEEP_SAVE_SP_PHYS
> +	ldr_l	x0, sleep_save_stash
>  	ldr	x0, [x0, x7, lsl #3]
>  	add	x29, x0, #SLEEP_STACK_DATA_CALLEE_REGS
>  	add	x0, x0, #SLEEP_STACK_DATA_SYSTEM_REGS
>  	/* load sp from context */
>  	ldr	x2, [x0, #CPU_CTX_SP]
> -	/* load physical address of identity map page table in x1 */
> -	adrp	x1, idmap_pg_dir
>  	mov	sp, x2
>  	/* save thread_info */
>  	and	x2, x2, #~(THREAD_SIZE - 1)
>  	msr	sp_el0, x2
>  	/*
> -	 * cpu_do_resume expects x0 to contain context physical address
> -	 * pointer and x1 to contain physical address of 1:1 page tables
> +	 * cpu_do_resume expects x0 to contain context address pointer
>  	 */
> -	bl	cpu_do_resume		// PC relative jump, MMU off
> -	/* Can't access these by physical address once the MMU is on */
> +	bl	cpu_do_resume
> +
>  	ldp	x19, x20, [x29, #16]
>  	ldp	x21, x22, [x29, #32]
>  	ldp	x23, x24, [x29, #48]
>  	ldp	x25, x26, [x29, #64]
>  	ldp	x27, x28, [x29, #80]
>  	ldp	x29, lr, [x29]
> -	b	cpu_resume_mmu		// Resume MMU, never returns
> +	mov	x0, #0
> +	ret
>  ENDPROC(cpu_resume)
> diff --git a/arch/arm64/kernel/suspend.c b/arch/arm64/kernel/suspend.c
> index 6fe46100685a..2ec2f94d1690 100644
> --- a/arch/arm64/kernel/suspend.c
> +++ b/arch/arm64/kernel/suspend.c
> @@ -10,30 +10,12 @@
>  #include <asm/suspend.h>
>  #include <asm/tlbflush.h>
>  
> -
>  /*
> - * This is called by __cpu_suspend_enter() to save the state, and do whatever
> - * flushing is required to ensure that when the CPU goes to sleep we have
> - * the necessary data available when the caches are not searched.
> - *
> - * ptr: sleep_stack_data containing cpu state virtual address.
> - * save_ptr: address of the location where the context physical address
> - *           must be saved
> + * This is allocate by cpu_suspend_init(), and used in cpuidle to store a

Nit: s/allocate/allocated

"and used to store", it is not just used in cpuidle, also S2R and now
we have hibernate too.

[...]

> diff --git a/arch/arm64/mm/proc.S b/arch/arm64/mm/proc.S
> index db832c42ae30..a2ef1256a329 100644
> --- a/arch/arm64/mm/proc.S
> +++ b/arch/arm64/mm/proc.S
> @@ -24,6 +24,7 @@
>  #include <asm/asm-offsets.h>
>  #include <asm/hwcap.h>
>  #include <asm/pgtable.h>
> +#include <asm/pgtable-hwdef.h>
>  
>  #ifdef CONFIG_ARM64_64K_PAGES
>  #define TCR_TG_FLAGS	TCR_TG0_64K | TCR_TG1_64K
> @@ -61,62 +62,50 @@ ENTRY(cpu_do_suspend)
>  	mrs	x2, tpidr_el0
>  	mrs	x3, tpidrro_el0
>  	mrs	x4, contextidr_el1
> -	mrs	x5, mair_el1
>  	mrs	x6, cpacr_el1
> -	mrs	x7, ttbr1_el1
>  	mrs	x8, tcr_el1
>  	mrs	x9, vbar_el1
>  	mrs	x10, mdscr_el1
>  	mrs	x11, oslsr_el1
>  	mrs	x12, sctlr_el1
>  	stp	x2, x3, [x0]
> -	stp	x4, x5, [x0, #16]
> -	stp	x6, x7, [x0, #32]
> -	stp	x8, x9, [x0, #48]
> -	stp	x10, x11, [x0, #64]
> -	str	x12, [x0, #80]
> +	stp	x4, xzr, [x0, #16]
> +	stp	x6, x8, [x0, #32]
> +	stp	x9, x10, [x0, #48]
> +	stp	x11, x12, [x0, #64]

Nit: You may want to re-enumerate the registers.

With the last updates it seems fine by me, so:

Reviewed-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>

>  	ret
>  ENDPROC(cpu_do_suspend)
>  
>  /**
>   * cpu_do_resume - restore CPU register context
>   *
> - * x0: Physical address of context pointer
> - * x1: ttbr0_el1 to be restored
> - *
> - * Returns:
> - *	sctlr_el1 value in x0
> + * x0: Address of context pointer
>   */
>  ENTRY(cpu_do_resume)
> -	/*
> -	 * Invalidate local tlb entries before turning on MMU
> -	 */
> -	tlbi	vmalle1
>  	ldp	x2, x3, [x0]
>  	ldp	x4, x5, [x0, #16]
> -	ldp	x6, x7, [x0, #32]
> -	ldp	x8, x9, [x0, #48]
> -	ldp	x10, x11, [x0, #64]
> -	ldr	x12, [x0, #80]
> +	ldp	x6, x8, [x0, #32]
> +	ldp	x9, x10, [x0, #48]
> +	ldp	x11, x12, [x0, #64]
>  	msr	tpidr_el0, x2
>  	msr	tpidrro_el0, x3
>  	msr	contextidr_el1, x4
> -	msr	mair_el1, x5
>  	msr	cpacr_el1, x6
> -	msr	ttbr0_el1, x1
> -	msr	ttbr1_el1, x7
> -	tcr_set_idmap_t0sz x8, x7
> +
> +	/* Don't change t0sz here, mask those bits when restoring */
> +	mrs	x5, tcr_el1
> +	bfi	x8, x5, TCR_T0SZ_OFFSET, TCR_TxSZ_WIDTH
> +
>  	msr	tcr_el1, x8
>  	msr	vbar_el1, x9
>  	msr	mdscr_el1, x10
> +	msr	sctlr_el1, x12
>  	/*
>  	 * Restore oslsr_el1 by writing oslar_el1
>  	 */
>  	ubfx	x11, x11, #1, #1
>  	msr	oslar_el1, x11
>  	reset_pmuserenr_el0 x0			// Disable PMU access from EL0
> -	mov	x0, x12
> -	dsb	nsh		// Make sure local tlb invalidation completed
>  	isb
>  	ret
>  ENDPROC(cpu_do_resume)
> -- 
> 2.6.2
> 
