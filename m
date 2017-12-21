From: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH V8 2/3] OPP: Introduce "required-opp" property
Date: Thu, 21 Dec 2017 16:26:09 -0600
Message-ID: <20171221222609.zeykydxmaffqhqon@rob-hp-laptop>
References: <cover.1513591822.git.viresh.kumar@linaro.org>
 <6615035f294a64a4c17e5b44ac6690d1c2ac127c.1513591822.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <6615035f294a64a4c17e5b44ac6690d1c2ac127c.1513591822.git.viresh.kumar-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Viresh Kumar <viresh.kumar-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, Kevin Hilman <khilman-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Viresh Kumar <vireshk-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Nishanth Menon <nm-l0cyMroinI0@public.gmane.org>, Stephen Boyd <sboyd-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, "Rafael J. Wysocki" <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Vincent Guittot <vincent.guittot-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, rnayak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, sudeep.holla-5wv7dgnIgG8@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-pm@vger.kernel.org

On Mon, Dec 18, 2017 at 03:51:29PM +0530, Viresh Kumar wrote:
> Devices have inter-dependencies some times. For example a device that
> needs to run at 800 MHz, needs another device (e.g. Its power domain) to
> be configured at a particular operating performance point.
> 
> This patch introduces a new property "required-opp" which can be present
> directly in a device's node (if it doesn't need to change its OPPs), or
> in device's OPP nodes. More details on the property can be seen in the
> binding itself.
> 
> Signed-off-by: Viresh Kumar <viresh.kumar-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
> ---
>  Documentation/devicetree/bindings/opp/opp.txt      |  8 +++
>  .../devicetree/bindings/power/power_domain.txt     | 59 ++++++++++++++++++++++
>  2 files changed, 67 insertions(+)

A couple of nits, otherwise:

Reviewed-by: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>

> 
> diff --git a/Documentation/devicetree/bindings/opp/opp.txt b/Documentation/devicetree/bindings/opp/opp.txt
> index a3953a1bb1a1..4e4f30288c8b 100644
> --- a/Documentation/devicetree/bindings/opp/opp.txt
> +++ b/Documentation/devicetree/bindings/opp/opp.txt
> @@ -159,6 +159,14 @@ properties.
>  
>  - status: Marks the node enabled/disabled.
>  
> +- required-opp: This contains phandle to an OPP node in another device's OPP
> +  table. It may contain an array of phandles, where each phandle points to an
> +  OPP of a different device. It should not contain multiple phandles to the OPP
> +  nodes in the same OPP table. This specifies the minimum required OPP of the
> +  device(s), whose OPP's phandle is present in this property, for the
> +  functioning of the current device at the current OPP (where this property is
> +  present).
> +
>  Example 1: Single cluster Dual-core ARM cortex A9, switch DVFS states together.
>  
>  / {
> diff --git a/Documentation/devicetree/bindings/power/power_domain.txt b/Documentation/devicetree/bindings/power/power_domain.txt
> index 61549840ab3b..f824763b202e 100644
> --- a/Documentation/devicetree/bindings/power/power_domain.txt
> +++ b/Documentation/devicetree/bindings/power/power_domain.txt
> @@ -126,4 +126,63 @@ The node above defines a typical PM domain consumer device, which is located
>  inside a PM domain with index 0 of a power controller represented by a node
>  with the label "power".
>  
> +Optional properties:
> +- required-opp: This contains phandle to an OPP node in another device's OPP
> +  table. It may contain an array of phandles, where each phandle points to an
> +  OPP of a different device. It should not contain multiple phandles to the OPP
> +  nodes in the same OPP table. This specifies the minimum required OPP of the
> +  device(s), whose OPP's phandle is present in this property, for the
> +  functioning of the current device at the current OPP (where this property is
> +  present).
> +
> +Example:
> +- OPP table for domain provider that provides two domains.
> +
> +	domain0_opp_table: opp_table0 {

opp-table0

> +		compatible = "operating-points-v2";
> +
> +		domain0_opp_0: opp-1000000000 {
> +			opp-hz = /bits/ 64 <1000000000>;
> +			opp-microvolt = <975000 970000 985000>;
> +		};
> +		domain0_opp_1: opp-1100000000 {
> +			opp-hz = /bits/ 64 <1100000000>;
> +			opp-microvolt = <1000000 980000 1010000>;
> +		};
> +	};
> +
> +	domain1_opp_table: opp_table1 {

opp-table1

> +		compatible = "operating-points-v2";
> +
> +		domain1_opp_0: opp-1200000000 {
> +			opp-hz = /bits/ 64 <1200000000>;
> +			opp-microvolt = <975000 970000 985000>;
> +		};
> +		domain1_opp_1: opp-1300000000 {
> +			opp-hz = /bits/ 64 <1300000000>;
> +			opp-microvolt = <1000000 980000 1010000>;
> +		};
> +	};
> +
> +	parent: power-controller@12340000 {
> +		compatible = "foo,power-controller";
> +		reg = <0x12340000 0x1000>;
> +		#power-domain-cells = <1>;
> +		operating-points-v2 = <&domain0_opp_table>, <&domain1_opp_table>;
> +	};
> +
> +	leaky-device0@12350000 {
> +		compatible = "foo,i-leak-current";
> +		reg = <0x12350000 0x1000>;
> +		power-domains = <&parent 0>;
> +		required-opp = <&domain0_opp_0>;
> +	};
> +
> +	leaky-device1@12350000 {
> +		compatible = "foo,i-leak-current";
> +		reg = <0x12350000 0x1000>;
> +		power-domains = <&parent 1>;
> +		required-opp = <&domain1_opp_1>;
> +	};
> +
>  [1]. Documentation/devicetree/bindings/power/domain-idle-state.txt
> -- 
> 2.15.0.194.g9af6a3dea062
> 
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
