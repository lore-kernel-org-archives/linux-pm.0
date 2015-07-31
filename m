From: Stephen Boyd <sboyd@codeaurora.org>
Subject: Re: [PATCH V3 16/16] cpufreq: dt: Add support for turbo/boost mode
Date: Thu, 30 Jul 2015 23:16:11 -0700
Message-ID: <20150731061611.GP3159@codeaurora.org>
References: <cover.1438166099.git.viresh.kumar@linaro.org>
 <5dba664d47ca399e0ad7a55f2d74688d1300a703.1438166099.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:37605 "EHLO
	smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751491AbbGaGQN (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 31 Jul 2015 02:16:13 -0400
Content-Disposition: inline
In-Reply-To: <5dba664d47ca399e0ad7a55f2d74688d1300a703.1438166099.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Rafael Wysocki <rjw@rjwysocki.net>, linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, rob.herring@linaro.org, arnd.bergmann@linaro.org, nm@ti.com, broonie@kernel.org, mturquette@baylibre.com, Sudeep.Holla@arm.com, viswanath.puttagunta@linaro.org, l.stach@pengutronix.de, thomas.petazzoni@free-electrons.com, linux-arm-kernel@lists.infradead.org, ta.omasab@gmail.com, kesavan.abhilash@gmail.com, khilman@linaro.org, santosh.shilimkar@oracle.com, b.zolnierkie@samsung.com, open list <linux-kernel@vger.kernel.org>

On 07/29, Viresh Kumar wrote:
> With opp-v2 DT bindings, few OPPs can be used only for the boost mode.
> But using such OPPs require the boost mode to be supported by cpufreq
> driver.
> 
> We will parse DT bindings only during ->init() and so can enable boost
> support only after registering cpufreq driver.
> 
> This enables boost support as soon as any policy has boost/turbo OPPs
> for its CPUs.
> 
> We don't need to disable boost support as that is done by the core, when
> the driver is unregistered.
> 
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---

Reviewed-by: Stephen Boyd <sboyd@codeaurora.org>

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
