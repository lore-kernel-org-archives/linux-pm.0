From: Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH 2/2] cpufreq: ap806: add cpufreq driver for Armada 8K
Date: Sat, 22 Sep 2018 14:28:38 +0200
Message-ID: <20180922142838.6bde6b9c@windsurf>
References: <20180921154326.10776-1-gregory.clement@bootlin.com>
 <20180921154326.10776-2-gregory.clement@bootlin.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20180921154326.10776-2-gregory.clement@bootlin.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Gregory CLEMENT <gregory.clement@bootlin.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Jason Cooper <jason@lakedaemon.net>, linux-pm@vger.kernel.org, Antoine Tenart <antoine.tenart@bootlin.com>, Viresh Kumar <viresh.kumar@linaro.org>, Hanna Hawa <hannah@marvell.com>, Omri Itach <omrii@marvell.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Maxime Chevallier <maxime.chevallier@bootlin.com>, Nadav Haklai <nadavh@marvell.com>, Shadi Ammouri <shadi@marvell.com>, Igal Liberman <igall@marvell.com>, =?UTF-8?B?TWlxdcOobA==?= Raynal <miquel.raynal@bootlin.com>, Marcin Wojtas <mw@semihalf.com>, linux-arm-kernel@lists.infradead.org, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
List-Id: linux-pm@vger.kernel.org

Hello,

This is not a full review, just a few things I noticed.

On Fri, 21 Sep 2018 17:43:26 +0200, Gregory CLEMENT wrote:
> Add cpufreq driver for Marvell AP-806 found on Aramda 8K.

Armada, not Aramda.

> +config ARM_ARMADA_8K_CPUFREQ
> +       tristate "Armada 8K CPUFreq driver"
> +       depends on ARCH_MVEBU && CPUFREQ_DT
> +       help

Indentation of those items should use one tab, not spaces.

> +         This enables the CPUFreq driver support for Marvell
> +	 Armada8k SOCs.
> +	 Armada8K device has the AP806 which supports scaling
> +	 to any full integer divider.

And for the help text, it should be one tab + two spaces.


> +/*
> + * Setup the opps list with the divider for the max frequency, that
> + * will be filled at runtime, 0 meaning 100Mhz
> + */
> +static int opps_div[] __initdata = {1, 2, 3, 0};

const ?

> +
> +struct opps_array {
> +	struct device *cpu_dev;
> +	unsigned int freq[ARRAY_SIZE(opps_div)];
> +};
> +
> +/* If the CPUs share the same clock, then they are in the same cluster */
> +static void __init aramda_8k_get_sharing_cpus(struct clk *cur_clk,

Typo in function name, it should use armada, not aramda.

> +				       struct cpumask *cpumask)
> +{
> +	int cpu;
> +
> +	for_each_possible_cpu(cpu) {
> +		struct device *cpu_dev = get_cpu_device(cpu);
> +		struct clk *clk = clk_get(cpu_dev, 0);
> +
> +		if (IS_ERR(clk))
> +			dev_warn(cpu_dev, "Cannot get clock for CPU %d\n", cpu);
> +
> +		if (clk_is_match(clk, cur_clk))

Is it OK to call clk_is_match() is clk being an error ?

> +			cpumask_set_cpu(cpu, cpumask);
> +	}
> +
> +}
> +
> +static int __init armada_8k_cpufreq_init(void)
> +{
> +	struct opps_array *opps_arrays;
> +	struct platform_device *pdev;
> +	int ret, cpu, opps_index = 0;
> +	unsigned int cur_frequency;
> +	struct device_node *node;
> +
> +	node = of_find_compatible_node(NULL, NULL, "marvell,ap806-cpu-clock");
> +	if (!node || !of_device_is_available(node))
> +		return -ENODEV;
> +
> +	opps_arrays = kcalloc(num_possible_cpus(), sizeof(*opps_arrays),
> +			      GFP_KERNEL);
> +	/*
> +	 * For each CPU, this loop registers the operating points
> +	 * supported (which are the nominal CPU frequency and full integer
> +	 * divisions of it).
> +	 */
> +	for_each_possible_cpu(cpu) {
> +		struct device *cpu_dev;
> +		struct cpumask cpus;
> +		unsigned int freq;
> +		struct clk *clk;
> +		int i;
> +
> +		cpu_dev = get_cpu_device(cpu);
> +		if (!cpu_dev) {
> +			dev_err(cpu_dev, "Cannot get CPU %d\n", cpu);
> +			continue;
> +		}
> +
> +		clk = clk_get(cpu_dev, 0);
> +		if (IS_ERR(clk)) {
> +			dev_err(cpu_dev, "Cannot get clock for CPU %d\n", cpu);
> +			return PTR_ERR(clk);

So here you're leaking the memory allocation of opps_array[] and
everything that was done during all previous iterations of the loop.

> +		}
> +
> +		/* Get nominal (current) CPU frequency */
> +		cur_frequency = clk_get_rate(clk);
> +		if (!cur_frequency) {
> +			dev_err(cpu_dev,
> +				"Failed to get clock rate for CPU %d\n", cpu);
> +			return -EINVAL;

Ditto.

> +		}
> +
> +		opps_arrays[opps_index].cpu_dev = cpu_dev;
> +		for (i = 0; i < ARRAY_SIZE(opps_div); i++) {
> +			if (opps_div[i])
> +				freq = cur_frequency / opps_div[i];
> +			else
> +				freq = MIN_FREQ;
> +
> +			ret = dev_pm_opp_add(cpu_dev, freq, 0);
> +

Remove this blank line, to have the if (ret) just below the function
call.

> +			if (ret)
> +				goto remove_opp;

And add a blank line here instead.

> +			opps_arrays[opps_index].freq[i] = freq;
> +		}
> +
> +		cpumask_clear(&cpus);
> +		aramda_8k_get_sharing_cpus(clk, &cpus);
> +		dev_pm_opp_set_sharing_cpus(cpu_dev, &cpus);
> +	}
> +
> +	pdev = platform_device_register_simple("cpufreq-dt", -1, NULL, 0);
> +	ret = PTR_ERR_OR_ZERO(pdev);
> +	if (ret)
> +		goto remove_opp;
> +	kfree(opps_arrays);
> +	return 0;
> +remove_opp:
> +

Please exchange those two lines: one blank line between the return and
the goto label, and no blank line between the goto label and the core
of the code.

> +	for (; opps_index >= 0; opps_index--) {
> +		int i = 0;
> +
> +		while (opps_arrays[opps_index].freq[i]) {
> +			dev_pm_opp_remove(opps_arrays[opps_index].cpu_dev,
> +					  opps_arrays[opps_index].freq[i]);
> +			i++;
> +		}
> +	}
> +	kfree(opps_arrays);
> +	return ret;
> +}
> +module_init(armada_8k_cpufreq_init);
> +
> +MODULE_AUTHOR("Gregory Clement <gregory.clement@bootlin.com>");
> +MODULE_DESCRIPTION("Armada 8K cpufreq driver");
> +MODULE_LICENSE("GPL");

Once again, this is not a full review, I haven't reviewed the logic of
the driver itself, just a few obvious things I noticed.

Best regards,

Thomas Petazzoni
-- 
Thomas Petazzoni, CTO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
