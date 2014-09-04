From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Subject: Re: [PATCH v8 6/8] drivers: cpuidle: CPU idle ARM64 driver
Date: Thu, 4 Sep 2014 18:29:10 +0100
Message-ID: <20140904172909.GA14822@e102568-lin.cambridge.arm.com>
References: <1409585324-3678-1-git-send-email-lorenzo.pieralisi@arm.com>
 <1409585324-3678-7-git-send-email-lorenzo.pieralisi@arm.com>
 <20140903173740.GJ1824@e102568-lin.cambridge.arm.com>
 <20140904160320.GB22354@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: 8BIT
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from service87.mimecast.com ([91.220.42.44]:37053 "EHLO
	service87.mimecast.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751620AbaIDR3c convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 4 Sep 2014 13:29:32 -0400
In-Reply-To: <20140904160320.GB22354@arm.com>
Content-Disposition: inline
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Catalin Marinas <catalin.marinas@arm.com>
Cc: "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Mark Rutland <Mark.Rutland@arm.com>, Sudeep Holla <Sudeep.Holla@arm.com>, Charles Garcia-Tobin <Charles.Garcia-Tobin@arm.com>, Nicolas Pitre <nico@linaro.org>, Rob Herring <robh+dt@kernel.org>, "grant.likely@linaro.org" <grant.likely@linaro.org>, Peter De Schrijver <pdeschrijver@nvidia.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>, Amit Kucheria <amit.kucheria@linaro.org>, Vincent Guittot <vincent.guittot@linaro.org>, Antti Miettinen <ananaza@iki.fi>, Stephen Boyd <sboyd@codeaurora.org>, Kevin Hilman <khilman@linaro.org>, Sebastian Capella <sebcape@gmail.com>, Tomasz Figa <t.figa@samsung.com>, Mark Brown <broonie>

On Thu, Sep 04, 2014 at 05:03:20PM +0100, Catalin Marinas wrote:
> On Wed, Sep 03, 2014 at 06:37:40PM +0100, Lorenzo Pieralisi wrote:
> > On Mon, Sep 01, 2014 at 04:28:42PM +0100, Lorenzo Pieralisi wrote:
> > > This patch implements a generic CPU idle driver for ARM64 machines.
> > > 
> > > It relies on the DT idle states infrastructure to initialize idle
> > > states count and respective parameters. Current code assumes the driver
> > > is managing idle states on all possible CPUs but can be easily
> > > generalized to support heterogenous systems and build cpumasks at
> > > runtime using MIDRs or DT cpu nodes compatible properties.
> > > 
> > > The driver relies on the arm64 CPU operations to call the idle
> > > initialization hook used to parse and save suspend back-end specific
> > > idle states information upon probing.
> > > 
> > > Idle state index 0 is always initialized as a simple wfi state, ie always
> > > considered present and functional on all ARM64 platforms.
> > > 
> > > Idle state indices higher than 0 trigger idle state entry by calling
> > > the cpu_suspend function, that triggers the suspend operation through
> > > the CPU operations suspend back-end hook. cpu_suspend passes the idle
> > > state index as a parameter so that the CPU operations suspend back-end
> > > can retrieve the required idle state data by using the idle state
> > > index to execute a look-up on its internal data structures.
> > > 
> > > Reviewed-by: Ashwin Chaugule <ashwin.chaugule@linaro.org>
> > > Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
> > > Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> > 
> > This patch should be ready to go too, is it ok if I split the series
> > in arm64 arch specific patches (will ask Catalin to pull) and CPUidle ones
> > (inclusive of DT bindings and !!this patch!!) and send two separate pull
> > requests ?
> 
> If Daniel/Rafael don't have any objection, I can take the whole series
> through the arm64 tree (it seems that patches have been already acked by
> Daniel).

Thanks a lot Catalin. Since this one is a brand new CPUidle driver and it
follows a different pattern from arm legacy drivers I would like to get
Daniel's ack on this patch too before pushing it. For the records I have
just added two pr_err to signal driver probing error, ultraminor changes
that do not justify a repost.

If Samsung guys do not manifest themselves I would drop patch 8 from
the series till it gets tested and its patch dependency queued too.

Lorenzo

