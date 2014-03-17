From: Antti P Miettinen <ananaza@iki.fi>
Subject: Re: [PATCH RFC v4 3/3] Documentation: arm: define DT idle states
 bindings
Date: Mon, 17 Mar 2014 20:26:38 +0200 (EET)
Message-ID: <20140317.202638.1149319857823818469.apm@brigitte.kvy.fi>
References: <20140317115303.GB28453@e102568-lin.cambridge.arm.com>
	<20140317.154940.169167846103479320.apm@brigitte.kvy.fi>
	<20140317144515.GC28453@e102568-lin.cambridge.arm.com>
Reply-To: ananaza@iki.fi
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mx.kvy.fi ([83.143.60.202]:4204 "EHLO mx.kvy.fi"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755568AbaCQS06 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Mon, 17 Mar 2014 14:26:58 -0400
In-Reply-To: <20140317144515.GC28453@e102568-lin.cambridge.arm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: lorenzo.pieralisi@arm.com
Cc: devicetree@vger.kernel.org, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Dave.Martin@arm.com, Mark.Rutland@arm.com, Sudeep.Holla@arm.com, Charles.Garcia-Tobin@arm.com, nico@linaro.org, robh+dt@kernel.org, pdeschrijver@nvidia.com, grant.likely@linaro.org, galak@codeaurora.org, santosh.shilimkar@ti.com, linux@arm.linux.org.uk, mark.hambleton@broadcom.com, hanjun.guo@linaro.org, daniel.lezcano@linaro.org, amit.kucheria@linaro.org, vincent.guittot@linaro.org, sboyd@codeaurora.org, t.figa@samsung.com, khilman@linaro.org, mturquette@linaro.org, broonie@kernel.org, sebastian.capella@linaro.org

From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> When we make a decision on what idle state to enter all we do, and
> that's OS agnostic, is predicting (+checking the next event) the next IRQ and
> see if it is worth entering a state or not. We have to compare it against
> a baseline, which is the processor being in standbywfi and that's what
> these bindings define.
> 
> I do not understand why you want to define min-residency against the
> previous shallower state.
> 
> What this binding says is: standbywfi is the shallower idle state in
> power consumption terms. Deeper idle states save more power than
> standbywfi if the residency in that state is at least min-residency.
> 
> I do not see where the problem is to be honest, maybe I need an example.
> 
> Thanks!
> Lorenzo

Sorry, I should have explained myself more clearly. I've been
pondering about these issues somewhat lately so I'm perhaps suffering
from a bit of a tunnel vision.

In short, when we choose an idle state based on expected idle duration
we are not comparing wfi against all possible idle states in turn and
making a decision between wfi and state X. Instead we want to choose
among all states the one that gives minimum energy for the expected
idle time. I'll try to elaborate..

Entering and exiting idle states takes time at nonzero power. To make
up for this lost energy we indeed want the time in the idle state to
be sufficiently long to make up for the lost energy. Now the important
question here is "make up compared to what?".

The energy over the idle time can be also interpreted as average
power. When the idle time increases the average power for a state
approaches the in-state power. A deeper idle state would be a state
with lower in-state power and longer entry/exit time. Therefore the
average power for a deeper idle state drops slower as function of idle
time than the average power for a shallower idle state. If we'd plot
the average power for a number of idle states as function of idle
duration, we'd get a set of "constant over idle time plus constant"
style curves. Average power for state 0 will drop fastest close to the
in-state power of state 0. Average power for state 1 will drop slower
and approach the in-state power of state 1, average power for state 2
will drop even slower and approach the in-state power of state 3.

To define that the min-residency is the breakeven time against state 0
means that we are looking at the curves and asking "when does the
average power for state X cross the average power for state 0?". But
that would be the guideline for making a decision between state 0 and
the state in question. Even if average power for state 2 is below
the average power of state 0 it is not necessarily yet below the
average power of state 1. To break even against state 1 the idle
duration needs to be longer.

Yet another way to look at this: for three states we can define three
times of interest:
- t1: the time when state1 breaks even against state0
- t2: the time when state2 breaks even against state0
- t3: the time when state2 breaks even against state1
and t3 would typically be larger than t2.

	--Antti
