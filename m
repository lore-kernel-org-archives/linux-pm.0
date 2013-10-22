From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH 1/4] cpufreq: Add a cpufreq driver for Marvell Dove
Date: Tue, 22 Oct 2013 14:31:03 +0530
Message-ID: <CAKohpok2scsSU7eFOP5LYmQar8xfOqG4-b3z4sVS6JOgnxVcpw@mail.gmail.com>
References: <1382186261-14482-1-git-send-email-andrew@lunn.ch>
	<1382186261-14482-2-git-send-email-andrew@lunn.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-ob0-f174.google.com ([209.85.214.174]:43951 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750988Ab3JVJBE (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 22 Oct 2013 05:01:04 -0400
Received: by mail-ob0-f174.google.com with SMTP id vb8so2608728obc.19
        for <linux-pm@vger.kernel.org>; Tue, 22 Oct 2013 02:01:03 -0700 (PDT)
In-Reply-To: <1382186261-14482-2-git-send-email-andrew@lunn.ch>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Andrew Lunn <andrew@lunn.ch>
Cc: Sebastian Hesselbarth <sebastian.hesselbarth@googlemail.com>, Jason Cooper <jason@lakedaemon.net>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, linux ARM <linux-arm-kernel@lists.infradead.org>

On 19 October 2013 18:07, Andrew Lunn <andrew@lunn.ch> wrote:

> +config ARM_DOVE_CPUFREQ
> +       def_bool ARCH_DOVE && OF
> +       select CPU_FREQ_TABLE

Refer:
3bc28ab cpufreq: remove CONFIG_CPU_FREQ_TABLE

> +       help
> +         This adds the CPUFreq driver for Marvell Dove
> +         SoCs.

Above can come in one line?

> +
>  config ARM_DT_BL_CPUFREQ
>         tristate "Generic probing via DT for ARM big LITTLE CPUfreq driver"
>         depends on ARM_BIG_LITTLE_CPUFREQ && OF


> diff --git a/drivers/cpufreq/dove-cpufreq.c b/drivers/cpufreq/dove-cpufreq.c

> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/clk.h>
> +#include <linux/clk-provider.h>

why do you need this one?

> +#include <linux/cpufreq.h>
> +#include <linux/interrupt.h>
> +#include <linux/of.h>
> +#include <linux/platform_device.h>
> +#include <linux/io.h>
> +#include <linux/of_irq.h>

Can you add them in ascending order please?

> +#include <asm/proc-fns.h>
> +
> +#define DFS_CR                 0x00
> +#define         DFS_EN                 BIT(0)
> +#define         CPU_SLOW_EN            BIT(1)
> +#define         L2_RATIO_OFFS          9
> +#define         L2_RATIO_MASK          (0x3F << L2_RATIO_OFFS)
> +#define DFS_SR                 0x04
> +#define         CPU_SLOW_MODE_STTS     BIT(1)
> +
> +/* PMU_CR */
> +#define         MASK_FIQ               BIT(28)
> +#define         MASK_IRQ               BIT(24) /* PMU_CR */

Use space after #define instead of tabs. And then use tabs
consistently after Macro name to keep macro values aligned.

> +/* CPU Clock Divider Control 0 Register */
> +#define DPRATIO_OFFS           24
> +#define DPRATIO_MASK           (0x3F << DPRATIO_OFFS)
> +#define XPRATIO_OFFS           16
> +#define XPRATIO_MASK           (0x3F << XPRATIO_OFFS)

Here as well.. aligning with earlier macro's might look better.

> +static struct priv
> +{
> +       struct clk *cpu_clk;
> +       struct clk *ddr_clk;
> +       struct device *dev;
> +       unsigned long dpratio;
> +       unsigned long xpratio;
> +       void __iomem *dfs;
> +       void __iomem *pmu_cr;
> +       void __iomem *pmu_clk_div;
> +} priv;
> +
> +#define STATE_CPU_FREQ 0x01
> +#define STATE_DDR_FREQ 0x02
> +
> +/*
> + * Dove can swap the clock to the CPU between two clocks:
> + *
> + * - cpu clk
> + * - ddr clk
> + *
> + * The frequencies are set at runtime before registering this
> + * table.
> + */
> +static struct cpufreq_frequency_table dove_freq_table[] = {
> +       {STATE_CPU_FREQ,        0}, /* CPU uses cpuclk */
> +       {STATE_DDR_FREQ,        0}, /* CPU uses ddrclk */
> +       {0,                     CPUFREQ_TABLE_END},
> +};
> +
> +static unsigned int dove_cpufreq_get_cpu_frequency(unsigned int cpu)
> +{
> +       unsigned long reg = readl_relaxed(priv.dfs + DFS_SR);
> +
> +       if (reg & CPU_SLOW_MODE_STTS)
> +               return dove_freq_table[1].frequency;
> +       return dove_freq_table[0].frequency;
> +}
> +
> +static void dove_cpufreq_set_cpu_state(struct cpufreq_policy *policy,
> +                                      unsigned int index)
> +{
> +       struct cpufreq_freqs freqs;
> +       unsigned int state = dove_freq_table[index].driver_data;
> +       unsigned long reg, cr;
> +
> +       freqs.old = dove_cpufreq_get_cpu_frequency(0);
> +       freqs.new = dove_freq_table[index].frequency;
> +
> +       cpufreq_notify_transition(policy, &freqs, CPUFREQ_PRECHANGE);
> +
> +       if (freqs.old != freqs.new) {

If this is false, why should we start sending notifications?

> +               local_irq_disable();
> +
> +               /* Mask IRQ and FIQ to CPU */
> +               cr = readl(priv.pmu_cr);
> +               cr |= MASK_IRQ | MASK_FIQ;
> +               writel(cr, priv.pmu_cr);
> +
> +               /* Set/Clear the CPU_SLOW_EN bit */
> +               reg = readl_relaxed(priv.dfs + DFS_CR);
> +               reg &= ~L2_RATIO_MASK;
> +
> +               switch (state) {
> +               case STATE_CPU_FREQ:
> +                       reg |= priv.xpratio;
> +                       reg &= ~CPU_SLOW_EN;
> +                       break;
> +               case STATE_DDR_FREQ:
> +                       reg |= (priv.dpratio | CPU_SLOW_EN);
> +                       break;
> +               }
> +
> +               /* Start the DFS process */
> +               reg |= DFS_EN;
> +
> +               writel(reg, priv.dfs + DFS_CR);
> +
> +               /* Wait-for-Interrupt, while the hardware changes frequency */
> +               cpu_do_idle();
> +
> +               local_irq_enable();
> +       }
> +       cpufreq_notify_transition(policy, &freqs, CPUFREQ_POSTCHANGE);
> +}
> +
> +static int dove_cpufreq_target(struct cpufreq_policy *policy,
> +                           unsigned int target_freq,
> +                           unsigned int relation)

there are few patches floating in making target light weight.. This part will
change significantly ones those are in..

> +{
> +       unsigned int index = 0;
> +
> +       if (cpufreq_frequency_table_target(policy, dove_freq_table,
> +                               target_freq, relation, &index))
> +               return -EINVAL;
> +
> +       dove_cpufreq_set_cpu_state(policy, index);
> +
> +       return 0;
> +}
> +
> +static int dove_cpufreq_cpu_init(struct cpufreq_policy *policy)
> +{
> +       return cpufreq_generic_init(policy, dove_freq_table, 5000);
> +}
> +
> +static irqreturn_t dove_cpufreq_irq(int irq, void *dev)
> +{
> +       return IRQ_HANDLED;
> +}

what is this for?

> +static struct cpufreq_driver dove_cpufreq_driver = {
> +       .get    = dove_cpufreq_get_cpu_frequency,
> +       .verify = cpufreq_generic_frequency_table_verify,
> +       .target = dove_cpufreq_target,
> +       .init   = dove_cpufreq_cpu_init,
> +       .exit   = cpufreq_generic_exit,
> +       .name   = "dove-cpufreq",
> +       .attr   = cpufreq_generic_attr,
> +};
> +
> +static int dove_cpufreq_probe(struct platform_device *pdev)
> +{
> +       struct device_node *np;
> +       struct resource *res;
> +       int err;
> +       int irq;

Above two can be merged.

> +       priv.dev = &pdev->dev;
> +
> +       res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +       priv.dfs = devm_ioremap_resource(&pdev->dev, res);
> +       if (IS_ERR(priv.dfs))
> +               return PTR_ERR(priv.dfs);
> +
> +       res = platform_get_resource(pdev, IORESOURCE_MEM, 1);
> +       priv.pmu_cr = devm_ioremap_resource(&pdev->dev, res);
> +       if (IS_ERR(priv.pmu_cr))
> +               return PTR_ERR(priv.pmu_cr);
> +
> +       res = platform_get_resource(pdev, IORESOURCE_MEM, 2);
> +       priv.pmu_clk_div = devm_ioremap_resource(&pdev->dev, res);
> +       if (IS_ERR(priv.pmu_clk_div))
> +               return PTR_ERR(priv.pmu_clk_div);
> +
> +       np = of_find_node_by_path("/cpus/cpu@0");
> +       if (!np)
> +               return -ENODEV;
> +
> +       priv.cpu_clk = of_clk_get_by_name(np, "cpu_clk");
> +       if (IS_ERR(priv.cpu_clk)) {
> +               dev_err(priv.dev, "Unable to get cpuclk");
> +               return PTR_ERR(priv.cpu_clk);
> +       }
> +
> +       clk_prepare_enable(priv.cpu_clk);

this can fail..

> +       dove_freq_table[0].frequency = clk_get_rate(priv.cpu_clk) / 1000;
> +
> +       priv.ddr_clk = of_clk_get_by_name(np, "ddrclk");
> +       if (IS_ERR(priv.ddr_clk)) {
> +               dev_err(priv.dev, "Unable to get ddrclk");
> +               err = PTR_ERR(priv.ddr_clk);
> +               goto out_cpu;
> +       }
> +
> +       clk_prepare_enable(priv.ddr_clk);

and so can this..
