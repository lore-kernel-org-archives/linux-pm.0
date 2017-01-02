From: Viresh Kumar <viresh.kumar-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH V2 1/2] PM / Domains: Introduce domain-performance-states
 binding
Date: Mon, 2 Jan 2017 15:35:03 +0530
Message-ID: <20170102100503.GG13679@vireshk-i7>
References: <cover.1481539827.git.viresh.kumar@linaro.org>
 <dd95df02a1c3efd00bd4890f8aceeb717ad38788.1481539827.git.viresh.kumar@linaro.org>
 <20161222183453.xlkfrb2f4stcfr32@rob-hp-laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20161222183453.xlkfrb2f4stcfr32@rob-hp-laptop>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: Rafael Wysocki <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>, linaro-kernel-cunTk1MwBs8s++Sfvej+rw@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Stephen Boyd <sboyd-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Nishanth Menon <nm-l0cyMroinI0@public.gmane.org>, Vincent Guittot <vincent.guittot-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Kevin Hilman <khilman-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Lina Iyer <lina.iyer-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Nayak Rajendra <rnayak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

On 22-12-16, 12:34, Rob Herring wrote:
> > +Optional properties:
> > +- domain-performance-state: A phandle of a Performance state node.
> > +
> > +Example:
> > +
> > +	parent: power-controller@12340000 {
> > +		compatible = "foo,power-controller";
> > +		reg = <0x12340000 0x1000>;
> > +		#power-domain-cells = <0>;
> > +		domain-performance-states = <&domain_perf_states>;
> > +	};
> > +
> > +	domain_perf_states: performance_states {
> 
> If you want to have performance states for a domain in DT, then you need 
> to actually have a node for the domain in DT. Then this should be a 
> child of the domain. I wouldn't think non-CPU domain performance states 
> will be common across domains.

So you suggest something like this then ?

+       parent: power-controller@12340000 {
+               compatible = "foo,power-controller";
+               reg = <0x12340000 0x1000>;
+               #power-domain-cells = <0>;
+
+               performance_states {
+                       compatible = "domain-performance-state";
+                       domain_perf_state1: pstate@1 {
+                               performance-level = <1>;
+                               domain-microvolt = <970000 975000 985000>;
+                       };
+                       domain_perf_state2: pstate@2 {
+                               performance-level = <2>;
+                               domain-microvolt = <1000000 1075000 1085000>;
+                       };
+                       domain_perf_state3: pstate@3 {
+                               performance-level = <3>;
+                               domain-microvolt = <1100000 1175000 1185000>;
+                       };
+               }
+       };
+

> 
> > +		compatible = "domain-performance-state";
> > +		domain_perf_state1: pstate@1 {
> 
> A unit address should have a reg property.

There is no register address here. Similar problem as the OPP table
where we ended up using the frequency. What should we do here ?

> > +			performance-level = <1>;
> > +			domain-microvolt = <970000 975000 985000>;
> > +		};
> > +		domain_perf_state2: pstate@2 {
> > +			performance-level = <2>;
> > +			domain-microvolt = <1000000 1075000 1085000>;
> > +		};
> > +		domain_perf_state3: pstate@3 {
> > +			performance-level = <3>;
> > +			domain-microvolt = <1100000 1175000 1185000>;
> > +		};
> > +	}
> > +
> > +	leaky-device@12350000 {
> > +		compatible = "foo,i-leak-current";
> > +		reg = <0x12350000 0x1000>;
> > +		power-domains = <&power 0>;
> > +		domain-performance-state = <&domain_perf_state2>;
> 
> domain-performance-state and domain-performance-states are too similar 
> in name. The property here should probably reflect the mode needed and 
> perhaps specific to the device.

Its the state of its power domain which is required for the
functioning of the device.

> I assume a device will need multiple states/modes.

Such devices are handled by the 2nd patch, which uses OPP table for
this. The above example is for simple devices, which have a fixed
requirement.

> Also, since you refer to the performance state node directly, I'm not 
> sure why you need the performance-level property.

That value will be used by the genpd core to pass on to the platform
specific code which will take care of updating the domain state. For
example in case of Qcom, it is a separate M3 core which accepts these
values.

-- 
viresh
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
