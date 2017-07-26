From: Sudeep Holla <sudeep.holla@arm.com>
Subject: Re: [PATCH v4 1/1] PM / OPP: Fix get sharing cpus when hotplug is
 used
Date: Wed, 26 Jul 2017 14:10:43 +0100
Message-ID: <276e68a1-edfe-961b-e387-7855f409557b@arm.com>
References: <20170726121151.7576-1-waldemarx.rymarkiewicz@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:60650 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750964AbdGZNKq (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 26 Jul 2017 09:10:46 -0400
In-Reply-To: <20170726121151.7576-1-waldemarx.rymarkiewicz@intel.com>
Content-Language: en-US
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Waldemar Rymarkiewicz <waldemarx.rymarkiewicz@intel.com>, linux-pm@vger.kernel.org
Cc: Sudeep Holla <sudeep.holla@arm.com>, waldemar.rymarkiewicz@gmail.com, Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@codeaurora.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>



On 26/07/17 13:11, Waldemar Rymarkiewicz wrote:
> We fail dev_pm_opp_of_get_sharing_cpus() when possible cpu device does not
> exist. This can happen on platforms where not all possible CPUs are
> available at start up ie. hotplugged out. Cpu device is not registered in
> the system so we are not able to check struct device to set the sharing
> CPUs bitmask properly.
> 
> Example (real use case):
> 2 physical MIPS cores, 4 VPE, cpu0/2 run Linux and cpu1/3 are not available
> for Linux at boot up. cpufreq-dt driver + opp v2 fail to register opp_table
> due to the fact there is no struct device for cpu1 (remains offline at
> bootup).
> 

Interesting, will cpu1/3 ever hotplugged in to Linux ?
Just wondering if we can change the logical cpu assignment.

Please note, I am not against this patch, just got curious on logical
cpu numbering.

> To solve the bug, stop using device struct to check device_node. Instead
> get cpu device_node directly from device tree with of_get_cpu_node().
> 
> Signed-off-by: Waldemar Rymarkiewicz <waldemarx.rymarkiewicz@intel.com>
> Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
> Reviewed-by: Stephen Boyd <sboyd@codeaurora.org>
> ---
>  drivers/base/power/opp/of.c | 29 +++++++++++++++++------------
>  1 file changed, 17 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/base/power/opp/of.c b/drivers/base/power/opp/of.c
> index 57eec1c..e83bc15 100644
> --- a/drivers/base/power/opp/of.c
> +++ b/drivers/base/power/opp/of.c
> @@ -248,15 +248,22 @@ void dev_pm_opp_of_remove_table(struct device *dev)
>  }
>  EXPORT_SYMBOL_GPL(dev_pm_opp_of_remove_table);
>  
> -/* Returns opp descriptor node for a device, caller must do of_node_put() */
> -struct device_node *dev_pm_opp_of_get_opp_desc_node(struct device *dev)
> +/* Returns opp descriptor node for a device node, caller must
> + * do of_node_put() */
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
> @@ -572,8 +579,7 @@ EXPORT_SYMBOL_GPL(dev_pm_opp_of_cpumask_add_table);
>  int dev_pm_opp_of_get_sharing_cpus(struct device *cpu_dev,
>  				   struct cpumask *cpumask)
>  {
> -	struct device_node *np, *tmp_np;
> -	struct device *tcpu_dev;
> +	struct device_node *np, *tmp_np, *cpu_np;
>  	int cpu, ret = 0;
>  
>  	/* Get OPP descriptor node */
> @@ -593,19 +599,18 @@ int dev_pm_opp_of_get_sharing_cpus(struct device *cpu_dev,
>  		if (cpu == cpu_dev->id)
>  			continue;
>  
> -		tcpu_dev = get_cpu_device(cpu);
> -		if (!tcpu_dev) {
> -			dev_err(cpu_dev, "%s: failed to get cpu%d device\n",
> +		cpu_np = of_get_cpu_node(cpu, NULL);

Does this mean you get cpu_np != NULL even for cpu1/3 ? If yes, is that
OK to set the mask here ?

Can we make use of of_cpu_device_node_get instead above ? We don't want
keep parsing the device tree every time as the pointers are stashed in
device struct.

-- 
Regards,
Sudeep
