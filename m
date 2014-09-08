From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH V3 09/10] cpufreq: cpu0: rename driver and internals to 'cpufreq_generic'
Date: Tue, 09 Sep 2014 01:34:15 +0200
Message-ID: <1841344.yBggYEARvr@vostro.rjw.lan>
References: <cover.1409201048.git.viresh.kumar@linaro.org> <8d75112b27fa36c873838185e99f0dbe7f86cc05.1409201048.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:56975 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1755218AbaIHXOt (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 8 Sep 2014 19:14:49 -0400
In-Reply-To: <8d75112b27fa36c873838185e99f0dbe7f86cc05.1409201048.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, shawn.guo@linaro.org, sboyd@codeaurora.org, linux-arm-msm@vger.kernel.org, spk.linux@gmail.com, thomas.ab@samsung.com, t.figa@samsung.com, santosh.shilimkar@ti.com, thomas.petazzoni@free-electrons.com, pramod.gurav@smartplayin.com

On Thursday, August 28, 2014 11:22:31 AM Viresh Kumar wrote:
> The naming convention of this driver was always under the scanner, people
> complained that it should have a more generic name than cpu0, as it manages all
> CPUs that are sharing clock lines.
> 
> Also, in future it will be modified to support any number of clusters with
> separate clock/voltage lines.
> 
> Lets rename it to 'cpufreq_generic' from 'cpufreq_cpu0'.

I'm not a big fan of changes like this to be honest, because they kind of
hide history.  For example, if you do a "git blame" on the new file, it will
show your commit and nothing before it.

> '.name' field of platform driver/devices isn't renamed yet, would be done
> separately.
> 
> Tested-by: Stephen Boyd <sboyd@codeaurora.org>
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---
>  .../{cpufreq-cpu0.txt => cpufreq-generic.txt}      |  8 ++---
>  drivers/cpufreq/Kconfig                            | 10 +++---
>  drivers/cpufreq/Kconfig.arm                        |  2 +-
>  drivers/cpufreq/Makefile                           |  2 +-
>  .../cpufreq/{cpufreq-cpu0.c => cpufreq-generic.c}  | 36 +++++++++++-----------
>  5 files changed, 29 insertions(+), 29 deletions(-)
>  rename Documentation/devicetree/bindings/cpufreq/{cpufreq-cpu0.txt => cpufreq-generic.txt} (85%)
>  rename drivers/cpufreq/{cpufreq-cpu0.c => cpufreq-generic.c} (90%)
> 
> diff --git a/Documentation/devicetree/bindings/cpufreq/cpufreq-cpu0.txt b/Documentation/devicetree/bindings/cpufreq/cpufreq-generic.txt
> similarity index 85%
> rename from Documentation/devicetree/bindings/cpufreq/cpufreq-cpu0.txt
> rename to Documentation/devicetree/bindings/cpufreq/cpufreq-generic.txt
> index 366690c..9278f79 100644
> --- a/Documentation/devicetree/bindings/cpufreq/cpufreq-cpu0.txt
> +++ b/Documentation/devicetree/bindings/cpufreq/cpufreq-generic.txt
> @@ -1,8 +1,8 @@
> -Generic CPU0 cpufreq driver
> +Generic cpufreq driver
>  
> -It is a generic cpufreq driver for CPU0 frequency management.  It
> -supports both uniprocessor (UP) and symmetric multiprocessor (SMP)
> -systems which share clock and voltage across all CPUs.
> +It is a generic cpufreq driver for frequency management.  It supports both
> +uniprocessor (UP) and symmetric multiprocessor (SMP) systems which share clock
> +and voltage across all CPUs.
>  
>  Both required and optional properties listed below must be defined
>  under node /cpus/cpu@0.
> diff --git a/drivers/cpufreq/Kconfig b/drivers/cpufreq/Kconfig
> index ffe350f..22b42d5 100644
> --- a/drivers/cpufreq/Kconfig
> +++ b/drivers/cpufreq/Kconfig
> @@ -183,16 +183,16 @@ config CPU_FREQ_GOV_CONSERVATIVE
>  
>  	  If in doubt, say N.
>  
> -config GENERIC_CPUFREQ_CPU0
> -	tristate "Generic CPU0 cpufreq driver"
> +config CPUFREQ_GENERIC
> +	tristate "Generic cpufreq driver"
>  	depends on HAVE_CLK && OF
> -	# if CPU_THERMAL is on and THERMAL=m, CPU0 cannot be =y:
> +	# if CPU_THERMAL is on and THERMAL=m, GENERIC cannot be =y:
>  	depends on !CPU_THERMAL || THERMAL
>  	select PM_OPP
>  	help
> -	  This adds a generic cpufreq driver for CPU0 frequency management.
> +	  This adds a generic cpufreq driver for frequency management.
>  	  It supports both uniprocessor (UP) and symmetric multiprocessor (SMP)
> -	  systems which share clock and voltage across all CPUs.
> +	  systems which may or maynot share clock and voltage across all CPUs.
>  
>  	  If in doubt, say N.
>  
> diff --git a/drivers/cpufreq/Kconfig.arm b/drivers/cpufreq/Kconfig.arm
> index 7364a53..b0b0ca1 100644
> --- a/drivers/cpufreq/Kconfig.arm
> +++ b/drivers/cpufreq/Kconfig.arm
> @@ -92,7 +92,7 @@ config ARM_EXYNOS_CPU_FREQ_BOOST_SW
>  
>  config ARM_HIGHBANK_CPUFREQ
>  	tristate "Calxeda Highbank-based"
> -	depends on ARCH_HIGHBANK && GENERIC_CPUFREQ_CPU0 && REGULATOR
> +	depends on ARCH_HIGHBANK && CPUFREQ_GENERIC && REGULATOR
>  	default m
>  	help
>  	  This adds the CPUFreq driver for Calxeda Highbank SoC
> diff --git a/drivers/cpufreq/Makefile b/drivers/cpufreq/Makefile
> index db6d9a2..e8efe9b 100644
> --- a/drivers/cpufreq/Makefile
> +++ b/drivers/cpufreq/Makefile
> @@ -13,7 +13,7 @@ obj-$(CONFIG_CPU_FREQ_GOV_ONDEMAND)	+= cpufreq_ondemand.o
>  obj-$(CONFIG_CPU_FREQ_GOV_CONSERVATIVE)	+= cpufreq_conservative.o
>  obj-$(CONFIG_CPU_FREQ_GOV_COMMON)		+= cpufreq_governor.o
>  
> -obj-$(CONFIG_GENERIC_CPUFREQ_CPU0)	+= cpufreq-cpu0.o
> +obj-$(CONFIG_CPUFREQ_GENERIC)		+= cpufreq-generic.o
>  
>  ##################################################################################
>  # x86 drivers.
> diff --git a/drivers/cpufreq/cpufreq-cpu0.c b/drivers/cpufreq/cpufreq-generic.c
> similarity index 90%
> rename from drivers/cpufreq/cpufreq-cpu0.c
> rename to drivers/cpufreq/cpufreq-generic.c
> index a5f8c5f..9b85055 100644
> --- a/drivers/cpufreq/cpufreq-cpu0.c
> +++ b/drivers/cpufreq/cpufreq-generic.c
> @@ -4,7 +4,7 @@
>   * Copyright (C) 2014 Linaro.
>   * Viresh Kumar <viresh.kumar@linaro.org>
>   *
> - * The OPP code in function cpu0_set_target() is reused from
> + * The OPP code in function set_target() is reused from
>   * drivers/cpufreq/omap-cpufreq.c
>   *
>   * This program is free software; you can redistribute it and/or modify
> @@ -35,7 +35,7 @@ struct private_data {
>  	unsigned int voltage_tolerance; /* in percentage */
>  };
>  
> -static int cpu0_set_target(struct cpufreq_policy *policy, unsigned int index)
> +static int set_target(struct cpufreq_policy *policy, unsigned int index)
>  {
>  	struct dev_pm_opp *opp;
>  	struct cpufreq_frequency_table *freq_table = policy->freq_table;
> @@ -176,7 +176,7 @@ static int allocate_resources(int cpu, struct device **cdev,
>  	return ret;
>  }
>  
> -static int cpu0_cpufreq_init(struct cpufreq_policy *policy)
> +static int cpufreq_init(struct cpufreq_policy *policy)
>  {
>  	struct cpufreq_frequency_table *freq_table;
>  	struct thermal_cooling_device *cdev;
> @@ -287,7 +287,7 @@ static int cpu0_cpufreq_init(struct cpufreq_policy *policy)
>  	return ret;
>  }
>  
> -static int cpu0_cpufreq_exit(struct cpufreq_policy *policy)
> +static int cpufreq_exit(struct cpufreq_policy *policy)
>  {
>  	struct private_data *priv = policy->driver_data;
>  
> @@ -301,18 +301,18 @@ static int cpu0_cpufreq_exit(struct cpufreq_policy *policy)
>  	return 0;
>  }
>  
> -static struct cpufreq_driver cpu0_cpufreq_driver = {
> +static struct cpufreq_driver generic_cpufreq_driver = {
>  	.flags = CPUFREQ_STICKY | CPUFREQ_NEED_INITIAL_FREQ_CHECK,
>  	.verify = cpufreq_generic_frequency_table_verify,
> -	.target_index = cpu0_set_target,
> +	.target_index = set_target,
>  	.get = cpufreq_generic_get,
> -	.init = cpu0_cpufreq_init,
> -	.exit = cpu0_cpufreq_exit,
> -	.name = "generic_cpu0",
> +	.init = cpufreq_init,
> +	.exit = cpufreq_exit,
> +	.name = "cpufreq-generic",
>  	.attr = cpufreq_generic_attr,
>  };
>  
> -static int cpu0_cpufreq_probe(struct platform_device *pdev)
> +static int generic_cpufreq_probe(struct platform_device *pdev)
>  {
>  	struct device *cpu_dev;
>  	struct regulator *cpu_reg;
> @@ -334,30 +334,30 @@ static int cpu0_cpufreq_probe(struct platform_device *pdev)
>  	if (!IS_ERR(cpu_reg))
>  		regulator_put(cpu_reg);
>  
> -	ret = cpufreq_register_driver(&cpu0_cpufreq_driver);
> +	ret = cpufreq_register_driver(&generic_cpufreq_driver);
>  	if (ret)
>  		dev_err(cpu_dev, "failed register driver: %d\n", ret);
>  
>  	return ret;
>  }
>  
> -static int cpu0_cpufreq_remove(struct platform_device *pdev)
> +static int generic_cpufreq_remove(struct platform_device *pdev)
>  {
> -	cpufreq_unregister_driver(&cpu0_cpufreq_driver);
> +	cpufreq_unregister_driver(&generic_cpufreq_driver);
>  	return 0;
>  }
>  
> -static struct platform_driver cpu0_cpufreq_platdrv = {
> +static struct platform_driver generic_cpufreq_platdrv = {
>  	.driver = {
>  		.name	= "cpufreq-cpu0",
>  		.owner	= THIS_MODULE,
>  	},
> -	.probe		= cpu0_cpufreq_probe,
> -	.remove		= cpu0_cpufreq_remove,
> +	.probe		= generic_cpufreq_probe,
> +	.remove		= generic_cpufreq_remove,
>  };
> -module_platform_driver(cpu0_cpufreq_platdrv);
> +module_platform_driver(generic_cpufreq_platdrv);
>  
>  MODULE_AUTHOR("Viresh Kumar <viresh.kumar@linaro.org>");
>  MODULE_AUTHOR("Shawn Guo <shawn.guo@linaro.org>");
> -MODULE_DESCRIPTION("Generic CPU0 cpufreq driver");
> +MODULE_DESCRIPTION("Generic cpufreq driver");
>  MODULE_LICENSE("GPL");
> 

-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
