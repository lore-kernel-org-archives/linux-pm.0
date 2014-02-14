From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Subject: Re: [PATCH v4 01/13] ARM: PJ4B: Add cpu_suspend/cpu_resume hooks for
 PJ4B
Date: Fri, 14 Feb 2014 16:06:36 +0000
Message-ID: <20140214160636.GC25043@e102568-lin.cambridge.arm.com>
References: <1392312816-17657-1-git-send-email-gregory.clement@free-electrons.com>
 <1392312816-17657-2-git-send-email-gregory.clement@free-electrons.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: 8BIT
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from service87.mimecast.com ([91.220.42.44]:54162 "EHLO
	service87.mimecast.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751772AbaBNQGm convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 14 Feb 2014 11:06:42 -0500
In-Reply-To: <1392312816-17657-2-git-send-email-gregory.clement@free-electrons.com>
Content-Disposition: inline
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Gregory CLEMENT <gregory.clement@free-electrons.com>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>, "Rafael J. Wysocki" <rjw@sisk.pl>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Jason Cooper <jason@lakedaemon.net>, Andrew Lunn <andrew@lunn.ch>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, Ezequiel Garcia <ezequiel.garcia@free-electrons.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Lior Amsalem <alior@marvell.com>, Tawfik Bayouk <tawfik@marvell.com>, Nadav Haklai <nadavh@marvell.com>, Russell King <linux@arm.linux.org.uk>

Hi Gregory,

On Thu, Feb 13, 2014 at 05:33:24PM +0000, Gregory CLEMENT wrote:
> PJ4B needs extra instructions for suspend and resume, so instead of
> using the armv7 version, this commit introduces specific versions for
> PJ4B.
> 
> Cc: Russell King <linux@arm.linux.org.uk>
> Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
> ---
>  arch/arm/mm/proc-v7.S | 64 ++++++++++++++++++++++++++++++++++++++++++++++++---
>  1 file changed, 61 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/arm/mm/proc-v7.S b/arch/arm/mm/proc-v7.S
> index bd1781979a39..11117423a9b4 100644
> --- a/arch/arm/mm/proc-v7.S
> +++ b/arch/arm/mm/proc-v7.S
> @@ -169,9 +169,67 @@ ENDPROC(cpu_pj4b_do_idle)
>  	globl_equ	cpu_pj4b_do_idle,  	cpu_v7_do_idle
>  #endif
>  	globl_equ	cpu_pj4b_dcache_clean_area,	cpu_v7_dcache_clean_area
> -	globl_equ	cpu_pj4b_do_suspend,	cpu_v7_do_suspend
> -	globl_equ	cpu_pj4b_do_resume,	cpu_v7_do_resume
> -	globl_equ	cpu_pj4b_suspend_size,	cpu_v7_suspend_size
> +#ifdef CONFIG_ARM_CPU_SUSPEND
> +ENTRY(cpu_pj4b_do_suspend)
> +	stmfd	sp!, {r4 - r10, lr}
> +	mrc	p15, 0, r4, c13, c0, 0	@ FCSE/PID
> +	mrc	p15, 0, r5, c13, c0, 3	@ User r/o thread ID
> +	stmia	r0!, {r4 - r5}
> +	mrc	p15, 1, r6, c15, c1, 0  @ save CP15 - extra features
> +	mrc	p15, 1, r7, c15, c2, 0	@ save CP15 - Aux Func Modes Ctrl 0
> +	mrc	p15, 1, r8, c15, c1, 2	@ save CP15 - Aux Debug Modes Ctrl 2
> +	mrc	p15, 1, r9, c15, c1, 1  @ save CP15 - Aux Debug Modes Ctrl 1
> +	mrc	p15, 0, r10, c9, c14, 0  @ save CP15 - PMC
> +	stmia	r0!, {r6 - r10}
> +	mrc	p15, 0, r6, c3, c0, 0	@ Domain ID
> +	mrc	p15, 0, r7, c2, c0, 1	@ TTB 1
> +	mrc	p15, 0, r11, c2, c0, 2	@ TTB control register
> +	mrc	p15, 0, r8, c1, c0, 0	@ Control register
> +	mrc	p15, 0, r9, c1, c0, 1	@ Auxiliary control register
> +	mrc	p15, 0, r10, c1, c0, 2	@ Co-processor access control
> +	stmia	r0, {r6 - r11}
> +	ldmfd	sp!, {r4 - r10, pc}
> +ENDPROC(cpu_pj4b_do_suspend)
> +
> +ENTRY(cpu_pj4b_do_resume)
> +	mov	ip, #0
> +	mcr	p15, 0, ip, c7, c5, 0	@ invalidate I cache
> +	mcr	p15, 0, ip, c13, c0, 1	@ set reserved context ID
> +	ldmia	r0!, {r4 - r5}
> +	mcr	p15, 0, r4, c13, c0, 0	@ FCSE/PID
> +	mcr	p15, 0, r5, c13, c0, 3	@ User r/o thread ID
> +	ldmia	r0!, {r6 - r10}
> +	mcr	p15, 1, r6, c15, c1, 0  @ save CP15 - extra features
> +	mcr	p15, 1, r7, c15, c2, 0	@ save CP15 - Aux Func Modes Ctrl 0
> +	mcr	p15, 1, r8, c15, c1, 2	@ save CP15 - Aux Debug Modes Ctrl 2
> +	mcr	p15, 1, r9, c15, c1, 1  @ save CP15 - Aux Debug Modes Ctrl 1
> +	mcr	p15, 0, r10, c9, c14, 0  @ save CP15 - PMC
> +	ldmia	r0, {r6 - r11}
> +	mcr	p15, 0, ip, c8, c7, 0	@ invalidate TLBs
> +	mcr	p15, 0, r6, c3, c0, 0	@ Domain ID
> +#ifndef CONFIG_ARM_LPAE
> +	ALT_SMP(orr	r1, r1, #TTB_FLAGS_SMP)
> +	ALT_UP(orr	r1, r1, #TTB_FLAGS_UP)
> +#endif
> +	mcr	p15, 0, r1, c2, c0, 0	@ TTB 0
> +	mcr	p15, 0, r7, c2, c0, 1	@ TTB 1
> +	mcr	p15, 0, r11, c2, c0, 2	@ TTB control register
> +	ldr	r4, =PRRR		@ PRRR
> +	ldr	r5, =NMRR		@ NMRR
> +	mcr	p15, 0, r4, c10, c2, 0	@ write PRRR
> +	mcr	p15, 0, r5, c10, c2, 1	@ write NMRR
> +	mrc	p15, 0, r4, c1, c0, 1	@ Read Auxiliary control register
> +	teq	r4, r9			@ Is it already set?
> +	mcrne	p15, 0, r9, c1, c0, 1	@ No, so write it
> +	mcr	p15, 0, r10, c1, c0, 2	@ Co-processor access control
> +	isb
> +	dsb
> +	mov	r0, r8			@ control register
> +	b	cpu_resume_mmu
> +ENDPROC(cpu_pj4b_do_resume)
> +#endif
> +.globl	cpu_pj4b_suspend_size
> +.equ	cpu_pj4b_suspend_size, 4 * 13
>  
>  #endif

A couple of questions:

1) Do the extra registers ever change after coldboot ?
2) Do you need to restore them before turning the MMU and caches on ?
3) Most of the code is copy'n'paste from v7, is not it possible to reuse
   that code by doing processor specific save/restore and then jump to
   the v7 functions ?

Thanks,
Lorenzo

