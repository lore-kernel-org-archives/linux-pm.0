From: Anson Huang <b20788@freescale.com>
Subject: Re: [PATCH 4/4] cpufreq: imx6q: correct VDDSOC/PU voltage scaling
 when cpufreq is changed
Date: Tue, 17 Dec 2013 11:52:57 -0500
Message-ID: <20131217165257.GA27607@ubuntu>
References: <1387228450-641-1-git-send-email-b20788@freescale.com>
 <1387228450-641-2-git-send-email-b20788@freescale.com>
 <20131217025616.GC6691@S2101-09.ap.freescale.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from am1ehsobe001.messaging.microsoft.com ([213.199.154.204]:51385
	"EHLO am1outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752350Ab3LQEzC (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 16 Dec 2013 23:55:02 -0500
Content-Disposition: inline
In-Reply-To: <20131217025616.GC6691@S2101-09.ap.freescale.net>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Shawn Guo <shawn.guo@linaro.org>
Cc: rjw@rjwysocki.net, viresh.kumar@linaro.org, cpufreq@vger.kernel.org, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Tue, Dec 17, 2013 at 10:56:18AM +0800, Shawn Guo wrote:
> On Mon, Dec 16, 2013 at 04:14:10PM -0500, Anson Huang wrote:
> > on i.MX6Q, cpu freq change need to follow below flows:
> > 
> > 1. each setpoint has different VDDARM, VDDSOC/PU voltage, get the setpoint
> > table from dts;
> > 2. when cpu freq is scaling up, need to increase VDDSOC/PU voltage before
> > VDDARM, if VDDPU is off, no need to change it;
> > 3. when cpu freq is scaling down, need to decrease VDDARM voltage before
> > VDDSOC/PU, if VDDPU is off, no need to change it;
> > 
> > Signed-off-by: Anson Huang <b20788@freescale.com>
> > ---
> >  drivers/cpufreq/imx6q-cpufreq.c |  161 ++++++++++++++++++++++++++++++---------
> >  1 file changed, 126 insertions(+), 35 deletions(-)
> > 
> > diff --git a/drivers/cpufreq/imx6q-cpufreq.c b/drivers/cpufreq/imx6q-cpufreq.c
> > index 4b3f18e..5fb302e 100644
> > --- a/drivers/cpufreq/imx6q-cpufreq.c
> > +++ b/drivers/cpufreq/imx6q-cpufreq.c
> > @@ -17,10 +17,6 @@
> >  #include <linux/platform_device.h>
> >  #include <linux/regulator/consumer.h>
> >  
> > -#define PU_SOC_VOLTAGE_NORMAL	1250000
> > -#define PU_SOC_VOLTAGE_HIGH	1275000
> > -#define FREQ_1P2_GHZ		1200000000
> > -
> >  static struct regulator *arm_reg;
> >  static struct regulator *pu_reg;
> >  static struct regulator *soc_reg;
> > @@ -35,6 +31,14 @@ static struct device *cpu_dev;
> >  static struct cpufreq_frequency_table *freq_table;
> >  static unsigned int transition_latency;
> >  
> > +struct soc_opp {
> > +	u32 arm_freq;
> > +	u32 soc_volt;
> > +};
> > +
> > +static struct soc_opp *imx6_soc_opp;
> > +static u32 soc_opp_count;
> > +
> >  static unsigned int imx6q_get_speed(unsigned int cpu)
> >  {
> >  	return clk_get_rate(arm_clk) / 1000;
> > @@ -45,6 +49,7 @@ static int imx6q_set_target(struct cpufreq_policy *policy, unsigned int index)
> >  	struct dev_pm_opp *opp;
> >  	unsigned long freq_hz, volt, volt_old;
> >  	unsigned int old_freq, new_freq;
> > +	unsigned int soc_opp_index = 0;
> >  	int ret;
> >  
> >  	new_freq = freq_table[index].frequency;
> > @@ -63,29 +68,48 @@ static int imx6q_set_target(struct cpufreq_policy *policy, unsigned int index)
> >  	rcu_read_unlock();
> >  	volt_old = regulator_get_voltage(arm_reg);
> >  
> > -	dev_dbg(cpu_dev, "%u MHz, %ld mV --> %u MHz, %ld mV\n",
> > +	/* Find the matching VDDSOC/VDDPU operating voltage */
> > +	while (soc_opp_index < soc_opp_count) {
> > +		if (new_freq == imx6_soc_opp[soc_opp_index].arm_freq)
> > +			break;
> > +		soc_opp_index++;
> > +	}
> 
> I'm not comfortable with this lookup every time imx6q_set_target() is
> called.  I think we can use the 'index' variable to find VDDSOC/VDDPU
> operating voltage from imx6_soc_opp table directly, if we sort the table
> in the same order that freq_table is sorted.
>

yes, we can use the index passed from OPP, then I will add some comments that
the freq/volt table of vddsoc should be sorted in same order.

> > +	if (soc_opp_index >= soc_opp_count) {
> 
> Can soc_opp_index be possibly greater than soc_opp_count?  Otherwise,
> the condition check below is good enough?

right, using "==" is good enough, will improve it in V2 patch.

> 
> 	if (soc_opp_index == soc_opp_count)
> 
> > +		dev_err(cpu_dev,
> > +			"Can NOT find matching imx6_soc_opp voltage!\n");
> 
> Put them on the same line, since we can ignore 80 column warning for
> message.

okay.

> 
> > +			return -EINVAL;
> > +	}
> > +
> > +	dev_dbg(cpu_dev, "%u MHz, arm %ld mV, soc-pu %d mV --> %u MHz, arm %ld mV, soc-pu %d mV\n",
> >  		old_freq / 1000, volt_old / 1000,
> > -		new_freq / 1000, volt / 1000);
> > +		imx6_soc_opp[soc_opp_index].soc_volt / 1000,
> > +		new_freq / 1000, volt / 1000,
> > +		imx6_soc_opp[soc_opp_index].soc_volt / 1000);
> 
> You print the same soc_volt for both old and new ones?

this is my mistake, maybe I can leave the original code here to only
print out vddarm's voltage? Otherwise, I have to add variable to keep
old vddsoc/pu's voltage.

> 
> >  
> >  	/* scaling up?  scale voltage before frequency */
> >  	if (new_freq > old_freq) {
> > +		if (regulator_is_enabled(pu_reg)) {
> > +			ret = regulator_set_voltage_tol(pu_reg,
> > +				imx6_soc_opp[soc_opp_index].soc_volt, 0);
> > +			if (ret) {
> > +				dev_err(cpu_dev,
> > +					"failed to scale vddpu up: %d\n", ret);
> > +				return ret;
> > +			}
> > +		}
> > +		ret = regulator_set_voltage_tol(soc_reg,
> > +				imx6_soc_opp[soc_opp_index].soc_volt, 0);
> > +		if (ret) {
> > +			dev_err(cpu_dev,
> > +				"failed to scale vddsoc up: %d\n", ret);
> > +			return ret;
> > +		}
> >  		ret = regulator_set_voltage_tol(arm_reg, volt, 0);
> >  		if (ret) {
> >  			dev_err(cpu_dev,
> >  				"failed to scale vddarm up: %d\n", ret);
> >  			return ret;
> >  		}
> > -
> > -		/*
> > -		 * Need to increase vddpu and vddsoc for safety
> > -		 * if we are about to run at 1.2 GHz.
> > -		 */
> > -		if (new_freq == FREQ_1P2_GHZ / 1000) {
> > -			regulator_set_voltage_tol(pu_reg,
> > -					PU_SOC_VOLTAGE_HIGH, 0);
> > -			regulator_set_voltage_tol(soc_reg,
> > -					PU_SOC_VOLTAGE_HIGH, 0);
> > -		}
> >  	}
> >  
> >  	/*
> > @@ -120,12 +144,22 @@ static int imx6q_set_target(struct cpufreq_policy *policy, unsigned int index)
> >  				 "failed to scale vddarm down: %d\n", ret);
> >  			ret = 0;
> >  		}
> > -
> > -		if (old_freq == FREQ_1P2_GHZ / 1000) {
> > -			regulator_set_voltage_tol(pu_reg,
> > -					PU_SOC_VOLTAGE_NORMAL, 0);
> > -			regulator_set_voltage_tol(soc_reg,
> > -					PU_SOC_VOLTAGE_NORMAL, 0);
> > +		ret = regulator_set_voltage_tol(soc_reg,
> > +				imx6_soc_opp[soc_opp_index].soc_volt, 0);
> > +		if (ret) {
> > +			dev_warn(cpu_dev,
> > +				"failed to scale vddsoc down: %d\n", ret);
> > +			ret = 0;
> > +		}
> > +		if (regulator_is_enabled(pu_reg)) {
> > +			ret = regulator_set_voltage_tol(pu_reg,
> > +				imx6_soc_opp[soc_opp_index].soc_volt, 0);
> > +			if (ret) {
> > +				dev_warn(cpu_dev,
> > +					"failed to scale vddpu down: %d\n",
> > +					ret);
> > +				ret = 0;
> > +			}
> >  		}
> >  	}
> >  
> > @@ -153,6 +187,9 @@ static int imx6q_cpufreq_probe(struct platform_device *pdev)
> >  	struct dev_pm_opp *opp;
> >  	unsigned long min_volt, max_volt;
> >  	int num, ret;
> > +	const struct property *prop;
> > +	const __be32 *val;
> > +	u32 nr, i;
> >  
> >  	cpu_dev = get_cpu_device(0);
> >  	if (!cpu_dev) {
> > @@ -201,9 +238,75 @@ static int imx6q_cpufreq_probe(struct platform_device *pdev)
> >  		goto put_node;
> >  	}
> >  
> > +	prop = of_find_property(np, "fsl,soc-operating-points", NULL);
> > +	if (!prop) {
> > +		dev_err(cpu_dev,
> > +			"fsl,soc-operating-points node not found!\n");
> 
> 'fsl,soc-operating-points' is not a node but a property.

will improve it.

> 
> > +		goto free_freq_table;
> > +	}
> > +	if (!prop->value) {
> > +		dev_err(cpu_dev,
> > +			"No entries in fsl-soc-operating-points node!\n");
> 
> s/fsl-soc-operating-points/fsl,soc-operating-points

will do it.

> 
> > +		goto free_freq_table;
> > +	}
> 
> To simplify the code a little bit and populate the return code:
> 
> 	if (!prop || !prop->value) {
> 		dev_err(cpu_dev, "No valid fsl,soc-operating-points property is found");
> 		ret = -ENOENT;
> 		goto free_freq_table;
> 	}
> 
> Note, it's okay to ignore 80 column warning in case of message output.
> 
> Also, you need to understand the working flow of upstreaming kernel.
> Generally, we have drivers/cpufreq change go upstream via cpufreq tree
> maintained by Rafael, and arch/arm/boot/dts/imx* change go via IMX tree
> maintained by myself.  That means your patches should be properly
> partitioned to not cause any regression on either of these trees.
> 
> Right now, if Rafael merges the patch as it is, it will break imx6q
> cpufreq driver on his tree immediately, because fsl,soc-operating-points
> change is not on his tree.
> 
> To make it easier, you may want to merge dts changes into this patch,
> and have the patch go via single tree, either Rafael's or mine (we two
> will sort it out), to avoid breakage and maintain git bisect.

sorry for that, I was confused before, now I think I should merge the dts
and cpufreq driver change into a patch, and send them to both of you for
review.

> 
> > +
> > +	/*
> > +	 * Each OPP is a set of tuples consisting of frequency and
> > +	 * voltage like <freq-kHz vol-uV>.
> > +	 */
> > +	nr = prop->length / sizeof(u32);
> > +	if (nr % 2) {
> > +		dev_err(cpu_dev, "Invalid fsl-soc-operating-points list!\n");
> 
> fsl,soc-operating-points
> 
> and
> 
> 		ret = -EINVAL;

no need to free freq table here?

> 
> > +		goto free_freq_table;
> > +	}
> > +
> > +	/* Get the VDDSOC/VDDPU voltages that need to track the CPU voltages. */
> > +	imx6_soc_opp = devm_kzalloc(cpu_dev,
> > +		sizeof(struct soc_opp) * (nr / 2), GFP_KERNEL);
> 
> Quote from Documentation/CodingStyle:
> 
> The preferred form for passing a size of a struct is the following:
> 
>         p = kmalloc(sizeof(*p), ...);
> 
> The alternative form where struct name is spelled out hurts readability and
> introduces an opportunity for a bug when the pointer variable type is changed
> but the corresponding sizeof that is passed to a memory allocator is not.
> 
> Also to follow the indentation style used in the file, the following is
> what I would have.
> 
> 	imx6_soc_opp = devm_kzalloc(cpu_dev, sizeof(*imx6_soc_opp) * (nr / 2),
> 				    GFP_KERNEL);

will improve it.

> 
> > +
> 
> Drop this blank line.

Okay.

> 
> > +	if (imx6_soc_opp == NULL) {
> 
> 		ret = -ENOMEM;
> 
> > +		dev_err(cpu_dev, "No Memory for VDDSOC/PU table!\n");
> 
> With the error code -ENOMEM returned, we can save this message since I
> doubt you will ever get a chance to see it.

will remove it.

> 
> > +		goto free_freq_table;
> > +	}
> > +
> > +	rcu_read_lock();
> > +	val = prop->value;
> 
> What is this assignment used for?

mistake, will remove it.

> 
> > +
> > +	min_volt = max_volt = 0;
> > +	for (i = 0; i < nr / 2; i++) {
> > +		unsigned long freq = be32_to_cpup(val++);
> > +		unsigned long volt = be32_to_cpup(val++);
> > +
> > +		if (i == 0)
> > +			min_volt = max_volt = volt;
> > +		if (volt < min_volt)
> > +			min_volt = volt;
> > +		if (volt > max_volt)
> > +			max_volt = volt;
> > +		opp = dev_pm_opp_find_freq_exact(cpu_dev, freq * 1000, true);
> > +		imx6_soc_opp[i].arm_freq = freq;
> > +		imx6_soc_opp[i].soc_volt = volt;
> > +		soc_opp_count++;
> > +	}
> > +	rcu_read_unlock();
> 
> We may need another sanity check to see if soc_opp_count == num (arm opp
> count) here.

yes, will add it, need to make sure soc_opp_count is same as arm opp count,
but since we did NOT have 1G2 check, so the soc_opp_count will ">=" arm opp
count.

> 
> Shawn
> 
> > +
> >  	if (of_property_read_u32(np, "clock-latency", &transition_latency))
> >  		transition_latency = CPUFREQ_ETERNAL;
> >  
> > +	if (min_volt * max_volt != 0) {
> > +		/*
> > +		 * Calculate the ramp time for max voltage change in the
> > +		 * VDDSOC and VDDPU regulators.
> > +		 */
> > +		ret = regulator_set_voltage_time(soc_reg, min_volt, max_volt);
> > +		if (ret > 0)
> > +			transition_latency += ret * 1000;
> > +
> > +		ret = regulator_set_voltage_time(pu_reg, min_volt, max_volt);
> > +		if (ret > 0)
> > +			transition_latency += ret * 1000;
> > +	}
> > +
> >  	/*
> >  	 * OPP is maintained in order of increasing frequency, and
> >  	 * freq_table initialised from OPP is therefore sorted in the
> > @@ -221,18 +324,6 @@ static int imx6q_cpufreq_probe(struct platform_device *pdev)
> >  	if (ret > 0)
> >  		transition_latency += ret * 1000;
> >  
> > -	/* Count vddpu and vddsoc latency in for 1.2 GHz support */
> > -	if (freq_table[num].frequency == FREQ_1P2_GHZ / 1000) {
> > -		ret = regulator_set_voltage_time(pu_reg, PU_SOC_VOLTAGE_NORMAL,
> > -						 PU_SOC_VOLTAGE_HIGH);
> > -		if (ret > 0)
> > -			transition_latency += ret * 1000;
> > -		ret = regulator_set_voltage_time(soc_reg, PU_SOC_VOLTAGE_NORMAL,
> > -						 PU_SOC_VOLTAGE_HIGH);
> > -		if (ret > 0)
> > -			transition_latency += ret * 1000;
> > -	}
> > -
> >  	ret = cpufreq_register_driver(&imx6q_cpufreq_driver);
> >  	if (ret) {
> >  		dev_err(cpu_dev, "failed register driver: %d\n", ret);
> > -- 
> > 1.7.9.5
> > 
> > 
> 

