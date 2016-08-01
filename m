From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v2 02/14] dt/bindings: update binding for PM domain idle
 states
Date: Mon, 1 Aug 2016 11:30:03 -0500
Message-ID: <20160801163003.GA17592@rob-hp-laptop>
References: <1469829385-11511-1-git-send-email-lina.iyer@linaro.org>
 <1469829385-11511-3-git-send-email-lina.iyer@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-oi0-f66.google.com ([209.85.218.66]:36773 "EHLO
	mail-oi0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754006AbcHAQa1 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 1 Aug 2016 12:30:27 -0400
Content-Disposition: inline
In-Reply-To: <1469829385-11511-3-git-send-email-lina.iyer@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Lina Iyer <lina.iyer@linaro.org>
Cc: ulf.hansson@linaro.org, khilman@kernel.org, rjw@rjwysocki.net, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, andy.gross@linaro.org, sboyd@codeaurora.org, linux-arm-msm@vger.kernel.org, Axel Haslam <ahaslam+renesas@baylibre.com>, devicetree@vger.kernel.org, Marc Titinger <mtitinger+renesas@baylibre.com>

On Fri, Jul 29, 2016 at 03:56:13PM -0600, Lina Iyer wrote:
> From: Axel Haslam <ahaslam+renesas@baylibre.com>
> 
> Update DT bindings to describe idle states of PM domains.
> 
> Cc: <devicetree@vger.kernel.org>
> Signed-off-by: Marc Titinger <mtitinger+renesas@baylibre.com>
> Signed-off-by: Lina Iyer <lina.iyer@linaro.org>
> [Lina: Added state properties, removed state names, wakeup-latency,
> added of_pm_genpd_init() API, pruned commit text]
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> [Ulf: Moved around code to make it compile properly, rebased on top of multiple state support]
> ---
>  .../devicetree/bindings/power/power_domain.txt     | 39 ++++++++++++++++++++++
>  1 file changed, 39 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/power/power_domain.txt b/Documentation/devicetree/bindings/power/power_domain.txt
> index 025b5e7..69aa4e2 100644
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
> @@ -55,6 +59,39 @@ Example 2:
>  		#power-domain-cells = <1>;
>  	};
>  
> +Example 3:
> +
> +	pm-domains {
> +		a57_pd: a57_pd@ {

The trailing '@' is not valid. If dtc doesn't complain about that, it 
should.

> +			/* will have a57 platform ARM_PD_METHOD_OF_DECLARE*/
> +			compatible = "arm,pd","arm,cortex-a57";
> +			#power-domain-cells = <0>;
> +			idle-states = <&CLUSTER_SLEEP_0>;

Is this supposed to be 'domain-idle-states'? The domain part is 
pointless IMO given these are power domain nodes.

> +		};
> +
> +		a53_pd: a53_pd@ {
> +			/* will have a a53 platform ARM_PD_METHOD_OF_DECLARE*/
> +			compatible = "arm,pd","arm,cortex-a53";
> +			#power-domain-cells = <0>;
> +			idle-states = <&CLUSTER_SLEEP_0>, <&CLUSTER_SLEEP_1>;
> +		};
> +
> +		CLUSTER_SLEEP_0: idle-state@0 {

A unit-address should have a matching reg value or be dropped. A reg 
property would be fine here, but I think it should correspond to MPIDR 
values. 

> +			compatible = "arm,idle-state";
> +			entry-latency-us = <1000>;
> +			exit-latency-us = <2000>;
> +			residency-us = <10000>;
> +		};
> +
> +		CLUSTER_SLEEP_1: idle-state@1 {
> +			compatible = "arm,idle-state";
> +			entry-latency-us = <5000>;
> +			exit-latency-us = <5000>;
> +			residency-us = <100000>;
> +		};
> +	};
> +
> +
>  The nodes above define two power controllers: 'parent' and 'child'.
>  Domains created by the 'child' power controller are subdomains of '0' power
>  domain provided by the 'parent' power controller.
> @@ -76,3 +113,5 @@ Example:
>  The node above defines a typical PM domain consumer device, which is located
>  inside a PM domain with index 0 of a power controller represented by a node
>  with the label "power".
> +
> +[1]. Documentation/devicetree/bindings/arm/idle-states.txt
> -- 
> 2.7.4
> 
> --
> To unsubscribe from this list: send the line "unsubscribe devicetree" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
