From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Subject: Re: [PATCH v2 03/13] arm64: kernel: suspend/resume registers
 save/restore
Date: Wed, 16 Oct 2013 09:59:29 +0100
Message-ID: <20131016085929.GB4815@e102568-lin.cambridge.arm.com>
References: <1381748590-14279-1-git-send-email-lorenzo.pieralisi@arm.com>
 <1381748590-14279-4-git-send-email-lorenzo.pieralisi@arm.com>
 <20131015105907.GB30411@mudshark.cambridge.arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: 8BIT
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from service87.mimecast.com ([91.220.42.44]:39352 "EHLO
	service87.mimecast.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760546Ab3JPI7g convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 16 Oct 2013 04:59:36 -0400
In-Reply-To: <20131015105907.GB30411@mudshark.cambridge.arm.com>
Content-Disposition: inline
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Will Deacon <will.deacon@arm.com>
Cc: "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Dave P Martin <Dave.Martin@arm.com>, Catalin Marinas <Catalin.Marinas@arm.com>, Marc Zyngier <Marc.Zyngier@arm.com>, Mark Rutland <Mark.Rutland@arm.com>, Sudeep KarkadaNagesha <Sudeep.KarkadaNagesha@arm.com>, Russell King <linux@arm.linux.org.uk>, Colin Cross <ccross@android.com>, Yu Tang <ytang5@marvell.com>, Zhou Zhu <zzhu3@marvell.com>, "ksankaran@apm.com" <ksankaran@apm.com>, Loc Ho <lho@apm.com>, Feng Kan <fkan@apm.com>, Nicolas Pitre <nico@linaro.org>, Santosh Shilimkar <santosh.shilimkar@ti.com>, Stephen Boyd <sboyd@codeaurora.org>, Graeme Gregory <graeme.gregory@linaro.org>, Hanjun Guo <hanjun.guo@linaro.org>, Daniel Lezcano <daniel.lezcano@linaro.org>

On Tue, Oct 15, 2013 at 11:59:07AM +0100, Will Deacon wrote:
> On Mon, Oct 14, 2013 at 12:03:00PM +0100, Lorenzo Pieralisi wrote:

[...]

> > +/*
> > + * struct cpu_suspend_ctx must be 16-byte aligned since it is allocated on
> > + * the stack, which must be 16-byte aligned on v8
> > + */
> > +struct cpu_suspend_ctx {
> > +	/*
> > +	 * This struct must be kept in sync with
> > +	 * suspend_save_ctx/suspend_restore_ctx
> > +	 * macros in asm/suspendmacros.h
> > +	 */
> > +	struct {
> > +		u64 tpidr_el0;
> > +		u64 tpidrro_el0;
> > +		u64 contextidr_el1;
> > +		u64 mair_el1;
> > +		u64 cpacr_el1;
> > +		u64 ttbr1_el1;
> > +		u64 tcr_el1;
> > +		u64 vbar_el1;
> > +		u64 sctlr_el1;
> > +	} ctx_regs;
> 
> There doesn't look like a lot of state here. What about EL2 registers used
> by KVM? (in fact, I don't see how this interacts with KVM at all).

Patch 7 implements a CPU PM notifier to restore KVM EL2 state upon resume from
shutdown states, we discussed that with Marc and I think that's sufficient;
KVM survives after successful shutdown and consequent save/restore cycle.

> > +	u64 sp;
> > +} __aligned(16);
> > +#endif
> > diff --git a/arch/arm64/include/asm/suspendmacros.h b/arch/arm64/include/asm/suspendmacros.h
> > new file mode 100644
> > index 0000000..9203e76
> > --- /dev/null
> > +++ b/arch/arm64/include/asm/suspendmacros.h
> > @@ -0,0 +1,75 @@
> > +/*
> > + * suspend state saving and restoring macros
> > + *
> > + * Copyright (C) 2013 ARM Ltd.
> > + * Author: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> > + *
> > + * This program is free software; you can redistribute it and/or modify
> > + * it under the terms of the GNU General Public License version 2 as
> > + * published by the Free Software Foundation.
> > + *
> > + * This program is distributed in the hope that it will be useful,
> > + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> > + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> > + * GNU General Public License for more details.
> > + *
> > + * You should have received a copy of the GNU General Public License
> > + * along with this program.  If not, see <http://www.gnu.org/licenses/>.
> > + */
> > +
> > +/*
> > + * suspend_save_ctx - save registers required to suspend a cpu
> > + *
> > + * x0: register where context base address is stored
> > + * macro clobbers {x2 - x10}
> > + *
> > + * Registers to be saved must be kept consistent with
> > + * struct cpu_suspend_ctx
> > + */
> > +.macro suspend_save_ctx
> > +	mrs	x2, tpidr_el0
> > +	mrs	x3, tpidrro_el0
> > +	mrs	x4, contextidr_el1
> > +	mrs	x5, mair_el1
> > +	mrs	x6, cpacr_el1
> > +	mrs	x7, ttbr1_el1
> > +	mrs	x8, tcr_el1
> > +	mrs	x9, vbar_el1
> > +	mrs	x10, sctlr_el1
> > +	stp	x2, x3, [x0]
> > +	stp	x4, x5, [x0, #16]
> > +	stp	x6, x7, [x0, #32]
> > +	stp	x8, x9, [x0, #48]
> > +	str	x10, [x0, #64]
> > +.endm
> 
> You only need to care about contextidr_el1 if CONFIG_PID_IN_CONTEXTIDR. Then
> again, you're not saving ttbr0, so you could rely on switch_mm to deal with
> contextidr_el1 for you, no?

Is contextidr_el1 "restored" in switch_mm or in contexidr_thread_switch() ?
It seems to be the latter, so if I do not save/restore it, the idle or suspend
thread might be running with the wrong contextidr_el1 until a context switch
is executed in the resume path, or I misunderstood it.

Yes, cpu_suspend() relies on switch_mm to restore the ttbr0_el1, and I use
the identity map page tables to enable the MMU in cpu_resume().

> > diff --git a/arch/arm64/mm/proc.S b/arch/arm64/mm/proc.S
> > index b1b31bb..6ee3b99 100644
> > --- a/arch/arm64/mm/proc.S
> > +++ b/arch/arm64/mm/proc.S
> > @@ -25,6 +25,7 @@
> >  #include <asm/hwcap.h>
> >  #include <asm/pgtable-hwdef.h>
> >  #include <asm/pgtable.h>
> > +#include <asm/suspendmacros.h>
> >  
> >  #include "proc-macros.S"
> >  
> > @@ -80,6 +81,35 @@ ENTRY(cpu_do_idle)
> >  	ret
> >  ENDPROC(cpu_do_idle)
> >  
> > +#ifdef CONFIG_ARM64_CPU_SUSPEND
> > +/**
> > + * cpu_do_suspend - save CPU registers context
> > + * x0: virtual address of context pointer
> > + */
> > +ENTRY(cpu_do_suspend)
> > +	suspend_save_ctx
> > +	ret
> > +ENDPROC(cpu_do_suspend)
> > +
> > +/**
> > + * cpu_do_resume - restore CPU register context
> > + *
> > + *
> > + * x0: Physical address of context pointer
> > + * x1: ttbr0_el1 to be restored
> > + *
> > + * Returns:
> > + *	sctlr_el1 value in x0
> > + */
> > +ENTRY(cpu_do_resume)
> > +	tlbi	vmalle1is	// make sure tlb entries are invalidated
> 
> Why? Is this just to be sure that the local TLB is invalid before enabling
> the MMU? If so, you can use the non-shareable variant...

Yes, that's what I thought in the first place, but then we went for the same
semantics as flush_tlb_all() which is not really needed here, as you
said it can be a non-shareable variant.

> > +	suspend_restore_ctx
> > +	isb
> > +	dsb	sy
> 
> and make this a dsb nsh. Also, aren't the dsb and the isb the wrong way
> round here?

Yes, I should swap them even if with the MMU off things do not change much
(actually arm32 v7 resume code has them the wrong way around too so for
consistency they should be swapped there too since the order is wrong).

Ok for the dsb nsh, that's what it is meant to be.

Thanks a lot,
Lorenzo

