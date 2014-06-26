From: Nicolas Pitre <nicolas.pitre@linaro.org>
Subject: Re: [PATCH v5 1/8] Documentation: arm: define DT idle states
 bindings
Date: Thu, 26 Jun 2014 15:30:22 -0400 (EDT)
Message-ID: <alpine.LFD.2.11.1406261527520.16842@knanqh.ubzr>
References: <1403705421-17597-1-git-send-email-lorenzo.pieralisi@arm.com> <1403705421-17597-2-git-send-email-lorenzo.pieralisi@arm.com> <alpine.LFD.2.11.1406251154500.16842@knanqh.ubzr> <20140626101707.GB25130@e102568-lin.cambridge.arm.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-qc0-f176.google.com ([209.85.216.176]:37191 "EHLO
	mail-qc0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750844AbaFZTaZ (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 26 Jun 2014 15:30:25 -0400
Received: by mail-qc0-f176.google.com with SMTP id w7so3541637qcr.21
        for <linux-pm@vger.kernel.org>; Thu, 26 Jun 2014 12:30:24 -0700 (PDT)
In-Reply-To: <20140626101707.GB25130@e102568-lin.cambridge.arm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Mark Rutland <Mark.Rutland@arm.com>, Sudeep Holla <Sudeep.Holla@arm.com>, Catalin Marinas <Catalin.Marinas@arm.com>, Charles Garcia-Tobin <Charles.Garcia-Tobin@arm.com>, Rob Herring <robh+dt@kernel.org>, "grant.likely@linaro.org" <grant.likely@linaro.org>, Peter De Schrijver <pdeschrijver@nvidia.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, Amit Kucheria <amit.kucheria@linaro.org>, Vincent Guittot <vincent.guittot@linaro.org>, Antti Miettinen <ananaza@iki.fi>, Stephen Boyd <sboyd@codeaurora.org>, Kevin Hilman <khilman@linaro.org>, Sebastian Capella <sebcape@gmail.com>, Tomasz Figa <t.figa@samsung.com>, Mark Brown <broonie@ke>

On Thu, 26 Jun 2014, Lorenzo Pieralisi wrote:

> On Wed, Jun 25, 2014 at 04:56:02PM +0100, Nicolas Pitre wrote:
> > On Wed, 25 Jun 2014, Lorenzo Pieralisi wrote:
> > 
> > > ARM based platforms implement a variety of power management schemes that
> > > allow processors to enter idle states at run-time.
> > > The parameters defining these idle states vary on a per-platform basis forcing
> > > the OS to hardcode the state parameters in platform specific static tables
> > > whose size grows as the number of platforms supported in the kernel increases
> > > and hampers device drivers standardization.
> > >
> > > Therefore, this patch aims at standardizing idle state device tree bindings for
> > > ARM platforms. Bindings define idle state parameters inclusive of entry methods
> > > and state latencies, to allow operating systems to retrieve the configuration
> > > entries from the device tree and initialize the related power management
> > > drivers, paving the way for common code in the kernel to deal with idle
> > > states and removing the need for static data in current and previous kernel
> > > versions.
> > >
> > > Reviewed-by: Sebastian Capella <sebcape@gmail.com>
> > > Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> > 
> > Excellent.
> > 
> > Reviewed-by: Nicolas Pitre <nico@linaro.org>
> 
> Thanks Nico, there are still a couple of niggles to sort out (ie local
> timer state), but the bulk of the document should be complete I hope.
> 
> I will postpone adding your (and Seb's) Reviewed-by until we have a
> final agreement if it is ok with you.

As you wish.  The parts I care about are now well covered.  I don't 
think I know enough about timers to comment further.

Nicolas
