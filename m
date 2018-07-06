From: Vincent Guittot <vincent.guittot@linaro.org>
Subject: Re: [RFC PATCH v4 12/12] OPTIONAL: cpufreq: dt: Register an Energy Model
Date: Fri, 6 Jul 2018 12:10:02 +0200
Message-ID: <CAKfTPtAANKzw7QTzKiU_ntiGYMxZD3etd8wMzXtngwUWHXj+Hg@mail.gmail.com>
References: <20180628114043.24724-1-quentin.perret@arm.com> <20180628114043.24724-13-quentin.perret@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180628114043.24724-13-quentin.perret@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Quentin Perret <quentin.perret@arm.com>
Cc: Peter Zijlstra <peterz@infradead.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-kernel <linux-kernel@vger.kernel.org>, "open list:THERMAL" <linux-pm@vger.kernel.org>, "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>, Ingo Molnar <mingo@redhat.com>, Dietmar Eggemann <dietmar.eggemann@arm.com>, Morten Rasmussen <morten.rasmussen@arm.com>, Chris Redpath <chris.redpath@arm.com>, Patrick Bellasi <patrick.bellasi@arm.com>, Valentin Schneider <valentin.schneider@arm.com>, Thara Gopinath <thara.gopinath@linaro.org>, viresh kumar <viresh.kumar@linaro.org>, Todd Kjos <tkjos@google.com>, Joel Fernandes <joel@joelfernandes.org>, "Cc: Steve Muckle" <smuckle@google.com>, adharmap@quicinc.com, "Kannan, Saravana" <skannan@quicinc.com>, pkondeti@codeaurora.org
List-Id: linux-pm@vger.kernel.org

On Thu, 28 Jun 2018 at 13:41, Quentin Perret <quentin.perret@arm.com> wrote:
>
> *******************************************************************
> * This patch illustrates the usage of the newly introduced Energy *
> * Model framework and isn't supposed to be merged as-is.          *
> *******************************************************************
>
> The Energy Model framework provides an API to register the active power
> of CPUs. Call this API from the cpufreq-dt driver with an estimation
> of the power as P = C * V^2 * f with C, V, and f respectively the
> capacitance of the CPU and the voltage and frequency of the OPP.
>
> The CPU capacitance is read from the "dynamic-power-coefficient" DT
> binding (originally introduced for thermal/IPA), and the voltage and
> frequency values from PM_OPP.
>
> Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
> Cc: Viresh Kumar <viresh.kumar@linaro.org>
> Signed-off-by: Quentin Perret <quentin.perret@arm.com>
> ---
>  drivers/cpufreq/cpufreq-dt.c | 45 +++++++++++++++++++++++++++++++++++-
>  1 file changed, 44 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/cpufreq/cpufreq-dt.c b/drivers/cpufreq/cpufreq-dt.c
> index 190ea0dccb79..5a0747f73121 100644
> --- a/drivers/cpufreq/cpufreq-dt.c
> +++ b/drivers/cpufreq/cpufreq-dt.c
> @@ -16,6 +16,7 @@
>  #include <linux/cpu_cooling.h>
>  #include <linux/cpufreq.h>
>  #include <linux/cpumask.h>
> +#include <linux/energy_model.h>
>  #include <linux/err.h>
>  #include <linux/module.h>
>  #include <linux/of.h>
> @@ -149,8 +150,47 @@ static int resources_available(void)
>         return 0;
>  }
>
> +static int of_est_power(unsigned long *mW, unsigned long *KHz, int cpu)
> +{
> +       unsigned long mV, Hz, MHz;
> +       struct device *cpu_dev;
> +       struct dev_pm_opp *opp;
> +       struct device_node *np;
> +       u32 cap;
> +       u64 tmp;
> +
> +       cpu_dev = get_cpu_device(cpu);
> +       if (!cpu_dev)
> +               return -ENODEV;
> +
> +       np = of_node_get(cpu_dev->of_node);
> +       if (!np)
> +               return -EINVAL;
> +
> +       if (of_property_read_u32(np, "dynamic-power-coefficient", &cap))
> +               return -EINVAL;
> +
> +       Hz = *KHz * 1000;
> +       opp = dev_pm_opp_find_freq_ceil(cpu_dev, &Hz);
> +       if (IS_ERR(opp))
> +               return -EINVAL;
> +
> +       mV = dev_pm_opp_get_voltage(opp) / 1000;
> +       dev_pm_opp_put(opp);
> +
> +       MHz = Hz / 1000000;
> +       tmp = (u64)cap * mV * mV * MHz;
> +       do_div(tmp, 1000000000);

Could you explain the formula above ? and especially the 1000000000 it
seems related to the use of mV and mW instead of uV and uW ...

Can't you just optimize that into
tmp = (u64)cap * mV * mV * Hz;
do_div(tmp, 1000);

> +
> +       *mW = (unsigned long)tmp;
> +       *KHz = Hz / 1000;
> +
> +       return 0;
> +}
> +
>  static int cpufreq_init(struct cpufreq_policy *policy)
>  {
> +       struct em_data_callback em_cb = EM_DATA_CB(of_est_power);
>         struct cpufreq_frequency_table *freq_table;
>         struct opp_table *opp_table = NULL;
>         struct private_data *priv;
> @@ -159,7 +199,7 @@ static int cpufreq_init(struct cpufreq_policy *policy)
>         unsigned int transition_latency;
>         bool fallback = false;
>         const char *name;
> -       int ret;
> +       int ret, nr_opp;
>
>         cpu_dev = get_cpu_device(policy->cpu);
>         if (!cpu_dev) {
> @@ -226,6 +266,7 @@ static int cpufreq_init(struct cpufreq_policy *policy)
>                 ret = -EPROBE_DEFER;
>                 goto out_free_opp;
>         }
> +       nr_opp = ret;
>
>         if (fallback) {
>                 cpumask_setall(policy->cpus);
> @@ -278,6 +319,8 @@ static int cpufreq_init(struct cpufreq_policy *policy)
>         policy->cpuinfo.transition_latency = transition_latency;
>         policy->dvfs_possible_from_any_cpu = true;
>
> +       em_register_freq_domain(policy->cpus, nr_opp, &em_cb);
> +
>         return 0;
>
>  out_free_cpufreq_table:
> --
> 2.17.1
>
