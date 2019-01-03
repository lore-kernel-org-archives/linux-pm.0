From: Sudeep Holla <sudeep.holla@arm.com>
Subject: Re: [BUG] dev_pm_opp refcount issue on Arm Juno r0
Date: Thu, 3 Jan 2019 10:33:39 +0000
Message-ID: <20190103103318.GA23511@e107155-lin>
References: <a2a42913-04e0-e6fc-d9ee-a2e355ac22c9@arm.com>
 <20190103070514.o6yaqvpxouazosnn@vireshk-i7>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190103070514.o6yaqvpxouazosnn@vireshk-i7>
Sender: linux-kernel-owner@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Valentin Schneider <valentin.schneider@arm.com>, linux-kernel <linux-kernel@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>, LAK <linux-arm-kernel@lists.infradead.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, nm@ti.com, sboyd@kernel.org, Quentin Perret <quentin.perret@arm.com>, Dietmar Eggemann <dietmar.eggemann@arm.com>, Sudeep Holla <sudeep.holla@arm.com>, Douglas Raillard <Douglas.Raillard@arm.com>
List-Id: linux-pm@vger.kernel.org

On Thu, Jan 03, 2019 at 12:35:14PM +0530, Viresh Kumar wrote:

[...]

> @Sudeep: Please help review it as well.
> 
> -- 
> viresh
> 
> -------------------------8<-------------------------
> 
> From f3913738618031e9d71ebf64461cee22909e6e20 Mon Sep 17 00:00:00 2001
> Message-Id: <f3913738618031e9d71ebf64461cee22909e6e20.1546498940.git.viresh.kumar@linaro.org>
> From: Viresh Kumar <viresh.kumar@linaro.org>
> Date: Thu, 3 Jan 2019 12:28:26 +0530
> Subject: [PATCH] cpufreq: scpi: Fix freeing of OPPs
> 
> Since the commit 2a4eb7358aba ("OPP: Don't remove dynamic OPPs from
> _dev_pm_opp_remove_table()"), dynamically created OPP aren't
> automatically removed anymore by dev_pm_opp_cpumask_remove_table().
> 
> The OPPs for scpi cpufreq driver aren't getting freed currently, fix
> that by adding a new callback scpi_ops->remove_device_opps() which will
> remove those OPPs.
> 
> Cc: 4.20 <stable@vger.kernel.org> # v4.20
> Reported-by: Valentin Schneider <valentin.schneider@arm.com>
> Fixes: 2a4eb7358aba ("OPP: Don't remove dynamic OPPs from _dev_pm_opp_remove_table()")
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---
>  drivers/cpufreq/scpi-cpufreq.c |  4 ++--
>  drivers/firmware/arm_scpi.c    | 15 +++++++++++++++
>  include/linux/scpi_protocol.h  |  1 +
>  3 files changed, 18 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/cpufreq/scpi-cpufreq.c b/drivers/cpufreq/scpi-cpufreq.c
> index 87a98ec77773..1bfd168de0b2 100644
> --- a/drivers/cpufreq/scpi-cpufreq.c
> +++ b/drivers/cpufreq/scpi-cpufreq.c
> @@ -177,7 +177,7 @@ static int scpi_cpufreq_init(struct cpufreq_policy *policy)
>  out_free_priv:
>  	kfree(priv);
>  out_free_opp:
> -	dev_pm_opp_cpumask_remove_table(policy->cpus);
> +	scpi_ops->remove_device_opps(cpu_dev);
>  
>  	return ret;
>  }
> @@ -190,7 +190,7 @@ static int scpi_cpufreq_exit(struct cpufreq_policy *policy)
>  	clk_put(priv->clk);
>  	dev_pm_opp_free_cpufreq_table(priv->cpu_dev, &policy->freq_table);
>  	kfree(priv);
> -	dev_pm_opp_cpumask_remove_table(policy->related_cpus);
> +	scpi_ops->remove_device_opps(priv->cpu_dev);
>  
>  	return 0;
>  }
> diff --git a/drivers/firmware/arm_scpi.c b/drivers/firmware/arm_scpi.c
> index c7d06a36b23a..963f2ffbd820 100644
> --- a/drivers/firmware/arm_scpi.c
> +++ b/drivers/firmware/arm_scpi.c
> @@ -716,6 +716,20 @@ static int scpi_dvfs_add_opps_to_device(struct device *dev)
>  	return 0;
>  }
>  
> +static void scpi_dvfs_remove_device_opps(struct device *dev)
> +{
> +	int idx;
> +	struct scpi_opp *opp;
> +	struct scpi_dvfs_info *info = scpi_dvfs_info(dev);
> +
> +	/* We already added OPPs successfully, this data can't be invalid */

As you already state the checks are unnecessary, if we drop them we don't need
to add any firmware specific callbacks. I am thinking if it makes sense to
add a generic helper function to remove the OPPs from a device. If we have
that any driver needing that can use it. The main reason I think helper is
useful is that we need exactly same fix for SCMI driver too.

Thoughts ?

--
Regards,
Sudeep
