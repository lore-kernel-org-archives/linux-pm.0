From: Catalin Marinas <catalin.marinas@arm.com>
Subject: Re: [RFC PATCH 04/14] arm64: kernel: suspend/resume registers
 save/restore
Date: Fri, 30 Aug 2013 18:23:10 +0100
Message-ID: <20130830172310.GJ4650@arm.com>
References: <1377689766-17642-1-git-send-email-lorenzo.pieralisi@arm.com>
 <1377689766-17642-5-git-send-email-lorenzo.pieralisi@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <1377689766-17642-5-git-send-email-lorenzo.pieralisi@arm.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>
Cc: Mark Rutland <Mark.Rutland@arm.com>, Feng Kan <fkan@apm.com>, Russell King <linux@arm.linux.org.uk>, Graeme Gregory <graeme.gregory@linaro.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Marc Zyngier <Marc.Zyngier@arm.com>, Stephen Boyd <sboyd@codeaurora.org>, Yu Tang <ytang5@marvell.com>, Nicolas Pitre <nico@linaro.org>, Will Deacon <Will.Deacon@arm.com>, Hanjun Guo <hanjun.guo@linaro.org>, Sudeep KarkadaNagesha <Sudeep.KarkadaNagesha@arm.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>, Loc Ho <lho@apm.com>, Colin Cross <ccross@android.com>, "ksankaran@apm.com" <ksankaran@apm.com>, Dave P Martin <Dave.Martin@arm.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Zhou Zhu <zzhu3@marvell.com>
List-Id: linux-pm@vger.kernel.org

On Wed, Aug 28, 2013 at 12:35:56PM +0100, Lorenzo Pieralisi wrote:
> Power management software requires the kernel to save and restore
> CPU registers while going through suspend and resume operations
> triggered by kernel subsystems like CPU idle and suspend to RAM.
> 
> This patch implements code that provides save and restore mechanism
> for the arm v8 implementation. Memory for the context is passed as
> parameter to both cpu_do_suspend and cpu_do_resume functions, and allows
> the callers to implement context allocation as they deem fit.
> 
> The registers that are saved and restored correspond to the registers
> actually required by the kernel to be up and running and is by no means
> a complete save and restore of the entire v8 register set.
> 
> Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> ---
>  arch/arm64/include/asm/proc-fns.h |  3 ++
>  arch/arm64/mm/proc.S              | 64 +++++++++++++++++++++++++++++++++++++++
>  2 files changed, 67 insertions(+)
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
> diff --git a/arch/arm64/mm/proc.S b/arch/arm64/mm/proc.S
> index a82ae88..193bf98 100644
> --- a/arch/arm64/mm/proc.S
> +++ b/arch/arm64/mm/proc.S
> @@ -80,6 +80,70 @@ ENTRY(cpu_do_idle)
>  	ret
>  ENDPROC(cpu_do_idle)
>  
> +#ifdef CONFIG_ARM_CPU_SUSPEND
> +/**
> + * cpu_do_suspend - save CPU registers context
> + * x0: virtual address of context pointer
> + */
> +ENTRY(cpu_do_suspend)
> +	mrs	x1, tpidr_el0
> +	str	x1, [x0, #CPU_CTX_TPIDR_EL0]
> +	mrs	x2, tpidrro_el0
> +	str	x2, [x0, #CPU_CTX_TPIDRRO_EL0]
> +	mrs	x3, contextidr_el1
> +	str	x3, [x0, #CPU_CTX_CTXIDR_EL1]
> +	mrs	x4, mair_el1
> +	str	x4, [x0, #CPU_CTX_MAIR_EL1]
> +	mrs	x5, cpacr_el1
> +	str	x5, [x0, #CPU_CTX_CPACR_EL1]
> +	mrs	x6, ttbr1_el1
> +	str	x6, [x0, #CPU_CTX_TTBR1_EL1]
> +	mrs	x7, tcr_el1
> +	str	x7, [x0, #CPU_CTX_TCR_EL1]
> +	mrs	x8, vbar_el1
> +	str	x8, [x0, #CPU_CTX_VBAR_EL1]
> +	mrs	x9, sctlr_el1
> +	str	x9, [x0, #CPU_CTX_SCTLR_EL1]
> +	ret
> +ENDPROC(cpu_do_suspend)

Can you read all the registers a once and do some stp to save them?

> +
> +/**
> + * cpu_do_resume - registers layout should match the corresponding
> + *                 cpu_do_suspend call
> + *
> + * x0: Physical address of context pointer
> + * x1: Should contain the physical address of identity map page tables
> + *     used to turn on the MMU and complete context restore
> + *
> + * Returns:
> + *	sctlr value in x0
> + */
> +ENTRY(cpu_do_resume)
> +	tlbi	vmalle1is	// make sure tlb entries are invalid
> +	ldr	x2, [x0, #CPU_CTX_TPIDR_EL0]
> +	msr	tpidr_el0, x2
> +	ldr	x3, [x0, #CPU_CTX_TPIDRRO_EL0]
> +	msr	tpidrro_el0, x3
> +	ldr	x4, [x0, #CPU_CTX_CTXIDR_EL1]
> +	msr	contextidr_el1, x4
> +	ldr	x5, [x0, #CPU_CTX_MAIR_EL1]
> +	msr	mair_el1, x5
> +	ldr	x6, [x0, #CPU_CTX_CPACR_EL1]
> +	msr	cpacr_el1, x6
> +	msr	ttbr0_el1, x1
> +	ldr	x7, [x0, #CPU_CTX_TTBR1_EL1]
> +	msr	ttbr1_el1, x7
> +	ldr	x8, [x0, #CPU_CTX_TCR_EL1]
> +	msr	tcr_el1, x8
> +	ldr	x9, [x0, #CPU_CTX_VBAR_EL1]
> +	msr	vbar_el1, x9
> +	ldr	x0, [x0, #CPU_CTX_SCTLR_EL1]
> +	isb
> +	dsb	sy
> +	ret
> +ENDPROC(cpu_do_resume)

Same here, use ldp.

BTW, do we need the DSB here or just the ISB?

-- 
Catalin
