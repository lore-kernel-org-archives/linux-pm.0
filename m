From: Antti P Miettinen <ananaza@iki.fi>
Subject: Re: [PATCH RFC v4 3/3] Documentation: arm: define DT idle states
 bindings
Date: Mon, 17 Mar 2014 15:49:40 +0200 (EET)
Message-ID: <20140317.154940.169167846103479320.apm@brigitte.kvy.fi>
References: <1392724051-11950-4-git-send-email-lorenzo.pieralisi@arm.com>
	<20140317.131507.1338341364843764791.apm@brigitte.kvy.fi>
	<20140317115303.GB28453@e102568-lin.cambridge.arm.com>
Reply-To: ananaza@iki.fi
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mx.kvy.fi ([83.143.60.202]:59109 "EHLO mx.kvy.fi"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933293AbaCQNtw (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Mon, 17 Mar 2014 09:49:52 -0400
In-Reply-To: <20140317115303.GB28453@e102568-lin.cambridge.arm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: lorenzo.pieralisi@arm.com
Cc: devicetree@vger.kernel.org, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Dave.Martin@arm.com, Mark.Rutland@arm.com, Sudeep.Holla@arm.com, Charles.Garcia-Tobin@arm.com, nico@linaro.org, robh+dt@kernel.org, pdeschrijver@nvidia.com, grant.likely@linaro.org, galak@codeaurora.org, santosh.shilimkar@ti.com, linux@arm.linux.org.uk, mark.hambleton@broadcom.com, hanjun.guo@linaro.org, daniel.lezcano@linaro.org, amit.kucheria@linaro.org, vincent.guittot@linaro.org, sboyd@codeaurora.org, t.figa@samsung.com, khilman@linaro.org, mturquette@linaro.org, broonie@kernel.org, sebastian.capella@linaro.org

From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> Hi Antti,
> 
> On Mon, Mar 17, 2014 at 11:15:07AM +0000, Antti P Miettinen wrote:
>> Sorry for having been lazy in commenting..
> 
> No worries, comments always welcome.
> 
>> From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
>> Date: Tue, 18 Feb 2014 11:47:31 +0000
>> > +	- min-residency
>> > +		Usage: Required
>> > +		Value type: <prop-encoded-array>
>> > +		Definition: u32 value representing time in microseconds
>> > +			    required for the CPU to be in the idle state to
>> > +			    break even in power consumption terms compared
>> > +			    to idle state idle_standby ([4][5]).
>> 
>> To me this continues to be a bit illdefined. Say we have three states:
>> 0,1,2. State 0 is the idle_standby. Providing a minimum residency for
>> state 1 compared to state 0 sort of makes sense, but if we provide a
>> minimum residency for state 2 compared to state 0 the break even time
>> is going to be smaller than break even when comparing state 1 and
>> state 2. With this data we'd enter state 2 when we'd be better off
>> entering state 1.
> 
> I am not sure I got your reply right, but min-residency for
> state 2 will be higher than state 1, since it has to cater for the
> dynamic power consumed by entering the state (but burns less power
> than state 1 when _in_ the state).
> 
> Entering a state has a power cost and min-residency should take that into
> account, worst-case as per other stats.
> 
> min-residency (and so the break-even) should take into account that
> entering the state is not for free.
> 
> I think that comparing against idle_standby is the only sane way we can
> define that parameter, either that or we remove it.
> 
> Does it make sense ?
> 
> Thanks !
> Lorenzo

The point is that if you compare breakeven between state 0 and state 2
the breakeven time will be smaller that when you compare the breakeven
between state 1 and state 2. Assuming states ordered by "deepness" in
the sense that deeper states have lower in-state power and longer
entry/exit times.

I guess you could specify that the min-residency defines the time when
the state breaks even compared to the previous (shallower) state.

	--Antti
