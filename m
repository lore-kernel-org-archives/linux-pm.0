From: Stephen Boyd <sboyd@codeaurora.org>
Subject: Re: [PATCH 17/17] cpufreq: dt: No need to allocate resources anymore
Date: Mon, 11 Jan 2016 18:20:22 -0800
Message-ID: <20160112022022.GV22188@codeaurora.org>
References: <cover.1450777582.git.viresh.kumar@linaro.org>
 <df2534b4ced57791ec3ee42eb34211e132aa423a.1450777582.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:44522 "EHLO
	smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1762192AbcALCUY (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 11 Jan 2016 21:20:24 -0500
Content-Disposition: inline
In-Reply-To: <df2534b4ced57791ec3ee42eb34211e132aa423a.1450777582.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Rafael Wysocki <rjw@rjwysocki.net>, linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, nm@ti.com

On 12/22, Viresh Kumar wrote:
> OPP layer manages it now and cpufreq-dt driver doesn't need it. But, we
> still need to check for availability of resources for deferred probing.

Why? It seems cleaner to let OPP layer return an error indicating
probe defer or failure when we try to initialize it. That way we
aren't duplicating the same logic in two places to figure out if
a regulator or clock is ready.

> 
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> @@ -95,8 +90,8 @@ static int allocate_resources(int cpu, struct device **cdev,
>  		 * not yet registered, we should try defering probe.
>  		 */
>  		if (PTR_ERR(cpu_reg) == -EPROBE_DEFER) {
> -			dev_dbg(cpu_dev, "cpu%d regulator not ready, retry\n",
> -				cpu);
> +			dev_dbg(cpu_dev, "cpu%s regulator not ready, retry\n",

Should that just be "%s regulator not ready"?

> +				reg);
>  			return -EPROBE_DEFER;
>  		}
> @@ -241,9 +234,7 @@ static int cpufreq_init(struct cpufreq_policy *policy)
>  	}
>  
>  	priv->cpu_dev = cpu_dev;
> -	priv->cpu_reg = cpu_reg;
>  	policy->driver_data = priv;
> -
>  	policy->clk = cpu_clk;

Maybe we can have an dev_pm_opp_get_rate() API and a
cpufreq_generic_opp_get() so we can get rid of policy->clk usage
in this driver?

>  
>  	rcu_read_lock();
-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
