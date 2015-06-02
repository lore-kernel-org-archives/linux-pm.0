From: Stephen Boyd <sboyd@codeaurora.org>
Subject: Re: [PATCH V6 1/3] OPP: Add new bindings to address shortcomings of
 existing bindings
Date: Tue, 2 Jun 2015 11:31:20 -0700
Message-ID: <20150602183120.GB24349@codeaurora.org>
References: <cover.1432797343.git.viresh.kumar@linaro.org>
 <96d49e7e6747c1a65c5f285d70600795126641cc.1432797343.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:38301 "EHLO
	smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753970AbbFBSbZ (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 2 Jun 2015 14:31:25 -0400
Content-Disposition: inline
In-Reply-To: <96d49e7e6747c1a65c5f285d70600795126641cc.1432797343.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Rafael Wysocki <rjw@rjwysocki.net>, rob.herring@linaro.org, linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, arnd.bergmann@linaro.org, nm@ti.com, broonie@kernel.org, mike.turquette@linaro.org, grant.likely@linaro.org, olof@lixom.net, Sudeep.Holla@arm.com, devicetree@vger.kernel.org, viswanath.puttagunta@linaro.org, l.stach@pengutronix.de, thomas.petazzoni@free-electrons.com, linux-arm-kernel@lists.infradead.org, ta.omasab@gmail.com, kesavan.abhilash@gmail.com, khilman@linaro.org, santosh.shilimkar@oracle.com

On 05/28, Viresh Kumar wrote:
> Current OPP (Operating performance point) device tree bindings have been
> insufficient due to the inflexible nature of the original bindings. Over
> time, we have realized that Operating Performance Point definitions and
> usage is varied depending on the SoC and a "single size (just frequency,
> voltage) fits all" model which the original bindings attempted and
> failed.
> 
> The proposed next generation of the bindings addresses by providing a
> expandable binding for OPPs and introduces the following common
> shortcomings seen with the original bindings:
> 
> - Getting clock/voltage/current rails sharing information between CPUs.
>   Shared by all cores vs independent clock per core vs shared clock per
>   cluster.
> 
> - Support for specifying current levels along with voltages.
> 
> - Support for multiple regulators.
> 
> - Support for turbo modes.
> 
> - Other per OPP settings: transition latencies, disabled status, etc.?
> 
> - Expandability of OPPs in future.
> 
> This patch introduces new bindings "operating-points-v2" to get these problems
> solved. Refer to the bindings for more details.
> 
> We now have multiple versions of OPP binding and only one of them should
> be used per device.
> 
> Reviewed-by: Rob Herring <robh@kernel.org>
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---

It looks pretty good. Just one question below on the regulator
stuff. Also, is there already code written to handle these new
bindings in the OPP library? If not, it would be good to write
some to flush out any problems that may be lurking in actual
implementation.

> +
> +Example 1: Single cluster Dual-core ARM cortex A9, switch DVFS states together.
> +
> +/ {
> +	cpus {
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +
> +		cpu@0 {
> +			compatible = "arm,cortex-a9";
> +			reg = <0>;
> +			next-level-cache = <&L2>;
> +			clocks = <&clk_controller 0>;
> +			clock-names = "cpu";
> +			opp-supply = <&cpu_supply0>;

opp-supply isn't mentioned anywhere. Is that intentional? Is it
supposed to be cpu-supply still? It isn't clear to me from the
previous discussion where this all ended up, but I'm not sure how
the in-kernel API is going to match up regulators with OPPs. I
mean, how are we going to ask the OPP library what the
min/max/target voltage is at a particular frequency when we have
multiple regulators? Is that some string based interface? 

	dev_pm_opp_get_voltage(name, &target, &min, &max);

Or a regulator pointer interface?

	dev_pm_opp_get_voltage(regulator, &target, &min, &max);

Or something else? Does this mean the OPP library is going to get
the CPU device to request the opp-supply from the CPU node?
Furthermore, why don't we care about opp-clocks? Are clocks
somehow special?

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
