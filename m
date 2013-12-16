From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH v4 1/4] cpufreq: Add a cpufreq driver for Marvell Dove
Date: Mon, 16 Dec 2013 14:10:04 +0530
Message-ID: <CAKohpo=cPMF+Op_EOwPy2Nn0wz=7bSepCy08DPJAvpmcN7o0AA@mail.gmail.com>
References: <1386166641-7567-1-git-send-email-andrew@lunn.ch>
	<1386166641-7567-2-git-send-email-andrew@lunn.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-oa0-f43.google.com ([209.85.219.43]:40907 "EHLO
	mail-oa0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752200Ab3LPIkF (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 16 Dec 2013 03:40:05 -0500
Received: by mail-oa0-f43.google.com with SMTP id i7so4686800oag.30
        for <linux-pm@vger.kernel.org>; Mon, 16 Dec 2013 00:40:04 -0800 (PST)
In-Reply-To: <1386166641-7567-2-git-send-email-andrew@lunn.ch>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Andrew Lunn <andrew@lunn.ch>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Jason Cooper <jason@lakedaemon.net>, Sebastian Hesselbarth <sebastian.hesselbarth@googlemail.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, linux ARM <linux-arm-kernel@lists.infradead.org>

On 4 December 2013 19:47, Andrew Lunn <andrew@lunn.ch> wrote:
> The Marvell Dove SoC can run the CPU at two frequencies. The high
> frequencey is from a PLL, while the lower is the same as the DDR
> clock. Add a cpufreq driver to swap between these frequences.
>
> Signed-off-by: Andrew Lunn <andrew@lunn.ch>
> Tested-by: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
> Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

I was sure about it and checked it again. I haven't Acked this patch
until now. :)

> diff --git a/drivers/cpufreq/Kconfig.arm b/drivers/cpufreq/Kconfig.arm
> index ce52ed949249..af7c4947f218 100644
> --- a/drivers/cpufreq/Kconfig.arm
> +++ b/drivers/cpufreq/Kconfig.arm
> @@ -8,6 +8,11 @@ config ARM_BIG_LITTLE_CPUFREQ
>         help
>           This enables the Generic CPUfreq driver for ARM big.LITTLE platforms.
>
> +config ARM_DOVE_CPUFREQ
> +       def_bool ARCH_DOVE && OF
> +       help
> +         This adds the CPUFreq driver for Marvell Dove SoCs.

Please add this one after DT_BL one.. I know you wanted to keep
them in alphabetical order (probably we need to rename DT_BL),
but keeping both BIG LITTLE options makes more sense.

I will do the renaming later.

>  config ARM_DT_BL_CPUFREQ
>         tristate "Generic probing via DT for ARM big LITTLE CPUfreq driver"
>         depends on ARM_BIG_LITTLE_CPUFREQ && OF

> diff --git a/drivers/cpufreq/dove-cpufreq.c b/drivers/cpufreq/dove-cpufreq.c
> +static int dove_cpufreq_probe(struct platform_device *pdev)
> +{
> +       struct device *cpu_dev;
> +       struct resource *res;
> +       int err, irq;
> +
> +       memset(&priv, 0, sizeof(priv));
> +       priv.dev = &pdev->dev;
> +
> +       res = platform_get_resource_byname(pdev, IORESOURCE_MEM,
> +                                          "cpufreq: DFS");
> +       priv.dfs = devm_ioremap_resource(&pdev->dev, res);
> +       if (IS_ERR(priv.dfs))
> +               return PTR_ERR(priv.dfs);
> +
> +       res = platform_get_resource_byname(pdev, IORESOURCE_MEM,
> +                                          "cpufreq: PMU CR");
> +       priv.pmu_cr = devm_ioremap_resource(&pdev->dev, res);
> +       if (IS_ERR(priv.pmu_cr))
> +               return PTR_ERR(priv.pmu_cr);
> +
> +       res = platform_get_resource_byname(pdev, IORESOURCE_MEM,
> +                                          "cpufreq: PMU Clk Div");
> +       priv.pmu_clk_div = devm_ioremap_resource(&pdev->dev, res);
> +       if (IS_ERR(priv.pmu_clk_div))
> +               return PTR_ERR(priv.pmu_clk_div);
> +
> +       cpu_dev = get_cpu_device(0);
> +
> +       priv.cpu_clk = devm_clk_get(cpu_dev, "cpu_clk");
> +       if (IS_ERR(priv.cpu_clk)) {
> +               err = PTR_ERR(priv.cpu_clk);
> +               goto out;
> +       }

You are doing clk_disable_unprepare in out, and you haven't enabled
them yet. So, just return error from here.

> +       err = clk_prepare_enable(priv.cpu_clk);
> +       if (err)
> +               goto out;

same here

> +       dove_freq_table[0].frequency = clk_get_rate(priv.cpu_clk) / 1000;
> +
> +       priv.ddr_clk = devm_clk_get(cpu_dev, "ddrclk");
> +       if (IS_ERR(priv.ddr_clk)) {
> +               err = PTR_ERR(priv.ddr_clk);
> +               goto out;

You need to do unprepare only for cpu clk here.

> +       }
> +
> +       err = clk_prepare_enable(priv.ddr_clk);
> +       if (err)
> +               goto out;

same here

> +
> +       dove_freq_table[1].frequency = clk_get_rate(priv.ddr_clk) / 1000;

Because you are using 0 and 1 in index for CPU and DDR freq at multiple
places, probably makes sense to make Macros for them ?

> +
> +       irq = irq_of_parse_and_map(cpu_dev->of_node, 0);
> +       if (!irq) {
> +               err = -ENXIO;
> +               goto out;
> +       }
> +
> +       err = devm_request_irq(&pdev->dev, irq, dove_cpufreq_irq,
> +                              0, "dove-cpufreq", NULL);
> +       if (err) {
> +               dev_err(&pdev->dev, "cannot assign irq %d, %d\n", irq, err);
> +               goto out;
> +       }
> +
> +       /* Read the target ratio which should be the DDR ratio */
> +       priv.dpratio = readl_relaxed(priv.pmu_clk_div);
> +       priv.dpratio = (priv.dpratio & DPRATIO_MASK) >> DPRATIO_OFFS;
> +       priv.dpratio = priv.dpratio << L2_RATIO_OFFS;
> +
> +       /* Save L2 ratio at reset */
> +       priv.xpratio = readl(priv.pmu_clk_div);
> +       priv.xpratio = (priv.xpratio & XPRATIO_MASK) >> XPRATIO_OFFS;
> +       priv.xpratio = priv.xpratio << L2_RATIO_OFFS;
> +
> +       err = cpufreq_register_driver(&dove_cpufreq_driver);
> +       if (!err)
> +               return 0;
> +
> +       dev_err(priv.dev, "Failed to register cpufreq driver");
> +
> +out:
> +       clk_disable_unprepare(priv.ddr_clk);
> +       clk_disable_unprepare(priv.cpu_clk);
> +
> +       return err;
> +}
> +
> +static int dove_cpufreq_remove(struct platform_device *pdev)
> +{
> +       cpufreq_unregister_driver(&dove_cpufreq_driver);
> +
> +       clk_disable_unprepare(priv.ddr_clk);
> +       clk_disable_unprepare(priv.cpu_clk);
> +
> +       return 0;
> +}
> +
> +static struct platform_driver dove_cpufreq_platform_driver = {
> +       .probe = dove_cpufreq_probe,
> +       .remove = dove_cpufreq_remove,
> +       .driver = {
> +               .name = "dove-cpufreq",
> +               .owner = THIS_MODULE,
> +       },
> +};
> +
> +module_platform_driver(dove_cpufreq_platform_driver);

Otherwise looks fine :)
