From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH 1/2] PM / OPP: introduce an OPP power estimation helper
Date: Wed, 10 Jan 2018 10:06:25 +0530
Message-ID: <20180110043625.GD3335@vireshk-i7>
References: <20180109110252.13557-1-quentin.perret@arm.com>
 <20180109110252.13557-2-quentin.perret@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pg0-f68.google.com ([74.125.83.68]:35373 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756296AbeAJEg2 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 9 Jan 2018 23:36:28 -0500
Received: by mail-pg0-f68.google.com with SMTP id d6so8849048pgv.2
        for <linux-pm@vger.kernel.org>; Tue, 09 Jan 2018 20:36:28 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20180109110252.13557-2-quentin.perret@arm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Quentin Perret <quentin.perret@arm.com>
Cc: linux-pm@vger.kernel.org, rjw@rjwysocki.net, vireshk@kernel.org, nm@ti.com, sboyd@codeaurora.org, sudeep.holla@arm.com, amit.kachhap@gmail.com, javi.merino@kernel.org, rui.zhang@intel.com, edubezval@gmail.com, matthias.bgg@gmail.com, dietmar.eggemann@arm.com, morten.rasmussen@arm.com, patrick.bellasi@arm.com, ionela.voinescu@arm.com

On 09-01-18, 11:02, Quentin Perret wrote:
> The power dissipated by a CPU at a specific OPP is currently estimated by
> the thermal subsystem as P = C * V^2 * f, with P the power, C the CPU's
> capacitance, V the OPP's voltage and f the OPP's frequency. As this
> feature can be useful for other clients requiring energy models of CPUs,
> this commit introduces an equivalent power estimator directly into the OPP
> library, hence enabling code re-use.

Okay. I am fine with the basic idea of moving this stuff into the OPP
library but will do it a bit differently.

> Signed-off-by: Quentin Perret <quentin.perret@arm.com>
> ---
>  drivers/opp/core.c     | 40 +++++++++++++++++++++++++++++++++
>  drivers/opp/of.c       | 61 ++++++++++++++++++++++++++++++++++++++++++++++++++
>  drivers/opp/opp.h      |  4 ++++
>  include/linux/pm_opp.h | 20 +++++++++++++++++
>  4 files changed, 125 insertions(+)
> 
> diff --git a/drivers/opp/core.c b/drivers/opp/core.c
> index 92fa94a6dcc1..b5e1ad2d311d 100644
> --- a/drivers/opp/core.c
> +++ b/drivers/opp/core.c
> @@ -127,6 +127,24 @@ unsigned long dev_pm_opp_get_freq(struct dev_pm_opp *opp)
>  }
>  EXPORT_SYMBOL_GPL(dev_pm_opp_get_freq);
>  
> +/**
> + * dev_pm_opp_get_power() - Gets the estimated power corresponding to an opp
> + * @opp:	opp for which power has to be returned for
> + *
> + * Return: estimated power in mirco-watts corresponding to the opp, else
> + * return 0
> + */
> +unsigned long dev_pm_opp_get_power(struct dev_pm_opp *opp)
> +{
> +	if (IS_ERR_OR_NULL(opp) || !opp->available) {

Drop the available check here.

> +		pr_err("%s: Invalid parameters\n", __func__);
> +		return 0;
> +	}
> +
> +	return opp->power_estimate_uw;
> +}
> +EXPORT_SYMBOL_GPL(dev_pm_opp_get_power);
> +
>  /**
>   * dev_pm_opp_is_turbo() - Returns if opp is turbo OPP or not
>   * @opp: opp for which turbo mode is being verified
> @@ -148,6 +166,28 @@ bool dev_pm_opp_is_turbo(struct dev_pm_opp *opp)
>  }
>  EXPORT_SYMBOL_GPL(dev_pm_opp_is_turbo);
>  
> +/**
> + * dev_pm_opp_has_power() - Get the status of power values for OPPs
> + * @cpu_dev:	CPU device for which we do this operation
> + *
> + * Return: True if the OPPs hold power estimates for the CPU
> + */
> +bool dev_pm_opp_has_power(struct device *cpu_dev)
> +{
> +	struct opp_table *opp_table;
> +	bool has_power;
> +
> +	opp_table = _find_opp_table(cpu_dev);
> +	if (IS_ERR(opp_table))
> +		return false;
> +
> +	has_power = opp_table->has_power;
> +
> +	dev_pm_opp_put_opp_table(opp_table);
> +
> +	return has_power;
> +}
> +
>  /**
>   * dev_pm_opp_get_max_clock_latency() - Get max clock latency in nanoseconds
>   * @dev:	device for which we do this operation
> diff --git a/drivers/opp/of.c b/drivers/opp/of.c
> index cb716aa2f44b..4a376cd00e8d 100644
> --- a/drivers/opp/of.c
> +++ b/drivers/opp/of.c
> @@ -633,3 +633,64 @@ int dev_pm_opp_of_get_sharing_cpus(struct device *cpu_dev,
>  	return ret;
>  }
>  EXPORT_SYMBOL_GPL(dev_pm_opp_of_get_sharing_cpus);
> +
> +/**
> + * dev_pm_opp_of_estimate_power() - Estimates the power dissipated by @cpu_dev
> + *                                  at each OPP.
> + * @cpu_dev:	CPU device for which we do this estimation
> + *
> + * This estimates the active power consumed by a CPU at each OPP using:
> + *                         P = C * V^2 * f
> + * with P the power, C the CPU's capacitance, V the OPP's voltage and f the
> + * OPP's frequency. V and f are assumed to be known by the time this function
> + * is called and C is read from DT.
> + *
> + * Returns -EINVAL if the CPU's capacitance cannot be read from DT.
> + */
> +int dev_pm_opp_of_estimate_power(struct device *cpu_dev)

I wouldn't add this special function, but rather fill
power_estimate_uW while creating the OPPs for the first time.

-- 
viresh
