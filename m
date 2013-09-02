From: Catalin Marinas <catalin.marinas@arm.com>
Subject: Re: [RFC PATCH 04/14] arm64: kernel: suspend/resume registers
 save/restore
Date: Mon, 2 Sep 2013 12:17:17 +0100
Message-ID: <20130902111716.GF64064@MacBook-Pro.local>
References: <1377689766-17642-1-git-send-email-lorenzo.pieralisi@arm.com>
 <1377689766-17642-5-git-send-email-lorenzo.pieralisi@arm.com>
 <20130830172310.GJ4650@arm.com>
 <20130902095728.GB2500@e102568-lin.cambridge.arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from cam-admin0.cambridge.arm.com ([217.140.96.50]:36675 "EHLO
	cam-admin0.cambridge.arm.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756751Ab3IEFHg (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 5 Sep 2013 01:07:36 -0400
Content-Disposition: inline
In-Reply-To: <20130902095728.GB2500@e102568-lin.cambridge.arm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>
Cc: "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Dave P Martin <Dave.Martin@arm.com>, Will Deacon <Will.Deacon@arm.com>, Marc Zyngier <Marc.Zyngier@arm.com>, Mark Rutland <Mark.Rutland@arm.com>, Sudeep KarkadaNagesha <Sudeep.KarkadaNagesha@arm.com>, Russell King <linux@arm.linux.org.uk>, Colin Cross <ccross@android.com>, Yu Tang <ytang5@marvell.com>, Zhou Zhu <zzhu3@marvell.com>, "ksankaran@apm.com" <ksankaran@apm.com>, Loc Ho <lho@apm.com>, Feng Kan <fkan@apm.com>, Nicolas Pitre <nico@linaro.org>, Santosh Shilimkar <santosh.shilimkar@ti.com>, Stephen Boyd <sboyd@codeaurora.org>, Graeme Gregory <graeme.gregory@linaro.org>, Hanjun Guo <hanjun.guo@linaro.org>

On Mon, Sep 02, 2013 at 10:57:28AM +0100, Lorenzo Pieralisi wrote:
> On Fri, Aug 30, 2013 at 06:23:10PM +0100, Catalin Marinas wrote:
> > On Wed, Aug 28, 2013 at 12:35:56PM +0100, Lorenzo Pieralisi wrote:
> > > Power management software requires the kernel to save and restore
> > > CPU registers while going through suspend and resume operations
> > > triggered by kernel subsystems like CPU idle and suspend to RAM.
> > > 
> > > This patch implements code that provides save and restore mechanism
> > > for the arm v8 implementation. Memory for the context is passed as
> > > parameter to both cpu_do_suspend and cpu_do_resume functions, and allows
> > > the callers to implement context allocation as they deem fit.
> > > 
> > > The registers that are saved and restored correspond to the registers
> > > actually required by the kernel to be up and running and is by no means
> > > a complete save and restore of the entire v8 register set.
> > > 
> > > Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> > > ---
> > >  arch/arm64/include/asm/proc-fns.h |  3 ++
> > >  arch/arm64/mm/proc.S              | 64 +++++++++++++++++++++++++++++++++++++++
> > >  2 files changed, 67 insertions(+)
> > > 
> > > diff --git a/arch/arm64/include/asm/proc-fns.h b/arch/arm64/include/asm/proc-fns.h
> > > index 7cdf466..0c657bb 100644
> > > --- a/arch/arm64/include/asm/proc-fns.h
> > > +++ b/arch/arm64/include/asm/proc-fns.h
> > > @@ -26,11 +26,14 @@
> > >  #include <asm/page.h>
> > >  
> > >  struct mm_struct;
> > > +struct cpu_suspend_ctx;
> > >  
> > >  extern void cpu_cache_off(void);
> > >  extern void cpu_do_idle(void);
> > >  extern void cpu_do_switch_mm(unsigned long pgd_phys, struct mm_struct *mm);
> > >  extern void cpu_reset(unsigned long addr) __attribute__((noreturn));
> > > +extern void cpu_do_suspend(struct cpu_suspend_ctx *ptr);
> > > +extern u64 cpu_do_resume(phys_addr_t ptr, u64 idmap_ttbr);
> > >  
> > >  #include <asm/memory.h>
> > >  
> > > diff --git a/arch/arm64/mm/proc.S b/arch/arm64/mm/proc.S
> > > index a82ae88..193bf98 100644
> > > --- a/arch/arm64/mm/proc.S
> > > +++ b/arch/arm64/mm/proc.S
> > > @@ -80,6 +80,70 @@ ENTRY(cpu_do_idle)
> > >  	ret
> > >  ENDPROC(cpu_do_idle)
> > >  
> > > +#ifdef CONFIG_ARM_CPU_SUSPEND
> > > +/**
> > > + * cpu_do_suspend - save CPU registers context
> > > + * x0: virtual address of context pointer
> > > + */
> > > +ENTRY(cpu_do_suspend)
> > > +	mrs	x1, tpidr_el0
> > > +	str	x1, [x0, #CPU_CTX_TPIDR_EL0]
> > > +	mrs	x2, tpidrro_el0
> > > +	str	x2, [x0, #CPU_CTX_TPIDRRO_EL0]
> > > +	mrs	x3, contextidr_el1
> > > +	str	x3, [x0, #CPU_CTX_CTXIDR_EL1]
> > > +	mrs	x4, mair_el1
> > > +	str	x4, [x0, #CPU_CTX_MAIR_EL1]
> > > +	mrs	x5, cpacr_el1
> > > +	str	x5, [x0, #CPU_CTX_CPACR_EL1]
> > > +	mrs	x6, ttbr1_el1
> > > +	str	x6, [x0, #CPU_CTX_TTBR1_EL1]
> > > +	mrs	x7, tcr_el1
> > > +	str	x7, [x0, #CPU_CTX_TCR_EL1]
> > > +	mrs	x8, vbar_el1
> > > +	str	x8, [x0, #CPU_CTX_VBAR_EL1]
> > > +	mrs	x9, sctlr_el1
> > > +	str	x9, [x0, #CPU_CTX_SCTLR_EL1]
> > > +	ret
> > > +ENDPROC(cpu_do_suspend)
> > 
> > Can you read all the registers a once and do some stp to save them?
> 
> Yes, absolutely. In a way the store pair will require an assumption on
> the context structure layout - eg:
> 
> 	mrs	x1, tpidr_el0
> 	mrs	x2, tpidrro_el0
> 	stp	x1, x2, [x0, #CPU_CTX_TPIDR_EL0]
> 
> implicitly assumes that the storage for TPIDR_EL0 and TPIDRRO_EL0 is
> contiguous, we can't change the layout later, but I guess we can live
> with that.

Do we need to access the individual saved registers from this structure,
outside the suspend/resume code? Otherwise we could simply have a plain
array to save the registers.

> > > +/**
> > > + * cpu_do_resume - registers layout should match the corresponding
> > > + *                 cpu_do_suspend call
> > > + *
> > > + * x0: Physical address of context pointer
> > > + * x1: Should contain the physical address of identity map page tables
> > > + *     used to turn on the MMU and complete context restore
> > > + *
> > > + * Returns:
> > > + *	sctlr value in x0
> > > + */
> > > +ENTRY(cpu_do_resume)
> > > +	tlbi	vmalle1is	// make sure tlb entries are invalid
> > > +	ldr	x2, [x0, #CPU_CTX_TPIDR_EL0]
> > > +	msr	tpidr_el0, x2
> > > +	ldr	x3, [x0, #CPU_CTX_TPIDRRO_EL0]
> > > +	msr	tpidrro_el0, x3
> > > +	ldr	x4, [x0, #CPU_CTX_CTXIDR_EL1]
> > > +	msr	contextidr_el1, x4
> > > +	ldr	x5, [x0, #CPU_CTX_MAIR_EL1]
> > > +	msr	mair_el1, x5
> > > +	ldr	x6, [x0, #CPU_CTX_CPACR_EL1]
> > > +	msr	cpacr_el1, x6
> > > +	msr	ttbr0_el1, x1
> > > +	ldr	x7, [x0, #CPU_CTX_TTBR1_EL1]
> > > +	msr	ttbr1_el1, x7
> > > +	ldr	x8, [x0, #CPU_CTX_TCR_EL1]
> > > +	msr	tcr_el1, x8
> > > +	ldr	x9, [x0, #CPU_CTX_VBAR_EL1]
> > > +	msr	vbar_el1, x9
> > > +	ldr	x0, [x0, #CPU_CTX_SCTLR_EL1]
> > > +	isb
> > > +	dsb	sy
> > > +	ret
> > > +ENDPROC(cpu_do_resume)
> > 
> > Same here, use ldp.
> > 
> > BTW, do we need the DSB here or just the ISB?
> 
> A dsb is required to ensure that the tlb invalidate has completed, I
> think it is mandatory from an architectural standpoint but please
> correct me if I am wrong.

Yes, it's needed for that (though usually it comes before isb, but in
this case the MMU is disabled anyway, so it doesn't matter).

-- 
Catalin
