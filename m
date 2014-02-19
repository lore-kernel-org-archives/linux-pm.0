From: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Subject: Re: [PATCH v4 04/13] ARM: mvebu: Remove the unused argument of
 set_cpu_coherent()
Date: Wed, 19 Feb 2014 17:27:48 +0100
Message-ID: <20140219172748.0b7ab37f@skate>
References: <1392312816-17657-1-git-send-email-gregory.clement@free-electrons.com>
	<1392312816-17657-5-git-send-email-gregory.clement@free-electrons.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from top.free-electrons.com ([176.31.233.9]:50645 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753654AbaBSQ1v (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 19 Feb 2014 11:27:51 -0500
In-Reply-To: <1392312816-17657-5-git-send-email-gregory.clement@free-electrons.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Gregory CLEMENT <gregory.clement@free-electrons.com>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>, "Rafael J. Wysocki" <rjw@sisk.pl>, linux-pm@vger.kernel.org, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Jason Cooper <jason@lakedaemon.net>, Andrew Lunn <andrew@lunn.ch>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, Lior Amsalem <alior@marvell.com>, Tawfik Bayouk <tawfik@marvell.com>, Nadav Haklai <nadavh@marvell.com>, Ezequiel Garcia <ezequiel.garcia@free-electrons.com>, linux-arm-kernel@lists.infradead.org

Dear Gregory CLEMENT,

On Thu, 13 Feb 2014 18:33:27 +0100, Gregory CLEMENT wrote:
> set_cpu_coherent() took the SMP group ID as parameter. But this
> parameter was never used, and the CPU always use the SMP group 0. So
> we can remove this parameter.
> 
> Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>

This patch does much more than what the title and commit log says. The
title and commit log says the patch is removing the useless parameter
of set_cpu_coherent(), which I'm fine with.

But this patch also renames ll_set_cpu_coherent() to
ll_set_cpu_coherent_and_smp(), introduces the modify_coherent_reg
macro, etc.

And actually, I'm really unhappy about this modify_coherent_reg macro.
It is a large blurb of assembly with some conditions in the middle. I
have already stated this in previous reviews of this patch series, but
you have not taken into account my comments: this stuff should be split
in separate functions, each function doing *one* thing, and then those
functions are called in sequence depending on what needs to be done
whether you're starting a secondary CPU, entering or exiting deep idle,
etc.

Here is what I would prefer to see:

/* Returns with r1 filled with the coherency base address */
ENTRY(ll_get_coherency_base)
	mrc	p15, 0, r1, c1, c0, 0
	tst	r1, #CR_M @ Check MMU bit enabled
	bne	1f

	/* use physical address of the coherency register */
	adr	r1, 3f
	ldr	r3, [r1]
	ldr	r1, [r1, r3]
	b	2f
1:
	/* use virtual address of the coherency register */
	ldr	r1, =coherency_base
	ldr	r1, [r1]
2:
	mov	pc, lr
ENDPROC(ll_get_coherency_base)

/* Returns with the CPU ID in r3 */
ENTRY(ll_get_cpuid)
	mrc	15, 0, r3, cr0, cr0, 5
	and	r3, r3, #15
	mov	r2, #(1 << 24)
	lsl	r3, r2, r3
	ARM_BE8(rev	r3, r3)
	mov	pc, lr
ENDPROC(ll_get_cpuid)

ENTRY(ll_add_cpu_to_smp_group)
	bl	ll_get_coherency_base
	bl	ll_get_cpuid
	add	r0, r1, #ARMADA_XP_CFB_CFG_REG_OFFSET
1:
	ldrex	r2, [r0]
	orr	r2, r2, r3
	strex	r1, r2, [r0]
	cmp	r1, #0
	bne	1b
	mov	pc, lr
ENDPROC(ll_add_cpu_to_smp_group)

ENTRY(ll_enable_coherency)
	bl	ll_get_coherency_base
	bl	ll_get_cpuid
	add	r0, r1, #ARMADA_XP_CFB_CTL_REG_OFFSET
1:
	ldrex	r2, [r0]
	orr	r2, r2, r3
	strex	r1, r2, [r0]
	cmp	r1, #0
	bne	1b
	dsb
	mov	pc, lr
ENDPROC(ll_enable_coherency)

ENTRY(ll_disable_coherency)
	bl	ll_get_coherency_base
	bl	ll_get_cpuid
	add	r0, r1, #ARMADA_XP_CFB_CTL_REG_OFFSET
1:
	ldrex	r2, [r0]
	bic	r2, r2, r3
	strex	r1, r2, [r0]
	cmp	r1, #0
	bne	1b
	dsb
	mov	pc, lr
ENDPROC(ll_disable_coherency)

And then, your C code calls ll_disable_coherency(),
ll_enable_coherency() and/or ll_add_cpu_to_smp_group().

An alternative solution is to implement more of this stuff in C, with
only a small helper function in assembly to do the atomic bit set or
clear magic:

/* First argument:  address
   Second argument: bit mask 
*/
ENTRY(ll_atomic_bit_set)
1:
	ldrex	r2, [r0]
	orr	r2, r2, r1
	strex	r3, r2, [r0]
	cmp	r3, #0
	bne	1b
	dsb
	mov	pc, lr
ENDPROC(ll_atomic_bit_set)

ENTRY(ll_atomic_bit_clear)
1:
	ldrex	r2, [r0]
	bic	r2, r2, r1
	strex	r3, r2, [r0]
	cmp	r3, #0
	bne	1b
	dsb
	mov	pc, lr
ENDPROC(ll_atomic_bit_clear)

Thomas
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
