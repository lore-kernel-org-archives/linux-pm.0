From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Subject: Re: [PATCH v4 1/6] Documentation: arm: define DT idle states bindings
Date: Mon, 16 Jun 2014 15:23:00 +0100
Message-ID: <20140616142259.GA6650@e102568-lin.cambridge.arm.com>
References: <1402503520-8611-1-git-send-email-lorenzo.pieralisi@arm.com>
 <1402503520-8611-2-git-send-email-lorenzo.pieralisi@arm.com>
 <alpine.LFD.2.11.1406111240010.25775@knanqh.ubzr>
 <20140613164954.GA16745@e102568-lin.cambridge.arm.com>
 <alpine.LFD.2.11.1406131306160.25775@knanqh.ubzr>
Mime-Version: 1.0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: 8BIT
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from service87.mimecast.com ([91.220.42.44]:34066 "EHLO
	service87.mimecast.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753364AbaFPOXL convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 16 Jun 2014 10:23:11 -0400
In-Reply-To: <alpine.LFD.2.11.1406131306160.25775@knanqh.ubzr>
Content-Disposition: inline
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Nicolas Pitre <nicolas.pitre@linaro.org>
Cc: "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Mark Rutland <Mark.Rutland@arm.com>, Sudeep Holla <Sudeep.Holla@arm.com>, Catalin Marinas <Catalin.Marinas@arm.com>, Charles Garcia-Tobin <Charles.Garcia-Tobin@arm.com>, Rob Herring <robh+dt@kernel.org>, "grant.likely@linaro.org" <grant.likely@linaro.org>, Peter De Schrijver <pdeschrijver@nvidia.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, Amit Kucheria <amit.kucheria@linaro.org>, Vincent Guittot <vincent.guittot@linaro.org>, Antti Miettinen <ananaza@iki.fi>, Stephen Boyd <sboyd@codeaurora.org>, Kevin Hilman <khilman@linaro.org>, Sebastian Capella <sebcape@gmail.com>, Tomasz Figa <t.figa@samsung.com>, Mark Brown <broonie@ke>

On Fri, Jun 13, 2014 at 06:33:35PM +0100, Nicolas Pitre wrote:
> On Fri, 13 Jun 2014, Lorenzo Pieralisi wrote:
> 
> > On Wed, Jun 11, 2014 at 07:15:16PM +0100, Nicolas Pitre wrote:
> > > Let's illustrate the different periods on a time line to make it clearer
> > > (hmmm let's see how this can be managed on a braille display :-O ):
> > > 
> > > EXEC:	Normal CPU execution.
> > > 
> > > PREP:	Preparation phase before committing the hardware to idle mode
> > > 	like cache flushing. This is abortable on pending wake-up 
> > > 	event conditions. The abort latency is assumed to be negligible 
> > > 	(i.e. less than the ENTRY + EXIT duration). If aborted, we go 
> > > 	back to EXEC. This phase is optional. If not abortable, this 
> > > 	should be included in the ENTRY phase instead.
> > > 
> > > ENTRY:	The hardware is committed to idle mode. This period must run to
> > > 	completion up to IDLE before anything else can happen.
> > > 
> > > IDLE:	This is the actual power-saving idle period. This may last 
> > > 	between 0 and infinite time, until a wake-up event occurs.
> > > 
> > > EXIT:	Period during which the CPU is brought back to operational
> > > 	mode (EXEC).
> > > 
> > > ...__[EXEC]__|__[PREP]--|__[ENTRY]__|__[IDLE]__|___[EXIT]_--|__[EXEC]__...
> > >              |          |           |          |            |
> > > 
> > >              |<-- entry-latency --->|
> > > 
> > >                                                |<- exit-  ->|
> > >                                                |  latency   |
> > > 
> > >              |<-------------- min-residency --------------->|
> > > 
> > >                         |<----- worst_wakeup_latency ------>|
> > > 
> > > entry-latency: Worst case latency required to enter the idle state.  The 
> > > exit_latency may be guaranteed only after entry-latency has passed.
> > > 
> > > min-residency: Minimum period, including preparation, entry and exit, 
> > > for a given power mode to be worthwhile energy wise.  It must be at 
> > > least equal to entry_latency + exit_latency.
> > > 
> > > worst_wakeup_latency: Maximum delay between the signaling of a wake-up 
> > > event and the CPU being able to execute normal code again. If not 
> > > specified, this is assumed to be entry-latency + exit_latency.
> > > 
> > > Notes:
> > > 
> > > The cpuidle code would only care about min-residency to select the most 
> > > appropriate mode based on the expected delay before the next event.
> > > 
> > > The scheduler will care about the following in the near future:
> > > 
> > > wakeup_delay = exit_latency + max(entry_latency - (now - entry_timestamp), 0)
> > > 
> > > In other words, the scheduler would wake up the CPU with the shortest 
> > > wake-up latency.  This wake-up latency must take into account the entry 
> > > latency if that period has not expired.  Here the abortable nature of 
> > > the PREP period is ignored on purpose because it cannot be relied upon 
> > > (e.g. if the cache is mostly clean then the PREP deadline may occur much 
> > > sooner than expected).
> > > 
> > > And pmqos would only care about worst_wakeup_latency.
> > > 
> > > So... I hope this is useful.  I think the above ascii art could be part 
> > > of your documentation to explain it all.
> > 
> > I will, it makes perfect sense, let me point out a couple of things:
> > 
> > 1) we need 4 properties, 1 optional (worst_wakeup_latency, if not
> >    present defaults to entry+exit)
> > 2) is everyone ok, given these definitions, in sorting idle states using
> >    min-residency-us as a rank ?
> 
> Yes.
> 
> > 3) CPUidle:
> >    idle_state.exit_latency = worst-wakeup-latency
> >    idle_state.target_residency = min-residency-us
> 
> But exit_latency is not necessarily equal to worst-wakeup-latency.  
> We'll need any of those 4 values depending on the context.  So I'd add 
> entry_latency and worst_wakeup_latency to struct cpuidle_state.  If a 
> driver doesn't initialize entry_latency then it can be left to 0, and if 
> worst_wakeup_latency is 0 then it should be set to entry_latency + 
> exit_latency by the core code.

Well, that's why I mentioned idle_state.exit_latency, because in CPUidle
today, the struct cpuidle_state.exit_latency field corresponds to our
worst-wakeup-latency property, not to the exit_latency property; I know
it is confusing but at least by defining proper bindings the kernel
structures can be updated with clear semantics (I would not rename them
for the time being though). Fields required by the scheduler (ie
entry_latency) can be added in the patches that rely on them, when we agreed
on the bindings, adding the variables is no big deal.

> > 4) PREP (longest period) can be obtained from the other properties, IF it is
> >    needed
> >    PREP = (entry + exit) - worst_wakeup (if worst_wakeup omitted, PREP = 0)
> 
> Sure.  However I'd avoid documenting it.  As I said this period cannot 
> be relied upon because it can vary a lot and if you miss its deadline 
> you're up for a much longer delay than expected.  It is useful if a 
> wake-up event happens during that period and then the latency can be cut 
> short opportunistically. But if we get to the point we need to rely on 
> this period to improve things then it would be a good idea to question 
> why we need to request and immediately abort a state so often to start 
> with.

Agreed.

Thanks,
Lorenzo

