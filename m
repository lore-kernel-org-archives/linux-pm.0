From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Subject: Re: [PATCH v4 1/6] Documentation: arm: define DT idle states bindings
Date: Fri, 13 Jun 2014 17:49:55 +0100
Message-ID: <20140613164954.GA16745@e102568-lin.cambridge.arm.com>
References: <1402503520-8611-1-git-send-email-lorenzo.pieralisi@arm.com>
 <1402503520-8611-2-git-send-email-lorenzo.pieralisi@arm.com>
 <alpine.LFD.2.11.1406111240010.25775@knanqh.ubzr>
Mime-Version: 1.0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: 8BIT
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from service87.mimecast.com ([91.220.42.44]:47938 "EHLO
	service87.mimecast.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752507AbaFMQuC convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 13 Jun 2014 12:50:02 -0400
In-Reply-To: <alpine.LFD.2.11.1406111240010.25775@knanqh.ubzr>
Content-Disposition: inline
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Nicolas Pitre <nicolas.pitre@linaro.org>
Cc: "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Mark Rutland <Mark.Rutland@arm.com>, Sudeep Holla <Sudeep.Holla@arm.com>, Catalin Marinas <Catalin.Marinas@arm.com>, Charles Garcia-Tobin <Charles.Garcia-Tobin@arm.com>, Rob Herring <robh+dt@kernel.org>, "grant.likely@linaro.org" <grant.likely@linaro.org>, Peter De Schrijver <pdeschrijver@nvidia.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, Amit Kucheria <amit.kucheria@linaro.org>, Vincent Guittot <vincent.guittot@linaro.org>, Antti Miettinen <ananaza@iki.fi>, Stephen Boyd <sboyd@codeaurora.org>, Kevin Hilman <khilman@linaro.org>, Sebastian Capella <sebcape@gmail.com>, Tomasz Figa <t.figa@samsung.com>, Mark Brown <broonie@ke>

On Wed, Jun 11, 2014 at 07:15:16PM +0100, Nicolas Pitre wrote:
> On Wed, 11 Jun 2014, Lorenzo Pieralisi wrote:
> 
> > ARM based platforms implement a variety of power management schemes that
> > allow processors to enter idle states at run-time.
> > The parameters defining these idle states vary on a per-platform basis forcing
> > the OS to hardcode the state parameters in platform specific static tables
> > whose size grows as the number of platforms supported in the kernel increases
> > and hampers device drivers standardization.
> > 
> > Therefore, this patch aims at standardizing idle state device tree bindings for
> > ARM platforms. Bindings define idle state parameters inclusive of entry methods
> > and state latencies, to allow operating systems to retrieve the configuration
> > entries from the device tree and initialize the related power management
> > drivers, paving the way for common code in the kernel to deal with idle
> > states and removing the need for static data in current and previous kernel
> > versions.
> 
> Following the offline discussion with Charles, I've some comments.
> 
> [...]

Thank you for summing that discussion up.

> > +Idle state parameters (eg entry latency) are platform specific and 
> need to be
> > +characterized with bindings that provide the required information to OSPM
> > +code so that it can build the required tables and use them at runtime.
> 
> [...]
> 
> > +	- entry-latency-us
> > +		Usage: Required
> > +		Value type: <prop-encoded-array>
> > +		Definition: u32 value representing worst case latency
> > +			    in microseconds required to enter the idle state.
> > +
> > +	- exit-latency-us
> > +		Usage: Required
> > +		Value type: <prop-encoded-array>
> > +		Definition: u32 value representing worst case latency
> > +			    in microseconds required to exit the idle state.
> > +
> > +	- min-residency-us
> > +		Usage: Required
> > +		Value type: <prop-encoded-array>
> > +		Definition: u32 value representing duration in microseconds
> > +			    after which this state becomes more energy
> > +			    efficient than any shallower states.
> 
> I think this would benefit from a clearer definition.  For example, 
> should the min-residency-us value include or exclude the entry and exit 
> delays?  I think it should since that's what the cpuidle code will have 
> to use when testing against expected delay before next wakeup event in 
> any case.  Some of your examples don't assume it is the case though, as 
> the min-residency-us is smaller than entry+exit delays.
> 
> Also I think we'd need a 4th value to fully characterize a state: worst 
> case wake-up latency for QoS purposes.
> 
> Let's illustrate the different periods on a time line to make it clearer
> (hmmm let's see how this can be managed on a braille display :-O ):
> 
> EXEC:	Normal CPU execution.
> 
> PREP:	Preparation phase before committing the hardware to idle mode
> 	like cache flushing. This is abortable on pending wake-up 
> 	event conditions. The abort latency is assumed to be negligible 
> 	(i.e. less than the ENTRY + EXIT duration). If aborted, we go 
> 	back to EXEC. This phase is optional. If not abortable, this 
> 	should be included in the ENTRY phase instead.
> 
> ENTRY:	The hardware is committed to idle mode. This period must run to
> 	completion up to IDLE before anything else can happen.
> 
> IDLE:	This is the actual power-saving idle period. This may last 
> 	between 0 and infinite time, until a wake-up event occurs.
> 
> EXIT:	Period during which the CPU is brought back to operational
> 	mode (EXEC).
> 
> ...__[EXEC]__|__[PREP]--|__[ENTRY]__|__[IDLE]__|___[EXIT]_--|__[EXEC]__...
>              |          |           |          |            |
> 
>              |<-- entry-latency --->|
> 
>                                                |<- exit-  ->|
>                                                |  latency   |
> 
>              |<-------------- min-residency --------------->|
> 
>                         |<----- worst_wakeup_latency ------>|
> 
> entry-latency: Worst case latency required to enter the idle state.  The 
> exit_latency may be guaranteed only after entry-latency has passed.
> 
> min-residency: Minimum period, including preparation, entry and exit, 
> for a given power mode to be worthwhile energy wise.  It must be at 
> least equal to entry_latency + exit_latency.
> 
> worst_wakeup_latency: Maximum delay between the signaling of a wake-up 
> event and the CPU being able to execute normal code again. If not 
> specified, this is assumed to be entry-latency + exit_latency.
> 
> Notes:
> 
> The cpuidle code would only care about min-residency to select the most 
> appropriate mode based on the expected delay before the next event.
> 
> The scheduler will care about the following in the near future:
> 
> wakeup_delay = exit_latency + max(entry_latency - (now - entry_timestamp), 0)
> 
> In other words, the scheduler would wake up the CPU with the shortest 
> wake-up latency.  This wake-up latency must take into account the entry 
> latency if that period has not expired.  Here the abortable nature of 
> the PREP period is ignored on purpose because it cannot be relied upon 
> (e.g. if the cache is mostly clean then the PREP deadline may occur much 
> sooner than expected).
> 
> And pmqos would only care about worst_wakeup_latency.
> 
> So... I hope this is useful.  I think the above ascii art could be part 
> of your documentation to explain it all.

I will, it makes perfect sense, let me point out a couple of things:

1) we need 4 properties, 1 optional (worst_wakeup_latency, if not
   present defaults to entry+exit)
2) is everyone ok, given these definitions, in sorting idle states using
   min-residency-us as a rank ?
3) CPUidle:
   idle_state.exit_latency = worst-wakeup-latency
   idle_state.target_residency = min-residency-us
4) PREP (longest period) can be obtained from the other properties, IF it is
   needed
   PREP = (entry + exit) - worst_wakeup (if worst_wakeup omitted, PREP = 0)

If everyone agrees I think these bindings updated with Nico's diagram
and definitions (I will tweak them, not change them because they make
perfect sense to me) are ready to go, if anyone has concerns please
drop a comment.

Thank you Nico !
Lorenzo

