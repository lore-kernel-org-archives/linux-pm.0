From: Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH v2 1/6] arm64: Create sections.h
Date: Thu, 16 Jun 2016 11:52:12 +0100
Message-ID: <20160616105212.GA6073@leverpostej>
References: <1466012148-7674-1-git-send-email-james.morse@arm.com>
 <1466012148-7674-2-git-send-email-james.morse@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:42925 "EHLO foss.arm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752424AbcFPKwj (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Thu, 16 Jun 2016 06:52:39 -0400
Content-Disposition: inline
In-Reply-To: <1466012148-7674-2-git-send-email-james.morse@arm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: James Morse <james.morse@arm.com>
Cc: linux-arm-kernel@lists.infradead.org, Will Deacon <will.deacon@arm.com>, Catalin Marinas <catalin.marinas@arm.com>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Pavel Machek <pavel@ucw.cz>, linux-pm@vger.kernel.org, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>

On Wed, Jun 15, 2016 at 06:35:43PM +0100, James Morse wrote:
> Each time new section markers are added, kernel/vmlinux.ld.S is updated,
> and new extern char __start_foo[] definitions are scattered through the
> tree.
> 
> Create asm/include/sections.h to collect these definitions (and include
> the existing asm-generic version).
> 
> Signed-off-by: James Morse <james.morse@arm.com>

This looks right to me, and a defconfig kernel builds cleanly with this
applied. FWIW:

Reviewed-by: Mark Rutland <mark.rutland@arm.com>
Tested-by: Mark Rutland <mark.rutland@arm.com>

Mark.

