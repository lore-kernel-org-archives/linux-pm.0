From: Stephen Boyd <sboyd@codeaurora.org>
Subject: Re: [PATCH 9/9] ARM: smp: Add runtime PM support for CPU hotplug
Date: Thu, 13 Aug 2015 12:18:18 -0700
Message-ID: <20150813191818.GT26614@codeaurora.org>
References: <1438731339-58317-1-git-send-email-lina.iyer@linaro.org>
 <1438731339-58317-10-git-send-email-lina.iyer@linaro.org>
 <20150812234756.GO26614@codeaurora.org>
 <20150813160038.GP52339@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:53025 "EHLO
	smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754056AbbHMTST (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 13 Aug 2015 15:18:19 -0400
Content-Disposition: inline
In-Reply-To: <20150813160038.GP52339@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Lina Iyer <lina.iyer@linaro.org>
Cc: rjw@rjwysocki.net, ulf.hansson@linaro.org, khilman@linaro.org, geert@linux-m68k.org, k.kozlowski@samsung.com, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, msivasub@codeaurora.org, agross@codeaurora.org, Catalin Marinas <catalin.marinas@arm.com>, Mark Rutland <mark.rutland@arm.com>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>

On 08/13, Lina Iyer wrote:
> On Wed, Aug 12 2015 at 17:47 -0600, Stephen Boyd wrote:
> >On 08/04, Lina Iyer wrote:
> 
> >>+
> >> 	ret = platform_cpu_disable(cpu);
> >> 	if (ret)
> >> 		return ret;
> >>@@ -272,6 +275,13 @@ void __ref cpu_die(void)
> >> {
> >> 	unsigned int cpu = smp_processor_id();
> >>
> >>+	/*
> >>+	 * We dont need the CPU device anymore.
> >>+	 * Lets do this before IRQs are disabled to allow
> >>+	 * runtime PM to suspend the domain as well.
> >>+	 */
> >>+	pm_runtime_put_sync(get_cpu_device(cpu));
> >
> >The two put calls is confusing. __cpu_disable() is called on the
> >CPU that's dying, and cpu_die() is called on the CPU that's doing
> >the takedown.
> >
> Is that right? Looking at the code and the comments, I can only imagine
> that they must be called on the CPU going down. If thats not the case,
> then I need to fix this.
> 
> >That would be two decrements but only one increment
> >in secondary_start_kernel()? How is this properly balanced?
> >
> I dont see __cpu_disable() ending up at cpu_die(). These seem two
> different exit points. I will check again.

Yeah I suspect we want a single call in __cpu_disable() so that
it runs on the CPU that's being hotplugged out.

> 
> >>+
> >> 	idle_task_exit();
> >>
> >> 	local_irq_disable();
> >>@@ -401,6 +412,11 @@ asmlinkage void secondary_start_kernel(void)
> >> 	local_irq_enable();
> >> 	local_fiq_enable();
> >>
> >>+	/* We are running, enable runtime PM for the CPU. */
> >>+	cpu_dev = get_cpu_device(cpu);
> >>+	if (cpu_dev)
> >>+		pm_runtime_get_sync(cpu_dev);
> >
> >Also, where would the dev->power.irq_safe flag be set if we
> >aren't using the genpd DT stuff? It looks like we're going to
> >start causing warnings on devices that don't have the DT magic.
> >
> Not necessarily. I have added _get and _put at points, when the
> interrupts are still enabled. So there should not be a need for the CPU
> devices to be IRQ safe. They will operate as regular devices. If they
> are attached to a non-IRQ safe domain, they would effect power savings
> on the domain.

What about preemption? Preemption is disabled in __cpu_disable()
and secondary_start_kernel() where this patch is calling
pm_runtime_{get,put}_sync(). That should still trigger a warning
with the might_sleep() inside the runtime PM functions if we
haven't set the irq_safe flag.

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
