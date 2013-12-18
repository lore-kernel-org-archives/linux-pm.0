From: Shawn Guo <shawn.guo@linaro.org>
Subject: Re: [PATCH V2 2/2] cpufreq: imx6q: correct VDDSOC/PU voltage scaling
 when cpufreq is changed
Date: Wed, 18 Dec 2013 15:33:23 +0800
Message-ID: <20131218073321.GF6691@S2101-09.ap.freescale.net>
References: <1387318102-11070-1-git-send-email-b20788@freescale.com>
 <1387318102-11070-2-git-send-email-b20788@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from co1ehsobe004.messaging.microsoft.com ([216.32.180.187]:58159
	"EHLO co1outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751320Ab3LRHcZ (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 18 Dec 2013 02:32:25 -0500
Content-Disposition: inline
In-Reply-To: <1387318102-11070-2-git-send-email-b20788@freescale.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Anson Huang <b20788@freescale.com>
Cc: rjw@rjwysocki.net, viresh.kumar@linaro.org, cpufreq@vger.kernel.org, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org

On Tue, Dec 17, 2013 at 05:08:22PM -0500, Anson Huang wrote:
> on i.MX6Q, cpu freq change need to follow below flows:
> 
> 1. each setpoint has different VDDARM, VDDSOC/PU voltage, get the setpoint
>    table from dts;
> 2. when cpu freq is scaling up, need to increase VDDSOC/PU voltage before
>    VDDARM, if VDDPU is off, no need to change it;
> 3. when cpu freq is scaling down, need to decrease VDDARM voltage before
>    VDDSOC/PU, if VDDPU is off, no need to change it;
> 
> normally dts will pass vddsoc/pu freq/volt info to kernel, if not, will
> use fixed value for vddsoc/pu voltage setting.
> 
> Signed-off-by: Anson Huang <b20788@freescale.com>
> ---
>  drivers/cpufreq/imx6q-cpufreq.c |  117 +++++++++++++++++++++++++++++----------
>  1 file changed, 88 insertions(+), 29 deletions(-)
> 
> diff --git a/drivers/cpufreq/imx6q-cpufreq.c b/drivers/cpufreq/imx6q-cpufreq.c
> index 4b3f18e..65c1df1 100644
> --- a/drivers/cpufreq/imx6q-cpufreq.c
> +++ b/drivers/cpufreq/imx6q-cpufreq.c
> @@ -35,6 +35,9 @@ static struct device *cpu_dev;
>  static struct cpufreq_frequency_table *freq_table;
>  static unsigned int transition_latency;
>  
> +static u32 *imx6_soc_volt;
> +static u32 soc_opp_count;
> +
>  static unsigned int imx6q_get_speed(unsigned int cpu)
>  {
>  	return clk_get_rate(arm_clk) / 1000;
> @@ -69,23 +72,24 @@ static int imx6q_set_target(struct cpufreq_policy *policy, unsigned int index)
>  
>  	/* scaling up?  scale voltage before frequency */
>  	if (new_freq > old_freq) {
> +		if (regulator_is_enabled(pu_reg)) {
> +			ret = regulator_set_voltage_tol(pu_reg, imx6_soc_volt[index], 0);
> +			if (ret) {
> +				dev_err(cpu_dev, "failed to scale vddpu up: %d\n", ret);
> +				return ret;
> +			}
> +		}
> +		ret = regulator_set_voltage_tol(soc_reg, imx6_soc_volt[index], 0);
> +		if (ret) {
> +			dev_err(cpu_dev, "failed to scale vddsoc up: %d\n", ret);
> +			return ret;
> +		}
>  		ret = regulator_set_voltage_tol(arm_reg, volt, 0);
>  		if (ret) {
>  			dev_err(cpu_dev,
>  				"failed to scale vddarm up: %d\n", ret);
>  			return ret;
>  		}
> -
> -		/*
> -		 * Need to increase vddpu and vddsoc for safety
> -		 * if we are about to run at 1.2 GHz.
> -		 */
> -		if (new_freq == FREQ_1P2_GHZ / 1000) {
> -			regulator_set_voltage_tol(pu_reg,
> -					PU_SOC_VOLTAGE_HIGH, 0);
> -			regulator_set_voltage_tol(soc_reg,
> -					PU_SOC_VOLTAGE_HIGH, 0);
> -		}
>  	}
>  
>  	/*
> @@ -120,12 +124,17 @@ static int imx6q_set_target(struct cpufreq_policy *policy, unsigned int index)
>  				 "failed to scale vddarm down: %d\n", ret);
>  			ret = 0;
>  		}
> -
> -		if (old_freq == FREQ_1P2_GHZ / 1000) {
> -			regulator_set_voltage_tol(pu_reg,
> -					PU_SOC_VOLTAGE_NORMAL, 0);
> -			regulator_set_voltage_tol(soc_reg,
> -					PU_SOC_VOLTAGE_NORMAL, 0);
> +		ret = regulator_set_voltage_tol(soc_reg, imx6_soc_volt[index], 0);
> +		if (ret) {
> +			dev_warn(cpu_dev, "failed to scale vddsoc down: %d\n", ret);
> +			ret = 0;
> +		}
> +		if (regulator_is_enabled(pu_reg)) {
> +			ret = regulator_set_voltage_tol(pu_reg, imx6_soc_volt[index], 0);
> +			if (ret) {
> +				dev_warn(cpu_dev, "failed to scale vddpu down: %d\n", ret);
> +				ret = 0;
> +			}
>  		}
>  	}
>  
> @@ -153,6 +162,9 @@ static int imx6q_cpufreq_probe(struct platform_device *pdev)
>  	struct dev_pm_opp *opp;
>  	unsigned long min_volt, max_volt;
>  	int num, ret;
> +	const struct property *prop;
> +	const __be32 *val;
> +	u32 nr, i, j;
>  
>  	cpu_dev = get_cpu_device(0);
>  	if (!cpu_dev) {
> @@ -201,10 +213,69 @@ static int imx6q_cpufreq_probe(struct platform_device *pdev)
>  		goto put_node;
>  	}
>  
> +	/* Make imx6_soc_volt array's size same as arm opp number */
> +	imx6_soc_volt = devm_kzalloc(cpu_dev, sizeof(*imx6_soc_volt) * num, GFP_KERNEL);
> +	if (imx6_soc_volt == NULL) {
> +		dev_warn(cpu_dev, "No valid memory for imx6_soc_volt!\n");

Drop this message.  Error code -ENOMEM is enough to tell what's going
wrong.

> +		ret = -ENOMEM;
> +		goto free_freq_table;
> +	}
> +
> +	prop = of_find_property(np, "fsl,soc-operating-points", NULL);
> +	if (!prop || !prop->value) {
> +		dev_warn(cpu_dev, "No valid fsl,soc-operating-points property is found!\n");
> +		goto soc_opp_out;
> +	}
> +
> +	/*
> +	 * Each OPP is a set of tuples consisting of frequency and
> +	 * voltage like <freq-kHz vol-uV>.
> +	 */
> +	nr = prop->length / sizeof(u32);
> +	if (nr % 2 || (nr / 2) < num) {
> +		dev_warn(cpu_dev, "Invalid fsl,soc-operating-points list!\n");
> +		goto soc_opp_out;
> +	}
> +
> +	rcu_read_lock();

You do not need this lock any more.

> +	for (j = 0; j < num; j++) {
> +		val = prop->value;
> +		for (i = 0; i < nr / 2; i++) {
> +			unsigned long freq = be32_to_cpup(val++);
> +			unsigned long volt = be32_to_cpup(val++);
> +			if (freq_table[j].frequency == freq) {
> +				imx6_soc_volt[soc_opp_count++] = volt;
> +				break;
> +			}
> +		}
> +	}
> +	rcu_read_unlock();
> +
> +soc_opp_out:
> +	/* use fixed soc opp volt if no valid soc opp info found in dtb */
> +	if (soc_opp_count != num) {
> +		dev_warn(cpu_dev, "can NOT find valid soc opp info in dtb, use default value!\n");

It will be a little noisy for old DTB case with print so many warnings.
Maybe we should drop above two dev_warn() in fsl,soc-operating-points
property check and do once here.

> +		for (j = 0; j < num; j++)
> +			imx6_soc_volt[j] = PU_SOC_VOLTAGE_NORMAL;
> +		if (freq_table[num - 1].frequency * 1000 == FREQ_1P2_GHZ)
> +			imx6_soc_volt[num - 1] = PU_SOC_VOLTAGE_HIGH;
> +	}
> +
>  	if (of_property_read_u32(np, "clock-latency", &transition_latency))
>  		transition_latency = CPUFREQ_ETERNAL;
>  
>  	/*
> +	 * Calculate the ramp time for max voltage change in the
> +	 * VDDSOC and VDDPU regulators.
> +	 */
> +	ret = regulator_set_voltage_time(soc_reg, imx6_soc_volt[0], imx6_soc_volt[num - 1]);
> +	if (ret > 0)
> +		transition_latency += ret * 1000;
> +	ret = regulator_set_voltage_time(soc_reg, imx6_soc_volt[0], imx6_soc_volt[num - 1]);

One of the regulator_set_voltage_time() should be for pu_reg.

Shawn

> +	if (ret > 0)
> +		transition_latency += ret * 1000;
> +
> +	/*
>  	 * OPP is maintained in order of increasing frequency, and
>  	 * freq_table initialised from OPP is therefore sorted in the
>  	 * same order.
> @@ -221,18 +292,6 @@ static int imx6q_cpufreq_probe(struct platform_device *pdev)
>  	if (ret > 0)
>  		transition_latency += ret * 1000;
>  
> -	/* Count vddpu and vddsoc latency in for 1.2 GHz support */
> -	if (freq_table[num].frequency == FREQ_1P2_GHZ / 1000) {
> -		ret = regulator_set_voltage_time(pu_reg, PU_SOC_VOLTAGE_NORMAL,
> -						 PU_SOC_VOLTAGE_HIGH);
> -		if (ret > 0)
> -			transition_latency += ret * 1000;
> -		ret = regulator_set_voltage_time(soc_reg, PU_SOC_VOLTAGE_NORMAL,
> -						 PU_SOC_VOLTAGE_HIGH);
> -		if (ret > 0)
> -			transition_latency += ret * 1000;
> -	}
> -
>  	ret = cpufreq_register_driver(&imx6q_cpufreq_driver);
>  	if (ret) {
>  		dev_err(cpu_dev, "failed register driver: %d\n", ret);
> -- 
> 1.7.9.5
> 
> 

