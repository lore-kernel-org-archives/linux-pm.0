From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Subject: Re: [PATCH 1/2] ARM: cpuidle: make cpuidle_ops interfaces ARM64
 compliant
Date: Fri, 2 Oct 2015 11:52:17 +0100
Message-ID: <20151002105217.GA1533@red-moon>
References: <1443689933-28882-1-git-send-email-lorenzo.pieralisi@arm.com>
 <1443689933-28882-2-git-send-email-lorenzo.pieralisi@arm.com>
 <560E5076.7020906@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:39789 "EHLO foss.arm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750777AbbJBKvy (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Fri, 2 Oct 2015 06:51:54 -0400
Content-Disposition: inline
In-Reply-To: <560E5076.7020906@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Lina Iyer <lina.iyer@linaro.org>, Russell King <linux@arm.linux.org.uk>, Will Deacon <Will.Deacon@arm.com>, Sudeep Holla <Sudeep.Holla@arm.com>, Catalin Marinas <Catalin.Marinas@arm.com>, Mark Rutland <Mark.Rutland@arm.com>, Jisheng Zhang <jszhang@marvell.com>

On Fri, Oct 02, 2015 at 10:37:58AM +0100, Daniel Lezcano wrote:

[...]

> > diff --git a/arch/arm/include/asm/cpuidle.h b/arch/arm/include/asm/cpuidle.h
> > index 0f84249..ee36dd4 100644
> > --- a/arch/arm/include/asm/cpuidle.h
> > +++ b/arch/arm/include/asm/cpuidle.h
> > @@ -30,8 +30,8 @@ static inline int arm_cpuidle_simple_enter(struct cpuidle_device *dev,
> >   struct device_node;
> >
> >   struct cpuidle_ops {
> > -	int (*suspend)(int cpu, unsigned long arg);
> > -	int (*init)(struct device_node *, int cpu);
> 
> I don't know the reason why the 'cpu_psci_cpu_init_idle' signature was 
> changed. It has before the same signature as this ops.

Short answer, ACPI (ie device_node is useless on ACPI systems, so
there is no point in passing it).

> As in ARM, we can have more than one driver using the cpuidle_ops 
> infrastructure, removing the struct device_node * parameter will force 
> to add a call to of_get_cpu_node(cpu, NULL) in each driver with a call 
> to of_node_put (btw it is missing below in qcom_cpuidle_init), the 
> rollback labels and this will lead to duplicated code.
> 
> So why not change ARM64 signature instead ?

See above, I will see what I can do and I understand your concern,
it makes sense.

Thanks,
Lorenzo
