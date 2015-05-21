From: Nishanth Menon <nm@ti.com>
Subject: Re: [PATCH V5 2/3] OPP: Allow multiple OPP tables to be passed via
 DT
Date: Thu, 21 May 2015 00:34:47 -0500
Message-ID: <555D6E77.3060206@ti.com>
References: <cover.1432091956.git.viresh.kumar@linaro.org> <4690ad854263d6553debab67d65d230105c206ec.1432091956.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:35742 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752657AbbEUFfi (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Thu, 21 May 2015 01:35:38 -0400
In-Reply-To: <4690ad854263d6553debab67d65d230105c206ec.1432091956.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>, Rafael Wysocki <rjw@rjwysocki.net>, rob.herring@linaro.org, arnd.bergmann@linaro.org, broonie@kernel.org, mike.turquette@linaro.org, sboyd@codeaurora.org
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, grant.likely@linaro.org, olof@lixom.net, Sudeep.Holla@arm.com, devicetree@vger.kernel.org, viswanath.puttagunta@linaro.org, l.stach@pengutronix.de, thomas.petazzoni@free-electrons.com, linux-arm-kernel@lists.infradead.org, ta.omasab@gmail.com, kesavan.abhilash@gmail.com, khilman@linaro.org, santosh.shilimkar@oracle.com

On 05/19/2015 10:41 PM, Viresh Kumar wrote:
Thinking a little more..

> +Example 5: Multiple OPP tables
> +
> +/ {
> +	cpus {
> +		cpu@0 {
> +			compatible = "arm,cortex-a7";
> +			...
> +
> +			opp-supply = <&cpu_supply>
> +			operating-points-v2 = <&cpu0_opp0>, <&cpu0_opp1>;
> +		};
> +	};
> +
> +	cpu0_opp0: opp0 {

Maybe we should rename these as cpu0_opp_table_slow opp_table-fast

> +		compatible = "operating-points-v2";
> +		opp-name = "opp-slow";

just name = "slow" ?

> +		opp-shared;
> +
> +		entry00 {

rename these as opp0, opp01 etc?
these are the actual OPP description, while, what we call "cpu0_opp0" is
actually an OPP table choice we have.

> +			opp-hz = <600000000>;
> +			...
> +		};
> +
> +		entry01 {
> +			opp-hz = <800000000>;
> +			...
> +		};
> +	};
> +
> +	cpu0_opp1: opp1 {
> +		compatible = "operating-points-v2";
> +		opp-name = "opp-fast";
> +		opp-shared;
> +
> +		entry10 {
> +			opp-hz = <1000000000>;
> +			...
> +		};
> +
> +		entry11 {
> +			opp-hz = <1100000000>;
> +			...
> +		};
> +	};
> +};
> 


-- 
Regards,
Nishanth Menon
