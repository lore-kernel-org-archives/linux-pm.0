From: Juri Lelli <juri.lelli@arm.com>
Subject: Re: [PATCH 6/7] arm, arm64: factorize common cpu capacity default
 code
Date: Fri, 20 Jan 2017 10:42:40 +0000
Message-ID: <20170120104240.GO30747@e106622-lin>
References: <20170119143757.14537-1-juri.lelli@arm.com>
 <20170119143757.14537-7-juri.lelli@arm.com>
 <e5b902a0-8c2b-a682-0f67-0b0d9ee4ef5c@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:47512 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751800AbdATKly (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 20 Jan 2017 05:41:54 -0500
Content-Disposition: inline
In-Reply-To: <e5b902a0-8c2b-a682-0f67-0b0d9ee4ef5c@arm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, peterz@infradead.org, vincent.guittot@linaro.org, robh+dt@kernel.org, mark.rutland@arm.com, linux@arm.linux.org.uk, sudeep.holla@arm.com, lorenzo.pieralisi@arm.com, catalin.marinas@arm.com, will.deacon@arm.com, morten.rasmussen@arm.com, broonie@kernel.org, gregkh@linuxfoundation.org, Russell King <linux@armlinux.org.uk>

Hi Dietmar,

On 19/01/17 16:00, Dietmar Eggemann wrote:
> On 19/01/17 14:37, Juri Lelli wrote:
> > arm and arm64 share lot of code relative to parsing CPU capacity
> > information from DT, using that information for appropriate scaling and
> > exposing a sysfs interface for chaging such values at runtime.
> > 
> > Factorize such code in a common place (driver/base/arch_topology.c) in
> > preparation for further additions.
> > 
> > Suggested-by: Will Deacon <will.deacon@arm.com>
> > Suggested-by: Mark Rutland <mark.rutland@arm.com>
> > Suggested-by: Catalin Marinas <catalin.marinas@arm.com>
> > Cc: Russell King <linux@armlinux.org.uk>
> > Cc: Catalin Marinas <catalin.marinas@arm.com>
> > Cc: Will Deacon <will.deacon@arm.com>
> > Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > Signed-off-by: Juri Lelli <juri.lelli@arm.com>
> > ---
> >  arch/arm/Kconfig             |   1 +
> >  arch/arm/kernel/topology.c   | 213 ++------------------------------------
> >  arch/arm64/Kconfig           |   1 +
> >  arch/arm64/kernel/topology.c | 213 +-------------------------------------
> >  drivers/base/Kconfig         |   8 ++
> >  drivers/base/Makefile        |   1 +
> >  drivers/base/arch_topology.c | 240 +++++++++++++++++++++++++++++++++++++++++++
> >  7 files changed, 260 insertions(+), 417 deletions(-)
> >  create mode 100644 drivers/base/arch_topology.c
> 
> [...]
> 
> > +extern unsigned long
> > +arch_scale_cpu_capacity(struct sched_domain *sd, int cpu);
> 
> How about adding a driver specific prefix 'foo_' to all driver interfaces?
> 
> I'm asking because I would rather like to do a
> 
> #define arch_scale_cpu_capacity foo_scale_cpu_capacity
> 
> then a
> 
> #define arch_scale_cpu_capacity arch_scale_cpu_capacity
> 
> in arch/arm64/include/asm/topology.h
> 
> later to wire cpu-invariant load-tracking support up to the task
> scheduler for ARM64.
> 
> That's probably true too for all the 'driver' interfaces which get used
> in arch/arm{,64}/kernel/topology.c.
> 

Looks like a good way to improve clarity to me. I'll add a patch for the
next version doing this and we see what people think.

Best,

- Juri
