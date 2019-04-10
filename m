From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH v2 1/2] cpufreq: Add sunxi nvmem based CPU scaling driver
Date: Wed, 10 Apr 2019 08:54:04 +0530
Message-ID: <20190410032404.eskk4qxbsws6fbec@vireshk-i7>
References: <20190409172558.18778-1-tiny.windzz@gmail.com>
 <20190409172558.18778-2-tiny.windzz@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <20190409172558.18778-2-tiny.windzz@gmail.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Yangtao Li <tiny.windzz@gmail.com>
Cc: nm@ti.com, mark.rutland@arm.com, linux-pm@vger.kernel.org, maxime.ripard@bootlin.com, vireshk@kernel.org, rjw@rjwysocki.net, linux-kernel@vger.kernel.org, sboyd@kernel.org, wens@csie.org, robh+dt@kernel.org, linux-arm-kernel@lists.infradead.org, gregkh@linuxfoundation.org, mchehab+samsung@kernel.org, davem@davemloft.net, devicetree@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On 09-04-19, 13:25, Yangtao Li wrote:
> +static const struct sunxi_cpufreq_soc_data sun50i_h6_data = {
> +	.efuse_xlate = sun50i_efuse_xlate,
> +	.nvmem_mask = 0x7,
> +	.nvmem_shift = 5,
> +};
> +
> +static const struct of_device_id sunxi_cpufreq_match_list[] = {
> +	{ .compatible = "allwinner,sun50i-h6", .data = &sun50i_h6_data },
> +	{}
> +};
> +
> +static const struct of_device_id *sunxi_cpufreq_match_node(void)
> +{
> +	struct device_node *np;
> +	const struct of_device_id *match;
> +
> +	np = of_find_node_by_path("/");
> +	match = of_match_node(sunxi_cpufreq_match_list, np);
> +	of_node_put(np);
> +
> +	return match;
> +}
> +

Above code can be placed just above sunxi_cpufreq_init(), if you ...

> +static int sunxi_cpufreq_nvmem_probe(struct platform_device *pdev)
> +{
> +	const struct sunxi_cpufreq_soc_data *soc_data;
> +	struct opp_table **opp_tables;
> +	const struct of_device_id *match;
> +	char name[MAX_NAME_LEN];
> +	unsigned int cpu;
> +	u32 speed = 0;
> +	int ret;
> +
> +	opp_tables = kcalloc(num_possible_cpus(), sizeof(*opp_tables),
> +			     GFP_KERNEL);
> +	if (!opp_tables)
> +		return -ENOMEM;
> +
> +	match = sunxi_cpufreq_match_node();

... avoid this and ...

> +	soc_data = match->data;
> +	if (!soc_data)
> +		return -EINVAL;
> +
> +	ret = sunxi_cpufreq_get_efuse(soc_data, &speed);
> +	if (ret)
> +		return ret;
> +
> +	snprintf(name, MAX_NAME_LEN, "speed%d", speed);
> +
> +	for_each_possible_cpu(cpu) {
> +		struct device *cpu_dev = get_cpu_device(cpu);
> +
> +		if (NULL == cpu_dev) {
> +			ret = -ENODEV;
> +			goto free_opp;
> +		}
> +
> +		opp_tables[cpu] = dev_pm_opp_set_prop_name(cpu_dev, name);
> +		if (IS_ERR(opp_tables[cpu])) {
> +			ret = PTR_ERR(opp_tables[cpu]);
> +			pr_err("Failed to set prop name\n");
> +			goto free_opp;
> +		}
> +	}
> +
> +	cpufreq_dt_pdev = platform_device_register_simple("cpufreq-dt", -1,
> +							  NULL, 0);
> +	if (!IS_ERR(cpufreq_dt_pdev)) {
> +		platform_set_drvdata(pdev, opp_tables);
> +		return 0;
> +	}
> +
> +	ret = PTR_ERR(cpufreq_dt_pdev);
> +	pr_err("Failed to register platform device\n");
> +
> +free_opp:
> +	for_each_possible_cpu(cpu) {
> +		if (IS_ERR_OR_NULL(opp_tables[cpu]))
> +			break;
> +		dev_pm_opp_put_prop_name(opp_tables[cpu]);
> +	}
> +	kfree(opp_tables);
> +
> +	return ret;
> +}
> +
> +static int sunxi_cpufreq_nvmem_remove(struct platform_device *pdev)
> +{
> +	struct opp_table **opp_tables = platform_get_drvdata(pdev);
> +	unsigned int cpu;
> +
> +	platform_device_unregister(cpufreq_dt_pdev);
> +
> +	for_each_possible_cpu(cpu)
> +		dev_pm_opp_put_prop_name(opp_tables[cpu]);
> +
> +	kfree(opp_tables);
> +
> +	return 0;
> +}
> +
> +static struct platform_driver sunxi_cpufreq_driver = {
> +	.probe = sunxi_cpufreq_nvmem_probe,
> +	.remove = sunxi_cpufreq_nvmem_remove,
> +	.driver = {
> +		.name = "sunxi-cpufreq-nvmem",
> +	},
> +};
> +
> +/*
> + * Since the driver depends on nvmem drivers, which may return EPROBE_DEFER,
> + * all the real activity is done in the probe, which may be defered as well.
> + * The init here is only registering the driver and the platform device.
> + */
> +static int __init sunxi_cpufreq_init(void)
> +{
> +	const struct of_device_id *match;
> +	int ret;
> +
> +	match = sunxi_cpufreq_match_node();
> +	if (!match)
> +		return -ENODEV;
> +
> +	ret = platform_driver_register(&sunxi_cpufreq_driver);
> +	if (unlikely(ret < 0))
> +		return ret;
> +
> +	sunxi_cpufreq_pdev = platform_device_register_simple(
> +		"sunxi-cpufreq-nvmem", -1, NULL, 0);

... pass match->data as platform device's data here..

> +	ret = PTR_ERR_OR_ZERO(sunxi_cpufreq_pdev);
> +	if (0 == ret)
> +		return 0;
> +
> +	platform_driver_unregister(&sunxi_cpufreq_driver);
> +	return ret;
> +}
> +module_init(sunxi_cpufreq_init);
> +
> +static void __exit sunxi_cpufreq_exit(void)
> +{
> +	platform_device_unregister(sunxi_cpufreq_pdev);
> +	platform_driver_unregister(&sunxi_cpufreq_driver);
> +}
> +module_exit(sunxi_cpufreq_exit);
> +
> +MODULE_DESCRIPTION("Sunxi cpufreq driver");
> +MODULE_LICENSE("GPL v2");
> -- 
> 2.17.0

-- 
viresh
