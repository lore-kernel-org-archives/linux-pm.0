From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Subject: Re: [PATCH v3 2/2] ARM64: kernel: PSCI: move PSCI idle management
 code to drivers/firmware
Date: Tue, 5 Jan 2016 13:27:01 +0000
Message-ID: <20160105132701.GA17214@red-moon>
References: <1445011379-8787-1-git-send-email-lorenzo.pieralisi@arm.com>
 <1445011379-8787-3-git-send-email-lorenzo.pieralisi@arm.com>
 <20160105105900.GT19062@n2100.arm.linux.org.uk>
 <20160105123134.GA1821@red-moon>
 <20160105125142.GV19062@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:58193 "EHLO foss.arm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751188AbcAENZ3 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Tue, 5 Jan 2016 08:25:29 -0500
Content-Disposition: inline
In-Reply-To: <20160105125142.GV19062@n2100.arm.linux.org.uk>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org, Will Deacon <will.deacon@arm.com>, Sudeep Holla <sudeep.holla@arm.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, Catalin Marinas <catalin.marinas@arm.com>, Mark Rutland <mark.rutland@arm.com>, Jisheng Zhang <jszhang@marvell.com>

On Tue, Jan 05, 2016 at 12:51:42PM +0000, Russell King - ARM Linux wrote:

[...]

> > > > On ARM64 this patch provides no functional change.
> > > 
> > > On ARM64, it causes build breakage though:
> > > 
> > > drivers/built-in.o: In function `psci_suspend_finisher':
> > > arm_pmu.c:(.text+0xc6494): undefined reference to `cpu_resume'
> > > arm_pmu.c:(.text+0xc6498): undefined reference to `cpu_resume'
> > > drivers/built-in.o: In function `psci_cpu_suspend_enter':
> > > arm_pmu.c:(.text+0xc66c0): undefined reference to `cpu_suspend'
> > > 
> > > The code which has been moved looks similar.  However, when it lived
> > > in arch/arm64/kernel/psci.c, it was protected by
> > > #ifdef CONFIG_HOTPLUG_CPU.  In its new location, there are no ifdefs
> > > around it, and so if it gets built without CONFIG_ARM_CPU_SUSPEND on
> > > ARM, or CONFIG_CPU_PM for ARM64, it will error out like the above.
> > > 
> > > As this is causing a regression, and I've now closed my tree, I will
> > > be doing what I said yesterday: I'll be dropping this patch for this
> > > merge window in order to stabilise my tree.  Sorry.
> > 
> > My bad, I apologise, I will likely have to add a config option to
> > make sure cpu_{suspend/resume} code is compiled in (on both ARM/ARM64),
> > thanks for spotting it.
> 
> On ARM, that option is CONFIG_ARM_CPU_SUSPEND - that option solely
> controls whether cpu_suspend/resume are present.  ARM64 just needs
> to adopt this, and use that to control the code which is built in
> drivers/firmware/psci.c.
> 
> However, I don't think it's as simple as just adding that to ARM64,
> as you need to be careful of the Kconfig dependencies.  For ARM,
> this is:
> 
> Generic code:
> - SUSPEND defaults to y, depends on ARCH_SUSPEND_POSSIBLE (which is set for
>    any cpu_suspend enabled CPU.)
> - PM_SLEEP if SUSPEND || HIBERNATE_CALLBACKS
> ARM sets:
> - CPU_PM if SUSPEND || CPU_IDLE.
> - ARM_CPU_SUSPEND if PM_SLEEP || BL_SWITCHER || (ARCH_PXA && PM)
> 
> What this means is that CPU_PM is entirely independent of
> ARM_CPU_SUSPEND.  One does not imply the other, so I think you need
> to consider carefully what ifdef you need in drivers/firmware/psci.c.
> 
> This is why I think fixing this is not simple as it first looks.

Not saying it is nice, but unless I find a cleaner way I was keener on
adding a silent config entry in drivers/firmware, say:

config ARM_PSCI_CPU_IDLE
	def_bool ARM_PSCI_FW && CPU_IDLE
	select ARM_CPU_SUSPEND if ARM

and use that to either guard the code or stub it out and compile it
if that config option is enabled.

I will post a v4 at -rc1.

Thanks,
Lorenzo
