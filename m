From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH 2/3] cpufreq: bmips-cpufreq: CPUfreq driver for
 Broadcom's BMIPS SoCs
Date: Fri, 3 Feb 2017 09:58:06 +0530
Message-ID: <20170203042805.GK7458@vireshk-i7>
References: <20170202010601.75995-1-code@mmayer.net>
 <20170202010601.75995-3-code@mmayer.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pg0-f43.google.com ([74.125.83.43]:36337 "EHLO
        mail-pg0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752317AbdBCE2K (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 2 Feb 2017 23:28:10 -0500
Received: by mail-pg0-f43.google.com with SMTP id v184so3010676pgv.3
        for <linux-pm@vger.kernel.org>; Thu, 02 Feb 2017 20:28:09 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20170202010601.75995-3-code@mmayer.net>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Markus Mayer <code@mmayer.net>
Cc: Ralf Baechle <ralf@linux-mips.org>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Markus Mayer <mmayer@broadcom.com>, MIPS Linux Kernel List <linux-mips@linux-mips.org>, Power Management List <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

You must be a cpufreq driver expert by now. What's the count? Is this the 3rd
one you have written ? :)

On 01-02-17, 17:06, Markus Mayer wrote:
> diff --git a/drivers/cpufreq/bmips-cpufreq.c b/drivers/cpufreq/bmips-cpufreq.c
> +static struct cpufreq_frequency_table *
> +bmips_cpufreq_get_freq_table(const struct cpufreq_policy *policy)

Maybe call it bmips_cpufreq_create_freq_table() as that's what you are doing.
But its all up to you only.

> +{
> +	struct cpufreq_frequency_table *table;
> +	struct cpufreq_compat *cc;
> +	unsigned long cpu_freq;
> +	int i;
> +
> +	cc = policy->driver_data;
> +	cpu_freq = htp_freq_to_cpu_freq(cc->clk_mult);
> +
> +	table = kzalloc((cc->max_freqs + 1) * sizeof(*table), GFP_KERNEL);

Maybe kmalloc as you are updating all the entries.

> +	if (!table)
> +		return ERR_PTR(-ENOMEM);
> +
> +	for (i = 0; i < cc->max_freqs; i++) {
> +		table[i].frequency = cpu_freq / (1 << i);
> +		table[i].driver_data = i;
> +	}
> +	table[i].frequency = CPUFREQ_TABLE_END;
> +
> +	return table;
> +}
> +
> +static unsigned int bmips_cpufreq_get(unsigned int cpu)
> +{
> +	struct cpufreq_policy *policy;
> +	struct cpufreq_compat *cc;
> +	unsigned long freq, cpu_freq;
> +	unsigned int div;
> +	uint32_t mode;
> +
> +	policy = cpufreq_cpu_get(cpu);

You need to do a corresponding cpufreq_cpu_put().

> +	cc = policy->driver_data;
> +
> +	switch (cc->bmips_type) {
> +	case BMIPS5200:
> +	case BMIPS5000:
> +		mode = read_c0_brcm_mode();
> +		div = ((mode >> BMIPS5_CLK_DIV_SHIFT) & BMIPS5_CLK_DIV_MASK);
> +		break;
> +	default:
> +		div = 0;
> +	}
> +
> +	cpu_freq = htp_freq_to_cpu_freq(cc->clk_mult);
> +	freq = cpu_freq / (1 << div);
> +
> +	return freq;
> +}
> +
> +static int bmips_cpufreq_target_index(struct cpufreq_policy *policy,
> +				      unsigned int index)
> +{
> +	struct cpufreq_compat *cc;
> +	unsigned int div;
> +
> +	cc = policy->driver_data;
> +	div = policy->freq_table[index].driver_data;
> +
> +	switch (cc->bmips_type) {
> +	case BMIPS5200:
> +	case BMIPS5000:
> +		change_c0_brcm_mode(BMIPS5_CLK_DIV_MASK << BMIPS5_CLK_DIV_SHIFT,
> +				    (1 << BMIPS5_CLK_DIV_SET_SHIFT) |
> +				    (div << BMIPS5_CLK_DIV_SHIFT));
> +		break;
> +	default:
> +		return -ENOTSUPP;
> +	}
> +
> +	return 0;
> +}
> +
> +static int bmips_cpufreq_exit(struct cpufreq_policy *policy)
> +{
> +	kfree(policy->freq_table);
> +	policy->freq_table = NULL;

No need to set it to NULL.

> +
> +	return 0;
> +}
> +
> +static int bmips_cpufreq_init(struct cpufreq_policy *policy)
> +{
> +	struct cpufreq_frequency_table *freq_table;
> +	int ret;
> +
> +	/* Store the compatibility data with the policy. */
> +	policy->driver_data = cpufreq_get_driver_data();

Hmm, I wouldn't mind keeping a global variable for this. This driver will be
probed only once and so we can simplify the code a bit. Up to you.

> +
> +	freq_table = bmips_cpufreq_get_freq_table(policy);
> +	if (IS_ERR(freq_table)) {
> +		ret = PTR_ERR(freq_table);
> +		pr_err("%s: couldn't determine frequency table (%d).\n",
> +			BMIPS_CPUFREQ_NAME, ret);
> +		return ret;
> +	}
> +
> +	ret = cpufreq_generic_init(policy, freq_table, TRANSITION_LATENCY);
> +	if (ret)
> +		bmips_cpufreq_exit(policy);
> +	else
> +		pr_info("%s: registered\n", BMIPS_CPUFREQ_NAME);
> +
> +	return ret;
> +}
> +
> +static struct cpufreq_driver bmips_cpufreq_driver = {
> +	.flags		= CPUFREQ_NEED_INITIAL_FREQ_CHECK,
> +	.verify		= cpufreq_generic_frequency_table_verify,
> +	.target_index	= bmips_cpufreq_target_index,
> +	.get		= bmips_cpufreq_get,
> +	.init		= bmips_cpufreq_init,
> +	.exit		= bmips_cpufreq_exit,
> +	.attr		= cpufreq_generic_attr,
> +	.name		= BMIPS_CPUFREQ_PREFIX,
> +};
> +
> +static int __init bmips_cpufreq_probe(void)
> +{
> +	struct cpufreq_compat *cc;
> +	struct device_node *np;
> +
> +	for (cc = bmips_cpufreq_compat; cc->compatible; cc++) {
> +		np = of_find_compatible_node(NULL, "cpu", cc->compatible);
> +		if (np) {
> +			of_node_put(np);
> +			bmips_cpufreq_driver.driver_data = cc;
> +			break;
> +		}
> +	}
> +
> +	/* We hit the guard element of the array. No compatible CPU found. */
> +	if (!cc->compatible)
> +		return -ENODEV;
> +
> +	return cpufreq_register_driver(&bmips_cpufreq_driver);
> +}
> +device_initcall(bmips_cpufreq_probe);
> +
> +MODULE_AUTHOR("Markus Mayer <mmayer@broadcom.com>");
> +MODULE_DESCRIPTION("CPUfreq driver for Broadcom BMIPS SoCs");
> +MODULE_LICENSE("GPL");
> -- 
> 2.7.4

-- 
viresh
