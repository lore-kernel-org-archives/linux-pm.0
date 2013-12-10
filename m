From: Antti Miettinen <ananaza@iki.fi>
Subject: Re: [PATCH RFC 2/2] Documentation: arm: define DT C-states bindings
Date: Wed, 11 Dec 2013 00:04:27 +0200
Message-ID: <87haaggy6s.fsf@iki.fi>
References: <1386001205-11978-1-git-send-email-lorenzo.pieralisi@arm.com>
	<1386001205-11978-3-git-send-email-lorenzo.pieralisi@arm.com>
	<87lhztgqsj.fsf@iki.fi>
	<20131210132719.GC15543@e102568-lin.cambridge.arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mx.kvy.fi ([83.143.60.202]:49496 "EHLO mx.kvy.fi"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751349Ab3LJWEk (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Tue, 10 Dec 2013 17:04:40 -0500
In-Reply-To: <20131210132719.GC15543@e102568-lin.cambridge.arm.com> (Lorenzo
	Pieralisi's message of "Tue, 10 Dec 2013 13:27:19 +0000")
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Dave P Martin <Dave.Martin@arm.com>, Mark Rutland <Mark.Rutland@arm.com>, Sudeep KarkadaNagesha <Sudeep.KarkadaNagesha@arm.com>, Charles Garcia-Tobin <Charles.Garcia-Tobin@arm.com>, Nicolas Pitre <nico@linaro.org>, "rob.herring@calxeda.com" <rob.herring@calxeda.com>, Peter De Schrijver <pdeschrijver@nvidia.com>, "grant.likely@linaro.org" <grant.likely@linaro.org>, Santosh Shilimkar <santosh.shilimkar@ti.com>, Mark Hambleton <mark.hambleton@broadcom.com>, Hanjun Guo <hanjun.guo@linaro.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, Amit Kucheria <amit.kucheria@linaro.org>, Vincent Guittot <vincent.guittot@linaro.org>

Lorenzo Pieralisi <lorenzo.pieralisi@arm.com> writes:
> I do not think we should think about how the kernel uses this data.
> We should strive to make DT data representative of HW C-states and
> that's very complex, as you mentioned (it depends at what granularity
> we want these bits of info).
>
> When we are happy with the bindings we can then code the kernel accordingly.
>
> Please let me know how you would like to have these bindings extended
> (eg adding operating points), getting feedback is the main reason why
> I posted them in the first place.

Hmm.. I'd like to challenge that a bit. I guess we are not defining DT
bindings just for the joy of modelling the hardware? We should care
whether kernel needs the data and have some idea of how the data will be
used.

As you say, modelling C state details is not trivial. It might be
possible to construct an approximate formula for e.g. entry/exit latency
that takes CPU frequency, memory frequency and PMIC ramp rates as
input. Also, in principle we could estimate power based on clocks,
voltages, temperature etc. As we probably do not want to put function
definitions to DT, the DT would contain e.g. coefficients for functions
that would need to be platform neutral.

Is this what you'd like to see? There has been some research in
estimating power without actually measuring it, e.g. the google
powertutor people have written some papers about this. The latencies
could be measured to some extend with instrumentation in the kernel and
the measurement results could be used to tune some parameters.

Or would you rather have tables, which specify latencies and power
levels and the tables would be indexed with frequencies and voltages?

Anyway, I would really like to see the option of having the state choice
in the driver. One possible way to achieve this would be to allow for
the driver to export an optional "choose" method. If that exists the
governor would offload the decision to the driver.

	--Antti
