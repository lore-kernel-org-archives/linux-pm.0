From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Subject: Re: [PATCH v3 2/2] ARM64: kernel: PSCI: move PSCI idle management
 code to drivers/firmware
Date: Tue, 5 Jan 2016 15:28:09 +0000
Message-ID: <20160105152809.GA17461@red-moon>
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
Received: from foss.arm.com ([217.140.101.70]:58779 "EHLO foss.arm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750846AbcAEP0h (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Tue, 5 Jan 2016 10:26:37 -0500
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

Ok, I think the above is reasonable, only question I have is if on ARM:

CONFIG_SUSPEND=n
CONFIG_CPU_IDLE=y

this would imply:

CONFIG_ARM_CPU_SUSPEND=n => ARM_PSCI_CPU_IDLE=n

(which is a questionable setup but possible) we can't do PSCI based
CPUidle (I agree with you that bypassing the dependencies is not ideal
or correct in the first place though), that's a problem for all
subsystems "selecting" ARM_CPU_SUSPEND.

> Really, the answer is to stop ARM64 diverging from ARM, so we stop
> having these architecture conditionals all over the place.  If ARM64
> builds its cpu_suspend code in the same way that ARM does (iow,
> keyed off ARM_CPU_SUSPEND, which it can select), then we end up
> with the above being:
> 
> config ARM_PSCI_CPU_IDLE
> 	def_bool ARM_PSCI_FW && CPU_IDLE && ARM_CPU_SUSPEND

Yes, we could do that, on ARM64 should be = SUSPEND || CPU_IDLE,
ergo the value of CPU_PM on ARM64, that's why we do not have another
config entry at present.

> which is a helll of a lot simpler.  The dependency on ARM_PSCI_FW
> could be regarded as redundant if we're only using ARM_PSCI_CPU_IDLE
> to control code built within drivers/firmware/psci.c, as that won't
> be built unless ARM_PSCI_FW is set.

Yep, that's a good point and I will remove ARM_PSCI_FW from the first
option you provided above.

Thanks,
Lorenzo
