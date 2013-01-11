From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH 1/3] cpufreq: Manage only online cpus
Date: Fri, 11 Jan 2013 23:43:52 +0100
Message-ID: <104464435.bDq83Yqfys@vostro.rjw.lan>
References: <98330b2deb910453a356404b8cf774c94326bc42.1355636864.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from hydra.sisk.pl ([212.160.235.94]:38241 "EHLO hydra.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754691Ab3AKWiF (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Fri, 11 Jan 2013 17:38:05 -0500
In-Reply-To: <98330b2deb910453a356404b8cf774c94326bc42.1355636864.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: rafael.j.wysocki@intel.com, linaro-dev@lists.linaro.org, nicolas.pitre@linaro.org, amit.kucheria@linaro.org, mathieu.poirier@linaro.org, linux-kernel@vger.kernel.org, cpufreq@vger.kernel.org, pdsw-power-team@arm.com, linux-pm@vger.kernel.org

On Sunday, December 16, 2012 11:20:08 AM Viresh Kumar wrote:
> cpufreq core doesn't manage offline cpus and if driver->init() has returned
> mask including offline cpus, it may result in unwanted behavior by cpufreq core
> or governors.
> 
> We need to get only online cpus in this mask. There are two places to fix this
> mask, cpufreq core and cpufreq driver. It makes sense to do this at common place
> and hence is done in core.

Applied to the linux-next branch of the linux-pm.git tree as v3.9 material.

Thanks,
Rafael


> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---
>  drivers/cpufreq/cpufreq.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
> index 1f93dbd..de99517 100644
> --- a/drivers/cpufreq/cpufreq.c
> +++ b/drivers/cpufreq/cpufreq.c
> @@ -970,6 +970,13 @@ static int cpufreq_add_dev(struct device *dev, struct subsys_interface *sif)
>  		pr_debug("initialization failed\n");
>  		goto err_unlock_policy;
>  	}
> +
> +	/*
> +	 * affected cpus must always be the one, which are online. We aren't
> +	 * managing offline cpus here.
> +	 */
> +	cpumask_and(policy->cpus, policy->cpus, cpu_online_mask);
> +
>  	policy->user_policy.min = policy->min;
>  	policy->user_policy.max = policy->max;
>  
> 
-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
