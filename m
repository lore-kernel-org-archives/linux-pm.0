From: Stephen Boyd <sboyd@codeaurora.org>
Subject: Re: [PATCH V3 11/16] PM / OPP: Add helpers for initializing CPU OPPs
Date: Thu, 30 Jul 2015 23:07:11 -0700
Message-ID: <20150731060711.GK3159@codeaurora.org>
References: <cover.1438166099.git.viresh.kumar@linaro.org>
 <41e8c355e4e9f5a71b380cf87a7e09d10f00c606.1438166099.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:36522 "EHLO
	smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752347AbbGaGHO (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 31 Jul 2015 02:07:14 -0400
Content-Disposition: inline
In-Reply-To: <41e8c355e4e9f5a71b380cf87a7e09d10f00c606.1438166099.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Rafael Wysocki <rjw@rjwysocki.net>, linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, rob.herring@linaro.org, arnd.bergmann@linaro.org, nm@ti.com, broonie@kernel.org, mturquette@baylibre.com, Sudeep.Holla@arm.com, viswanath.puttagunta@linaro.org, l.stach@pengutronix.de, thomas.petazzoni@free-electrons.com, linux-arm-kernel@lists.infradead.org, ta.omasab@gmail.com, kesavan.abhilash@gmail.com, khilman@linaro.org, santosh.shilimkar@oracle.com, b.zolnierkie@samsung.com, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Len Brown <len.brown@intel.com>, open list <linux-kernel@vger.kernel.org>, Pavel Machek <pavel@ucw.cz>

On 07/29, Viresh Kumar wrote:
> With "operating-points-v2" its possible to tell which devices share
> OPPs. We already have infrastructure to decode that information.
> 
> This patch adds following APIs:
> - of_get_cpus_sharing_opps: Returns cpumask of CPUs sharing OPPs (only
>   valid with v2 bindings).
> - of_cpumask_init_opp_table: Initializes OPPs for all CPUs present in
>   cpumask.
> - of_cpumask_free_opp_table: Frees OPPs for all CPUs present in cpumask.
> 
> - set_cpus_sharing_opps: Sets which CPUs share OPPs (only valid with old
>   OPP bindings, as this information isn't present in DT).
> 
> Reviewed-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>

Reviewed-by: Stephen Boyd <sboyd@codeaurora.org>

Some minor nitpicks below:

> +
> +/*
> + * Works only for OPP v2 bindings.
> + *
> + * cpumask should be already set to mask of cpu_dev->id.
> + * Returns -ENOENT if operating-points-v2 bindings aren't supported.
> + */
> +int of_get_cpus_sharing_opps(struct device *cpu_dev, cpumask_var_t cpumask)
> +{
> +	struct device_node *np, *tmp_np;
> +	struct device *tcpu_dev;
> +	int cpu, ret = 0;
> +
> +	/* Get OPP descriptor node */
> +	np = _of_get_opp_desc_node(cpu_dev);
> +	if (IS_ERR(np)) {
> +		dev_dbg(cpu_dev, "%s: Couldn't find opp node: %ld\n", __func__,
> +			PTR_ERR(np));
> +		return -ENOENT;
> +	}
> +
> +	/* OPPs are shared ? */
> +	if (!of_get_property(np, "opp-shared", NULL))

if (!of_property_read_bool(np, "opp-shared")) ?

> +		goto put_cpu_node;
> +
> +	for_each_possible_cpu(cpu) {
> +		if (cpu == cpu_dev->id)
> +			continue;
> +
> +		tcpu_dev = get_cpu_device(cpu);
> +		if (!tcpu_dev) {
> +			dev_err(cpu_dev, "%s: failed to get cpu%d device\n",
> +				__func__, cpu);
> +			ret = -ENODEV;
> +			goto put_cpu_node;
> +		}
> +
> +		/* Get OPP descriptor node */
> +		tmp_np = _of_get_opp_desc_node(tcpu_dev);
> +		if (IS_ERR(tmp_np)) {
> +			dev_info(tcpu_dev, "%s: Couldn't find opp node: %ld\n",

dev_err?

> +				 __func__, PTR_ERR(tmp_np));
> +			ret = -EINVAL;

Why aren't we returning the PTR_ERR value here?

> +			goto put_cpu_node;

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
