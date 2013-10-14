From: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Subject: Re: [PATCH v3 11/14] ARM: mvebu: Add CPU idle low level support for
 Marvell Armada XP
Date: Mon, 14 Oct 2013 18:28:13 +0200
Message-ID: <20131014182813.677ca24e@skate>
References: <1381759106-15004-1-git-send-email-gregory.clement@free-electrons.com>
	<1381759106-15004-12-git-send-email-gregory.clement@free-electrons.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from top.free-electrons.com ([176.31.233.9]:33983 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1756196Ab3JNQ2T (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 14 Oct 2013 12:28:19 -0400
In-Reply-To: <1381759106-15004-12-git-send-email-gregory.clement@free-electrons.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Gregory CLEMENT <gregory.clement@free-electrons.com>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>, "Rafael J. Wysocki" <rjw@sisk.pl>, linux-pm@vger.kernel.org, lorenzo.pieralisi@arm.com, Jason Cooper <jason@lakedaemon.net>, Andrew Lunn <andrew@lunn.ch>, Ezequiel Garcia <ezequiel.garcia@free-electrons.com>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, linux-arm-kernel@lists.infradead.org, Nicolas Pitre <nico@fluxnic.net>, Lior Amsalem <alior@marvell.com>, Maen Suleiman <maen@marvell.com>, Tawfik Bayouk <tawfik@marvell.com>, Shadi Ammouri <shadi@marvell.com>, Eran Ben-Avi <benavi@marvell.com>, Yehuda Yitschak <yehuday@marvell.com>, Nadav Haklai <nadavh@marvell.com>, Ike Pan <ike.pan@canonical.com>, Dan Frazier <dann.frazier@canonical.com>, Leif Lindholm <leif.lindholm@arm.com>, Jon Masters <jcm@redhat.com>, David Marlin <dmarlin@redhat.com>

Dear Gregory CLEMENT,

On Mon, 14 Oct 2013 15:58:23 +0200, Gregory CLEMENT wrote:
> This commit adds the low level implementation of CPU Idle.
> Currently only Armada XP is supported, but the support
> will be extended for Armada 370.
> 
> Based on the work of Nadav Haklai.
> 
> Signed-off-by: Nadav Haklai <nadavh@marvell.com>
> Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
> ---
>  arch/arm/mach-mvebu/Makefile                |  1 +
>  arch/arm/mach-mvebu/suspend-armada-370-xp.S | 90 +++++++++++++++++++++++++++++

I know Daniel rejected this file from being part of drivers/cpuidle/,
but this seems weird to me. We're trying to put as much driver code as
possible to the respective drivers/ directory, and this code is really
part of the cpuidle driver itself. I know there isn't a single .S file
for now in drivers/cpuidle, but at least the cpuidle-calxeda.c file
already has some inline assembly statements.

>  2 files changed, 91 insertions(+)
>  create mode 100644 arch/arm/mach-mvebu/suspend-armada-370-xp.S
> 
> diff --git a/arch/arm/mach-mvebu/Makefile b/arch/arm/mach-mvebu/Makefile
> index 2d04f0e..9cd2705 100644
> --- a/arch/arm/mach-mvebu/Makefile
> +++ b/arch/arm/mach-mvebu/Makefile
> @@ -8,3 +8,4 @@ obj-$(CONFIG_MACH_ARMADA_370_XP) += armada-370-xp.o
>  obj-$(CONFIG_ARCH_MVEBU)	 += coherency.o coherency_ll.o pmsu.o
>  obj-$(CONFIG_SMP)                += platsmp.o headsmp.o
>  obj-$(CONFIG_HOTPLUG_CPU)        += hotplug.o
> +obj-$(CONFIG_ARM_ARMADA_370_XP_CPUIDLE) += suspend-armada-370-xp.o

I find it weird to have a Kconfig option from drivers/cpuidle/
affecting the build of things in arch/arm/mach-mvebu/, no?

> diff --git a/arch/arm/mach-mvebu/suspend-armada-370-xp.S b/arch/arm/mach-mvebu/suspend-armada-370-xp.S
> new file mode 100644
> index 0000000..5f01a68
> --- /dev/null
> +++ b/arch/arm/mach-mvebu/suspend-armada-370-xp.S
> @@ -0,0 +1,90 @@
> +/*
> + * CPU idle low level implementation for Marvell Armada 370 and Armada XP SoCs

But the Armada 370 implementation is not there yet, maybe worth
updating the comment to mention that (but keep the indication that
Armada 370 support should come, otherwise the name of the source file
seems a bit strange).

> + *
> + * Copyright (C) 2013 Marvell
> + *
> + * Nadav Haklai <nadavh@marvell.com>
> + *
> + * This file is licensed under the terms of the GNU General Public
> + * License version 2.  This program is licensed "as is" without any
> + * warranty of any kind, whether express or implied.
> + *
> + */
> +#include <linux/linkage.h>
> +
> +/*
> +* armadaxp_cpu_suspend: enter cpu deepIdle state

The name of the function in this comment doesn't match the name of the
function you've chosen below. Please don't re-use vendor code without
checking and rewording the comments as appropriate.

> +* input:
> +*/
> +ENTRY(armada_370_xp_cpu_suspend)

To me "cpu_suspend" sounds like "suspend/resume", not like cpuidle. Is
this routine also going to be used during a suspend/resume cycle, which
would explain its name?

> +/* Save ARM registers */
> +	stmfd	sp!, {r4 - r11, lr}	@ save registers on stack

The first comment is badly aligned, and duplicates the comment after
the @. Generally speaking, this file seems to hesitate between using @
and /* ... */ for comments. Make a decision, and stick to it, if
possible.

> +
> +	bl armada_370_xp_pmsu_idle_prepare
> +	/*

I'd like to have one empty line before comments.

> +	 * Invalidate L1 data cache. Even though only invalidate is
> +	 * necessary exported flush API is used here. Doing clean
> +	 * on already clean cache would be almost NOP.
> +	 */
> +	bl v7_flush_dcache_all
> +
> +	/*
> +	 * Clear the SCTLR.C bit to prevent further data cache
> +	 * allocation. Clearing SCTLR.C would make all the data accesses
> +	 * strongly ordered and would not hit the cache.
> +	 */
> +	mrc	p15, 0, r0, c1, c0, 0
> +	bic	r0, r0, #(1 << 2)	@ Disable the C bit
> +	mcr	p15, 0, r0, c1, c0, 0
> +	isb
> +
> +	bl v7_flush_dcache_all
> +
> +	/* Data memory barrier and Data sync barrier */
> +	dsb
> +	dmb

They are not in the order of the comment, and the comment seems quite
useless: instead of saying *what* the code is doing, it should explain
*why* the code is doing this. The fact that a dmb is a Data Memory
Barrier and a dsb is a Data Sync Barrier is already carried by the
instruction names themselves.

> +
> +	bl armada_370_xp_disable_snoop_ena
> +
> +	dsb				@ Data Synchronization Barrier

Same comment as above.

> +
> +/*
> + * ===================================
> + * == WFI instruction => Enter idle ==
> + * ===================================
> + */

This comment doesn't really look like mainline style, but vendor-style.
Please get rid of this, especially since we know what the wfi
instruction is, or just a:

	/* Enter idle now */
	wfi

> +
> +	wfi				@ wait for interrupt
> +/*
> + * ===================================
> + * == Resume path for non-OFF modes ==
> + * ===================================
> + */

Ditto, just something like:

	/*
         * For all non-OFF modes, we're getting out of idle here. For
	 * OFF modes, what happens is ...
	 */

this is a little bit more useful.

> +
> +/* Enable SnoopEna - Exclusive */

Please align comment and code.

> +	mov	r0, #1			@ r0!=0 means use virtual address
> +	mov	r1, #0			@ Do not add CPU to SMP group
> +	bl ll_set_cpu_coherent

As per comments on the previous patches, I'm not happy with this. Just
make ll_set_cpu_coherent only add to the coherency fabric and not to
the SMP group, and make it detect automatically if it needs to use the
virtual address or not.

Also, intend the name of the function with the other arguments of
assembly instructions.

> +/* Re-enable C-bit if needed */

Please align comment and code.

> +	mrc	p15, 0, r0, c1, c0, 0
> +	tst	r0, #(1 << 2)		@ Check C bit enabled?
> +	orreq	r0, r0, #(1 << 2)	@ Enable the C bit if cleared
> +	mcreq	p15, 0, r0, c1, c0, 0
> +	isb
> +
> +	ldmfd	sp!, {r4 - r11, pc}	@ restore regs and return
> +ENDPROC(armada_370_xp_cpu_suspend)
> +
> +/*
> +* armada_370_xp_cpu_resume: exit cpu deepIdle state
> +*/

So I guess this is where we're ending if we enter one of those "OFF"
idle states. Probably worth mentioning it here.

> +ENTRY(armada_370_xp_cpu_resume)
> +	mov	r0, #0			@ r0==0 means use physical address
> +	mov	r1, #1			@ Add CPU to SMP group
> +	bl ll_set_cpu_coherent

Same comment as above + intend the name of the function with the other
arguments of assembly instructions.

> +
> +	/* Now branch to the common CPU resume function */
> +	b	cpu_resume
> +
> +ENDPROC(armada_370_xp_cpu_resume)

Thanks,

Thomas
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
