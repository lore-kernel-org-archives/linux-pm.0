From: Stephen Boyd <sboyd@codeaurora.org>
Subject: Re: [RFC v2 12/12] ARM64: dts: Define CPU power domain for MSM8916
Date: Fri, 26 Feb 2016 11:50:35 -0800
Message-ID: <20160226195035.GA28849@codeaurora.org>
References: <1455310238-8963-1-git-send-email-lina.iyer@linaro.org>
 <1455310238-8963-13-git-send-email-lina.iyer@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:59389 "EHLO
	smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754882AbcBZTuh (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 26 Feb 2016 14:50:37 -0500
Content-Disposition: inline
In-Reply-To: <1455310238-8963-13-git-send-email-lina.iyer@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Lina Iyer <lina.iyer@linaro.org>
Cc: ulf.hansson@linaro.org, khilman@kernel.org, rjw@rjwysocki.net, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, geert@linux-m68k.org, k.kozlowski@samsung.com, msivasub@codeaurora.org, agross@codeaurora.org, linux-arm-msm@vger.kernel.org, lorenzo.pieralisi@arm.com, ahaslam@baylibre.com, mtitinger@baylibre.com, devicetree@vger.kernel.org

On 02/12, Lina Iyer wrote:
> @@ -101,6 +105,27 @@
>  		};
>  	};
>  
> +	CPU_PD: cpu-pd@0 {
> +		#power-domain-cells = <0>;
> +		power-states = <&CLUSTER_RET>, <&CLUSTER_PWR_DWN>;

Why isn't this part of the psci node? PSCI is the node that's
providing the code/logic for the power domain.

> +	};
> +
> +	pd-power-states {
> +		CLUSTER_RET: power-state@1 {
> +			state-param = <0x1000010>;
> +			entry-latency-us = <500>;
> +			exit-latency-us = <500>;
> +			residency-us = <2000>;
> +		 };
> +
> +		CLUSTER_PWR_DWN: power-state@2 {
> +			state-param = <0x1000030>;
> +			entry-latency-us = <2000>;
> +			exit-latency-us = <2000>;
> +			residency-us = <6000>;
> +		};
> +	};
> +

And I would expect these to be put somewhere inside the power
domain provider as well? Is this documented somewhere?

>  	psci {
>  		compatible = "arm,psci-1.0";
>  		method = "smc";

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
