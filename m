From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Subject: Re: [PATCH v3 2/2] ARM64: kernel: PSCI: move PSCI idle management
 code to drivers/firmware
Date: Wed, 6 Jan 2016 16:55:45 +0000
Message-ID: <20160106165545.GA19886@red-moon>
References: <1445011379-8787-1-git-send-email-lorenzo.pieralisi@arm.com>
 <1445011379-8787-3-git-send-email-lorenzo.pieralisi@arm.com>
 <20160105105900.GT19062@n2100.arm.linux.org.uk>
 <20160105123134.GA1821@red-moon>
 <20160105125142.GV19062@n2100.arm.linux.org.uk>
 <20160105132701.GA17214@red-moon>
 <20160105133447.GW19062@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:35834 "EHLO foss.arm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751959AbcAFQyM (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Wed, 6 Jan 2016 11:54:12 -0500
Content-Disposition: inline
In-Reply-To: <20160105133447.GW19062@n2100.arm.linux.org.uk>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org, Will Deacon <will.deacon@arm.com>, Sudeep Holla <sudeep.holla@arm.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, Catalin Marinas <catalin.marinas@arm.com>, Mark Rutland <mark.rutland@arm.com>, Jisheng Zhang <jszhang@marvell.com>

On Tue, Jan 05, 2016 at 01:34:47PM +0000, Russell King - ARM Linux wrote:
> On Tue, Jan 05, 2016 at 01:27:01PM +0000, Lorenzo Pieralisi wrote:
> > On Tue, Jan 05, 2016 at 12:51:42PM +0000, Russell King - ARM Linux wrote:
> > > On ARM, that option is CONFIG_ARM_CPU_SUSPEND - that option solely
> > > controls whether cpu_suspend/resume are present.  ARM64 just needs
> > > to adopt this, and use that to control the code which is built in
> > > drivers/firmware/psci.c.
> > > 
> > > However, I don't think it's as simple as just adding that to ARM64,
> > > as you need to be careful of the Kconfig dependencies.  For ARM,
> > > this is:
> > > 
> > > Generic code:
> > > - SUSPEND defaults to y, depends on ARCH_SUSPEND_POSSIBLE (which is set for
> > >    any cpu_suspend enabled CPU.)
> > > - PM_SLEEP if SUSPEND || HIBERNATE_CALLBACKS
> > > ARM sets:
> > > - CPU_PM if SUSPEND || CPU_IDLE.
> > > - ARM_CPU_SUSPEND if PM_SLEEP || BL_SWITCHER || (ARCH_PXA && PM)
> > > 
> > > What this means is that CPU_PM is entirely independent of
> > > ARM_CPU_SUSPEND.  One does not imply the other, so I think you need
> > > to consider carefully what ifdef you need in drivers/firmware/psci.c.
> > > 
> > > This is why I think fixing this is not simple as it first looks.
> > 
> > Not saying it is nice, but unless I find a cleaner way I was keener on
> > adding a silent config entry in drivers/firmware, say:
> > 
> > config ARM_PSCI_CPU_IDLE
> > 	def_bool ARM_PSCI_FW && CPU_IDLE
> > 	select ARM_CPU_SUSPEND if ARM
> > 
> > and use that to either guard the code or stub it out and compile it
> > if that config option is enabled.
> 
> That immediately worries me, because it bypasses the CPU dependencies
> for ARM_CPU_SUSPEND implicitly applied via ARCH_SUSPEND_POSSIBLE.  I'd
> prefer instead:
> 
> config ARM_PSCI_CPU_IDLE
> 	def_bool ARM_PSCI_FW && CPU_IDLE && (!ARM || ARM_CPU_SUSPEND)

If you are not against it, I could make ARM_PSCI select ARM_CPU_SUSPEND,
the CPU dependency would be taken into account (ie CPU_V7) and this
would mirror what's done for the eg BL_SWITCHER.

This would remove the need for ARM_PSCI_CPU_IDLE above altogether and
I could guard the code in drivers/firmware/psci.c through CONFIG_CPU_IDLE.

It is just an option, please let me know.

Thanks,
Lorenzo
