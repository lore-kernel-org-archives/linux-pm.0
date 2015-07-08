From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH v5 2/2] cpufreq: mediatek: Add MT8173 cpufreq driver
Date: Wed, 8 Jul 2015 17:04:55 +0530
Message-ID: <20150708113455.GF1805@linux>
References: <1435717005-20012-1-git-send-email-pi-cheng.chen@linaro.org>
 <1435717005-20012-3-git-send-email-pi-cheng.chen@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pd0-f171.google.com ([209.85.192.171]:34409 "EHLO
	mail-pd0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934757AbbGHLfB (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 8 Jul 2015 07:35:01 -0400
Received: by pdbep18 with SMTP id ep18so144364617pdb.1
        for <linux-pm@vger.kernel.org>; Wed, 08 Jul 2015 04:35:01 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1435717005-20012-3-git-send-email-pi-cheng.chen@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Pi-Cheng Chen <pi-cheng.chen@linaro.org>
Cc: Michael Turquette <mturquette@baylibre.com>, Matthias Brugger <matthias.bgg@gmail.com>, Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, linaro-kernel@lists.linaro.org, linux-mediatek@lists.infradead.org

On 01-07-15, 10:16, Pi-Cheng Chen wrote:
> This patch implements MT8173 cpufreq driver.

Now that you are going to resend this patchset, a few more comments.

Please describe your SoC a bit here, so that reviewers know what are
we going to implement.

> +static int mtk_cpu_dvfs_info_init(struct mtk_cpu_dvfs_info *info, int cpu)
> +{
> +	struct device *cpu_dev;
> +	struct regulator *proc_reg = ERR_PTR(-ENODEV);
> +	struct regulator *sram_reg = ERR_PTR(-ENODEV);
> +	struct clk *cpu_clk = ERR_PTR(-ENODEV);
> +	struct clk *inter_clk = ERR_PTR(-ENODEV);
> +	struct dev_pm_opp *opp;
> +	unsigned long rate;
> +	int ret;
> +
> +	cpu_dev = get_cpu_device(cpu);
> +	if (!cpu_dev) {
> +		pr_err("failed to get cpu%d device\n", cpu);
> +		return -ENODEV;
> +	}
> +
> +	ret = of_init_opp_table(cpu_dev);
> +	if (ret) {
> +		pr_warn("no OPP table for cpu%d\n", cpu);
> +		return ret;
> +	}

Initialize opp table only when you know other resources are available.
i.e. we aren't going to abort due to EPROBE_DEFER.

> +	cpu_clk = clk_get(cpu_dev, "cpu");
> +	if (IS_ERR(cpu_clk)) {
> +		if (PTR_ERR(cpu_clk) == -EPROBE_DEFER)
> +			pr_warn("cpu clk for cpu%d not ready, retry.\n", cpu);
> +		else
> +			pr_err("failed to get cpu clk for cpu%d\n", cpu);
> +
> +		ret = PTR_ERR(cpu_clk);
> +		goto out_free_opp_table;
> +	}
> +}


> +static int mt8173_cpufreq_probe(struct platform_device *pdev)
> +{
> +	int ret;
> +
> +	ret = cpufreq_register_driver(&mt8173_cpufreq_driver);
> +	if (ret)
> +		pr_err("failed to register mtk cpufreq driver\n");
> +
> +	return ret;
> +}
> +
> +static struct platform_driver mt8173_cpufreq_platdrv = {
> +	.driver = {
> +		.name	= "mt8173-cpufreq",
> +	},
> +	.probe		= mt8173_cpufreq_probe,
> +};
> +
> +static int mt8173_cpufreq_driver_init(void)
> +{
> +	struct platform_device *pdev;
> +	int err;
> +
> +	if (!of_machine_is_compatible("mediatek,mt8173"))
> +		return -ENODEV;

Why do you need to check this ? Its going to be the right SoC, others
can't even compile it.

> +	err = platform_driver_register(&mt8173_cpufreq_platdrv);
> +	if (err)
> +		return err;
> +
> +	pdev = platform_device_register_simple("mt8173-cpufreq", -1, NULL, 0);
> +	if (IS_ERR(pdev)) {
> +		pr_err("failed to register mtk-cpufreq platform device\n");
> +		return PTR_ERR(pdev);
> +	}

This is simply crap. You register the driver and then its device from
the same function. If you are so sure that this driver is required,
then why to get into the shit of device-driver model ?

Just call cpufreq_register_driver() from here :), no device/driver
required.

-- 
viresh
