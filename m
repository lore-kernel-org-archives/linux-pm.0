From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH v5 2/2] cpufreq: qcom-hw: Add support for QCOM cpufreq HW
 driver
Date: Mon, 16 Jul 2018 10:42:19 +0530
Message-ID: <20180716051219.36rdvxux3lz3rjed@vireshk-i7>
References: <1531418745-19742-1-git-send-email-tdas@codeaurora.org>
 <1531418745-19742-3-git-send-email-tdas@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1531418745-19742-3-git-send-email-tdas@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Taniya Das <tdas@codeaurora.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, Stephen Boyd <sboyd@kernel.org>, Rajendra Nayak <rnayak@codeaurora.org>, Amit Nischal <anischal@codeaurora.org>, devicetree@vger.kernel.org, robh@kernel.org, skannan@codeaurora.org, amit.kucheria@linaro.org, evgreen@google.com
List-Id: linux-pm@vger.kernel.org

On 12-07-18, 23:35, Taniya Das wrote:
> +static int qcom_cpu_resources_init(struct platform_device *pdev,
> +				   struct device_node *np, unsigned int cpu)
> +{
> +	struct cpufreq_qcom *c;
> +	struct resource res;
> +	struct device *dev = &pdev->dev;
> +	unsigned int offset, cpu_r;
> +	int ret;
> +
> +	c = devm_kzalloc(dev, sizeof(*c), GFP_KERNEL);
> +	if (!c)
> +		return -ENOMEM;
> +
> +	c->reg_offset = of_device_get_match_data(&pdev->dev);
> +	if (!c->reg_offset)
> +		return -EINVAL;
> +
> +	if (of_address_to_resource(np, 0, &res))
> +		return -ENOMEM;
> +
> +	c->base = devm_ioremap(dev, res.start, resource_size(&res));
> +	if (!c->base) {
> +		dev_err(dev, "Unable to map %s base\n", np->name);
> +		return -ENOMEM;
> +	}
> +
> +	offset = c->reg_offset[REG_ENABLE];
> +
> +	/* HW should be in enabled state to proceed */
> +	if (!(readl_relaxed(c->base + offset) & 0x1)) {
> +		dev_err(dev, "%s cpufreq hardware not enabled\n", np->name);
> +		return -ENODEV;
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
> +
> +	/* Related CPUs to keep a single copy */
> +	cpu_r = cpumask_first(&c->related_cpus);
> +	if (cpu != cpu_r) {
> +		qcom_freq_domain_map[cpu] = qcom_freq_domain_map[cpu_r];
> +		devm_kfree(dev, c);
> +	}

Sorry about missing this, you have actually worked on my comments.

But I think this isn't the clever way of doing it. You allocate the
structures, fill everything and then finally free them because we were
related. Why can't we have similar check at the top of this routine
and skip everything then ?

-- 
viresh
