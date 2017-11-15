From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH] cpufreq: imx6q: add CPU as cooling device
Date: Wed, 15 Nov 2017 10:29:56 +0530
Message-ID: <20171115045956.GG3257@vireshk-i7>
References: <20171114135128.6173-1-bst@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pg0-f67.google.com ([74.125.83.67]:44255 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752233AbdKOE77 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 14 Nov 2017 23:59:59 -0500
Received: by mail-pg0-f67.google.com with SMTP id 4so8262529pge.1
        for <linux-pm@vger.kernel.org>; Tue, 14 Nov 2017 20:59:59 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20171114135128.6173-1-bst@pengutronix.de>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Bastian Stender <bst@pengutronix.de>, shawnguo@kernel.org
Cc: "Rafael J . Wysocki" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org, Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>, kernel@pengutronix.de

+Shawn

On 14-11-17, 14:51, Bastian Stender wrote:
> The cooling device should be part of the i.MX cpufreq driver. So move
> it there.
> 
> Use of_cpufreq_power_cooling_register to link the cooling device to the
> device tree node provided.
> 
> This makes it possible to bind the cpufreq cooling device to a custom
> thermal zone via a cooling-maps entry like:
> 
> 	cooling-maps {
> 		map0 {
> 			trip = <&board_alert>;
> 			cooling-device = <&cpu0 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
> 		};
> 	};
> 
> Assuming a cpu node exists with label "cpu0" and #cooling-cells
> property.
> 
> Signed-off-by: Bastian Stender <bst@pengutronix.de>
> ---
> This is part of a rework of "thermal: imx: use cpufreq cooling of
> registration method" (id:20171103164203.5805-1-bst@pengutronix.de).
> 
> The cooling device gets removed from imx_thermal code by "thermal: imx:
> remove cooling device" (id:20171114134829.1354-1-bst@pengutronix.de)
> ---
>  drivers/cpufreq/imx6q-cpufreq.c | 38 ++++++++++++++++++++++++++++++++++++++
>  1 file changed, 38 insertions(+)
> 
> diff --git a/drivers/cpufreq/imx6q-cpufreq.c b/drivers/cpufreq/imx6q-cpufreq.c
> index 14466a9b01c0..66833840236e 100644
> --- a/drivers/cpufreq/imx6q-cpufreq.c
> +++ b/drivers/cpufreq/imx6q-cpufreq.c
> @@ -9,6 +9,7 @@
>  #include <linux/clk.h>
>  #include <linux/cpu.h>
>  #include <linux/cpufreq.h>
> +#include <linux/cpu_cooling.h>
>  #include <linux/err.h>
>  #include <linux/module.h>
>  #include <linux/of.h>
> @@ -35,6 +36,7 @@ static struct clk *pll2_bus_clk;
>  static struct clk *secondary_sel_clk;
>  
>  static struct device *cpu_dev;
> +static struct thermal_cooling_device *cdev;
>  static bool free_opp;
>  static struct cpufreq_frequency_table *freq_table;
>  static unsigned int transition_latency;
> @@ -169,6 +171,32 @@ static int imx6q_set_target(struct cpufreq_policy *policy, unsigned int index)
>  	return 0;
>  }
>  
> +static void imx6q_cpufreq_ready(struct cpufreq_policy *policy)
> +{
> +	struct device_node *np = of_node_get(cpu_dev->of_node);
> +	u32 capacitance = 0;
> +
> +	if (WARN_ON(!np))
> +		return;
> +
> +	if (of_find_property(np, "#cooling-cells", NULL)) {
> +		of_property_read_u32(np, "dynamic-power-coefficient", &capacitance);
> +
> +		cdev = of_cpufreq_power_cooling_register(np,
> +						policy, capacitance, NULL);
> +
> +		if (IS_ERR(cdev)) {
> +			dev_err(cpu_dev,
> +				"running cpufreq without cooling device: %ld\n",
> +				PTR_ERR(cdev));
> +
> +			cdev = NULL;
> +		}
> +	}
> +
> +	of_node_put(np);
> +}
> +
>  static int imx6q_cpufreq_init(struct cpufreq_policy *policy)
>  {
>  	int ret;
> @@ -180,13 +208,23 @@ static int imx6q_cpufreq_init(struct cpufreq_policy *policy)
>  	return ret;
>  }
>  
> +static int imx6q_cpufreq_exit(struct cpufreq_policy *policy)
> +{
> +	cpufreq_cooling_unregister(cdev);
> +	dev_pm_opp_free_cpufreq_table(cpu_dev, &policy->freq_table);

You incorrectly copied this routine (and so above line) from somewhere else ? :)

-- 
viresh
