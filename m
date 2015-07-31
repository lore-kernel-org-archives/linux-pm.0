From: Stephen Boyd <sboyd@codeaurora.org>
Subject: Re: [PATCH V3 14/16] cpufreq: Allow drivers to enable boost support
 after registering driver
Date: Thu, 30 Jul 2015 23:12:38 -0700
Message-ID: <20150731061238.GN3159@codeaurora.org>
References: <cover.1438166099.git.viresh.kumar@linaro.org>
 <98379f9625b9cc8ade2e052c29e86c29e11cea5e.1438166099.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:37059 "EHLO
	smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750957AbbGaGMk (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 31 Jul 2015 02:12:40 -0400
Content-Disposition: inline
In-Reply-To: <98379f9625b9cc8ade2e052c29e86c29e11cea5e.1438166099.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Rafael Wysocki <rjw@rjwysocki.net>, linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, rob.herring@linaro.org, arnd.bergmann@linaro.org, nm@ti.com, broonie@kernel.org, mturquette@baylibre.com, Sudeep.Holla@arm.com, viswanath.puttagunta@linaro.org, l.stach@pengutronix.de, thomas.petazzoni@free-electrons.com, linux-arm-kernel@lists.infradead.org, ta.omasab@gmail.com, kesavan.abhilash@gmail.com, khilman@linaro.org, santosh.shilimkar@oracle.com, b.zolnierkie@samsung.com, open list <linux-kernel@vger.kernel.org>

On 07/29, Viresh Kumar wrote:
> In some cases it wouldn't be known at time of driver registration, if
> the driver needs to support boost frequencies.
> 
> For example, while getting boost information from DT with opp-v2
> bindings, we need to parse the bindings for all the CPUs to know if
> turbo/boost OPPs are supported or not.
> 
> One way out to do that efficiently is to delay supporting boost mode
> (i.e. creating /sys/devices/system/cpu/cpufreq/boost file), until the
> time OPP bindings are parsed.
> 
> At that point, the driver can enable boost support. This can be done at
> ->init(), where the frequency table is created.
> 
> To do that, the driver requires few APIs from cpufreq core that let him
> do this. This patch provides these APIs.
> 
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---

Reviewed-by: Stephen Boyd <sboyd@codeaurora.org>

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