> ---
> Changes since v1:
>  * Removed text_text markers,
>  * Sorted sections.h
> 
>  arch/arm64/include/asm/Kbuild     |  1 -
>  arch/arm64/include/asm/sections.h | 28 ++++++++++++++++++++++++++++
>  arch/arm64/include/asm/traps.h    |  3 +--
>  arch/arm64/include/asm/virt.h     |  5 +----
>  arch/arm64/kernel/alternative.c   |  7 +++----
>  arch/arm64/kernel/hibernate.c     |  6 ------
>  arch/arm64/kvm/reset.c            |  3 +--
>  7 files changed, 34 insertions(+), 19 deletions(-)
>  create mode 100644 arch/arm64/include/asm/sections.h
> 
> diff --git a/arch/arm64/include/asm/Kbuild b/arch/arm64/include/asm/Kbuild
> index cff532a6744e..50c1f646b704 100644
> --- a/arch/arm64/include/asm/Kbuild
> +++ b/arch/arm64/include/asm/Kbuild
> @@ -33,7 +33,6 @@ generic-y += poll.h
>  generic-y += preempt.h
>  generic-y += resource.h
>  generic-y += rwsem.h
> -generic-y += sections.h
>  generic-y += segment.h
>  generic-y += sembuf.h
>  generic-y += serial.h
> diff --git a/arch/arm64/include/asm/sections.h b/arch/arm64/include/asm/sections.h
> new file mode 100644
> index 000000000000..cb68eb348566
> --- /dev/null
> +++ b/arch/arm64/include/asm/sections.h
> @@ -0,0 +1,28 @@
> +/*
> + * Copyright (C) 2016 ARM Limited
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
> +#ifndef __ASM_SECTIONS_H
> +#define __ASM_SECTIONS_H
> +
> +#include <asm-generic/sections.h>
> +
> +extern char __alt_instructions[], __alt_instructions_end[];
> +extern char __exception_text_start[], __exception_text_end[];
> +extern char __hibernate_exit_text_start[], __hibernate_exit_text_end[];
> +extern char __hyp_idmap_text_start[], __hyp_idmap_text_end[];
> +extern char __hyp_text_start[], __hyp_text_end[];
> +extern char __idmap_text_start[], __idmap_text_end[];
> +
> +#endif /* __ASM_SECTIONS_H */
> diff --git a/arch/arm64/include/asm/traps.h b/arch/arm64/include/asm/traps.h
> index 0cc2f29bf9da..90156c803f11 100644
> --- a/arch/arm64/include/asm/traps.h
> +++ b/arch/arm64/include/asm/traps.h
> @@ -19,6 +19,7 @@
>  #define __ASM_TRAP_H
>  
>  #include <linux/list.h>
> +#include <asm/sections.h>
>  
>  struct pt_regs;
>  
> @@ -52,8 +53,6 @@ static inline int __in_irqentry_text(unsigned long ptr)
>  
>  static inline int in_exception_text(unsigned long ptr)
>  {
> -	extern char __exception_text_start[];
> -	extern char __exception_text_end[];
>  	int in;
>  
>  	in = ptr >= (unsigned long)&__exception_text_start &&
> diff --git a/arch/arm64/include/asm/virt.h b/arch/arm64/include/asm/virt.h
> index dcbcf8dcbefb..b78611157f8b 100644
> --- a/arch/arm64/include/asm/virt.h
> +++ b/arch/arm64/include/asm/virt.h
> @@ -40,6 +40,7 @@
>  #ifndef __ASSEMBLY__
>  
>  #include <asm/ptrace.h>
> +#include <asm/sections.h>
>  
>  /*
>   * __boot_cpu_mode records what mode CPUs were booted in.
> @@ -82,10 +83,6 @@ extern void verify_cpu_run_el(void);
>  static inline void verify_cpu_run_el(void) {}
>  #endif
>  
> -/* The section containing the hypervisor text */
> -extern char __hyp_text_start[];
> -extern char __hyp_text_end[];
> -
>  #endif /* __ASSEMBLY__ */
>  
>  #endif /* ! __ASM__VIRT_H */
> diff --git a/arch/arm64/kernel/alternative.c b/arch/arm64/kernel/alternative.c
> index d2ee1b21a10d..4434dabde898 100644
> --- a/arch/arm64/kernel/alternative.c
> +++ b/arch/arm64/kernel/alternative.c
> @@ -25,14 +25,13 @@
>  #include <asm/alternative.h>
>  #include <asm/cpufeature.h>
>  #include <asm/insn.h>
> +#include <asm/sections.h>
>  #include <linux/stop_machine.h>
>  
>  #define __ALT_PTR(a,f)		(u32 *)((void *)&(a)->f + (a)->f)
>  #define ALT_ORIG_PTR(a)		__ALT_PTR(a, orig_offset)
>  #define ALT_REPL_PTR(a)		__ALT_PTR(a, alt_offset)
>  
> -extern struct alt_instr __alt_instructions[], __alt_instructions_end[];
> -
>  struct alt_region {
>  	struct alt_instr *begin;
>  	struct alt_instr *end;
> @@ -124,8 +123,8 @@ static int __apply_alternatives_multi_stop(void *unused)
>  {
>  	static int patched = 0;
>  	struct alt_region region = {
> -		.begin	= __alt_instructions,
> -		.end	= __alt_instructions_end,
> +		.begin	= (struct alt_instr *)__alt_instructions,
> +		.end	= (struct alt_instr *)__alt_instructions_end,
>  	};
>  
>  	/* We always have a CPU 0 at this point (__init) */
> diff --git a/arch/arm64/kernel/hibernate.c b/arch/arm64/kernel/hibernate.c
> index f8df75d740f4..56e548fe0386 100644
> --- a/arch/arm64/kernel/hibernate.c
> +++ b/arch/arm64/kernel/hibernate.c
> @@ -52,12 +52,6 @@ extern int in_suspend;
>  /* Do we need to reset el2? */
>  #define el2_reset_needed() (is_hyp_mode_available() && !is_kernel_in_hyp_mode())
>  
> -/*
> - * Start/end of the hibernate exit code, this must be copied to a 'safe'
> - * location in memory, and executed from there.
> - */
> -extern char __hibernate_exit_text_start[], __hibernate_exit_text_end[];
> -
>  /* temporary el2 vectors in the __hibernate_exit_text section. */
>  extern char hibernate_el2_vectors[];
>  
> diff --git a/arch/arm64/kvm/reset.c b/arch/arm64/kvm/reset.c
> index b1ad730e1567..c2d3594dd546 100644
> --- a/arch/arm64/kvm/reset.c
> +++ b/arch/arm64/kvm/reset.c
> @@ -32,6 +32,7 @@
>  #include <asm/kvm_asm.h>
>  #include <asm/kvm_coproc.h>
>  #include <asm/kvm_mmu.h>
> +#include <asm/sections.h>
>  
>  /*
>   * ARMv8 Reset Values
> @@ -133,8 +134,6 @@ int kvm_reset_vcpu(struct kvm_vcpu *vcpu)
>  	return kvm_timer_vcpu_reset(vcpu, cpu_vtimer_irq);
>  }
>  
> -extern char __hyp_idmap_text_start[];
> -
>  unsigned long kvm_hyp_reset_entry(void)
>  {
>  	if (!__kvm_cpu_uses_extended_idmap()) {
> -- 
> 2.8.0.rc3
> 
