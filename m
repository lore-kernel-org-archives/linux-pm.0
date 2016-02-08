From: Stephen Boyd <sboyd@codeaurora.org>
Subject: Re: [PATCH V2 11/16] cpufreq: dt: Pass regulator name to the OPP core
Date: Mon, 8 Feb 2016 14:55:15 -0800
Message-ID: <20160208225515.GF10791@codeaurora.org>
References: <cover.1453965717.git.viresh.kumar@linaro.org>
 <d59a1d27c9e2f4cc023dfc9a2b72cb920cbac43a.1453965717.git.viresh.kumar@linaro.org>
 <20160202023418.GK4848@codeaurora.org>
 <20160202061013.GC31828@vireshk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:49646 "EHLO
	smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751653AbcBHWzQ (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 8 Feb 2016 17:55:16 -0500
Content-Disposition: inline
In-Reply-To: <20160202061013.GC31828@vireshk>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Rafael Wysocki <rjw@rjwysocki.net>, linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, nm@ti.com, open list <linux-kernel@vger.kernel.org>

On 02/02, Viresh Kumar wrote:
>  static int allocate_resources(int cpu, struct device **cdev,
>  			      struct regulator **creg, struct clk **cclk)
>  {
> @@ -200,6 +225,7 @@ static int cpufreq_init(struct cpufreq_policy *policy)
>  	unsigned long min_uV = ~0, max_uV = 0;
>  	unsigned int transition_latency;
>  	bool opp_v1 = false;
> +	const char *name = NULL;

Is this initialization necessary?

>  	int ret;
>  
>  	ret = allocate_resources(policy->cpu, &cpu_dev, &cpu_reg, &cpu_clk);
> @@ -229,6 +255,25 @@ static int cpufreq_init(struct cpufreq_policy *policy)
>  	}
>  
>  	/*
> +	 * OPP layer will be taking care of regulators now, but it needs to know
> +	 * the name of the regulator first.
> +	 */
> +	name = find_supply_name(cpu_dev, np);
> +	if (IS_ERR(name)) {

This looks to never happen?

> +		ret = PTR_ERR(name);
> +		goto out_node_put;
> +	}
> +
> +	if (name) {
> +		ret = dev_pm_opp_set_regulator(cpu_dev, name);
-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
