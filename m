From: Viresh Kumar <viresh.kumar-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH V3 2/7] PM / OPP: Introduce "domain-performance-state"
 binding to OPP nodes
Date: Tue, 28 Feb 2017 12:27:11 +0530
Message-ID: <20170228065711.GD19417@vireshk-i7>
References: <cover.1487926924.git.viresh.kumar@linaro.org>
 <ceb1bf5f696138c30b30743c24b619336d438d7c.1487926924.git.viresh.kumar@linaro.org>
 <20170228003948.ihf4c2ppu2rf3lt2@rob-hp-laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20170228003948.ihf4c2ppu2rf3lt2@rob-hp-laptop>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: Rafael Wysocki <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>, ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, Kevin Hilman <khilman-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Viresh Kumar <vireshk-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Nishanth Menon <nm-l0cyMroinI0@public.gmane.org>, Stephen Boyd <sboyd-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, linaro-kernel-cunTk1MwBs8s++Sfvej+rw@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Vincent Guittot <vincent.guittot-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, lina.iyer-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, rnayak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-pm@vger.kernel.org

On 27-02-17, 18:39, Rob Herring wrote:
> On Fri, Feb 24, 2017 at 02:36:34PM +0530, Viresh Kumar wrote:
> > If the consumers don't need the capability of switching to different
> > domain performance states at runtime, then they can simply define their
> > required domain performance state in their nodes directly.
> > 
> > But if the device needs the capability of switching to different domain
> > performance states, as they may need to support different clock rates,
> > then the per OPP node can be used to contain that information.
> > 
> > This patch introduces the domain-performance-state (already defined by
> > Power Domain bindings) to the per OPP node.
> > 
> 
> We already have OPP voltages, why are those not sufficient?

Those are for the regulator that ONLY controls the device, and
domain-performance-state belongs to the parent domain which controls many
devices.

> > +Example 7: domain-Performance-state:
> > +(example: For 1GHz require domain state 1 and for 1.1 & 1.2 GHz require state 2)
> > +
> > +/ {
> > +	cpu0_opp_table: opp_table0 {
> > +		compatible = "operating-points-v2";
> > +		opp-shared;
> > +
> > +		opp@1000000000 {
> > +			opp-hz = /bits/ 64 <1000000000>;
> 
> Thinking about this some more, there's a problem here that you have no 
> link to foo_domain. I guess that resides in the cpu's node?

Right, the "cpus" node below demonstrates that.

> > +	cpus {
> > +		#address-cells = <1>;
> > +		#size-cells = <0>;
> > +
> > +		cpu@0 {
> > +			compatible = "arm,cortex-a9";
> > +			reg = <0>;
> > +			clocks = <&clk_controller 0>;
> > +			clock-names = "cpu";
> > +			operating-points-v2 = <&cpu0_opp_table>;
> > +			power-domains = <&foo_domain>;
> > +		};
> > +	};
> > +};

> > +			domain-performance-state = <1>;

> Perhaps instead of a number, this should be a phandle to pstate@1. Then 
> you just get the parent if you need to know the domain.

That's what I did in V2, but then I turned it down considering the parent/child
relationships we may have.

There are multiple cases we can have:

A.) DeviceX  --->  Parent-domain-1 (Contains Perfomance states)

B.) DeviceX  --->  Parent-domain-1  ---> Parent domain-2 (Contains Perfomance states)

                                    ---> Parent domain-2 (Contains Perfomance states)
                                    |
                                    |
C.) DeviceX  --->  Parent-domain-1  |
                                    |
                                    |
                                    ---> Parent domain-3 (Contains Perfomance states)


The case A.) represents a simple case where the parent domain of the device
contains the performance states. The phandle can work pretty well in this case.
But the other cases B.) and C.) are a bit complicated as the direct parent
domain doesn't allow changing the performance states, but its parents. And so I
went ahead with numbers instead of phandles. Yes, we will still be able to get
to the performance state node with the help of phandles, but will that be the
right thing to do ?

-- 
viresh
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
