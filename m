From: Sudeep Holla <sudeep.holla-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [PATCH V4 2/9] PM / Domains: Use OPP tables for power-domains
Date: Wed, 12 Apr 2017 17:58:41 +0100
Message-ID: <6f72cb6e-2d8c-4e68-59cd-67f40e8c3118@arm.com>
References: <cover.1490001099.git.viresh.kumar@linaro.org>
 <5619ac7777689f282f8aafabbde22d71b46a979b.1490001099.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <5619ac7777689f282f8aafabbde22d71b46a979b.1490001099.git.viresh.kumar-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Viresh Kumar <viresh.kumar-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: Rafael Wysocki <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>, ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, Kevin Hilman <khilman-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Sudeep Holla <sudeep.holla-5wv7dgnIgG8@public.gmane.org>, linaro-kernel-cunTk1MwBs8s++Sfvej+rw@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Vincent Guittot <vincent.guittot-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Stephen Boyd <sboyd-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Nishanth Menon <nm-l0cyMroinI0@public.gmane.org>, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, lina.iyer-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, rnayak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-pm@vger.kernel.org



On 20/03/17 09:32, Viresh Kumar wrote:
> The OPP table bindings contains all the necessary fields to support
> power-domains now. Update the power-domain bindings to allow
> "operating-points-v2" to be present within the power-domain node.
> 
> Also allow consumer devices, that don't use OPP tables, to specify the
> parent power-domain's performance level using the
> "domain-performance-state" property.
> 
> Signed-off-by: Viresh Kumar <viresh.kumar-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
> ---
>  .../devicetree/bindings/power/power_domain.txt     | 42 ++++++++++++++++++++++
>  1 file changed, 42 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/power/power_domain.txt b/Documentation/devicetree/bindings/power/power_domain.txt
> index 723e1ad937da..5db112fa5d7c 100644
> --- a/Documentation/devicetree/bindings/power/power_domain.txt
> +++ b/Documentation/devicetree/bindings/power/power_domain.txt
> @@ -38,6 +38,9 @@ phandle arguments (so called PM domain specifiers) of length specified by the
>    domain's idle states. In the absence of this property, the domain would be
>    considered as capable of being powered-on or powered-off.
>  
> +- operating-points-v2 : This describes the performance states of a PM domain.
> +  Refer to ../opp/opp.txt for more information.
> +
>  Example:
>  
>  	power: power-controller@12340000 {
> @@ -118,4 +121,43 @@ The node above defines a typical PM domain consumer device, which is located
>  inside a PM domain with index 0 of a power controller represented by a node
>  with the label "power".
>  
> +Optional properties:
> +- domain-performance-state: A positive integer value representing the minimum
> +  power-domain performance level required by the consumer device. The integer
> +  value '0' represents the lowest performance level and the higher values
> +  represent higher performance levels. The value of "domain-performance-state"
> +  field should match the "domain-performance-state" field of one of the OPP
> +  nodes in the parent power-domain's OPP table.
> +
> +
> +
> +Example:
> +
> +	domain_opp_table: opp_table {
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
> +	parent: power-controller@12340000 {
> +		compatible = "foo,power-controller";
> +		reg = <0x12340000 0x1000>;
> +		#power-domain-cells = <0>;
> +		operating-points-v2 = <&domain_opp_table>;

As mentioned in the other email, it would be good to consider
scalability with multiple power domains in a PM domain provider.
i.e case of #power-domain-cells = <1> or more

-- 
Regards,
Sudeep
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
