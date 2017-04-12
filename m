From: Sudeep Holla <sudeep.holla@arm.com>
Subject: Re: [PATCH V4 1/9] PM / OPP: Allow OPP table to be used for
 power-domains
Date: Wed, 12 Apr 2017 17:49:44 +0100
Message-ID: <0a7146f9-72f1-317c-3aab-770a72462968@arm.com>
References: <cover.1490001099.git.viresh.kumar@linaro.org>
 <e772e67a5445319bb8e0f312846ace666adc097f.1490001099.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <e772e67a5445319bb8e0f312846ace666adc097f.1490001099.git.viresh.kumar@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Rafael Wysocki <rjw@rjwysocki.net>, ulf.hansson@linaro.org, Kevin Hilman <khilman@linaro.org>, Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@codeaurora.org>, Sudeep Holla <sudeep.holla@arm.com>, linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>, robh+dt@kernel.org, lina.iyer@linaro.org, rnayak@codeaurora.org, devicetree@vger.kernel.org
List-Id: linux-pm@vger.kernel.org



On 20/03/17 09:32, Viresh Kumar wrote:
> Power-domains need to express their active states in DT and what's
> better than OPP table for that.
> 
> This patch allows power-domains to reuse OPP tables to express their
> active states. The "opp-hz" property isn't a required property anymore
> as power-domains may not always use them.
> 
> Add a new property "domain-performance-state", which will contain
> positive integer values to represent performance levels of the
> power-domains as described in this patch.
> 
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---
>  Documentation/devicetree/bindings/opp/opp.txt | 73 ++++++++++++++++++++++++++-
>  1 file changed, 71 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/opp/opp.txt b/Documentation/devicetree/bindings/opp/opp.txt
> index 63725498bd20..d0b95c9e1011 100644
> --- a/Documentation/devicetree/bindings/opp/opp.txt
> +++ b/Documentation/devicetree/bindings/opp/opp.txt
> @@ -76,10 +76,9 @@ This describes the OPPs belonging to a device. This node can have following
>  This defines voltage-current-frequency combinations along with other related
>  properties.
>  
> -Required properties:
> +Optional properties:
>  - opp-hz: Frequency in Hz, expressed as a 64-bit big-endian integer.
>  
> -Optional properties:
>  - opp-microvolt: voltage in micro Volts.
>  
>    A single regulator's voltage is specified with an array of size one or three.
> @@ -154,6 +153,19 @@ properties.
>  
>  - status: Marks the node enabled/disabled.
>  
> +- domain-performance-state: A positive integer value representing the minimum
> +  power-domain performance level required by the device for the OPP node. The

So the above definition is when this field in in the device node rather
than the OPP table entry, right ? For simplicity why not have the
properties named slightly different or just use phandle to an entry in
the device node for this purpose.

> +  The integer value '0' represents the lowest performance level and the higher
> +  values represent higher performance levels. 

needs to be changed as OPP table entry.

>  When present in the OPP table of a
> + power-domain, it represents the performance level of the domain. When present

again "performance level of the domain corresponding to that OPP entry"
on something similar

> +  in the OPP table of a normal device, it represents the performance level of

what do you mean by normal device ? needs description as that's
something new introduced here.

> +  the parent power-domain. The OPP table can contain the
> +  "domain-performance-state" property, only if the device node contains the
> +  "power-domains" or "#power-domain-cells" property. 

Why such a restriction ?

> The OPP nodes aren't
> +  allowed to contain the "domain-performance-state" property partially, i.e.
> +  Either all OPP nodes in the OPP table have the "domain-performance-state"
> +  property or none of them have it.
> +
>  Example 1: Single cluster Dual-core ARM cortex A9, switch DVFS states together.
>  
>  / {
> @@ -528,3 +540,60 @@ Example 5: opp-supported-hw
>  		};
>  	};
>  };
> +
> +Example 7: domain-Performance-state:
> +(example: For 1GHz require domain state 1 and for 1.1 & 1.2 GHz require state 2)
> +
> +/ {
> +	domain_opp_table: opp_table0 {
> +		compatible = "operating-points-v2";
> +
> +		opp@1 {
> +			domain-performance-state = <1>;
> +			opp-microvolt = <975000 970000 985000>;
> +		};
> +		opp@2 {
> +			domain-performance-state = <2>;
> +			opp-microvolt = <1075000 1000000 1085000>;
> +		};
> +	};
> +
> +	foo_domain: power-controller@12340000 {
> +		compatible = "foo,power-controller";
> +		reg = <0x12340000 0x1000>;
> +		#power-domain-cells = <0>;
> +		operating-points-v2 = <&domain_opp_table>;

How does it scale with power domain providers with multiple power domain ?

> +	}
> +
> +	cpu0_opp_table: opp_table1 {
> +		compatible = "operating-points-v2";
> +		opp-shared;
> +
> +		opp@1000000000 {
> +			opp-hz = /bits/ 64 <1000000000>;
> +			domain-performance-state = <1>;
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

Do we ignore operating-points-v2 above as this device/cpu node contains
power domain which has operating-points-v2 property ? In other words
how do they correlate ?

> +			power-domains = <&foo_domain>;
> +		};
> +	};
> +};
> 

-- 
Regards,
Sudeep
