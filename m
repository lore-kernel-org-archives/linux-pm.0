From: Sudeep Holla <sudeep.holla-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [PATCH V4 1/9] PM / OPP: Allow OPP table to be used for
 power-domains
Date: Wed, 12 Apr 2017 18:05:30 +0100
Message-ID: <468e756b-7112-4006-b31d-9fcf1c32673d@arm.com>
References: <cover.1490001099.git.viresh.kumar@linaro.org>
 <e772e67a5445319bb8e0f312846ace666adc097f.1490001099.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <e772e67a5445319bb8e0f312846ace666adc097f.1490001099.git.viresh.kumar-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Viresh Kumar <viresh.kumar-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Rafael Wysocki <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>, ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, Kevin Hilman <khilman-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Viresh Kumar <vireshk-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Nishanth Menon <nm-l0cyMroinI0@public.gmane.org>, Stephen Boyd <sboyd-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Cc: Sudeep Holla <sudeep.holla-5wv7dgnIgG8@public.gmane.org>, linaro-kernel-cunTk1MwBs8s++Sfvej+rw@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Vincent Guittot <vincent.guittot-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, lina.iyer-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, rnayak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-pm@vger.kernel.org



On 20/03/17 09:32, Viresh Kumar wrote:
[...]

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
> +			power-domains = <&foo_domain>;
> +		};
> +	};
> +};


Thinking more about this above example, I think you need more
explanation. So in the above case you have cpu with clock controller,
power-domain and the OPP table info, I can think of few things that need
to be explicit:

1. How does the precedence look like ?

2. Since power-domains with OPP table control the performance state, do
   we ignore clock and operating-points-v2 in the above case completely?

3. Will the power-domain drive the OPP ?

-- 
Regards,
Sudeep
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
