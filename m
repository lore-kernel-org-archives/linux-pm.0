From: Nicolas Pitre <nicolas.pitre@linaro.org>
Subject: Re: [PATCH v4 1/6] Documentation: arm: define DT idle states
 bindings
Date: Mon, 16 Jun 2014 10:48:30 -0400 (EDT)
Message-ID: <alpine.LFD.2.11.1406161044180.31631@knanqh.ubzr>
References: <1402503520-8611-1-git-send-email-lorenzo.pieralisi@arm.com> <1402503520-8611-2-git-send-email-lorenzo.pieralisi@arm.com> <alpine.LFD.2.11.1406111240010.25775@knanqh.ubzr> <20140613164954.GA16745@e102568-lin.cambridge.arm.com>
 <alpine.LFD.2.11.1406131306160.25775@knanqh.ubzr> <20140616142259.GA6650@e102568-lin.cambridge.arm.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-qa0-f48.google.com ([209.85.216.48]:59338 "EHLO
	mail-qa0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751668AbaFPOsd (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 16 Jun 2014 10:48:33 -0400
Received: by mail-qa0-f48.google.com with SMTP id x12so7471548qac.21
        for <linux-pm@vger.kernel.org>; Mon, 16 Jun 2014 07:48:32 -0700 (PDT)
In-Reply-To: <20140616142259.GA6650@e102568-lin.cambridge.arm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Mark Rutland <Mark.Rutland@arm.com>, Sudeep Holla <Sudeep.Holla@arm.com>, Catalin Marinas <Catalin.Marinas@arm.com>, Charles Garcia-Tobin <Charles.Garcia-Tobin@arm.com>, Rob Herring <robh+dt@kernel.org>, "grant.likely@linaro.org" <grant.likely@linaro.org>, Peter De Schrijver <pdeschrijver@nvidia.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, Amit Kucheria <amit.kucheria@linaro.org>, Vincent Guittot <vincent.guittot@linaro.org>, Antti Miettinen <ananaza@iki.fi>, Stephen Boyd <sboyd@codeaurora.org>, Kevin Hilman <khilman@linaro.org>, Sebastian Capella <sebcape@gmail.com>, Tomasz Figa <t.figa@samsung.com>, Mark Brown <broonie@ke>

On Mon, 16 Jun 2014, Lorenzo Pieralisi wrote:

> On Fri, Jun 13, 2014 at 06:33:35PM +0100, Nicolas Pitre wrote:
> > >    idle_state.exit_latency = worst-wakeup-latency
> > >    idle_state.target_residency = min-residency-us
> > 
> > But exit_latency is not necessarily equal to worst-wakeup-latency.  
> > We'll need any of those 4 values depending on the context.  So I'd add 
> > entry_latency and worst_wakeup_latency to struct cpuidle_state.  If a 
> > driver doesn't initialize entry_latency then it can be left to 0, and if 
> > worst_wakeup_latency is 0 then it should be set to entry_latency + 
> > exit_latency by the core code.
> 
> Well, that's why I mentioned idle_state.exit_latency, because in CPUidle
> today, the struct cpuidle_state.exit_latency field corresponds to our
> worst-wakeup-latency property, not to the exit_latency property; I know
> it is confusing but at least by defining proper bindings the kernel
> structures can be updated with clear semantics (I would not rename them
> for the time being though).

Why not?  Adding more confusion or even simply keeping the existing one, 
even if it is temporary, doesn't benefit anyone.

> Fields required by the scheduler (ie entry_latency) can be added in 
> the patches that rely on them, when we agreed on the bindings, adding 
> the variables is no big deal.

Sure.


Nicolas
