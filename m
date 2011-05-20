From: Dave Martin <dave.martin@linaro.org>
Subject: Re: [RFC PATCH] ARM hibernation / suspend-to-disk
	support code
Date: Fri, 20 May 2011 12:37:58 +0100
Message-ID: <20110520113758.GA3141__6726.16101005605$1305902045$gmane$org@arm.com>
References: <3DCE2F529B282E4B8F53D4D8AA406A07014FFE@008-AM1MPN1-022.mgdnok.nokia.com>
	<alpine.DEB.2.00.1105181257370.2374@localhost6.localdomain6>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.00.1105181257370.2374@localhost6.localdomain6>
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

On Thu, May 19, 2011 at 06:31:28PM +0100, Frank Hofmann wrote:
> Hi,
> 
> /me again ...
> 
> Sorry that this took a little ... holidays. And work. And distractions...
> 
> Anyway, here we go again, basic code to enable hibernation
> (suspend-to-disk) on ARM platforms.
> 
> Any comments highly welcome.
> 
> 
> 
> To use this, you need sleep.S modifications for your SoC type (to
> get __save/__restore_processor_state hooks). I've sent some of those
> for illustration earlier, they haven't changed, I've not included
> them here, so pick these changes up from:
> 
> http://68.183.106.108/lists/linux-pm/msg24020.html
> 
> The patch below only contains the _generic_ code.
> 
> 
> This is tested on S5P6450 and OMAP3, with the sleep...S changes just
> mentioned - check the archives for those. Works both with normal
> swsusp and tuxonice (again, check the archives for the TOI
> modification needed).
> 
> 
> 
> Previously, I've reported OMAP3 video issues, after
> resume-from-disk. That isn't fully solved (it's a driver issue) but
> I've found a workaround: Trigger the resume from initramfs, after
> loading a logo image into the framebuffer and switching it on. That
> gets everything back without corruptions / wrong LCD
> reinitialization.
> 
> The OMAP video seems a bit of a diva; I've got one board type on
> which suspend/resume work perfectly but the omapdss driver spits out
> thousands of error interrupts during system startup (before the
> image is loaded), and the other board where all that is fine but the
> restore somehow garbles the LCD clocking (but the driver's sysfs
> files claim it's the same).
> 
> 
> In short: This stuff really works now, for all I can say. And adding
> support for new type of ARM SoC doesn't touch the basic / generic
> code at all anymore either.
> 
> 
> 
> 
> Anyway ...
> About the patch, changes vs. all previous suggestions:
> 
> * Made the assembly sources as small as I responsibly could ;-)
>   They compile for thumb2 (but I haven't tested that yet) as well.
> 
> * The page copy loop is now a C function. That also has the advantage
>   that one can use cpu_switch_mm() - a macro - there for swapper_pg_dir,
>   which makes resume via uswsusp ioctl or /sys/power/tuxonice/do_resume
>   possible (only tested the latter, though).
> 
> * The SoC state save/restore is made to (re-)use the existing code in
>   sleep....S  for the particular chip.
>   OMAP3 and S5P64xx are provided as examples of that.
> 
> * The save/restore_processor_state() hooks are now used in the same way
>   as e.g. existing powerpc code uses them (to trigger lazy saves before
>   and perform cache flushes after).
> 
> 
> Things that probably aren't perfect yet:
> 
> * The code currently reserves a full page for the saved "core" state.
>   This is more than absolutely necessary; anyone think it's a problem ?
> 
> * it sets aside another half a page of __nosavedata page for use as
>   temporary stack during the image copy (so that funcs can be called).
> 
>   Right now on ARM, that's not an issue because even with TuxOnIce in,
>   there's less than 20 bytes of nosave stuff, so can as well put the
>   rest of that page to good use ;-)
> 
> * I'd love to get rid of the include/asm-generic/vmlinux.lds.h change,
>   as it seems that's not necessary in other architectures.
>   Without that, the code gives a link error when building vmlinux
>   though, and I'm unsure how to address that.
> 
> * The "integration" with the CPU sleep code is rather "backdoorish".
>   While the hooks into ..._cpu_suspend aren't massive, and there's no
>   code duplication, it'd be nicer to eventually have a cleaner way.
> 
> * An OMAPDSS restore troubleshooting HOWTO would be helpful ;-)
> 
> 
> * The patch needs to be rebaselined against a current kernel;
>   any preferences which tree to base this on ?
> 
> 
> 
> Thanks for all help with the little nits !
> FrankH.

