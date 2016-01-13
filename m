From: Stephen Boyd <sboyd@codeaurora.org>
Subject: Re: [PATCH 08/17] PM / OPP: Add dev_pm_opp_set_rate()
Date: Tue, 12 Jan 2016 16:49:36 -0800
Message-ID: <20160113004936.GE22188@codeaurora.org>
References: <cover.1450777582.git.viresh.kumar@linaro.org>
 <5824076a64ad4215cfc63c238e8b8947bc996e87.1450777582.git.viresh.kumar@linaro.org>
 <20160112014010.GM22188@codeaurora.org>
 <20160112065832.GN1084@ubuntu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:55278 "EHLO
	smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751940AbcAMAti (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 12 Jan 2016 19:49:38 -0500
Content-Disposition: inline
In-Reply-To: <20160112065832.GN1084@ubuntu>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Rafael Wysocki <rjw@rjwysocki.net>, linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, nm@ti.com

On 01/12, Viresh Kumar wrote:
> 
> Some of these I figured out earlier (after sending the series), and
> fixed them by dropping rcu lock at certain points. But the problem is
> that we will be using opp/clk/reg here for almost the complete routine
> and the lock must be acquired for all the time.
> 
> (Untested for now)
[...]
> +int dev_pm_opp_set_rate(struct device *dev, unsigned long target_freq)
> +{
> +	struct device_opp *dev_opp;
> +	struct dev_pm_opp *old_opp, *opp;
> +	struct regulator *reg;
> +	struct clk *clk;
> +	unsigned long freq, old_freq;
> +	unsigned long u_volt, u_volt_min, u_volt_max;
> +	unsigned long ou_volt, ou_volt_min, ou_volt_max;
> +	int ret;
> +
> +	if (unlikely(!target_freq)) {
> +		dev_err(dev, "%s: Invalid target frequency %lu\n", __func__,
> +			target_freq);
> +		return -EINVAL;
> +	}
> +
> +	/*
> +	 * Hold our list modification lock here as clk/regulator routines called
> +	 * below can possibly take another mutex, which isn't allowed within rcu
> +	 * locks.
> +	 */
> +	mutex_lock(&dev_opp_list_lock);
> +

Nak

Having a single mutex around the clock and voltage setting
makes cpu frequency switching scalability drop to zero for
devices that have independent clock and voltage supplies for each
CPU. We need to get the voltage and frequency settings under rcu
and then release rcu and change the hardware. This is already how
cpufreq-dt is doing it anyway, so I'm lost how it can't be copied
here into OPP framework.

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
