From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH V4 1/9] PM / OPP: Allow OPP table to be used for
 power-domains
Date: Mon, 10 Apr 2017 14:55:15 +0530
Message-ID: <20170410092515.GF24555@vireshk-i7>
References: <cover.1490001099.git.viresh.kumar@linaro.org>
 <e772e67a5445319bb8e0f312846ace666adc097f.1490001099.git.viresh.kumar@linaro.org>
 <20170324154451.ljszby3mhc4rlgnw@rob-hp-laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170324154451.ljszby3mhc4rlgnw@rob-hp-laptop>
Sender: linux-kernel-owner@vger.kernel.org
To: Rob Herring <robh@kernel.org>
Cc: Rafael Wysocki <rjw@rjwysocki.net>, ulf.hansson@linaro.org, Kevin Hilman <khilman@linaro.org>, Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@codeaurora.org>, linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>, lina.iyer@linaro.org, rnayak@codeaurora.org, devicetree@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On 24-03-17, 10:44, Rob Herring wrote:
> On Mon, Mar 20, 2017 at 03:02:13PM +0530, Viresh Kumar wrote:
> > Power-domains need to express their active states in DT and what's
> > better than OPP table for that.
> > 
> > This patch allows power-domains to reuse OPP tables to express their
> > active states. The "opp-hz" property isn't a required property anymore
> > as power-domains may not always use them.
> 
> Then maybe you shouldn't be trying to make OPP table work here. At that 
> point you just need a table of voltage(s) per performance state?

Because that's what Kevin strongly recommended in the previous
versions.

@Kevin: Would you like to reply here ?

> > Add a new property "domain-performance-state", which will contain
> > positive integer values to represent performance levels of the
> > power-domains as described in this patch.
> 
> Why not reference the OPP entries from the domain:
> 
> performance-states = <&opp1>, <&opp2>;

Because that would require additional code in the OPP core to parse
these then. Right now it is quite straight forward with the bindings I
presented.

> Just thinking out loud, not saying that is what you should do. The 
> continual evolution of power (management) domain, idle state, and OPP 
> bindings is getting tiring.

I agree :)

-- 
viresh
