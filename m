From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Subject: Re: [PATCH RFC 2/2] Documentation: arm: define DT C-states bindings
Date: Tue, 10 Dec 2013 13:27:19 +0000
Message-ID: <20131210132719.GC15543@e102568-lin.cambridge.arm.com>
References: <1386001205-11978-1-git-send-email-lorenzo.pieralisi@arm.com>
 <1386001205-11978-3-git-send-email-lorenzo.pieralisi@arm.com>
 <87lhztgqsj.fsf@iki.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: 8BIT
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from service87.mimecast.com ([91.220.42.44]:36630 "EHLO
	service87.mimecast.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752222Ab3LJN10 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 10 Dec 2013 08:27:26 -0500
In-Reply-To: <87lhztgqsj.fsf@iki.fi>
Content-Disposition: inline
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Antti Miettinen <ananaza@iki.fi>
Cc: "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Dave P Martin <Dave.Martin@arm.com>, Mark Rutland <Mark.Rutland@arm.com>, Sudeep KarkadaNagesha <Sudeep.KarkadaNagesha@arm.com>, Charles Garcia-Tobin <Charles.Garcia-Tobin@arm.com>, Nicolas Pitre <nico@linaro.org>, "rob.herring@calxeda.com" <rob.herring@calxeda.com>, Peter De Schrijver <pdeschrijver@nvidia.com>, "grant.likely@linaro.org" <grant.likely@linaro.org>, Santosh Shilimkar <santosh.shilimkar@ti.com>, Mark Hambleton <mark.hambleton@broadcom.com>, Hanjun Guo <hanjun.guo@linaro.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, Amit Kucheria <amit.kucheria@linaro.org>, Vincent Guittot <vincent.guittot@linaro.org>

On Tue, Dec 10, 2013 at 06:31:56AM +0000, Antti Miettinen wrote:
> Hi Lorenzo,
> 
> Lorenzo Pieralisi <lorenzo.pieralisi@arm.com> writes:
> > +	- latency
> > +		Usage: Required
> > +		Value type: <u32>
> > +		Definition: Worst case latency in microseconds required to
> > +			    enter and exit the C-state.
> > +
> > +	- min-residency
> > +		Usage: Required
> > +		Value type: <u32>
> > +		Definition: Time in microseconds required for the CPU to be in
> > +			    the C-state to make up for the dynamic power
> > +			    consumed to enter/exit the C-state in order to
> > +			    break even in terms of power consumption compared
> > +			    to C1 state (wfi).
> > +			    This parameter depends on the operating conditions
> > +			    (operating point, cache state) and must assume
> > +			    worst case scenario.
> 
> I have a concern with these. I know it is not the fault of this patch as
> these parameters are what current cpuidle governor/driver interface
> uses, but..

Concern is shared, that's why these bindings hit the list as early as
possible. Just to mention that, I wanted to keep them as OS agnostic
as I could, and I think min-residency might make sense (I mentioned
it has to cater for the worst case, which depends on a number of
run-time states as you describe below).

> Power state entry/exit latencies can be vary quite a lot. Especially CPU
> and memory frequencies affect them as can e.g. PMIC properties. Also
> power level during entry/exit depends on clocks and voltages. Also the
> power level of a sleep state can be context dependent (clocks and
> voltages). These mean that also the minimum residency for energy break
> even varies. Defining a minimum residency against C1 is a bit
> arbitrary. There is no guarantee that the break even order of idle
> states remains constant over device context changes.

Agree 100%.

> I have not really properly thought through this but here's an idea.. how
> about an alternative interface between governor and driver? The cpuidle
> core would provide the expected wakeup time and currently enforced
> minimum latency to the driver and the driver would make the decision
> about the state to choose.

I do not think we should think about how the kernel uses this data.
We should strive to make DT data representative of HW C-states and
that's very complex, as you mentioned (it depends at what granularity
we want these bits of info).

When we are happy with the bindings we can then code the kernel accordingly.

Please let me know how you would like to have these bindings extended
(eg adding operating points), getting feedback is the main reason why
I posted them in the first place.

Thank you,
Lorenzo

