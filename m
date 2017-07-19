From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH] cpufreq: dt: Don't use generic platdev driver for tango
Date: Wed, 19 Jul 2017 12:06:42 +0530
Message-ID: <20170719063642.GC352@vireshk-i7>
References: <f6b9a4e6-bbff-fe92-6867-547c581db3c8@sigmadesigns.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pg0-f45.google.com ([74.125.83.45]:32920 "EHLO
        mail-pg0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752055AbdGSGgq (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 19 Jul 2017 02:36:46 -0400
Received: by mail-pg0-f45.google.com with SMTP id k14so25704653pgr.0
        for <linux-pm@vger.kernel.org>; Tue, 18 Jul 2017 23:36:45 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <f6b9a4e6-bbff-fe92-6867-547c581db3c8@sigmadesigns.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Marc Gonzalez <marc_gonzalez@sigmadesigns.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-pm <linux-pm@vger.kernel.org>, Linux ARM <linux-arm-kernel@lists.infradead.org>, Thibaud Cornic <thibaud_cornic@sigmadesigns.com>, Mason <slash.tmp@free.fr>

On 18-07-17, 18:48, Marc Gonzalez wrote:
> On tango platforms, firmware configures the CPU clock, and Linux is
> then only allowed to use the cpu_clk_divider to change the frequency.
> Build the OPP table dynamically at init, in order to support whatever
> firmware throws at us.
> 
> Signed-off-by: Marc Gonzalez <marc_gonzalez@sigmadesigns.com>
> ---
>  arch/arm/boot/dts/tango4-smp8758.dtsi |  1 -
>  drivers/cpufreq/Kconfig.arm           |  5 +++++
>  drivers/cpufreq/Makefile              |  1 +
>  drivers/cpufreq/cpufreq-dt-platdev.c  |  2 --
>  drivers/cpufreq/tango-cpufreq.c       | 38 +++++++++++++++++++++++++++++++++++
>  5 files changed, 44 insertions(+), 3 deletions(-)
>  create mode 100644 drivers/cpufreq/tango-cpufreq.c
> 
> diff --git a/arch/arm/boot/dts/tango4-smp8758.dtsi b/arch/arm/boot/dts/tango4-smp8758.dtsi
> index d2e65c46bcc7..eca33d568690 100644
> --- a/arch/arm/boot/dts/tango4-smp8758.dtsi
> +++ b/arch/arm/boot/dts/tango4-smp8758.dtsi
> @@ -13,7 +13,6 @@
>  			reg = <0>;
>  			clocks = <&clkgen CPU_CLK>;
>  			clock-latency = <1>;
> -			operating-points = <1215000 0 607500 0 405000 0 243000 0 135000 0>;
>  		};
>  
>  		cpu1: cpu@1 {
> diff --git a/drivers/cpufreq/Kconfig.arm b/drivers/cpufreq/Kconfig.arm
> index 2011fec2d6ad..ea9ba00091bb 100644
> --- a/drivers/cpufreq/Kconfig.arm
> +++ b/drivers/cpufreq/Kconfig.arm
> @@ -242,6 +242,11 @@ config ARM_STI_CPUFREQ
>  	  this config option if you wish to add CPUFreq support for STi based
>  	  SoCs.
>  
> +config ARM_TANGO_CPUFREQ
> +	bool
> +	depends on CPUFREQ_DT && ARCH_TANGO
> +	default y
> +
>  config ARM_TEGRA20_CPUFREQ
>  	bool "Tegra20 CPUFreq support"
>  	depends on ARCH_TEGRA
> diff --git a/drivers/cpufreq/Makefile b/drivers/cpufreq/Makefile
> index ab3a42cd29ef..bb9841f57787 100644
> --- a/drivers/cpufreq/Makefile
> +++ b/drivers/cpufreq/Makefile
> @@ -75,6 +75,7 @@ obj-$(CONFIG_ARM_SA1110_CPUFREQ)	+= sa1110-cpufreq.o
>  obj-$(CONFIG_ARM_SCPI_CPUFREQ)		+= scpi-cpufreq.o
>  obj-$(CONFIG_ARM_SPEAR_CPUFREQ)		+= spear-cpufreq.o
>  obj-$(CONFIG_ARM_STI_CPUFREQ)		+= sti-cpufreq.o
> +obj-$(CONFIG_ARM_TANGO_CPUFREQ)		+= tango-cpufreq.o
>  obj-$(CONFIG_ARM_TEGRA20_CPUFREQ)	+= tegra20-cpufreq.o
>  obj-$(CONFIG_ARM_TEGRA124_CPUFREQ)	+= tegra124-cpufreq.o
>  obj-$(CONFIG_ARM_TEGRA186_CPUFREQ)	+= tegra186-cpufreq.o
> diff --git a/drivers/cpufreq/cpufreq-dt-platdev.c b/drivers/cpufreq/cpufreq-dt-platdev.c
> index 1c262923fe58..6cbe77765f46 100644
> --- a/drivers/cpufreq/cpufreq-dt-platdev.c
> +++ b/drivers/cpufreq/cpufreq-dt-platdev.c
> @@ -80,8 +80,6 @@ static const struct of_device_id machines[] __initconst = {
>  	{ .compatible = "rockchip,rk3368", },
>  	{ .compatible = "rockchip,rk3399", },
>  
> -	{ .compatible = "sigma,tango4" },
> -
>  	{ .compatible = "socionext,uniphier-pro5", },
>  	{ .compatible = "socionext,uniphier-pxs2", },
>  	{ .compatible = "socionext,uniphier-ld6b", },
> diff --git a/drivers/cpufreq/tango-cpufreq.c b/drivers/cpufreq/tango-cpufreq.c
> new file mode 100644
> index 000000000000..89a7f860bfe8
> --- /dev/null
> +++ b/drivers/cpufreq/tango-cpufreq.c
> @@ -0,0 +1,38 @@
> +#include <linux/of.h>
> +#include <linux/cpu.h>
> +#include <linux/clk.h>
> +#include <linux/pm_opp.h>
> +#include <linux/platform_device.h>
> +
> +static const struct of_device_id machines[] __initconst = {
> +	{ .compatible = "sigma,tango4" },
> +	{ /* sentinel */ }
> +};
> +
> +static int __init tango_cpufreq_init(void)
> +{
> +	struct device *cpu_dev = get_cpu_device(0);
> +	unsigned long max_freq;
> +	struct clk *cpu_clk;
> +	void *res;
> +
> +	if (!of_match_node(machines, of_root))
> +		return -ENODEV;
> +
> +	cpu_clk = clk_get(cpu_dev, NULL);
> +	if (IS_ERR(cpu_clk))
> +		return -ENODEV;
> +
> +	max_freq = clk_get_rate(cpu_clk);
> +
> +	dev_pm_opp_add(cpu_dev, max_freq / 1, 0);
> +	dev_pm_opp_add(cpu_dev, max_freq / 2, 0);
> +	dev_pm_opp_add(cpu_dev, max_freq / 3, 0);
> +	dev_pm_opp_add(cpu_dev, max_freq / 5, 0);
> +	dev_pm_opp_add(cpu_dev, max_freq / 9, 0);
> +
> +	res = platform_device_register_data(NULL, "cpufreq-dt", -1, NULL, 0);
> +
> +	return PTR_ERR_OR_ZERO(res);
> +}
> +device_initcall(tango_cpufreq_init);

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
