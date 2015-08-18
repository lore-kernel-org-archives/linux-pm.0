From: Bartlomiej Zolnierkiewicz <b.zolnierkie-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [RESEND PATCH 2/3 v6] cpufreq: mediatek: Add MT8173 cpufreq driver
Date: Tue, 18 Aug 2015 12:09:54 +0200
Message-ID: <18468574.WHJNqYO5N4@amdc1976>
References: <1439803465-19683-1-git-send-email-pi-cheng.chen@linaro.org>
 <1439803465-19683-3-git-send-email-pi-cheng.chen@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-reply-to: <1439803465-19683-3-git-send-email-pi-cheng.chen-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Pi-Cheng Chen <pi-cheng.chen-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: "Rafael J. Wysocki" <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>, Viresh Kumar <viresh.kumar-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Matthias Brugger <matthias.bgg-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Michael Turquette <mturquette-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linaro-kernel-cunTk1MwBs8s++Sfvej+rw@public.gmane.org, linux-mediatek-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-pm@vger.kernel.org


Hi,

On Monday, August 17, 2015 05:24:24 PM Pi-Cheng Chen wrote:
> Mediatek MT8173 is an ARMv8 based quad-core (2*Cortex-A53 and
> 2*Cortex-A72) SoC with duall clusters. For each cluster, two voltage
> inputs, Vproc and Vsram are supplied by two regulators. For the big
> cluster, two regulators come from different PMICs. In this case, when
> scaling voltage inputs of the cluster, the voltages of two regulator
> inputs need to be controlled by software explicitly under the SoC
> specific limitation:
> 
> 	100mV < Vsram - Vproc < 200mV
> 
> which is called 'voltage tracking' mechanism. And when scaling the
> frequency of cluster clock input, the input MUX need to be parented to
> another "intermediate" stable PLL first and reparented to the original
> PLL once the original PLL is stable at the target frequency. This patch
> implements those mechanisms to enable CPU DVFS support for Mediatek
> MT8173 SoC.
> 
> Signed-off-by: Pi-Cheng Chen <pi-cheng.chen-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
> Acked-by: Viresh Kumar <viresh.kumar-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
> ---
>  drivers/cpufreq/Kconfig.arm      |   7 +
>  drivers/cpufreq/Makefile         |   1 +
>  drivers/cpufreq/mt8173-cpufreq.c | 524 +++++++++++++++++++++++++++++++++++++++
>  3 files changed, 532 insertions(+)
>  create mode 100644 drivers/cpufreq/mt8173-cpufreq.c

[...]

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
> +	err = platform_driver_register(&mt8173_cpufreq_platdrv);
> +	if (err)
> +		return err;
> +
> +	/*
> +	 * Since there's no place to hold device registration code and no
> +	 * device tree based way to match cpufreq driver yet, both the driver
> +	 * and the device registration codes are put here to handle defer
> +	 * probing.
> +	 */
> +	pdev = platform_device_register_simple("mt8173-cpufreq", -1, NULL, 0);

This is not very friendly for multiplatform support
(mt8173_cpufreq_driver_init() can be called on other platforms,
i.e. Samsung Exynos7 one if ARCH_EXYNOS7 is also enabled in
the kernel config).

Why can't it be fixed with checking Device Tree with
of_machine_is_compatible("mediatek,mt8173")
(assuming that it can be used on arm64 like on arm32)?

> +	if (IS_ERR(pdev)) {
> +		pr_err("failed to register mtk-cpufreq platform device\n");
> +		return PTR_ERR(pdev);
> +	}
> +
> +	return 0;
> +}
> +device_initcall(mt8173_cpufreq_driver_init);

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
