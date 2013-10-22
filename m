From: Sudeep KarkadaNagesha <Sudeep.KarkadaNagesha@arm.com>
Subject: Re: [PATCH 1/4] cpufreq: Add a cpufreq driver for Marvell Dove
Date: Tue, 22 Oct 2013 11:19:51 +0100
Message-ID: <52665147.8080307@arm.com>
References: <1382186261-14482-1-git-send-email-andrew@lunn.ch> <1382186261-14482-2-git-send-email-andrew@lunn.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: 8BIT
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from service87.mimecast.com ([91.220.42.44]:33378 "EHLO
	service87.mimecast.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752377Ab3JVKTe convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 22 Oct 2013 06:19:34 -0400
In-Reply-To: <1382186261-14482-2-git-send-email-andrew@lunn.ch>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Andrew Lunn <andrew@lunn.ch>, Sebastian Hesselbarth <sebastian.hesselbarth@googlemail.com>, Jason Cooper <jason@lakedaemon.net>, "rjw@rjwysocki.net" <rjw@rjwysocki.net>, "viresh.kumar@linaro.org" <viresh.kumar@linaro.org>
Cc: linux ARM <linux-arm-kernel@lists.infradead.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>

On 19/10/13 13:37, Andrew Lunn wrote:
> The Marvell Dove SoC can run the CPU at two frequencies. The high
> frequencey is from a PLL, while the lower is the same as the DDR
> clock. Add a cpufreq driver to swap between these frequences.
> 
> Signed-off-by: Andrew Lunn <andrew@lunn.ch>
> ---
>  drivers/cpufreq/Kconfig.arm    |   7 ++
>  drivers/cpufreq/Makefile       |   1 +
>  drivers/cpufreq/dove-cpufreq.c | 276 +++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 284 insertions(+)
>  create mode 100644 drivers/cpufreq/dove-cpufreq.c
> 

[snip]

> +static int dove_cpufreq_probe(struct platform_device *pdev)
> +{
> +	struct device_node *np;
> +	struct resource *res;
> +	int err;
> +	int irq;
> +
> +	priv.dev = &pdev->dev;
> +
> +	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +	priv.dfs = devm_ioremap_resource(&pdev->dev, res);
> +	if (IS_ERR(priv.dfs))
> +		return PTR_ERR(priv.dfs);
> +
> +	res = platform_get_resource(pdev, IORESOURCE_MEM, 1);
> +	priv.pmu_cr = devm_ioremap_resource(&pdev->dev, res);
> +	if (IS_ERR(priv.pmu_cr))
> +		return PTR_ERR(priv.pmu_cr);
> +
> +	res = platform_get_resource(pdev, IORESOURCE_MEM, 2);
> +	priv.pmu_clk_div = devm_ioremap_resource(&pdev->dev, res);
> +	if (IS_ERR(priv.pmu_clk_div))
> +		return PTR_ERR(priv.pmu_clk_div);
> +
> +	np = of_find_node_by_path("/cpus/cpu@0");
> +	if (!np)
> +		return -ENODEV;
> +
You need not search for cpu nodes. When the cpu are registered, their of_node
gets initialised. So you can just use:
	np = of_cpu_device_node_get(0);

However I think its better to just get:
	cpu_dev = get_cpu_device(0);
as clk APIs can use cpu_dev

> +	priv.cpu_clk = of_clk_get_by_name(np, "cpu_clk");

Now this can be
	priv.cpu_clk = devm_clk_get(cpu_dev, "cpu_clk");

> +	if (IS_ERR(priv.cpu_clk)) {
> +		dev_err(priv.dev, "Unable to get cpuclk");
> +		return PTR_ERR(priv.cpu_clk);
> +	}
> +
> +	clk_prepare_enable(priv.cpu_clk);
> +	dove_freq_table[0].frequency = clk_get_rate(priv.cpu_clk) / 1000;
> +
> +	priv.ddr_clk = of_clk_get_by_name(np, "ddrclk");

Similarly priv.ddr_clk = devm_clk_get(cpu_dev, "ddrclk");

> +	if (IS_ERR(priv.ddr_clk)) {
> +		dev_err(priv.dev, "Unable to get ddrclk");
> +		err = PTR_ERR(priv.ddr_clk);
> +		goto out_cpu;
> +	}
> +
> +	clk_prepare_enable(priv.ddr_clk);
> +	dove_freq_table[1].frequency = clk_get_rate(priv.ddr_clk) / 1000;
> +
> +	irq = irq_of_parse_and_map(np, 0);

Here you can use cpu_dev->of_node

Regards,
Sudeep

