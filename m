From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH v2 1/2] cpufreq: add imx6q-cpufreq driver
Date: Thu, 10 Jan 2013 14:15:44 +0530
Message-ID: <CAKohpom2Z0LmTNjq6mbZAa=JvQfBeRBzfXU3Jifn8y_C6XJkQw@mail.gmail.com>
References: <1357806863-6899-1-git-send-email-shawn.guo@linaro.org>
	<1357806863-6899-2-git-send-email-shawn.guo@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-ob0-f180.google.com ([209.85.214.180]:49694 "EHLO
	mail-ob0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751753Ab3AJIpo (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 10 Jan 2013 03:45:44 -0500
Received: by mail-ob0-f180.google.com with SMTP id wd20so286515obb.25
        for <linux-pm@vger.kernel.org>; Thu, 10 Jan 2013 00:45:44 -0800 (PST)
In-Reply-To: <1357806863-6899-2-git-send-email-shawn.guo@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>, Shawn Guo <shawn.guo@linaro.org>
Cc: cpufreq@vger.kernel.org, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Sascha Hauer <s.hauer@pengutronix.de>

On 10 January 2013 14:04, Shawn Guo <shawn.guo@linaro.org> wrote:
> Add an imx6q-cpufreq for Freescale i.MX6Q SoC to handle the hardware

                                       ^
                                   driver

> specific frequency and voltage scaling requirements.
>
> The driver supports module build and is instantiated by the platform
> device/driver mechanism, so that it will be instantiated on other
> platform, as IMX is built with multiplatform support.
>
> Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
> ---
>  drivers/cpufreq/Kconfig.arm     |    9 ++
>  drivers/cpufreq/Makefile        |    1 +
>  drivers/cpufreq/imx6q-cpufreq.c |  296 +++++++++++++++++++++++++++++++++++++++
>  3 files changed, 306 insertions(+)
>  create mode 100644 drivers/cpufreq/imx6q-cpufreq.c
>
> diff --git a/drivers/cpufreq/Kconfig.arm b/drivers/cpufreq/Kconfig.arm
> index a0b3661..9e628ba 100644
> --- a/drivers/cpufreq/Kconfig.arm
> +++ b/drivers/cpufreq/Kconfig.arm
> @@ -77,6 +77,15 @@ config ARM_EXYNOS5250_CPUFREQ
>           This adds the CPUFreq driver for Samsung EXYNOS5250
>           SoC.
>
> +config ARM_IMX6Q_CPUFREQ
> +       tristate "Freescale i.MX6Q cpufreq support"
> +       depends on SOC_IMX6Q
> +       depends on REGULATOR_ANATOP
> +       help
> +         This adds cpufreq driver support for Freescale i.MX6Q SOC.
> +
> +         If in doubt, say N.
> +
>  config ARM_SPEAR_CPUFREQ
>         bool "SPEAr CPUFreq support"
>         depends on PLAT_SPEAR
> diff --git a/drivers/cpufreq/Makefile b/drivers/cpufreq/Makefile
> index 1f254ec0..31699a0 100644
> --- a/drivers/cpufreq/Makefile
> +++ b/drivers/cpufreq/Makefile
> @@ -49,6 +49,7 @@ obj-$(CONFIG_ARM_EXYNOS_CPUFREQ)      += exynos-cpufreq.o
>  obj-$(CONFIG_ARM_EXYNOS4210_CPUFREQ)   += exynos4210-cpufreq.o
>  obj-$(CONFIG_ARM_EXYNOS4X12_CPUFREQ)   += exynos4x12-cpufreq.o
>  obj-$(CONFIG_ARM_EXYNOS5250_CPUFREQ)   += exynos5250-cpufreq.o
> +obj-$(CONFIG_ARM_IMX6Q_CPUFREQ)                += imx6q-cpufreq.o
>  obj-$(CONFIG_ARM_OMAP2PLUS_CPUFREQ)     += omap-cpufreq.o
>  obj-$(CONFIG_ARM_SPEAR_CPUFREQ)                += spear-cpufreq.o
>
> diff --git a/drivers/cpufreq/imx6q-cpufreq.c b/drivers/cpufreq/imx6q-cpufreq.c
> new file mode 100644
> index 0000000..218d8f1
> --- /dev/null
> +++ b/drivers/cpufreq/imx6q-cpufreq.c
> @@ -0,0 +1,296 @@
> +/*
> + * Copyright (C) 2013 Freescale Semiconductor, Inc.
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + */
> +
> +#include <linux/clk.h>
> +#include <linux/cpu.h>
> +#include <linux/cpufreq.h>
> +#include <linux/err.h>
> +#include <linux/module.h>
> +#include <linux/of.h>
> +#include <linux/opp.h>
> +#include <linux/platform_device.h>
> +#include <linux/regulator/consumer.h>
> +#include <linux/slab.h>
> +
> +#define PU_SOC_VOLTAGE_NORMAL  1250000
> +#define PU_SOC_VOLTAGE_HIGH    1275000
> +#define FREQ_1P2_GHZ           1200000000
> +
> +static struct regulator *arm_reg;
> +static struct regulator *pu_reg;
> +static struct regulator *soc_reg;
> +
> +static struct clk *arm_clk;
> +static struct clk *pll1_sys_clk;
> +static struct clk *pll1_sw_clk;
> +static struct clk *step_clk;
> +static struct clk *pll2_pfd2_396m_clk;
> +
> +static struct device *cpu_dev;
> +static struct cpufreq_frequency_table *freq_table;
> +static unsigned int transition_latency;
> +
> +static int imx6q_verify_speed(struct cpufreq_policy *policy)
> +{
> +       return cpufreq_frequency_table_verify(policy, freq_table);
> +}
> +
> +static unsigned int imx6q_get_speed(unsigned int cpu)
> +{
> +       return clk_get_rate(arm_clk) / 1000;
> +}
> +
> +static int imx6q_set_target(struct cpufreq_policy *policy,
> +                           unsigned int target_freq, unsigned int relation)
> +{
> +       struct cpufreq_freqs freqs;
> +       struct opp *opp;
> +       unsigned long freq_hz, volt, volt_old;
> +       unsigned int index, cpu;
> +       int ret;
> +
> +       ret = cpufreq_frequency_table_target(policy, freq_table, target_freq,
> +                                            relation, &index);

@Rafael: Why is this function used in our target routines? Isn't the caller
supposed to send a valid freq from freq_table? All governors do it.

> +       if (ret) {
> +               dev_err(cpu_dev, "failed to match target frequency %d: %d\n",
> +                       target_freq, ret);
> +               return ret;
> +       }
> +
> +       freqs.new = freq_table[index].frequency;
> +       freq_hz = freqs.new * 1000;
> +       freqs.old = clk_get_rate(arm_clk) / 1000;

clk_get_rate() can fail.

> +
> +       if (freqs.old == freqs.new)
> +               return 0;
> +
> +       for_each_online_cpu(cpu) {
> +               freqs.cpu = cpu;
> +               cpufreq_notify_transition(&freqs, CPUFREQ_PRECHANGE);
> +       }
> +
> +       opp = opp_find_freq_ceil(cpu_dev, &freq_hz);
> +       if (IS_ERR(opp)) {
> +               dev_err(cpu_dev, "failed to find OPP for %ld\n", freq_hz);
> +               return PTR_ERR(opp);
> +       }
> +
> +       volt = opp_get_voltage(opp);
> +       volt_old = regulator_get_voltage(arm_reg);
> +
> +       dev_dbg(cpu_dev, "%u MHz, %ld mV --> %u MHz, %ld mV\n",
> +               freqs.old / 1000, volt_old / 1000,
> +               freqs.new / 1000, volt / 1000);
> +
> +       /* scaling up?  scale voltage before frequency */
> +       if (freqs.new > freqs.old) {
> +               ret = regulator_set_voltage_tol(arm_reg, volt, 0);
> +               if (ret) {
> +                       dev_err(cpu_dev, "failed to scale voltage up: %d\n", ret);
> +                       return ret;
> +               }
> +
> +               /*
> +                * Need to increase vddpu and vddsoc for safety
> +                * if we are about to run at 1.2 GHz.
> +                */
> +               if (freqs.new == FREQ_1P2_GHZ / 1000) {
> +                       regulator_set_voltage_tol(pu_reg,
> +                                       PU_SOC_VOLTAGE_HIGH, 0);
> +                       regulator_set_voltage_tol(soc_reg,
> +                                       PU_SOC_VOLTAGE_HIGH, 0);
> +               }
> +       }
> +
> +       /*
> +        * The setpoints are selected per PLL/PDF frequencies, so we need to
> +        * reprogram PLL for frequency scaling.  The procedure of reprogramming
> +        * PLL1 is as below.
> +        *
> +        *  - Enable pll2_pfd2_396m_clk and reparent pll1_sw_clk to it
> +        *  - Disable pll1_sys_clk and reprogram it
> +        *  - Enable pll1_sys_clk and reparent pll1_sw_clk back to it
> +        *  - Disable pll2_pfd2_396m_clk
> +        */
> +       clk_prepare_enable(pll2_pfd2_396m_clk);
> +       clk_set_parent(step_clk, pll2_pfd2_396m_clk);
> +       clk_set_parent(pll1_sw_clk, step_clk);
> +       clk_prepare_enable(pll1_sys_clk);

all these fns can fail too.. don't want to check return values?

> +       if (freq_hz > clk_get_rate(pll2_pfd2_396m_clk)) {
> +               clk_disable_unprepare(pll1_sys_clk);
> +               clk_set_rate(pll1_sys_clk, freqs.new * 1000);
> +               clk_prepare_enable(pll1_sys_clk);
> +               clk_set_parent(pll1_sw_clk, pll1_sys_clk);
> +               clk_disable_unprepare(pll2_pfd2_396m_clk);
> +       } else {
> +               /*
> +                * Disable pll1_sys_clk if pll2_pfd2_396m_clk is sufficient
> +                * to provide the frequency.
> +                */
> +               clk_disable_unprepare(pll1_sys_clk);
> +       }
> +
> +       /* Ensure the arm clock divider is what we expect */
> +       ret = clk_set_rate(arm_clk, freqs.new * 1000);
> +       if (ret) {
> +               dev_err(cpu_dev, "failed to set clock rate: %d\n", ret);
> +               regulator_set_voltage_tol(arm_reg, volt_old, 0);
> +               return ret;
> +       }
> +
> +       /* scaling down?  scale voltage after frequency */
> +       if (freqs.new < freqs.old) {
> +               ret = regulator_set_voltage_tol(arm_reg, volt, 0);
> +               if (ret)
> +                       dev_warn(cpu_dev, "failed to scale voltage down: %d\n", ret);
> +
> +               if (freqs.old == FREQ_1P2_GHZ / 1000) {
> +                       regulator_set_voltage_tol(pu_reg,
> +                                       PU_SOC_VOLTAGE_NORMAL, 0);
> +                       regulator_set_voltage_tol(soc_reg,
> +                                       PU_SOC_VOLTAGE_NORMAL, 0);
> +               }
> +       }
> +
> +       for_each_online_cpu(cpu) {
> +               freqs.cpu = cpu;
> +               cpufreq_notify_transition(&freqs, CPUFREQ_POSTCHANGE);
> +       }
> +
> +       return 0;
> +}
> +
> +static int imx6q_cpufreq_init(struct cpufreq_policy *policy)
> +{
> +       int ret;
> +

So you finally removed the ugly check :)

Reviewed-by: Viresh Kumar <viresh.kumar@linaro.org>
