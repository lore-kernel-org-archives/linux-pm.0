From: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH V3 2/7] PM / OPP: Introduce "domain-performance-state"
 binding to OPP nodes
Date: Mon, 27 Feb 2017 18:39:48 -0600
Message-ID: <20170228003948.ihf4c2ppu2rf3lt2@rob-hp-laptop>
References: <cover.1487926924.git.viresh.kumar@linaro.org>
 <ceb1bf5f696138c30b30743c24b619336d438d7c.1487926924.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <ceb1bf5f696138c30b30743c24b619336d438d7c.1487926924.git.viresh.kumar-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Viresh Kumar <viresh.kumar-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: Rafael Wysocki <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>, ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, Kevin Hilman <khilman-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Viresh Kumar <vireshk-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Nishanth Menon <nm-l0cyMroinI0@public.gmane.org>, Stephen Boyd <sboyd-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, linaro-kernel-cunTk1MwBs8s++Sfvej+rw@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Vincent Guittot <vincent.guittot-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, lina.iyer-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, rnayak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-pm@vger.kernel.org

On Fri, Feb 24, 2017 at 02:36:34PM +0530, Viresh Kumar wrote:
> If the consumers don't need the capability of switching to different
> domain performance states at runtime, then they can simply define their
> required domain performance state in their nodes directly.
> 
> But if the device needs the capability of switching to different domain
> performance states, as they may need to support different clock rates,
> then the per OPP node can be used to contain that information.
> 
> This patch introduces the domain-performance-state (already defined by
> Power Domain bindings) to the per OPP node.
> 

We already have OPP voltages, why are those not sufficient?

> Signed-off-by: Viresh Kumar <viresh.kumar-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
> Tested-by: Rajendra Nayak <rnayak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
> ---
>  Documentation/devicetree/bindings/opp/opp.txt | 64 +++++++++++++++++++++++++++
>  1 file changed, 64 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/opp/opp.txt b/Documentation/devicetree/bindings/opp/opp.txt
> index 9f5ca4457b5f..7f6bb52521b6 100644
> --- a/Documentation/devicetree/bindings/opp/opp.txt
> +++ b/Documentation/devicetree/bindings/opp/opp.txt
> @@ -154,6 +154,15 @@ properties.
>  
>  - status: Marks the node enabled/disabled.
>  
> +- domain-performance-state: A positive integer value representing the minimum
> +  performance level (of the parent domain) required by the consumer as defined
> +  by ../power/power_domain.txt binding document. The OPP nodes can contain the
> +  "domain-performance-state" property, only if the device node contains a
> +  "power-domains" property. The OPP nodes aren't allowed to contain the
> +  "domain-performance-state" property partially, i.e. Either all OPP nodes in
> +  the OPP table have the "domain-performance-state" property or none of them
> +  have it.
> +
>  Example 1: Single cluster Dual-core ARM cortex A9, switch DVFS states together.
>  
>  / {
> @@ -528,3 +537,58 @@ Example 5: opp-supported-hw
>  		};
>  	};
>  };
> +
> +Example 7: domain-Performance-state:
> +(example: For 1GHz require domain state 1 and for 1.1 & 1.2 GHz require state 2)
> +
> +/ {
> +	cpu0_opp_table: opp_table0 {
> +		compatible = "operating-points-v2";
> +		opp-shared;
> +
> +		opp@1000000000 {
> +			opp-hz = /bits/ 64 <1000000000>;
> +			domain-performance-state = <1>;

Thinking about this some more, there's a problem here that you have no 
link to foo_domain. I guess that resides in the cpu's node?

Perhaps instead of a number, this should be a phandle to pstate@1. Then 
you just get the parent if you need to know the domain.

> +		};
> +		opp@1100000000 {
> +			opp-hz = /bits/ 64 <1100000000>;
> +			domain-performance-state = <2>;
> +		};
> +		opp@1200000000 {
> +			opp-hz = /bits/ 64 <1200000000>;
> +			domain-performance-state = <2>;
> +		};
> +	};
> +
> +	foo_domain: power-controller@12340000 {
> +		compatible = "foo,power-controller";
> +		reg = <0x12340000 0x1000>;
> +		#power-domain-cells = <0>;
> +
> +		performance-states {
> +			compatible = "domain-performance-state";
> +			pstate@1 {
> +				reg = <1>;
> +				domain-microvolt = <970000 975000 985000>;
> +			};
> +			pstate@2 {
> +				reg = <2>;
> +				domain-microvolt = <1000000 1075000 1085000>;
> +			};
> +		};
> +	}
> +
> +	cpus {
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +
> +		cpu@0 {
> +			compatible = "arm,cortex-a9";
> +			reg = <0>;
> +			clocks = <&clk_controller 0>;
> +			clock-names = "cpu";
> +			operating-points-v2 = <&cpu0_opp_table>;
> +			power-domains = <&foo_domain>;
> +		};
> +	};
> +};
> -- 
> 2.7.1.410.g6faf27b
> 
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