>  arch/arm/Kconfig                  |    3 +
>  arch/arm/include/asm/memory.h     |    1 +
>  arch/arm/include/asm/suspend.h    |    6 ++
>  arch/arm/kernel/cpu.c             |   65 ++++++++++++++++++++++++++
>  arch/arm/kernel/swsusp.S          |   92 +++++++++++++++++++++++++++++++++++++
>  arch/arm/kernel/vmlinux.lds.S     |    3 +-
>  include/asm-generic/vmlinux.lds.h |    2 +-
>  7 files changed, 170 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
> index 6b6786c..859dd86 100644
> --- a/arch/arm/Kconfig
> +++ b/arch/arm/Kconfig
> @@ -198,6 +198,9 @@ config VECTORS_BASE
>  config ARCH_HAS_CPU_IDLE_WAIT
>  	def_bool y
>  
> +config ARCH_HIBERNATION_POSSIBLE
> +	def_bool n
> +
>  source "init/Kconfig"
>  
>  source "kernel/Kconfig.freezer"
> diff --git a/arch/arm/include/asm/memory.h b/arch/arm/include/asm/memory.h
> index 5421d82..23e93a6 100644
> --- a/arch/arm/include/asm/memory.h
> +++ b/arch/arm/include/asm/memory.h
> @@ -191,6 +191,7 @@ static inline void *phys_to_virt(unsigned long x)
>   */
>  #define __pa(x)			__virt_to_phys((unsigned long)(x))
>  #define __va(x)			((void *)__phys_to_virt((unsigned long)(x)))
> +#define __pa_symbol(x)		__pa(RELOC_HIDE((unsigned long)(x),0))
>  #define pfn_to_kaddr(pfn)	__va((pfn) << PAGE_SHIFT)
>  
>  /*
> diff --git a/arch/arm/include/asm/suspend.h b/arch/arm/include/asm/suspend.h
> new file mode 100644
> index 0000000..7ab1fd2
> --- /dev/null
> +++ b/arch/arm/include/asm/suspend.h
> @@ -0,0 +1,6 @@
> +#ifndef __ASM_ARM_SUSPEND_H
> +#define __ASM_ARM_SUSPEND_H
> +
> +static inline int arch_prepare_suspend(void) { return 0; }
> +
> +#endif /* __ASM_ARM_SUSPEND_H */
> diff --git a/arch/arm/kernel/cpu.c b/arch/arm/kernel/cpu.c
> new file mode 100644
> index 0000000..764c8fa
> --- /dev/null
> +++ b/arch/arm/kernel/cpu.c
> @@ -0,0 +1,65 @@
> +/*
> + * Hibernation support specific for ARM
> + *
> + * Derived from work on ARM hibernation support by:
> + *
> + * Ubuntu project, hibernation support for mach-dove
> + * Copyright (C) 2010 Nokia Corporation (Hiroshi Doyu)
> + * Copyright (C) 2010 Texas Instruments, Inc. (Teerth Reddy et al.)
> + *	https://lkml.org/lkml/2010/6/18/4
> + *	https://lists.linux-foundation.org/pipermail/linux-pm/2010-June/027422.html
> + *	https://patchwork.kernel.org/patch/96442/
> + *
> + * Copyright (C) 2006 Rafael J. Wysocki <rjw@sisk.pl>
> + *
> + * License terms: GNU General Public License (GPL) version 2
> + */
> +
> +#include <linux/mm.h>
> +#include <linux/sched.h>
> +#include <linux/suspend.h>
> +#include <asm/tlbflush.h>
> +
> +extern const void __nosave_begin, __nosave_end;
> +
> +int pfn_is_nosave(unsigned long pfn)
> +{
> +	unsigned long nosave_begin_pfn = __pa_symbol(&__nosave_begin) >> PAGE_SHIFT;
> +	unsigned long nosave_end_pfn = PAGE_ALIGN(__pa_symbol(&__nosave_end)) >> PAGE_SHIFT;
> +
> +	return (pfn >= nosave_begin_pfn) && (pfn < nosave_end_pfn);
> +}
> +
> +void save_processor_state(void)
> +{
> +	flush_thread();
> +}
> +
> +void restore_processor_state(void)
> +{
> +	local_flush_tlb_all();
> +}
> +
> +u8 __swsusp_arch_ctx[PAGE_SIZE] __attribute__((aligned(PAGE_SIZE)));
> +u8 __swsusp_resume_stk[PAGE_SIZE/2] __nosavedata;
> +
> +/*
> + * The framework loads the hibernation image into this linked list,
> + * for swsusp_arch_resume() to copy back to the proper destinations.
> + *
> + * To make this work if resume is triggered from initramfs, the
> + * pagetables need to be switched to allow writes to kernel mem.
> + */
> +void notrace __swsusp_arch_restore_prepare(void)
> +{
> +	cpu_switch_mm(__virt_to_phys(swapper_pg_dir), current->active_mm);
> +}
> +
> +void notrace __swsusp_arch_restore_image(void)
> +{
> +	extern struct pbe *restore_pblist;
> +	struct pbe *pbe;
> +
> +	for (pbe = restore_pblist; pbe; pbe = pbe->next)
> +		copy_page(pbe->orig_address, pbe->address);
> +}
> diff --git a/arch/arm/kernel/swsusp.S b/arch/arm/kernel/swsusp.S
> new file mode 100644
> index 0000000..fb260a7
> --- /dev/null
> +++ b/arch/arm/kernel/swsusp.S
> @@ -0,0 +1,92 @@
> +/*
> + * Hibernation support specific for ARM
> + *
> + * Based on work by:
> + *
> + * Ubuntu project, hibernation support for mach-dove,
> + * Copyright (C) 2010 Nokia Corporation (Hiroshi Doyu)
> + * Copyright (C) 2010 Texas Instruments, Inc. (Teerth Reddy et al.)
> + *	https://lkml.org/lkml/2010/6/18/4
> + *	https://lists.linux-foundation.org/pipermail/linux-pm/2010-June/027422.html
> + *	https://patchwork.kernel.org/patch/96442/
> + *
> + * Copyright (C) 2006 Rafael J. Wysocki <rjw@sisk.pl>
> + *
> + * License terms: GNU General Public License (GPL) version 2
> + */
> +
> +#include <linux/linkage.h>
> +#include <asm/memory.h>
> +#include <asm/page.h>
> +#include <asm/cache.h>
> +#include <asm/ptrace.h>
> +
> +/*
> + * Save the current CPU state before suspend / poweroff.
> + */
> +ENTRY(swsusp_arch_suspend)
> +	ldr	r0, =__swsusp_arch_ctx
> +	mrs	r1, cpsr
> +	str	r1, [r0], #4		/* CPSR */
> +ARM(	msr	cpsr_c, #SYSTEM_MODE					)
> +THUMB(	mov	r2, #SYSTEM_MODE					)
> +THUMB(	msr	cpsr_c, r2						)

For Thumb-2 kernels, you can use the cps instruction to change the CPU
mode:
	cps	#SYSTEM_MODE

For ARM though, this instruction is only supported for ARMv6 and above,
so it's best to keep the msr form for compatibility for that case.

> +	stm	r0!, {r4-r12,lr}	/* nonvolatile regs */

Since r12 is allowed to be corrupted across a function call, we
probably don't need to save it.

> +	str	sp, [r0], #4
> +ARM(	msr	cpsr_c, #SVC_MODE					)
> +THUMB(	mov	r2, #SVC_MODE						)
> +THUMB(	msr	cpsr_c, r2						)
> +	mrs	r2, spsr
> +	stm	r0!, {r2,lr}		/* SVC SPSR, SVC regs */
> +	str	sp, [r0], #4
> +	msr	cpsr, r1		/* restore mode at entry */
> +	push	{lr}
> +	bl	__save_processor_state

<aside>

Structurally, we seem to have:

swsusp_arch_suspend {
	/* save some processor state */
	__save_processor_state();

	swsusp_save();
}

Is __save_processor_state() intended to encapsulate all the CPU-model-
specific state saving?  Excuse my ignorance of previous conversations...

</aside>

> +	pop	{lr}
> +	b	swsusp_save
> +ENDPROC(swsusp_arch_suspend)

I'm not too familiar with the suspend/resume stuff, so I may be asking
a dumb question here, but:

Where do we save/restore r8_FIQ..r13_FIQ, r13_IRQ, r13_UND and r13_ABT?
(I'm assuming there's no reason to save/restore r14 or SPSR for any
exception mode, since we presumably aren't going to suspend/resume
from inside an exception handler (?))

The exception stack pointers might conceivably be reinitialised to
sane values on resume, without necessarily needing to save/restore
them, providing my assumption in the previous paragraph is correct.

r8_FIQ..r12_FIQ can store arbitrary state used by the FIQ handler,
if FIQ is in use.  Can we expect any driver using FIQ to save/restore
this state itself, rather than doing it globally?  This may be
reasonable.

Cheers
---Dave
