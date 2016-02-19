From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Subject: Re: [PATCH v5 07/15] arm64: Change cpu_resume() to enable mmu early
 then access sleep_sp by va
Date: Fri, 19 Feb 2016 16:43:21 +0000
Message-ID: <20160219164321.GA1195@red-moon>
References: <1455637767-31561-1-git-send-email-james.morse@arm.com>
 <1455637767-31561-8-git-send-email-james.morse@arm.com>
 <20160218182602.GA17589@red-moon>
 <56C740E2.5000801@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:47308 "EHLO foss.arm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1428320AbcBSQlQ (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Fri, 19 Feb 2016 11:41:16 -0500
Content-Disposition: inline
In-Reply-To: <56C740E2.5000801@arm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: James Morse <james.morse@arm.com>
Cc: linux-arm-kernel@lists.infradead.org, Will Deacon <will.deacon@arm.com>, Sudeep Holla <sudeep.holla@arm.com>, Geoff Levand <geoff@infradead.org>, Catalin Marinas <catalin.marinas@arm.com>, Mark Rutland <mark.rutland@arm.com>, AKASHI Takahiro <takahiro.akashi@linaro.org>, Marc Zyngier <marc.zyngier@arm.com>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Pavel Machek <pavel@ucw.cz>, linux-pm@vger.kernel.org

On Fri, Feb 19, 2016 at 04:20:50PM +0000, James Morse wrote:

[...]

> >> diff --git a/arch/arm64/kernel/sleep.S b/arch/arm64/kernel/sleep.S
> >> index dca81612fe90..0e2b36f1fb44 100644
> >> --- a/arch/arm64/kernel/sleep.S
> >> +++ b/arch/arm64/kernel/sleep.S
> >> @@ -73,8 +73,8 @@ ENTRY(__cpu_suspend_enter)
> >>  	str	x2, [x0, #SLEEP_STACK_DATA_SYSTEM_REGS + CPU_CTX_SP]
> >>  
> >>  	/* find the mpidr_hash */
> >> -	ldr	x1, =sleep_save_sp
> >> -	ldr	x1, [x1, #SLEEP_SAVE_SP_VIRT]
> >> +	ldr	x1, =sleep_save_stash
> >> +	ldr	x1, [x1]
> >>  	mrs	x7, mpidr_el1
> >>  	ldr	x9, =mpidr_hash
> >>  	ldr	x10, [x9, #MPIDR_HASH_MASK]
> >> @@ -87,40 +87,26 @@ ENTRY(__cpu_suspend_enter)
> >>  	compute_mpidr_hash x8, x3, x4, x5, x6, x7, x10
> >>  	add	x1, x1, x8, lsl #3
> >>  
> >> +	str	x0, [x1]
> >> +	add	x0, x0, #SLEEP_STACK_DATA_SYSTEM_REGS
> > 
> > Mmm...this instruction does not really belong in this patch,
> > it should be part of patch 6, correct ? What I mean is, the new
> > struct to stash system regs (struct sleep_stack_data) was added in
> > patch 6, if the offset #SLEEP_STACK_DATA_SYSTEM_REGS (which is 0) had
> > to be added it had to be added in patch 6 too, it does not belong
> > in this patch, am I right ?
> 
> In the previous patch __cpu_suspend_save() was changed to take a
> struct sleep_stack_data, this then passes system_regs to
> cpu_do_suspend(). The 'add	x0, x0, #SLEEP_STACK_DATA_SYSTEM_REGS'
> is being done in C, (and hopefully optimised out by the compiler).
> 
> In this patch, we removed __cpu_suspend_save() and call cpu_do_suspend()
> directly, so need to account for system_regs's position in struct
> sleep_stack_data ourselves.

Yes, I missed that during the review, that explains, thanks.

> I'm paranoid, but if you prefer I can remove the 'add 0', and dump a
> comment next to the struct definition making it someone elses problem
> to fix it if they ever change the layout of the struct...

No, what you do is correct and should be kept as-is, I thought it
had to be added in patch 6 but I was wrong, see above, code is
correct as it is.

Thanks,
Lorenzo

> 
> 
> > 
> >>  	push	x29, lr
> >> -	bl	__cpu_suspend_save
> >> +	bl	cpu_do_suspend
> >>  	pop	x29, lr
> >>  	mov	x0, #1
> >>  	ret
> >>  ENDPROC(__cpu_suspend_enter)
> >>  	.ltorg
> 
> [...2x Nits fixed...]
> 
> > With the last updates it seems fine by me, so:
> > 
> > Reviewed-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> 
> 
> Thanks!
> 
> 
> James
> 
> 
