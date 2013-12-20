From: Leo Yan <leoy@marvell.com>
Subject: Re: [PATCH RFC v3 04/12] arm64: kernel: cpu_{suspend/resume} implementation
Date: Fri, 20 Dec 2013 19:30:16 +0800
Message-ID: <52B42A48.5090202@marvell.com>
References: <1385033059-25896-1-git-send-email-lorenzo.pieralisi@arm.com> <1385033059-25896-5-git-send-email-lorenzo.pieralisi@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mx0b-0016f401.pphosted.com ([67.231.156.173]:30289 "EHLO
	mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756251Ab3LTLdF (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 20 Dec 2013 06:33:05 -0500
In-Reply-To: <1385033059-25896-5-git-send-email-lorenzo.pieralisi@arm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org
Cc: Mark Rutland <mark.rutland@arm.com>, Feng Kan <fkan@apm.com>, Stephen Boyd <sboyd@codeaurora.org>, Russell King <linux@arm.linux.org.uk>, Graeme Gregory <graeme.gregory@linaro.org>, Nicolas Pitre <nico@linaro.org>, Marc Zyngier <marc.zyngier@arm.com>, Catalin Marinas <catalin.marinas@arm.com>, Yu Tang <ytang5@marvell.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, Will Deacon <will.deacon@arm.com>, Christoffer Dall <christoffer.dall@linaro.org>, Sudeep KarkadaNagesha <sudeep.karkadanagesha@arm.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>, Loc Ho <lho@apm.com>, Colin Cross <ccross@android.com>, Kumar Sankaran <ksankaran@apm.com>, Dave Martin <dave.martin@arm.com>, Hanjun Guo <hanjun.guo@linaro.org>, Zhou Zhu <zzhu3@marvell.com>

On 11/21/2013 07:24 PM, Lorenzo Pieralisi wrote:

> +/*
> + * x0 must contain the sctlr value retrieved from restored context
> + */
> +ENTRY(cpu_resume_mmu)
> +	ldr	x3, =cpu_resume_after_mmu
> +	msr	sctlr_el1, x0		// restore sctlr_el1
> +	isb
> +	br	x3			// global jump to virtual address
> +ENDPROC(cpu_resume_mmu)
> +cpu_resume_after_mmu:
> +	mov	x0, #0			// return zero on success
> +	ldp	x19, x20, [sp, #16]
> +	ldp	x21, x22, [sp, #32]
> +	ldp	x23, x24, [sp, #48]
> +	ldp	x25, x26, [sp, #64]
> +	ldp	x27, x28, [sp, #80]
> +	ldp	x29, lr, [sp], #96
> +	ret
> +ENDPROC(cpu_resume_after_mmu)
> +
> +	.data
> +ENTRY(cpu_resume)
> +	bl	el2_setup		// if in EL2 drop to EL1 cleanly

Compare to v2's patch set, here remove the calculation fro the offset 
b/t PHYS_OFFSET - PAGE_OFFSET; so when i verify the patch set, i saw x28 
is zero and finally introduce the EL2's sync exception. Below are pasted 
v2's code for reference.

do u want use firmware to set the x28 for the offset value? :-) IMHO, 
v2's implementation is more reasonable and it's better keep the code.

ENTRY(cpu_resume)
           adr     x4, sleep_save_sp
           ldr     x5, =sleep_save_sp
           sub     x28, x4, x5             // x28 = PHYS_OFFSET - 
PAGE_OFFSET
           /*
            * make sure el2 is sane, el2_setup expects:
            * x28 = PHYS_OFFSET - PAGE_OFFSET
            */
           bl      el2_setup               // if in EL2 drop to EL1 cleanly


> +#ifdef CONFIG_SMP
> +	mrs	x1, mpidr_el1
> +	adr	x4, mpidr_hash_ptr
> +	ldr	x5, [x4]
> +	add	x8, x4, x5		// x8 = struct mpidr_hash phys address
> +        /* retrieve mpidr_hash members to compute the hash */
> +	ldr	x2, [x8, #MPIDR_HASH_MASK]
> +	ldp	w3, w4, [x8, #MPIDR_HASH_SHIFTS]
> +	ldp	w5, w6, [x8, #(MPIDR_HASH_SHIFTS + 8)]
> +	compute_mpidr_hash x7, x3, x4, x5, x6, x1, x2
> +        /* x7 contains hash index, let's use it to grab context pointer */
> +#else
> +	mov	x7, xzr
> +#endif
> +	adr	x0, sleep_save_sp
> +	ldr	x0, [x0, #SLEEP_SAVE_SP_PHYS]
> +	ldr	x0, [x0, x7, lsl #3]
> +	/* load sp from context */
> +	ldr	x2, [x0, #CPU_CTX_SP]
> +	adr	x1, sleep_idmap_phys
> +	/* load physical address of identity map page table in x1 */
> +	ldr	x1, [x1]
> +	mov	sp, x2
> +	/*
> +	 * cpu_do_resume expects x0 to contain context physical address
> +	 * pointer and x1 to contain physical address of 1:1 page tables
> +	 */
> +	bl	cpu_do_resume		// PC relative jump, MMU off
> +	b	cpu_resume_mmu		// Resume MMU, never returns
> +ENDPROC(cpu_resume)
> +
