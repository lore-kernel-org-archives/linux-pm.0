From: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH V2 1/2] PM / Domains: Introduce domain-performance-states
 binding
Date: Thu, 22 Dec 2016 12:34:53 -0600
Message-ID: <20161222183453.xlkfrb2f4stcfr32@rob-hp-laptop>
References: <cover.1481539827.git.viresh.kumar@linaro.org>
 <dd95df02a1c3efd00bd4890f8aceeb717ad38788.1481539827.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <dd95df02a1c3efd00bd4890f8aceeb717ad38788.1481539827.git.viresh.kumar-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Viresh Kumar <viresh.kumar-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: Rafael Wysocki <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>, linaro-kernel-cunTk1MwBs8s++Sfvej+rw@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Stephen Boyd <sboyd-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Nishanth Menon <nm-l0cyMroinI0@public.gmane.org>, Vincent Guittot <vincent.guittot-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Kevin Hilman <khilman-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Lina Iyer <lina.iyer-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Nayak Rajendra <rnayak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

On Mon, Dec 12, 2016 at 04:26:18PM +0530, Viresh Kumar wrote:
> Some platforms have the capability to configure the performance state of
> their Power Domains. The performance levels are represented by positive
> integer values, a lower value represents lower performance state.
> 
> The power-domains until now were only concentrating on the idle state
> management of the device and this needs to change in order to reuse the
> infrastructure of power domains for active state management.
> 
> This patch adds binding to describe the performance states of a power
> domain.
> 
> If the consumers don't need the capability of switching to different
> domain performance states at runtime, then they can simply define their
> required domain performance state in their node directly. Otherwise the
> consumers can define their requirements with help of other
> infrastructure, for example the OPP table.
> 
> Signed-off-by: Viresh Kumar <viresh.kumar-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
> ---
>  .../devicetree/bindings/power/power_domain.txt     | 69 ++++++++++++++++++++++
>  1 file changed, 69 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/power/power_domain.txt b/Documentation/devicetree/bindings/power/power_domain.txt
> index 723e1ad937da..a456e0dc04e0 100644
> --- a/Documentation/devicetree/bindings/power/power_domain.txt
> +++ b/Documentation/devicetree/bindings/power/power_domain.txt
> @@ -38,6 +38,40 @@ phandle arguments (so called PM domain specifiers) of length specified by the
>    domain's idle states. In the absence of this property, the domain would be
>    considered as capable of being powered-on or powered-off.
>  
> +- domain-performance-states : A phandle of the performance states node, which
> +		defines all the performance states associated with a power
> +		domain.
> +  The domain-performance-states property reflects the performance states of this
> +  PM domain and not the performance states of the devices or sub-domains in the
> +  PM domain. Devices and sub-domains have their own performance states, which
> +  are dependent on the performance state of the PM domain.
> +
> +* PM domain performance states node
> +
> +This describes the performance states of a PM domain.
> +
> +Required properties:
> +- compatible: Allow performance states to express their compatibility. It should
> +  be: "domain-performance-state".
> +
> +- Performance state nodes: This node shall have one or more "Performance State"
> +  nodes.
> +
> +* Performance state node
> +
> +Required properties:
> +- performance-level: A positive integer value representing the performance level
> +  associated with a performance state. The integer value '1' represents the
> +  lowest performance level and the highest value represents the highest
> +  performance level.
> +
> +Optional properties:
> +- domain-microvolt: voltage in micro Volts.
> +
> +  A single regulator's voltage is specified with an array of size one or three.
> +  Single entry is for target voltage and three entries are for <target min max>
> +  voltages.
> +
>  Example:
>  
>  	power: power-controller@12340000 {
> @@ -118,4 +152,39 @@ The node above defines a typical PM domain consumer device, which is located
>  inside a PM domain with index 0 of a power controller represented by a node
>  with the label "power".
>  
> +Optional properties:
> +- domain-performance-state: A phandle of a Performance state node.
> +
> +Example:
> +
> +	parent: power-controller@12340000 {
> +		compatible = "foo,power-controller";
> +		reg = <0x12340000 0x1000>;
> +		#power-domain-cells = <0>;
> +		domain-performance-states = <&domain_perf_states>;
> +	};
> +
> +	domain_perf_states: performance_states {

If you want to have performance states for a domain in DT, then you need 
to actually have a node for the domain in DT. Then this should be a 
child of the domain. I wouldn't think non-CPU domain performance states 
will be common across domains.

> +		compatible = "domain-performance-state";
> +		domain_perf_state1: pstate@1 {

A unit address should have a reg property.

> +			performance-level = <1>;
> +			domain-microvolt = <970000 975000 985000>;
> +		};
> +		domain_perf_state2: pstate@2 {
> +			performance-level = <2>;
> +			domain-microvolt = <1000000 1075000 1085000>;
> +		};
> +		domain_perf_state3: pstate@3 {
> +			performance-level = <3>;
> +			domain-microvolt = <1100000 1175000 1185000>;
> +		};
> +	}
> +
> +	leaky-device@12350000 {
> +		compatible = "foo,i-leak-current";
> +		reg = <0x12350000 0x1000>;
> +		power-domains = <&power 0>;
> +		domain-performance-state = <&domain_perf_state2>;

domain-performance-state and domain-performance-states are too similar 
in name. The property here should probably reflect the mode needed and 
perhaps specific to the device. I assume a device will need multiple 
states/modes.

Also, since you refer to the performance state node directly, I'm not 
sure why you need the performance-level property.

Rob
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
