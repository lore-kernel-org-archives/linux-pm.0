From: Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>
Subject: Re: [PATCH v4 1/1] cpufreq: tegra: Re-model Tegra20 cpufreq driver
Date: Fri, 13 Dec 2013 16:21:35 -0700
Message-ID: <52AB967F.9030900@wwwdotorg.org>
References: <1386840835-28751-1-git-send-email-bilhuang@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1386840835-28751-1-git-send-email-bilhuang-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Bill Huang <bilhuang-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org, viresh.kumar-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, cpufreq-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-pm@vger.kernel.org

On 12/12/2013 02:33 AM, Bill Huang wrote:
> Re-model Tegra20 cpufreq driver as below.
> 
> * Rename tegra-cpufreq.c to tegra20-cpufreq.c since this file supports
>   only Tegra20.
> * Add probe function so defer probe can be used when we're going to
>   support DVFS.
> * Create a fake cpufreq platform device with its name being
>   "${root_compatible}-cpufreq" so SoC cpufreq driver can bind to it
>   accordingly.

> diff --git a/drivers/cpufreq/Kconfig.arm b/drivers/cpufreq/Kconfig.arm

> +config ARM_TEGRA20_CPUFREQ
> +	bool "NVIDIA TEGRA20"
> +	depends on ARM_TEGRA_CPUFREQ && ARCH_TEGRA_2x_SOC
> +	default y
> +	help
> +	  This enables Tegra20 cpufreq functionality, it adds
> +	  Tegra20 CPU frequency ladder and the call back functions
> +	  to set CPU rate. All the non-SoC dependant codes are
> +	  controlled by the config ARM_TEGRA20_CPUFREQ.

I think that last sentence is no longer true in this patch version. Or,
did you mean to write ARM_TEGRA_CPUFREQ rather than ARM_TEGRA20_CPUFREQ?

> diff --git a/drivers/cpufreq/tegra-cpufreq.c b/drivers/cpufreq/tegra-cpufreq.c

> +static const char * const tegra_soc_compat[] = {
> +	"nvidia,tegra124",
> +	"nvidia,tegra114",
> +	"nvidia,tegra30",
> +	"nvidia,tegra20",
> +	NULL
>  };

That table will need editing for each chip. I wonder if you can do
something like always use the very last entry in /compatible. That would
assume a particular ordering of the compatible entries, but they should
be in the order $board, $soc anyway...

> +int __init tegra_cpufreq_init(void)
> +	int i;
> +
> +	for (i = 0; i < ARRAY_SIZE(tegra_soc_compat); i++) {
> +		if (of_machine_is_compatible(tegra_soc_compat[i])) {
> +			struct platform_device_info devinfo;
> +			char buf[40];
> +
> +			memset(&devinfo, 0, sizeof(devinfo));
> +			strcpy(buf, tegra_soc_compat[i]);
> +			strcat(buf, "-cpufreq");

kasprintf() might be simpler, and would avoid the arbitrary 39-character
string limit and possibility of overflow.

> +			devinfo.name = buf;
> +			platform_device_register_full(&devinfo);

Does the devinfo struct need to stick around, i.e. does
platform_device_register_full keep the pointer, or take a copy of the
struct? If it keeps the pointer, it'd be best to make devinfo a static
global variable.

> diff --git a/drivers/cpufreq/tegra20-cpufreq.c b/drivers/cpufreq/tegra20-cpufreq.c

Please pass the "-C" option to "git format-patch"; I assume that almost
all the code in this file is simply cut/paste verbatim from
tegra-cpufreq.c where it was deleted.

> + * Copyright (C) 2010 Google, Inc.

It's worth adding NV (c) here too.

> +static int tegra20_cpufreq_remove(struct platform_device *pdev)
> +{
> +	cpufreq_unregister_driver(&tegra20_cpufreq_driver);
> +	return 0;
> +}

That leaks all the clk_get_sys() calls. Does building this as a module
work OK?

> +MODULE_LICENSE("GPL");

That should be "GPL v2".

> diff --git a/include/linux/tegra-cpufreq.h b/include/linux/tegra-cpufreq.h

> +#ifdef CONFIG_ARM_TEGRA_CPUFREQ
> +int tegra_cpufreq_init(void);
> +#else
> +static inline int tegra_cpufreq_init(void)
> +{ return; }
> +#endif

If you're going to wrap the { } onto one line, then I think it'd be best
to wrap the whole thing (prototype and body) onto one line. Otherwise,
write:

{
	return;
}

Oh, and you need "return 0" not just "return".
