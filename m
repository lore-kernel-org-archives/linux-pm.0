From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH v4 2/2] cpufreq: qcom-fw: Add support for QCOM cpufreq FW
 driver
Date: Tue, 19 Jun 2018 15:00:53 +0530
Message-ID: <20180619093053.6q624k54bffrcqu6@vireshk-i7>
References: <1528801355-18719-1-git-send-email-tdas@codeaurora.org>
 <1528801355-18719-3-git-send-email-tdas@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1528801355-18719-3-git-send-email-tdas@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Taniya Das <tdas@codeaurora.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, Stephen Boyd <sboyd@kernel.org>, Rajendra Nayak <rnayak@codeaurora.org>, devicetree@vger.kernel.org, robh@kernel.org, skannan@codeaurora.org
List-Id: linux-pm@vger.kernel.org

On 12-06-18, 16:32, Taniya Das wrote:
> +static int qcom_get_related_cpus(struct device_node *np, struct cpumask *m)
> +{
> +	struct device_node *cpu_np, *freq_np;
> +	int cpu;
> +
> +	for_each_possible_cpu(cpu) {
> +		cpu_np = of_cpu_device_node_get(cpu);
> +		if (!cpu_np)
> +			continue;
> +		freq_np = of_parse_phandle(cpu_np, "qcom,freq-domain", 0);
> +		if (!freq_np)
> +			continue;
> +		if (freq_np == np)
> +			cpumask_set_cpu(cpu, m);
> +	}
> +
> +	return 0;
> +}
> +
> +static int qcom_cpu_resources_init(struct platform_device *pdev,
> +				   struct device_node *np, unsigned int cpu)
> +{
> +	struct cpufreq_qcom *c;
> +	struct resource res;
> +	struct device *dev = &pdev->dev;
> +	void __iomem *en_base;
> +	int index, ret;
> +
> +	c = devm_kzalloc(dev, sizeof(*c), GFP_KERNEL);
> +	if (!c)
> +		return -ENOMEM;
> +
> +	index = of_property_match_string(np, "reg-names", "enable");
> +	if (index < 0)
> +		return index;
> +
> +	if (of_address_to_resource(np, index, &res))
> +		return -ENOMEM;
> +
> +	en_base = devm_ioremap(dev, res.start, resource_size(&res));
> +	if (!en_base) {
> +		dev_err(dev, "Unable to map %s enable-base\n", np->name);
> +		return -ENOMEM;
> +	}
> +
> +	/* FW should be in enabled state to proceed */
> +	if (!(readl_relaxed(en_base) & 0x1)) {
> +		dev_err(dev, "%s firmware not enabled\n", np->name);
> +		return -ENODEV;
> +	}
> +	devm_iounmap(&pdev->dev, en_base);
> +
> +	index = of_property_match_string(np, "reg-names", "perf");
> +	if (index < 0)
> +		return index;
> +
> +	if (of_address_to_resource(np, index, &res))
> +		return -ENOMEM;
> +
> +	c->perf_base = devm_ioremap(dev, res.start, resource_size(&res));
> +	if (!c->perf_base) {
> +		dev_err(dev, "Unable to map %s perf-base\n", np->name);
> +		return -ENOMEM;
> +	}
> +
> +	index = of_property_match_string(np, "reg-names", "lut");
> +	if (index < 0)
> +		return index;
> +
> +	if (of_address_to_resource(np, index, &res))
> +		return -ENOMEM;
> +
> +	c->lut_base = devm_ioremap(dev, res.start, resource_size(&res));
> +	if (!c->lut_base) {
> +		dev_err(dev, "Unable to map %s lut-base\n", np->name);
> +		return -ENOMEM;
> +	}
> +
> +	ret = qcom_get_related_cpus(np, &c->related_cpus);
> +	if (ret) {
> +		dev_err(dev, "%s failed to get related CPUs\n", np->name);
> +		return ret;
> +	}
> +
> +	c->max_cores = cpumask_weight(&c->related_cpus);
> +	if (!c->max_cores)
> +		return -ENOENT;
> +
> +	ret = qcom_read_lut(pdev, c);
> +	if (ret) {
> +		dev_err(dev, "%s failed to read LUT\n", np->name);
> +		return ret;
> +	}
> +
> +	qcom_freq_domain_map[cpu] = c;

This still looks wrong. You have removed the for-each-cpu loop here, so what
will happen now is that you will allocate a different "struct cpufreq_qcom" for
every CPU, even if they are related. Is that what you should be doing ? I think
there should still be a single copy of that structure which must be used by all
related CPUs.

> +
> +	return 0;
> +}
> +
> +static int qcom_resources_init(struct platform_device *pdev)
> +{
> +	struct device_node *np, *cpu_np;
> +	unsigned int cpu;
> +	int ret;
> +
> +	for_each_possible_cpu(cpu) {
> +		cpu_np = of_cpu_device_node_get(cpu);
> +		if (!cpu_np) {
> +			dev_err(&pdev->dev, "Failed to get cpu %d device\n",
> +				cpu);
> +			continue;
> +		}
> +
> +		np = of_parse_phandle(cpu_np, "qcom,freq-domain", 0);
> +		if (!np) {
> +			dev_err(&pdev->dev, "Failed to get freq-domain device\n");
> +			return -EINVAL;
> +		}
> +
> +		of_node_put(cpu_np);
> +
> +		ret = qcom_cpu_resources_init(pdev, np, cpu);
> +		if (ret)
> +			return ret;
> +	}
> +
> +	return 0;
> +}

-- 
viresh
