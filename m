From: Viresh Kumar <viresh.kumar-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH V4 1/9] PM / OPP: Allow OPP table to be used for
 power-domains
Date: Thu, 13 Apr 2017 11:07:36 +0530
Message-ID: <20170413053736.GM5910@vireshk-i7>
References: <cover.1490001099.git.viresh.kumar@linaro.org>
 <e772e67a5445319bb8e0f312846ace666adc097f.1490001099.git.viresh.kumar@linaro.org>
 <0a7146f9-72f1-317c-3aab-770a72462968@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <0a7146f9-72f1-317c-3aab-770a72462968-5wv7dgnIgG8@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Sudeep Holla <sudeep.holla-5wv7dgnIgG8@public.gmane.org>
Cc: Rafael Wysocki <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>, ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, Kevin Hilman <khilman-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Viresh Kumar <vireshk-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Nishanth Menon <nm-l0cyMroinI0@public.gmane.org>, Stephen Boyd <sboyd-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, linaro-kernel-cunTk1MwBs8s++Sfvej+rw@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Vincent Guittot <vincent.guittot-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, lina.iyer-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, rnayak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-pm@vger.kernel.org

On 12-04-17, 17:49, Sudeep Holla wrote:
> On 20/03/17 09:32, Viresh Kumar wrote:
> > diff --git a/Documentation/devicetree/bindings/opp/opp.txt b/Documentation/devicetree/bindings/opp/opp.txt
> > index 63725498bd20..d0b95c9e1011 100644
> > --- a/Documentation/devicetree/bindings/opp/opp.txt
> > +++ b/Documentation/devicetree/bindings/opp/opp.txt
> > @@ -76,10 +76,9 @@ This describes the OPPs belonging to a device. This node can have following
> >  This defines voltage-current-frequency combinations along with other related
> >  properties.
> >  
> > -Required properties:
> > +Optional properties:
> >  - opp-hz: Frequency in Hz, expressed as a 64-bit big-endian integer.
> >  
> > -Optional properties:
> >  - opp-microvolt: voltage in micro Volts.
> >  
> >    A single regulator's voltage is specified with an array of size one or three.
> > @@ -154,6 +153,19 @@ properties.
> >  
> >  - status: Marks the node enabled/disabled.
> >  
> > +- domain-performance-state: A positive integer value representing the minimum
> > +  power-domain performance level required by the device for the OPP node. The
> 
> So the above definition is when this field in in the device node rather
> than the OPP table entry, right ?

No. We are updating the opp.txt file here and so it is not about the
device node. The OPP node entries will contain this field for two
cases:
- The OPP table belongs to a power domain
- The OPP table belongs to a device whose power domain supports
  performance-states.

> For simplicity why not have the
> properties named slightly different or just use phandle to an entry in
> the device node for this purpose.

We really need a value here. For example, in case where the OPP table
defines the states of the power-domain itself, we don't have any
phandles to point to.

> > +  The integer value '0' represents the lowest performance level and the higher
> > +  values represent higher performance levels. 
> 
> needs to be changed as OPP table entry.

Not sure I understood what change you are looking for :(

> >  When present in the OPP table of a
> > + power-domain, it represents the performance level of the domain. When present
> 
> again "performance level of the domain corresponding to that OPP entry"
> on something similar

Ok.

> > +  in the OPP table of a normal device, it represents the performance level of
> 
> what do you mean by normal device ? needs description as that's
> something new introduced here.

It should be non-power-domain node.

> > +  the parent power-domain. The OPP table can contain the
> > +  "domain-performance-state" property, only if the device node contains the
> > +  "power-domains" or "#power-domain-cells" property. 
> 
> Why such a restriction ?

Why would we use it for non-power-domain cases? That's not what we
are looking for..

> > The OPP nodes aren't
> > +  allowed to contain the "domain-performance-state" property partially, i.e.
> > +  Either all OPP nodes in the OPP table have the "domain-performance-state"
> > +  property or none of them have it.
> > +
> >  Example 1: Single cluster Dual-core ARM cortex A9, switch DVFS states together.
> >  
> >  / {
> > @@ -528,3 +540,60 @@ Example 5: opp-supported-hw
> >  		};
> >  	};
> >  };
> > +
> > +Example 7: domain-Performance-state:
> > +(example: For 1GHz require domain state 1 and for 1.1 & 1.2 GHz require state 2)
> > +
> > +/ {
> > +	domain_opp_table: opp_table0 {
> > +		compatible = "operating-points-v2";
> > +
> > +		opp@1 {
> > +			domain-performance-state = <1>;
> > +			opp-microvolt = <975000 970000 985000>;
> > +		};
> > +		opp@2 {
> > +			domain-performance-state = <2>;
> > +			opp-microvolt = <1075000 1000000 1085000>;
> > +		};
> > +	};
> > +
> > +	foo_domain: power-controller@12340000 {
> > +		compatible = "foo,power-controller";
> > +		reg = <0x12340000 0x1000>;
> > +		#power-domain-cells = <0>;
> > +		operating-points-v2 = <&domain_opp_table>;
> 
> How does it scale with power domain providers with multiple power domain ?

Devices can't have multiple power domains today. Will see this when
that support is added.

Note that only the power domains can have multiple parent power
domains today.

> > +	}
> > +
> > +	cpu0_opp_table: opp_table1 {
> > +		compatible = "operating-points-v2";
> > +		opp-shared;
> > +
> > +		opp@1000000000 {
> > +			opp-hz = /bits/ 64 <1000000000>;
> > +			domain-performance-state = <1>;
> > +		};
> > +		opp@1100000000 {
> > +			opp-hz = /bits/ 64 <1100000000>;
> > +			domain-performance-state = <2>;
> > +		};
> > +		opp@1200000000 {
> > +			opp-hz = /bits/ 64 <1200000000>;
> > +			domain-performance-state = <2>;
> > +		};
> > +	};
> > +
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
> 
> Do we ignore operating-points-v2 above as this device/cpu node contains
> power domain which has operating-points-v2 property ? In other words
> how do they correlate ?

Devices and their power domains can both have their performance
states. Just that to get the device in a particular state, we may need
to get its power domain to a particular state first.

-- 
viresh
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
