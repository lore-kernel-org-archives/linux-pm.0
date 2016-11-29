From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH 1/2] PM / Domains: Introduce domain-performance-state
 binding
Date: Tue, 29 Nov 2016 12:27:26 +0530
Message-ID: <20161129065726.GG3288@vireshk-i7>
References: <20161121150708.j4gosfr2uetc7mwp@rob-hp-laptop>
 <20161122031717.GE10014@vireshk-i7>
 <m260nfz8mr.fsf@baylibre.com>
 <CAKfTPtDR6Y5UgaqJ+D5T0yBeFRSYWm6OT1+r4ZABrtqtvF2D0w@mail.gmail.com>
 <m2wpfuw5wq.fsf@baylibre.com>
 <CAKfTPtBMro7+UruF0-E26TJPu6pEAvkjF9V7SKriNBm5q+K9+A@mail.gmail.com>
 <m2fumhx21h.fsf@baylibre.com>
 <20161124020322.GI6095@codeaurora.org>
 <20161124044020.GC9376@vireshk-i7>
 <4f815e31-22d0-fef7-953c-257fa2bbcb9d@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pg0-f43.google.com ([74.125.83.43]:35553 "EHLO
        mail-pg0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755776AbcK2G5a (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 29 Nov 2016 01:57:30 -0500
Received: by mail-pg0-f43.google.com with SMTP id p66so66317509pga.2
        for <linux-pm@vger.kernel.org>; Mon, 28 Nov 2016 22:57:30 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <4f815e31-22d0-fef7-953c-257fa2bbcb9d@codeaurora.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Stephen Boyd <sboyd@codeaurora.org>
Cc: Kevin Hilman <khilman@baylibre.com>, Vincent Guittot <vincent.guittot@linaro.org>, Rob Herring <robh@kernel.org>, Rafael Wysocki <rjw@rjwysocki.net>, "linaro-kernel@lists.linaro.org" <linaro-kernel@lists.linaro.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>, Mark Rutland <mark.rutland@arm.com>, Ulf Hansson <ulf.hansson@linaro.org>, Lina Iyer <lina.iyer@linaro.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Nayak Rajendra <rnayak@codeaurora.org>

On 28-11-16, 10:27, Stephen Boyd wrote:
> On 11/23/2016 08:40 PM, Viresh Kumar wrote:
> > But even in these cases we wouldn't be using the voltage values within the
> > kernel as we will be giving only a performance state to the M3 core, right?
> 
> Nope. In these cases we need to set a certain voltage and we do that by
> requesting it via the M3 core.

Don't we need something like this then ?

	parent: power-controller@12340000 {
		compatible = "foo,power-controller";
		reg = <0x12340000 0x1000>;
		#power-domain-cells = <0>;
		domain-performance-states = <&perf_state0>;
	};

	perf_state0: performance_states {
		pstate1: pstate@1 {
			index = <1>;
			/* Optional */
			microvolt = <970000 975000 985000>;
		};
		pstate2: pstate@2 {
			index = <2>;
			/* Optional */
			microvolt = <970000 975000 985000>;
		};
		pstate3: pstate@3 {
			index = <3>;
			/* Optional */
			microvolt = <970000 975000 985000>;
		};
	}

	cpus {
		cpu@0 {
			...
			power-domain = <&parent>;
			operating-points-v2 = <&cpu0_opp_table>;
		};
	};

	cpu0_opp_table: opp_table0 {
		compatible = "operating-points-v2";
		opp-shared;

		opp@1000000000 {
			opp-hz = /bits/ 64 <1000000000>;
			domain-performance-state = <&pstate1>;
		};
		opp@1100000000 {
			opp-hz = /bits/ 64 <1100000000>;
			domain-performance-state = <&pstate2>;
		};
		opp@1200000000 {
			opp-hz = /bits/ 64 <1200000000>;
			domain-performance-state = <&pstate3>;
		};
	};

-- 
viresh
