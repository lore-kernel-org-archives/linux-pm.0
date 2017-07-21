From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH] PM / OPP: Fix get sharing cpus when hotplug is used
Date: Fri, 21 Jul 2017 09:44:04 +0530
Message-ID: <20170721041404.GM352@vireshk-i7>
References: <20170720140237.6296-1-waldemarx.rymarkiewicz@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pf0-f169.google.com ([209.85.192.169]:34751 "EHLO
        mail-pf0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750727AbdGUEOH (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 21 Jul 2017 00:14:07 -0400
Received: by mail-pf0-f169.google.com with SMTP id q85so19511122pfq.1
        for <linux-pm@vger.kernel.org>; Thu, 20 Jul 2017 21:14:07 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20170720140237.6296-1-waldemarx.rymarkiewicz@intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Waldemar Rymarkiewicz <waldemarx.rymarkiewicz@intel.com>
Cc: linux-pm@vger.kernel.org, WaldemarRymarkiewiczwaldemar.rymarkiewicz@gmail.com, Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@codeaurora.org>

On 20-07-17, 16:02, Waldemar Rymarkiewicz wrote:
> On systems where not all possible CPUs are available for Linux, call to
> dev_pm_opp_of_get_sharing_cpus() will fail as cannot find a cpu device

s/fail/we fail/

> for not present (offline) CPUs.

not-present != offline. But above kind of says so. We need to only say
that the CPUs aren't present yet, i.e. hotplugged out.

> 
> Example (real use case):
> 2 physical MIPS cores, 4 VPE, cpu0/2 run Linux and cpu1/3 are not available
> for linux at boot up. cpufreq-dt driver + opp v2 fail to register opp_table
> due to the fact there is no struct device for cpu1 (remains offline at bootup).
> 
> More generally, this is a problem for all platforms that use cpu hotplugging.
> 
> Iterating over cpu device nodes instead of cpu device struct solves this
> problem.
> 
> Signed-off-by: Waldemar Rymarkiewicz <waldemarx.rymarkiewicz@intel.com>
> ---
>  drivers/base/power/opp/of.c | 27 ++++++++++++++++-----------
>  1 file changed, 16 insertions(+), 11 deletions(-)

So, this kind of means that you are abandoning your earlier patch as
that isn't required anymore? You should have marked it as V2 here and
provided a changelog.

> diff --git a/drivers/base/power/opp/of.c b/drivers/base/power/opp/of.c
> index 57eec1c..28348d6 100644
> --- a/drivers/base/power/opp/of.c
> +++ b/drivers/base/power/opp/of.c
> @@ -248,15 +248,21 @@ void dev_pm_opp_of_remove_table(struct device *dev)
>  }
>  EXPORT_SYMBOL_GPL(dev_pm_opp_of_remove_table);
>  
> -/* Returns opp descriptor node for a device, caller must do of_node_put() */
> -struct device_node *dev_pm_opp_of_get_opp_desc_node(struct device *dev)
> +/* Returns opp descriptor node for a device node, caller must do of_node_put() */
> +static struct device_node *_opp_of_get_opp_desc_node(struct device_node *np)
>  {
>  	/*
>  	 * There should be only ONE phandle present in "operating-points-v2"
>  	 * property.
>  	 */
>  
> -	return of_parse_phandle(dev->of_node, "operating-points-v2", 0);
> +	return of_parse_phandle(np, "operating-points-v2", 0);
> +}
> +
> +/* Returns opp descriptor node for a device, caller must do of_node_put() */
> +struct device_node *dev_pm_opp_of_get_opp_desc_node(struct device *dev)
> +{
> +	return _opp_of_get_opp_desc_node(dev->of_node);
>  }
>  EXPORT_SYMBOL_GPL(dev_pm_opp_of_get_opp_desc_node);
>  
> @@ -572,8 +578,7 @@ EXPORT_SYMBOL_GPL(dev_pm_opp_of_cpumask_add_table);
>  int dev_pm_opp_of_get_sharing_cpus(struct device *cpu_dev,
>  				   struct cpumask *cpumask)
>  {
> -	struct device_node *np, *tmp_np;
> -	struct device *tcpu_dev;
> +	struct device_node *np, *tmp_np, *cpu_np;
>  	int cpu, ret = 0;
>  
>  	/* Get OPP descriptor node */
> @@ -593,18 +598,18 @@ int dev_pm_opp_of_get_sharing_cpus(struct device *cpu_dev,
>  		if (cpu == cpu_dev->id)
>  			continue;
>  
> -		tcpu_dev = get_cpu_device(cpu);
> -		if (!tcpu_dev) {
> -			dev_err(cpu_dev, "%s: failed to get cpu%d device\n",
> +		cpu_np = of_get_cpu_node(cpu, NULL);
> +		if (!cpu_np) {
> +			dev_err(cpu_dev, "%s: failed to get cpu%d node\n",
>  				__func__, cpu);
> -			ret = -ENODEV;
> +			ret = -ENOENT;
>  			goto put_cpu_node;
>  		}
>  
>  		/* Get OPP descriptor node */
> -		tmp_np = dev_pm_opp_of_get_opp_desc_node(tcpu_dev);
> +		tmp_np = _opp_of_get_opp_desc_node(cpu_np);
>  		if (!tmp_np) {
> -			dev_err(tcpu_dev, "%s: Couldn't find opp node.\n",
> +			dev_err(cpu_dev, "%s: Couldn't find opp node.\n",
>  				__func__);
>  			ret = -ENOENT;
>  			goto put_cpu_node;
> -- 
> 2.10.1

Diff looks fine though.

-- 
viresh
