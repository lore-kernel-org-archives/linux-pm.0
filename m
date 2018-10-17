From: Stephen Boyd <swboyd@chromium.org>
Subject: Re: [PATCH 2/2] cpufreq: qcom-hw: Add support for QCOM cpufreq HW driver
Date: Wed, 17 Oct 2018 16:32:33 -0700
Message-ID: <153981915373.5275.15971019914218464179@swboyd.mtv.corp.google.com>
References: <1539257761-23023-1-git-send-email-tdas@codeaurora.org>
 <1539257761-23023-3-git-send-email-tdas@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1539257761-23023-3-git-send-email-tdas@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Viresh Kumar <viresh.kumar@linaro.org>, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Cc: Rajendra Nayak <rnayak@codeaurora.org>, devicetree@vger.kernel.org, robh@kernel.org, skannan@codeaurora.org, linux-arm-msm@vger.kernel.org, amit.kucheria@linaro.org, evgreen@google.com, Taniya Das <tdas@codeaurora.org>
List-Id: linux-pm@vger.kernel.org

Quoting Taniya Das (2018-10-11 04:36:01)
> --- a/drivers/cpufreq/Kconfig.arm
> +++ b/drivers/cpufreq/Kconfig.arm
> @@ -121,6 +121,17 @@ config ARM_QCOM_CPUFREQ_KRYO
> =

>           If in doubt, say N.
> =

> +config ARM_QCOM_CPUFREQ_HW
> +       bool "QCOM CPUFreq HW driver"

Is there any reason this can't be a module?

> +       depends on ARCH_QCOM || COMPILE_TEST
> +       help
> +         Support for the CPUFreq HW driver.
> +         Some QCOM chipsets have a HW engine to offload the steps
> +         necessary for changing the frequency of the CPUs. Firmware load=
ed
> +         in this engine exposes a programming interface to the OS.
> +         The driver implements the cpufreq interface for this HW engine.
> +         Say Y if you want to support CPUFreq HW.
> +
>  config ARM_S3C_CPUFREQ
>         bool
>         help
> diff --git a/drivers/cpufreq/qcom-cpufreq-hw.c b/drivers/cpufreq/qcom-cpu=
freq-hw.c
> new file mode 100644
> index 0000000..fe1c264
> --- /dev/null
> +++ b/drivers/cpufreq/qcom-cpufreq-hw.c
> @@ -0,0 +1,354 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (c) 2018, The Linux Foundation. All rights reserved.
> + */
> +
> +#include <linux/cpufreq.h>
> +#include <linux/init.h>
> +#include <linux/kernel.h>
> +#include <linux/of_address.h>
> +#include <linux/of_platform.h>
> +
> +#define LUT_MAX_ENTRIES                        40U
> +#define CORE_COUNT_VAL(val)            (((val) & (GENMASK(18, 16))) >> 1=
6)
> +#define LUT_ROW_SIZE                   32
> +#define CLK_HW_DIV                     2
> +
> +enum {
> +       REG_ENABLE,
> +       REG_LUT_TABLE,
> +       REG_PERF_STATE,
> +
> +       REG_ARRAY_SIZE,
> +};
> +
> +struct cpufreq_qcom {
> +       struct cpufreq_frequency_table *table;
> +       void __iomem *reg_bases[REG_ARRAY_SIZE];
> +       cpumask_t related_cpus;
> +       unsigned int max_cores;
> +       unsigned long xo_rate;
> +       unsigned long cpu_hw_rate;
> +};
> +
> +static const u16 cpufreq_qcom_std_offsets[REG_ARRAY_SIZE] =3D {

Is this going to change in the future?

> +       [REG_ENABLE]            =3D 0x0,
> +       [REG_LUT_TABLE]         =3D 0x110,
> +       [REG_PERF_STATE]        =3D 0x920,
> +};
> +
> +static struct cpufreq_qcom *qcom_freq_domain_map[NR_CPUS];
> +
> +static int
> +qcom_cpufreq_hw_target_index(struct cpufreq_policy *policy,
> +                            unsigned int index)
> +{
> +       struct cpufreq_qcom *c =3D policy->driver_data;
> +
> +       writel_relaxed(index, c->reg_bases[REG_PERF_STATE]);

Why can't we avoid the indirection here and store the perf_state pointer
in probe? Then we don't have to indirect through a table to perform the
register write.

> +
> +       return 0;
> +}
> +
[..]
> +static int qcom_resources_init(struct platform_device *pdev)
> +{
> +       struct device_node *cpu_np;
> +       struct of_phandle_args args;
> +       struct clk *clk;
> +       unsigned int cpu;
> +       unsigned long xo_rate, cpu_hw_rate;
> +       int ret;
> +
> +       clk =3D clk_get(&pdev->dev, "xo");
> +       if (IS_ERR(clk))
> +               return PTR_ERR(clk);
> +
> +       xo_rate =3D clk_get_rate(clk);
> +
> +       clk_put(clk);
> +
> +       clk =3D clk_get(&pdev->dev, "cpu_clk");

Sad that the name is cpu_clk, instead of something like 'backup' or
whatever the name really is in hardware.
