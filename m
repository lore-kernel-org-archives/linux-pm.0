From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Subject: Re: [PATCH v2 2/2] ARM64: kernel: PSCI: move PSCI idle management
 code to drivers/firmware
Date: Mon, 12 Oct 2015 16:12:20 +0100
Message-ID: <20151012151220.GA12925@red-moon>
References: <1444648628-24790-1-git-send-email-lorenzo.pieralisi@arm.com>
 <1444648628-24790-3-git-send-email-lorenzo.pieralisi@arm.com>
 <20151012142926.GB7452@leverpostej>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:47971 "EHLO foss.arm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751449AbbJLPLt (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Mon, 12 Oct 2015 11:11:49 -0400
Content-Disposition: inline
In-Reply-To: <20151012142926.GB7452@leverpostej>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Mark Rutland <mark.rutland@arm.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org, Will Deacon <will.deacon@arm.com>, Sudeep Holla <sudeep.holla@arm.com>, Russell King <linux@arm.linux.org.uk>, Daniel Lezcano <daniel.lezcano@linaro.org>, Catalin Marinas <catalin.marinas@arm.com>, Jisheng Zhang <jszhang@marvell.com>

Hi Mark,

On Mon, Oct 12, 2015 at 03:29:26PM +0100, Mark Rutland wrote:
> Hi Lorenzo,
> 
> On Mon, Oct 12, 2015 at 12:17:08PM +0100, Lorenzo Pieralisi wrote:
> > ARM64 PSCI kernel interfaces that initialize idle states and implement
> > the suspend API to enter them are generic and can be shared with the
> > ARM architecture.
> > 
> > To achieve that goal, this patch moves ARM64 PSCI idle management
> > code to drivers/firmware by creating a file that contains PSCI
> > helper functions implementing the common kernel interface required
> > by ARM and ARM64 to share the PSCI idle management code.
> > 
> > The ARM generic CPUidle implementation also requires the definition of
> > a cpuidle_ops section entry for the kernel to initialize the CPUidle
> > operations at boot based on the enable-method (ie ARM64 has the
> > statically initialized cpu_ops counterparts for that purpose); therefore
> > this patch also adds the required section entry on CONFIG_ARM for PSCI so
> > that the kernel can initialize the PSCI CPUidle back-end when PSCI is
> > the probed enable-method.
> > 
> > On ARM64 this patch provides no functional change.
> > 
> > Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> > Cc: Will Deacon <will.deacon@arm.com>
> > Cc: Sudeep Holla <sudeep.holla@arm.com>
> > Cc: Russell King <linux@arm.linux.org.uk>
> > Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
> > Cc: Catalin Marinas <catalin.marinas@arm.com>
> > Cc: Mark Rutland <mark.rutland@arm.com>
> > Cc: Jisheng Zhang <jszhang@marvell.com>
> > ---
> >  arch/arm64/kernel/psci.c       |  99 +-----------------------------
> >  drivers/firmware/Makefile      |   2 +-
> >  drivers/firmware/psci_cpuops.c | 133 +++++++++++++++++++++++++++++++++++++++++
> 
> Do we really need the new file, given most of this lived happily in
> psci.c previously?

No, I thought we could separate the PSCI FW API (eg psci_cpu_suspend())
from helper functions that are basically a kernel glue layer (but we have
already helper functions in psci.c like psci_tos_resident_on() so..),
if we think it is fine to keep them in the same file I can move the
functions to psci.c.

> > +#ifdef CONFIG_ARM
> > +struct cpuidle_ops psci_cpuidle_ops __initdata = {
> > +	.suspend = psci_cpu_suspend_enter,
> > +	.init = psci_dt_cpu_init_idle,
> > +};
> > +
> > +CPUIDLE_METHOD_OF_DECLARE(psci, "arm,psci", &psci_cpuidle_ops);
> > +#endif
> 
> Don't these also need to be guarded for CONFIG_CPU_IDLE?
> 
> The definitions of cpuidle_ops and CPUIDLE_METHOD_OF_DECLARE in
> arch/arm/include/asm/cpuidle.h depend on it.

Not really, they are not guarded, the side effect of not having
a CONFIG_CPU_IDLE guard is just a struct that is compiled in
and freed after boot, I thought about that but I am tempted to leave
it as is to avoid further ifdeffery, I am not fussed either way.

> Otherwise this looks fine to me.

Great, I will prepare a v3 shortly.

Thanks !
Lorenzo
