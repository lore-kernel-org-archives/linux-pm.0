From: Will Deacon <will.deacon@arm.com>
Subject: Re: [PATCH v2 03/13] arm64: kernel: suspend/resume registers
 save/restore
Date: Tue, 15 Oct 2013 11:59:07 +0100
Message-ID: <20131015105907.GB30411@mudshark.cambridge.arm.com>
References: <1381748590-14279-1-git-send-email-lorenzo.pieralisi@arm.com>
 <1381748590-14279-4-git-send-email-lorenzo.pieralisi@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from cam-admin0.cambridge.arm.com ([217.140.96.50]:42264 "EHLO
	cam-admin0.cambridge.arm.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756771Ab3JOK7L (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 15 Oct 2013 06:59:11 -0400
Content-Disposition: inline
In-Reply-To: <1381748590-14279-4-git-send-email-lorenzo.pieralisi@arm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>
Cc: "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Dave P Martin <Dave.Martin@arm.com>, Catalin Marinas <Catalin.Marinas@arm.com>, Marc Zyngier <Marc.Zyngier@arm.com>, Mark Rutland <Mark.Rutland@arm.com>, Sudeep KarkadaNagesha <Sudeep.KarkadaNagesha@arm.com>, Russell King <linux@arm.linux.org.uk>, Colin Cross <ccross@android.com>, Yu Tang <ytang5@marvell.com>, Zhou Zhu <zzhu3@marvell.com>, "ksankaran@apm.com" <ksankaran@apm.com>, Loc Ho <lho@apm.com>, Feng Kan <fkan@apm.com>, Nicolas Pitre <nico@linaro.org>, Santosh Shilimkar <santosh.shilimkar@ti.com>, Stephen Boyd <sboyd@codeaurora.org>, Graeme Gregory <graeme.gregory@linaro.org>, Hanjun Guo <hanjun.guo@linaro.org>, Daniel Lezcano <daniel.lezcano@linaro.org>

On Mon, Oct 14, 2013 at 12:03:00PM +0100, Lorenzo Pieralisi wrote:
> Power management software requires the kernel to save and restore
> CPU registers while going through suspend and resume operations
> triggered by kernel subsystems like CPU idle and suspend to RAM.
> 
> This patch implements code that provides save and restore mechanism
> for the arm v8 implementation. Memory for the context is passed as
> parameter to both cpu_do_suspend and cpu_do_resume functions, and allows
> the callers to implement context allocation as they deem fit.
> 
> The registers that are saved and restored correspond to the registers set
> actually required by the kernel to be up and running which represents a
> subset of v8 ISA.
> 
> Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> ---
>  arch/arm64/include/asm/proc-fns.h      |  3 ++
>  arch/arm64/include/asm/suspend.h       | 27 ++++++++++++
>  arch/arm64/include/asm/suspendmacros.h | 75 ++++++++++++++++++++++++++++++++++
>  arch/arm64/mm/proc.S                   | 30 ++++++++++++++
>  4 files changed, 135 insertions(+)
>  create mode 100644 arch/arm64/include/asm/suspend.h
>  create mode 100644 arch/arm64/include/asm/suspendmacros.h
> 
> diff --git a/arch/arm64/include/asm/proc-fns.h b/arch/arm64/include/asm/proc-fns.h
> index 7cdf466..0c657bb 100644
> --- a/arch/arm64/include/asm/proc-fns.h
> +++ b/arch/arm64/include/asm/proc-fns.h
> @@ -26,11 +26,14 @@
>  #include <asm/page.h>
>  
>  struct mm_struct;
> +struct cpu_suspend_ctx;
>  
>  extern void cpu_cache_off(void);
>  extern void cpu_do_idle(void);
>  extern void cpu_do_switch_mm(unsigned long pgd_phys, struct mm_struct *mm);
>  extern void cpu_reset(unsigned long addr) __attribute__((noreturn));
> +extern void cpu_do_suspend(struct cpu_suspend_ctx *ptr);
> +extern u64 cpu_do_resume(phys_addr_t ptr, u64 idmap_ttbr);
>  
>  #include <asm/memory.h>
>  
> diff --git a/arch/arm64/include/asm/suspend.h b/arch/arm64/include/asm/suspend.h
> new file mode 100644
> index 0000000..2b9f1a9
> --- /dev/null
> +++ b/arch/arm64/include/asm/suspend.h
> @@ -0,0 +1,27 @@
> +#ifndef __ASM_SUSPEND_H
> +#define __ASM_SUSPEND_H
> +
> +/*
> + * struct cpu_suspend_ctx must be 16-byte aligned since it is allocated on
> + * the stack, which must be 16-byte aligned on v8
> + */
> +struct cpu_suspend_ctx {
> +	/*
> +	 * This struct must be kept in sync with
> +	 * suspend_save_ctx/suspend_restore_ctx
> +	 * macros in asm/suspendmacros.h
> +	 */
> +	struct {
> +		u64 tpidr_el0;
> +		u64 tpidrro_el0;
> +		u64 contextidr_el1;
> +		u64 mair_el1;
> +		u64 cpacr_el1;
> +		u64 ttbr1_el1;
> +		u64 tcr_el1;
> +		u64 vbar_el1;
> +		u64 sctlr_el1;
> +	} ctx_regs;

There doesn't look like a lot of state here. What about EL2 registers used
by KVM? (in fact, I don't see how this interacts with KVM at all).

> +	u64 sp;
> +} __aligned(16);
> +#endif
> diff --git a/arch/arm64/include/asm/suspendmacros.h b/arch/arm64/include/asm/suspendmacros.h
> new file mode 100644
> index 0000000..9203e76
> --- /dev/null
> +++ b/arch/arm64/include/asm/suspendmacros.h
> @@ -0,0 +1,75 @@
> +/*
> + * suspend state saving and restoring macros
> + *
> + * Copyright (C) 2013 ARM Ltd.
> + * Author: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + *
> + * You should have received a copy of the GNU General Public License
> + * along with this program.  If not, see <http://www.gnu.org/licenses/>.
> + */
> +
> +/*
> + * suspend_save_ctx - save registers required to suspend a cpu
> + *
> + * x0: register where context base address is stored
> + * macro clobbers {x2 - x10}
> + *
> + * Registers to be saved must be kept consistent with
> + * struct cpu_suspend_ctx
> + */
> +.macro suspend_save_ctx
> +	mrs	x2, tpidr_el0
> +	mrs	x3, tpidrro_el0
> +	mrs	x4, contextidr_el1
> +	mrs	x5, mair_el1
> +	mrs	x6, cpacr_el1
> +	mrs	x7, ttbr1_el1
> +	mrs	x8, tcr_el1
> +	mrs	x9, vbar_el1
> +	mrs	x10, sctlr_el1
> +	stp	x2, x3, [x0]
> +	stp	x4, x5, [x0, #16]
> +	stp	x6, x7, [x0, #32]
> +	stp	x8, x9, [x0, #48]
> +	str	x10, [x0, #64]
> +.endm

You only need to care about contextidr_el1 if CONFIG_PID_IN_CONTEXTIDR. Then
again, you're not saving ttbr0, so you could rely on switch_mm to deal with
contextidr_el1 for you, no?

> diff --git a/arch/arm64/mm/proc.S b/arch/arm64/mm/proc.S
> index b1b31bb..6ee3b99 100644
> --- a/arch/arm64/mm/proc.S
> +++ b/arch/arm64/mm/proc.S
> @@ -25,6 +25,7 @@
>  #include <asm/hwcap.h>
>  #include <asm/pgtable-hwdef.h>
>  #include <asm/pgtable.h>
> +#include <asm/suspendmacros.h>
>  
>  #include "proc-macros.S"
>  
> @@ -80,6 +81,35 @@ ENTRY(cpu_do_idle)
>  	ret
>  ENDPROC(cpu_do_idle)
>  
> +#ifdef CONFIG_ARM64_CPU_SUSPEND
> +/**
> + * cpu_do_suspend - save CPU registers context
> + * x0: virtual address of context pointer
> + */
> +ENTRY(cpu_do_suspend)
> +	suspend_save_ctx
> +	ret
> +ENDPROC(cpu_do_suspend)
> +
> +/**
> + * cpu_do_resume - restore CPU register context
> + *
> + *
> + * x0: Physical address of context pointer
> + * x1: ttbr0_el1 to be restored
> + *
> + * Returns:
> + *	sctlr_el1 value in x0
> + */
> +ENTRY(cpu_do_resume)
> +	tlbi	vmalle1is	// make sure tlb entries are invalidated

Why? Is this just to be sure that the local TLB is invalid before enabling
the MMU? If so, you can use the non-shareable variant...

> +	suspend_restore_ctx
> +	isb
> +	dsb	sy

and make this a dsb nsh. Also, aren't the dsb and the isb the wrong way
round here?

Will
