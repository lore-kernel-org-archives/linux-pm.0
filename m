From: Stephen Boyd <sboyd@codeaurora.org>
Subject: Re: [PATCH V2 00/16] PM / OPP: Introduce APIs to transition OPPs
Date: Fri, 29 Jan 2016 17:48:42 -0800
Message-ID: <20160130014842.GI4848@codeaurora.org>
References: <cover.1453965717.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:39267 "EHLO
	smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752877AbcA3Bsp (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 29 Jan 2016 20:48:45 -0500
Content-Disposition: inline
In-Reply-To: <cover.1453965717.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Rafael Wysocki <rjw@rjwysocki.net>, linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, nm@ti.com

On 01/28, Viresh Kumar wrote:
> Hi Guys,
> 
> This patchset add APIs in OPP layer to allow OPPs transitioning from
> within OPP layer. Currently all OPP users need to replicate the same
> code to switch between OPPs. While the same can be handled easily by
> OPP-core.
> 
> The first 7 patches update the OPP core to introduce the new APIs and
> the next Nine patches update cpufreq-dt for the same.
> 
> 11 out of 17 are already Reviewed by Stephen, only few are left :)

I'll look at this early next week.

Just a note for future work, I think we're going to need to add
some sort of enable/disable into the OPP layer. At least in qcom
designs, if a clock is off we don't want the voltage requirement
for that clock to factor into the final voltage on the regulator.
Furthermore, we want to disable the regulator with
regulator_disable() if all the clocks are off.

This is also a problem with cpufreq-dt. The regulators and clocks
are assumed to be enabled out of the bootloader, which may not
even be true. Now that OPP layer is managing all the clocks and
regulators here we're going to need to do something to make sure
they're on and controllable.

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
