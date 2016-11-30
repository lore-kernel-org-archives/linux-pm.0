From: Stephen Boyd <sboyd@codeaurora.org>
Subject: Re: [PATCH 1/2] PM / Domains: Introduce domain-performance-state
 binding
Date: Tue, 29 Nov 2016 17:08:04 -0800
Message-ID: <20161130010804.GI6095@codeaurora.org>
References: <20161122031717.GE10014@vireshk-i7>
 <m260nfz8mr.fsf@baylibre.com>
 <CAKfTPtDR6Y5UgaqJ+D5T0yBeFRSYWm6OT1+r4ZABrtqtvF2D0w@mail.gmail.com>
 <m2wpfuw5wq.fsf@baylibre.com>
 <CAKfTPtBMro7+UruF0-E26TJPu6pEAvkjF9V7SKriNBm5q+K9+A@mail.gmail.com>
 <m2fumhx21h.fsf@baylibre.com>
 <20161124020322.GI6095@codeaurora.org>
 <20161124044020.GC9376@vireshk-i7>
 <4f815e31-22d0-fef7-953c-257fa2bbcb9d@codeaurora.org>
 <20161129065726.GG3288@vireshk-i7>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:56728 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752427AbcK3BIG (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 29 Nov 2016 20:08:06 -0500
Content-Disposition: inline
In-Reply-To: <20161129065726.GG3288@vireshk-i7>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Kevin Hilman <khilman@baylibre.com>, Vincent Guittot <vincent.guittot@linaro.org>, Rob Herring <robh@kernel.org>, Rafael Wysocki <rjw@rjwysocki.net>, "linaro-kernel@lists.linaro.org" <linaro-kernel@lists.linaro.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>, Mark Rutland <mark.rutland@arm.com>, Ulf Hansson <ulf.hansson@linaro.org>, Lina Iyer <lina.iyer@linaro.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Nayak Rajendra <rnayak@codeaurora.org>

On 11/29, Viresh Kumar wrote:
> On 28-11-16, 10:27, Stephen Boyd wrote:
> > On 11/23/2016 08:40 PM, Viresh Kumar wrote:
> > > But even in these cases we wouldn't be using the voltage values within the
> > > kernel as we will be giving only a performance state to the M3 core, right?
> > 
> > Nope. In these cases we need to set a certain voltage and we do that by
> > requesting it via the M3 core.
> 
> Don't we need something like this then ?

Perhaps. One question is if we consider a shared regulator as a
regulator in the kernel, or if we want to hide the regulator
behind some other API that aggregates the users of the voltage. I
don't see how to draw the line clearly between a regulator and a
power domain that modifies a regulator underneath. It seems like
everything that's using a regulator on the SoC could be using a
power domain instead and then we could be aggregating the voltage
requirements outside of the regulator APIs.

The only other way I can think of doing it is by having the
voltages in the OPP tables for each device. That gets sort of
messy though because all the devices calling
regulator_set_voltage() have to set the min voltage to be their
required voltage and the max to be the global max voltage on the
system. Otherwise a higher voltage may not be used while it may
be required. Of course, we could encode that as the last value in
the triplet and everything works.

> 
> 	parent: power-controller@12340000 {
> 		compatible = "foo,power-controller";
> 		reg = <0x12340000 0x1000>;
> 		#power-domain-cells = <0>;
> 		domain-performance-states = <&perf_state0>;
> 	};
> 
> 	perf_state0: performance_states {
> 		pstate1: pstate@1 {
> 			index = <1>;
> 			/* Optional */
> 			microvolt = <970000 975000 985000>;
> 		};
> 		pstate2: pstate@2 {
> 			index = <2>;
> 			/* Optional */
> 			microvolt = <970000 975000 985000>;
> 		};
> 		pstate3: pstate@3 {
> 			index = <3>;
> 			/* Optional */
> 			microvolt = <970000 975000 985000>;
> 		};
> 	}
> 
> 	cpus {
> 		cpu@0 {
> 			...
> 			power-domain = <&parent>;
> 			operating-points-v2 = <&cpu0_opp_table>;
> 		};
> 	};
> 
> 	cpu0_opp_table: opp_table0 {
> 		compatible = "operating-points-v2";
> 		opp-shared;
> 
> 		opp@1000000000 {
> 			opp-hz = /bits/ 64 <1000000000>;
> 			domain-performance-state = <&pstate1>;

What do we do if the device is part of multiple domains? For
example it may be part of two power domains for different pieces
of the silicon within one device, and we may want to
independently control those domains depending on the clock
frequency.

> 		};
> 		opp@1100000000 {
> 			opp-hz = /bits/ 64 <1100000000>;
> 			domain-performance-state = <&pstate2>;
> 		};
> 		opp@1200000000 {
> 			opp-hz = /bits/ 64 <1200000000>;
> 			domain-performance-state = <&pstate3>;
> 		};

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
