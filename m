From: Paul Bolle <pebolle@tiscali.nl>
Subject: Re: [PATCH v8 15/18] cpufreq: Add cpufreq driver for Tegra124
Date: Mon, 02 Mar 2015 09:49:46 +0100
Message-ID: <1425286186.24292.76.camel@x220>
References: <1425213881-5262-1-git-send-email-mikko.perttunen@kapsi.fi>
	 <1425213881-5262-16-git-send-email-mikko.perttunen@kapsi.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from cpsmtpb-ews02.kpnxchange.com ([213.75.39.5]:54964 "EHLO
	cpsmtpb-ews02.kpnxchange.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750870AbbCBItu (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 2 Mar 2015 03:49:50 -0500
In-Reply-To: <1425213881-5262-16-git-send-email-mikko.perttunen@kapsi.fi>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Mikko Perttunen <mikko.perttunen@kapsi.fi>
Cc: swarren@wwwdotorg.org, thierry.reding@gmail.com, gnurou@gmail.com, pdeschrijver@nvidia.com, rjw@rjwysocki.net, viresh.kumar@linaro.org, mturquette@linaro.org, pwalmsley@nvidia.com, vinceh@nvidia.com, pgaikwad@nvidia.com, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, linux-tegra@vger.kernel.org, linux-arm-kernel@lists.infradead.org, tuomas.tynkkynen@iki.fi, Tuomas Tynkkynen <ttynkkynen@nvidia.com>

On Sun, 2015-03-01 at 14:44 +0200, Mikko Perttunen wrote:
> --- a/drivers/cpufreq/Kconfig.arm
> +++ b/drivers/cpufreq/Kconfig.arm
> @@ -256,6 +256,13 @@ config ARM_TEGRA20_CPUFREQ
>  	help
>  	  This adds the CPUFreq driver support for Tegra20 SOCs.
>  
> +config ARM_TEGRA124_CPUFREQ
> +	bool "Tegra124 CPUFreq support"

This adds a bool Kconfig symbol...

> +	depends on ARCH_TEGRA && CPUFREQ_DT
> +	default y
> +	help
> +	  This adds the CPUFreq driver support for Tegra124 SOCs.
> +
>  config ARM_PXA2xx_CPUFREQ
>  	tristate "Intel PXA2xx CPUfreq driver"
>  	depends on PXA27x || PXA25x
> diff --git a/drivers/cpufreq/Makefile b/drivers/cpufreq/Makefile
> index 312d9c3..d478b83 100644
> --- a/drivers/cpufreq/Makefile
> +++ b/drivers/cpufreq/Makefile
> @@ -77,6 +77,7 @@ obj-$(CONFIG_ARM_SA1100_CPUFREQ)	+= sa1100-cpufreq.o
>  obj-$(CONFIG_ARM_SA1110_CPUFREQ)	+= sa1110-cpufreq.o
>  obj-$(CONFIG_ARM_SPEAR_CPUFREQ)		+= spear-cpufreq.o
>  obj-$(CONFIG_ARM_TEGRA20_CPUFREQ)	+= tegra20-cpufreq.o
> +obj-$(CONFIG_ARM_TEGRA124_CPUFREQ)	+= tegra124-cpufreq.o

... so this object will either not be built or be built-in.

>  obj-$(CONFIG_ARM_VEXPRESS_SPC_CPUFREQ)	+= vexpress-spc-cpufreq.o
>  
>  ##################################################################################
> diff --git a/drivers/cpufreq/tegra124-cpufreq.c b/drivers/cpufreq/tegra124-cpufreq.c
> new file mode 100644
> index 0000000..45778ce
> --- /dev/null
> +++ b/drivers/cpufreq/tegra124-cpufreq.c
> @@ -0,0 +1,217 @@
> +/*
> + * Tegra 124 cpufreq driver
> + *
> + * This software is licensed under the terms of the GNU General Public
> + * License version 2, as published by the Free Software Foundation, and
> + * may be copied, distributed, and modified under those terms.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + */
> +
> +#define pr_fmt(fmt)	KBUILD_MODNAME ": " fmt
> +
> +#include <linux/clk.h>
> +#include <linux/cpufreq-dt.h>
> +#include <linux/err.h>
> +#include <linux/init.h>
> +#include <linux/kernel.h>
> +#include <linux/module.h>

Is linux/module.h needed?

> +#include <linux/of_device.h>
> +#include <linux/of.h>
> +#include <linux/platform_device.h>
> +#include <linux/pm_opp.h>
> +#include <linux/regulator/consumer.h>
> +#include <linux/types.h>

[...]

> +static struct platform_driver tegra124_cpufreq_platdrv = {
> +	.driver = {
> +		.name	= "cpufreq-tegra124",
> +		.owner	= THIS_MODULE,

.owner will always be, in short, NULL.

> +	},
> +	.probe		= tegra124_cpufreq_probe,
> +	.remove		= tegra124_cpufreq_remove,
> +};

[...]

> +module_init(tegra_cpufreq_init);

This might as well be, I think, device_initcall().

> +MODULE_AUTHOR("Tuomas Tynkkynen <ttynkkynen@nvidia.com>");
> +MODULE_DESCRIPTION("cpufreq driver for NVIDIA Tegra124");
> +MODULE_LICENSE("GPL v2");

The strings in these macros will always be preprocessed away, because
this driver cannot become a module.


Paul Bolle

