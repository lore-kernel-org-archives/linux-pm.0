From: Sudeep Holla <sudeep.holla-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [PATCH v5 02/16] dt/bindings: Update binding for PM domain idle
 states
Date: Fri, 2 Sep 2016 15:21:52 +0100
Message-ID: <0b233802-f459-c6bb-ff42-70745a225cfb@arm.com>
References: <1472242678-33700-1-git-send-email-lina.iyer@linaro.org>
 <1472242678-33700-3-git-send-email-lina.iyer@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1472242678-33700-3-git-send-email-lina.iyer-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Lina Iyer <lina.iyer-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
Cc: ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, khilman-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, Sudeep Holla <sudeep.holla-5wv7dgnIgG8@public.gmane.org>, andy.gross-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, sboyd-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, linux-arm-msm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, brendan.jackman-5wv7dgnIgG8@public.gmane.org, lorenzo.pieralisi-5wv7dgnIgG8@public.gmane.org, Juri.Lelli-5wv7dgnIgG8@public.gmane.org, Axel Haslam <ahaslam+renesas-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Marc Titinger <mtitinger+renesas-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>
List-Id: linux-pm@vger.kernel.org



On 26/08/16 21:17, Lina Iyer wrote:
> From: Axel Haslam <ahaslam+renesas-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>
>
> Update DT bindings to describe idle states of PM domains.
>
> Cc: <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
> Signed-off-by: Marc Titinger <mtitinger+renesas-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>
> Signed-off-by: Lina Iyer <lina.iyer-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
> [Lina: Added state properties, removed state names, wakeup-latency,
> added of_pm_genpd_init() API, pruned commit text]
> Signed-off-by: Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
> [Ulf: Moved around code to make it compile properly, rebased on top of multiple state support]
> ---
>  .../devicetree/bindings/power/power_domain.txt     | 57 ++++++++++++++++++++++
>  1 file changed, 57 insertions(+)
>
> diff --git a/Documentation/devicetree/bindings/power/power_domain.txt b/Documentation/devicetree/bindings/power/power_domain.txt
> index 025b5e7..4960486 100644
> --- a/Documentation/devicetree/bindings/power/power_domain.txt
> +++ b/Documentation/devicetree/bindings/power/power_domain.txt
> @@ -29,6 +29,10 @@ Optional properties:
>     specified by this binding. More details about power domain specifier are
>     available in the next section.
>
> +- domain-idle-states : A phandle of an idle-state that shall be soaked into a
> +                generic domain power state. The idle state definitions are
> +                compatible with arm,idle-state specified in [1].
> +
>  Example:
>
>  	power: power-controller@12340000 {
> @@ -59,6 +63,57 @@ The nodes above define two power controllers: 'parent' and 'child'.
>  Domains created by the 'child' power controller are subdomains of '0' power
>  domain provided by the 'parent' power controller.
>
> +Example 3: ARM v7 style CPU PM domains (Linux domain controller)
> +
> +	cpus {
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +
> +		CPU0: cpu@0 {
> +			device_type = "cpu";
> +			compatible = "arm,cortex-a7", "arm,armv7";
> +			reg = <0x0>;
> +			power-domains = <&a7_pd>;
> +		};
> +
> +		CPU1: cpu@1 {
> +			device_type = "cpu";
> +			compatible = "arm,cortex-a15", "arm,armv7";
> +			reg = <0x0>;
> +			power-domains = <&a15_pd>;
> +		};
> +	};
> +
> +	pm-domains {
> +		a15_pd: a15_pd {
> +			/* will have A15 platform ARM_PD_METHOD_OF_DECLARE*/
> +			compatible = "arm,cortex-a15";
> +			#power-domain-cells = <0>;
> +			domain-idle-states = <&CLUSTER_SLEEP_0>;
> +		};
> +
> +		a7_pd: a7_pd {
> +			/* will have a A7 platform ARM_PD_METHOD_OF_DECLARE*/
> +			compatible = "arm,cortex-a7";
> +			#power-domain-cells = <0>;
> +			domain-idle-states = <&CLUSTER_SLEEP_0>, <&CLUSTER_SLEEP_1>;
> +		};
> +
> +		CLUSTER_SLEEP_0: state0 {
> +			compatible = "arm,idle-state";
> +			entry-latency-us = <1000>;
> +			exit-latency-us = <2000>;
> +			min-residency-us = <10000>;
> +		};
> +
> +		CLUSTER_SLEEP_1: state1 {
> +			compatible = "arm,idle-state";
> +			entry-latency-us = <5000>;
> +			exit-latency-us = <5000>;
> +			min-residency-us = <100000>;
> +		};
> +	};
> +

This version is *not very descriptive*. Also the discussion we had on v3
version has not yet concluded IMO. So can I take that we agreed on what
was proposed there or not ?

We could have better example above *really* based on the discussions we
had so far. This example always makes me think it's well crafted to
avoid any sort of discussions. We need to consider different use-cases
e.g. what about CPU level states ?

IMO, we need to discuss this DT binding in detail and arrive at some
conclusion before you take all the troubles to respin the series.
Also it's better to keep the DT binding separate until we have some
conclusion instead of posting the implementation for each version.
That's just my opinion(I would be least bothered about implementation
until I know it will be accepted before I can peek into the code, others
may differ.

-- 
Regards,
Sudeep
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
