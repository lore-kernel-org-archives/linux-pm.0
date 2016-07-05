From: Catalin Marinas <catalin.marinas@arm.com>
Subject: Re: [PATCH v4 2/3] arm64: hibernate: Resume when hibernate image
 created on non-boot CPU
Date: Tue, 5 Jul 2016 18:49:01 +0100
Message-ID: <20160705174901.GK3565@e104818-lin.cambridge.arm.com>
References: <1467643950-11034-1-git-send-email-james.morse@arm.com>
 <1467643950-11034-3-git-send-email-james.morse@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:54358 "EHLO foss.arm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752862AbcGERtG (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Tue, 5 Jul 2016 13:49:06 -0400
Content-Disposition: inline
In-Reply-To: <1467643950-11034-3-git-send-email-james.morse@arm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: James Morse <james.morse@arm.com>
Cc: linux-pm@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Chen Yu C <yu.c.chen@intel.com>, Will Deacon <will.deacon@arm.com>, Pavel Machek <pavel@ucw.cz>, linux-arm-kernel@lists.infradead.org

On Mon, Jul 04, 2016 at 03:52:29PM +0100, James Morse wrote:
> diff --git a/arch/arm64/include/asm/suspend.h b/arch/arm64/include/asm/suspend.h
> index 024d623f662e..9b3e8d9bfc8c 100644
> --- a/arch/arm64/include/asm/suspend.h
> +++ b/arch/arm64/include/asm/suspend.h
> @@ -47,4 +47,8 @@ int swsusp_arch_resume(void);
>  int arch_hibernation_header_save(void *addr, unsigned int max_size);
>  int arch_hibernation_header_restore(void *addr);
>  
> +/* Used to resume on the CPU we hibernated on */
> +int _arch_hibernation_disable_cpus(bool suspend);
> +#define arch_hibernation_disable_cpus(x) _arch_hibernation_disable_cpus(x)

Nitpick: we normally tend to use the same name for the function an macro
but it's fine like this as well:

+int arch_hibernation_disable_cpus(bool suspend);
+#define arch_hibernation_disable_cpus arch_hibernation_disable_cpus

BTW, do you expect an architecture to define ARCH_HIBERNATION_CPU_HOOKS
but not arch_hibernation_disable_cpus? Or you'd expect more hooks in the
future?

> diff --git a/arch/arm64/kernel/hibernate.c b/arch/arm64/kernel/hibernate.c
> index 21ab5df9fa76..bae45abde7a2 100644
> --- a/arch/arm64/kernel/hibernate.c
> +++ b/arch/arm64/kernel/hibernate.c
> @@ -15,6 +15,7 @@
>   * License terms: GNU General Public License (GPL) version 2
>   */
>  #define pr_fmt(x) "hibernate: " x
> +#include <linux/cpu.h>
>  #include <linux/kvm_host.h>
>  #include <linux/mm.h>
>  #include <linux/notifier.h>
> @@ -26,6 +27,7 @@
>  
>  #include <asm/barrier.h>
>  #include <asm/cacheflush.h>
> +#include <asm/cputype.h>
>  #include <asm/irqflags.h>
>  #include <asm/memory.h>
>  #include <asm/mmu_context.h>
> @@ -34,6 +36,7 @@
>  #include <asm/pgtable-hwdef.h>
>  #include <asm/sections.h>
>  #include <asm/smp.h>
> +#include <asm/smp_plat.h>
>  #include <asm/suspend.h>
>  #include <asm/virt.h>
>  
> @@ -66,6 +69,12 @@ extern char hibernate_el2_vectors[];
>  extern char __hyp_stub_vectors[];
>  
>  /*
> + * The logical cpu number we should resume on, initialised to a non-cpu
> + * number.
> + */
> +static int sleep_cpu = -EINVAL;
> +
> +/*
>   * Values that may not change over hibernate/resume. We put the build number
>   * and date in here so that we guarantee not to resume with a different
>   * kernel.
> @@ -87,6 +96,8 @@ static struct arch_hibernate_hdr {
>  	 * re-configure el2.
>  	 */
>  	phys_addr_t	__hyp_stub_vectors;
> +
> +	u64		sleep_cpu_mpidr;
>  } resume_hdr;
>  
>  static inline void arch_hdr_invariants(struct arch_hibernate_hdr_invariants *i)
> @@ -129,12 +140,18 @@ int arch_hibernation_header_save(void *addr, unsigned int max_size)
>  	else
>  		hdr->__hyp_stub_vectors = 0;
>  
> +	/* Save the mpidr of the cpu we called cpu_suspend() on... */
> +	hdr->sleep_cpu_mpidr = cpu_logical_map(sleep_cpu);
> +	pr_info("Hibernating on CPU %d [mpidr:0x%llx]\n", sleep_cpu,
> +		hdr->sleep_cpu_mpidr);

Do we have a guarantee that sleep_cpu != -EINVAL here?

If the above is fine, feel free to add:

Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
