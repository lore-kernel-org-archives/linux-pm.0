From: Tomasz Figa <tomasz.figa@gmail.com>
Subject: Re: [PATCH v7 5/6] ARM: Exynos: switch to using generic cpufreq driver
 for exynos4210/5250/5420
Date: Sat, 19 Jul 2014 15:27:35 +0200
Message-ID: <53CA7247.1080009@gmail.com>
References: <1405345118-4269-1-git-send-email-thomas.ab@samsung.com> <1405345118-4269-6-git-send-email-thomas.ab@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-Reply-To: <1405345118-4269-6-git-send-email-thomas.ab@samsung.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Thomas Abraham <thomas.ab@samsung.com>, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: linux-samsung-soc@vger.kernel.org, mturquette@linaro.org, kgene.kim@samsung.com, t.figa@samsung.com, l.majewski@samsung.com, viresh.kumar@linaro.org, heiko@sntech.de, cw00.choi@samsung.com
List-Id: linux-pm@vger.kernel.org

On 14.07.2014 15:38, Thomas Abraham wrote:
> From: Thomas Abraham <thomas.ab@samsung.com>
> 
> Remove the platform device instantiation for exynos cpufreq driver and add the
> platform device for generic cpufreq drivers.
> 
> Cc: Kukjin Kim <kgene.kim@samsung.com>
> Signed-off-by: Thomas Abraham <thomas.ab@samsung.com>
> Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
> Reviewed-by: Amit Daniel Kachhap <amit.daniel@samsung.com>
> Tested-by: Arjun K.V <arjun.kv@samsung.com>
> ---
>  arch/arm/mach-exynos/exynos.c |   15 ++++++++++++++-
>  1 file changed, 14 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm/mach-exynos/exynos.c b/arch/arm/mach-exynos/exynos.c
> index 2a43a17..5028b35 100644
> --- a/arch/arm/mach-exynos/exynos.c
> +++ b/arch/arm/mach-exynos/exynos.c
> @@ -183,7 +183,20 @@ void __init exynos_cpuidle_init(void)
>  
>  void __init exynos_cpufreq_init(void)
>  {
> -	platform_device_register_simple("exynos-cpufreq", -1, NULL, 0);
> +	char *dev_name;
> +
> +	if (of_machine_is_compatible("samsung,exynos5440"))
> +		return;

The original code registers the device unconditionally. Why Exynos5440
is excluded now?

> +	if (of_machine_is_compatible("samsung,exynos5420"))
> +		dev_name = "arm-bL-cpufreq-dt";
> +	else
> +		if (of_machine_is_compatible("samsung,exynos4412") ||
> +			of_machine_is_compatible("samsung,exynos4212"))
> +			dev_name = "exynos-cpufreq";
> +		else
> +			dev_name = "cpufreq-cpu0";
> +
> +	platform_device_register_simple(dev_name, -1, NULL, 0);
>  }

How about rewriting this to:

static const struct of_device_id exynos_cpufreq_matches[] = {
	{ .compatible = "samsung,exynos5420",
			.data = "arm-bL-cpufreq-dt" },
	{ .compatible = "samsung,exynos5250",
			.data = "cpufreq-cpu0" },
	{ .compatible = "samsung,exynos4210",
			.data = "cpufreq-cpu0" },
	{ /* sentinel */ }
};

void __init exynos_cpufreq_init(void)
{
	struct device_node *root = of_find_node_by_path("/");
	const struct of_device_id *match;

	match = of_match_node(exynos_cpufreq_matches, root);
	if (!match) {
		platform_device_register_simple("exynos-cpufreq", -1,
						NULL, 0);
		return;
	}

	platform_device_register_simple(match->data, -1, NULL, 0);
}

This way it is much more readable and original behavior is preserved for
any SoCs not supported by new drivers.

Best regards,
Tomasz
