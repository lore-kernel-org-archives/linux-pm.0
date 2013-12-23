From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Subject: Re: [PATCH RFC v3 08/12] arm64: kernel: implement HW breakpoints CPU
 PM notifier
Date: Mon, 23 Dec 2013 13:50:25 +0000
Message-ID: <20131223135025.GA2967@e102568-lin.cambridge.arm.com>
References: <1385033059-25896-1-git-send-email-lorenzo.pieralisi@arm.com>
 <1385033059-25896-9-git-send-email-lorenzo.pieralisi@arm.com>
 <20131220172907.GF16829@mudshark.cambridge.arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: 8BIT
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from service87.mimecast.com ([91.220.42.44]:57081 "EHLO
	service87.mimecast.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757380Ab3LWNue convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 23 Dec 2013 08:50:34 -0500
In-Reply-To: <20131220172907.GF16829@mudshark.cambridge.arm.com>
Content-Disposition: inline
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Will Deacon <will.deacon@arm.com>
Cc: "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Dave P Martin <Dave.Martin@arm.com>, Catalin Marinas <Catalin.Marinas@arm.com>, Marc Zyngier <Marc.Zyngier@arm.com>, Mark Rutland <Mark.Rutland@arm.com>, Sudeep KarkadaNagesha <Sudeep.KarkadaNagesha@arm.com>, Russell King <linux@arm.linux.org.uk>, Colin Cross <ccross@android.com>, Yu Tang <ytang5@marvell.com>, Zhou Zhu <zzhu3@marvell.com>, "ksankaran@apm.com" <ksankaran@apm.com>, Loc Ho <lho@apm.com>, Feng Kan <fkan@apm.com>, Nicolas Pitre <nico@linaro.org>, Santosh Shilimkar <santosh.shilimkar@ti.com>, Stephen Boyd <sboyd@codeaurora.org>, "graeme.gregory@linaro.org" <graeme.gregory@linaro.org>, Hanjun Guo <hanjun.guo@linaro.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, Christoffer Dall <christoffer.dall@linaro.org>

Hi Will,

thanks for having a look.

On Fri, Dec 20, 2013 at 05:29:07PM +0000, Will Deacon wrote:
> Hi Lorenzo,
> 
> On Thu, Nov 21, 2013 at 11:24:15AM +0000, Lorenzo Pieralisi wrote:
> > When a CPU is shutdown either through CPU idle or suspend to RAM, the
> > content of HW breakpoint registers must be reset or restored to proper
> > values when CPU resume from low power states. This patch adds debug register
> > restore operations to the HW breakpoint control function and implements a
> > CPU PM notifier that allows to restore the content of HW breakpoint registers
> > to allow proper suspend/resume operations.
> 
> This looks mostly fine to me, but I have one questions you might be able to
> answer...
> 
> > @@ -840,18 +847,36 @@ void hw_breakpoint_thread_switch(struct task_struct *next)
> >  /*
> >   * CPU initialisation.
> >   */
> > -static void reset_ctrl_regs(void *unused)
> > +static void hw_breakpoint_reset(void *unused)
> >  {
> >  	int i;
> > -
> > -	for (i = 0; i < core_num_brps; ++i) {
> > -		write_wb_reg(AARCH64_DBG_REG_BCR, i, 0UL);
> > -		write_wb_reg(AARCH64_DBG_REG_BVR, i, 0UL);
> > +	struct perf_event **slots;
> > +	/*
> > +	 * When a CPU goes through cold-boot, it does not have any installed
> > +	 * slot, so it is safe to share the same function for restoring and
> > +	 * resetting breakpoints; when a CPU is hotplugged in, it goes
> > +	 * through the slots, which are all empty, hence it just resets control
> > +	 * and value for debug registers.
> > +	 * When this function is triggered on warm-boot through a CPU PM
> > +	 * notifier some slots might be initialized; if so they are
> > +	 * reprogrammed according to the debug slots content.
> > +	 */
> > +	for (slots = this_cpu_ptr(bp_on_reg), i = 0; i < core_num_brps; ++i) {
> > +		if (slots[i]) {
> > +			hw_breakpoint_control(slots[i], HW_BREAKPOINT_RESTORE);
> > +		} else {
> > +			write_wb_reg(AARCH64_DBG_REG_BCR, i, 0UL);
> > +			write_wb_reg(AARCH64_DBG_REG_BVR, i, 0UL);
> > +		}
> 
> When this runs on warm-boot and starts restoring debug state, are debug
> exceptions guaranteed to be masked? I think that the debug restoration
> should appear atomic to a debugger (i.e. you can't take a debug exception
> half-way through the restore).

No, they might not be, good catch and this needs fixing (well, CPU PM notifiers
and suspend must be run with IRQs disabled, but debug exceptions can be left
on even though we should define to what extent this can be considered
reasonable/safe, eg debugging should not fiddle with HW state that we are
saving, it is a bit of a grey area).
I think the easiest option is to mask/unmask them in the CPU PM notifier,
before/after restoring the slots. As we discussed, I am trying to keep debug
on as deep in the power down sequence as possible, and now I mask debug
exceptions before saving general purpose registers, and restore the exception
flags when cpu_suspend returns (which means unfortunately that the sequence
above might run with debug exceptions unmasked). This means that the debugger
might see a restore that is not atomic from its perspective, again, good spot,
I should update the patch or put together a fix for -rc1 if the commit history
is immutable now, which I think that's the case.

Thank you,
Lorenzo

> 
> Providing that's the case:
> 
>   Acked-by: Will Deacon <will.deacon@arm.com>
> 
> Will
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pm" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

