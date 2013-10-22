From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH] cpufreq: sirf : Add cpufreq for SiRFprimaII and SiRFatlasVI
Date: Tue, 22 Oct 2013 14:51:48 +0530
Message-ID: <CAKohpok8GvukpTMyscjhn17UbcNSYpEzVMfv4JNg1Us=Gx39cg@mail.gmail.com>
References: <1381030393-10452-1-git-send-email-Baohua.Song@csr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <cpufreq-owner@vger.kernel.org>
In-Reply-To: <1381030393-10452-1-git-send-email-Baohua.Song@csr.com>
Sender: cpufreq-owner@vger.kernel.org
To: Barry Song <21cnbao@gmail.com>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, "cpufreq@vger.kernel.org" <cpufreq@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, workgroup.linux@csr.com, Rongjun Ying <Rongjun.Ying@csr.com>, Barry Song <Baohua.Song@csr.com>
List-Id: linux-pm@vger.kernel.org

On 6 October 2013 09:03, Barry Song <21cnbao@gmail.com> wrote:
> From: Rongjun Ying <Rongjun.Ying@csr.com>
>
> This patch adds support cpufreq for CSR SiRFprimaII and SiRFatlasVI unicore
> ARM Cortex-A9 SoCs.
>
> Signed-off-by: Rongjun Ying <Rongjun.Ying@csr.com>
> Signed-off-by: Barry Song <Baohua.Song@csr.com>
> ---
>  arch/arm/boot/dts/atlas6.dtsi     |   8 ++
>  arch/arm/boot/dts/prima2.dtsi     |   8 ++
>  arch/arm/configs/prima2_defconfig |   1 +
>  arch/arm/mach-prima2/Kconfig      |   1 +
>  drivers/cpufreq/Kconfig.arm       |  11 +++
>  drivers/cpufreq/Makefile          |   1 +
>  drivers/cpufreq/sirf-cpufreq.c    | 197 ++++++++++++++++++++++++++++++++++++++
>  7 files changed, 227 insertions(+)
>  create mode 100644 drivers/cpufreq/sirf-cpufreq.c

Shouldn't this be broken into several patches?
- One for drivers/cpufreq
- dts and mach
- defconfig

> diff --git a/drivers/cpufreq/Kconfig.arm b/drivers/cpufreq/Kconfig.arm
> index 0fa204b..4cfbb18 100644
> --- a/drivers/cpufreq/Kconfig.arm
> +++ b/drivers/cpufreq/Kconfig.arm
> @@ -220,6 +220,17 @@ config ARM_SA1100_CPUFREQ
>  config ARM_SA1110_CPUFREQ
>         bool
>
> +config ARM_SIRF_CPUFREQ
> +       bool "CSR SiRFprimaII and SiRFatlasVI"
> +       depends on ARCH_SIRF
> +       select CPU_FREQ_TABLE

Refer:
3bc28ab cpufreq: remove CONFIG_CPU_FREQ_TABLE

> +       default y
> +       help
> +         This adds the CPUFreq driver for CSR SiRFprimaII and
> +         SiRFatlasVI SoCs.
> +
> +         If in doubt, say N.

> diff --git a/drivers/cpufreq/sirf-cpufreq.c b/drivers/cpufreq/sirf-cpufreq.c

> +#include <linux/module.h>
> +#include <linux/err.h>
> +#include <linux/clk.h>
> +#include <linux/regulator/consumer.h>
> +#include <linux/cpufreq.h>
> +#include <linux/of.h>
> +#include <linux/slab.h>
> +#include <linux/cpu.h>
> +#include <linux/opp.h>

Can you please add them in ascending order?

> +#define SIRFSOC_MAX_VOLTAGE    1200000
> +
> +static struct {
> +       struct clk                      *cpu_clk;
> +       struct device                   *cpu_dev;
> +       struct cpufreq_freqs            freqs;
> +       struct cpufreq_frequency_table  *freq_tbl;
> +       unsigned int                    transition_latency;
> +       struct regulator                *regulator;
> +} sirf_cpufreq;
> +
> +static void update_voltage(int min_uV, int max_uV)
> +{
> +       if (sirf_cpufreq.regulator == NULL)

maybe
if (sirf_cpufreq.regulator)
    regulator_set_voltage(sirf_cpufreq.regulator, min_uV, max_uV);

> +               return;
> +
> +       regulator_set_voltage(sirf_cpufreq.regulator, min_uV, max_uV);
> +}
> +
> +static int sirf_verify_speed(struct cpufreq_policy *policy)
> +{
> +       if (sirf_cpufreq.freq_tbl)

Why will this be null ever?

> +               return cpufreq_frequency_table_verify(policy,
> +                       sirf_cpufreq.freq_tbl);
> +       return 0;
> +}
> +
> +static unsigned int sirf_getspeed(unsigned int cpu)
> +{
> +       return clk_get_rate(sirf_cpufreq.cpu_clk) / 1000;
> +}

There are many optimizations added in cpufreq linux-next branch..
please follow them for latest updates.

> +static int sirf_target(struct cpufreq_policy *policy,
> +                         unsigned int target_freq,
> +                         unsigned int relation)

With another patchset (to be applied very soon), this prototype
will change. Probably you better target your driver for 3.14.. There
are too many updates for 3.13..

> +{
> +       unsigned long freq, volt = 0;
> +       struct opp *opp;
> +       unsigned int index, old_index;
> +
> +       if (!sirf_cpufreq.freq_tbl)

??

> +               return -EINVAL;
> +
> +       sirf_cpufreq.freqs.old = sirf_getspeed(policy->cpu);

what about policy->cur?

> +
> +       if (cpufreq_frequency_table_target(policy, sirf_cpufreq.freq_tbl,
> +                                       sirf_cpufreq.freqs.old,
> +                                       relation, &old_index))
> +               return -EINVAL;
> +
> +       if (cpufreq_frequency_table_target(policy, sirf_cpufreq.freq_tbl,
> +                                          target_freq, relation, &index))
> +               return -EINVAL;
> +
> +       sirf_cpufreq.freqs.new = sirf_cpufreq.freq_tbl[index].frequency;
> +       sirf_cpufreq.freqs.cpu = policy->cpu;
> +
> +       if (sirf_cpufreq.freqs.new == sirf_cpufreq.freqs.old)
> +               return 0;

All this is highly simplified in latest linux-next..

Any particular reason why you aren't reusing cpufreq-cpu0 ?? I can't
see any special stuff in this driver, that can't be handled by cpu0..
