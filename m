From: Vincent Guittot <vincent.guittot@linaro.org>
Subject: Re: [RFC PATCH v4 03/12] PM: Introduce an Energy Model management framework
Date: Fri, 6 Jul 2018 11:57:37 +0200
Message-ID: <CAKfTPtCxt-O8uMOYgAjY7daujXwXyZQ-3BYe=DONL7R95T7nmQ@mail.gmail.com>
References: <20180628114043.24724-1-quentin.perret@arm.com> <20180628114043.24724-4-quentin.perret@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180628114043.24724-4-quentin.perret@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Quentin Perret <quentin.perret@arm.com>
Cc: Peter Zijlstra <peterz@infradead.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-kernel <linux-kernel@vger.kernel.org>, "open list:THERMAL" <linux-pm@vger.kernel.org>, "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>, Ingo Molnar <mingo@redhat.com>, Dietmar Eggemann <dietmar.eggemann@arm.com>, Morten Rasmussen <morten.rasmussen@arm.com>, Chris Redpath <chris.redpath@arm.com>, Patrick Bellasi <patrick.bellasi@arm.com>, Valentin Schneider <valentin.schneider@arm.com>, Thara Gopinath <thara.gopinath@linaro.org>, viresh kumar <viresh.kumar@linaro.org>, Todd Kjos <tkjos@google.com>, Joel Fernandes <joel@joelfernandes.org>, "Cc: Steve Muckle" <smuckle@google.com>, adharmap@quicinc.com, "Kannan, Saravana" <skannan@quicinc.com>, pkondeti@codeaurora.org
List-Id: linux-pm@vger.kernel.org

On Thu, 28 Jun 2018 at 13:41, Quentin Perret <quentin.perret@arm.com> wrote:
>
> Several subsystems in the kernel (task scheduler and/or thermal at the
> time of writing) can benefit from knowing about the energy consumed by
> CPUs. Yet, this information can come from different sources (DT or
> firmware for example), in different formats, hence making it hard to
> exploit without a standard API.
>
> As an attempt to address this, introduce a centralized Energy Model
> (EM) management framework which aggregates the power values provided
> by drivers into a table for each frequency domain in the system. The
> power cost tables are made available to interested clients (e.g. task
> scheduler or thermal) via platform-agnostic APIs. The overall design
> is represented by the diagram below (focused on Arm-related drivers as
> an example, but hopefully applicable to any architecture):
>
>      +---------------+  +-----------------+  +---------+
>      | Thermal (IPA) |  | Scheduler (EAS) |  | Other ? |
>      +---------------+  +-----------------+  +---------+
>              |                 | em_fd_energy()   |
>              |                 | em_cpu_get()     |
>              +-----------+     |         +--------+
>                          |     |         |
>                          v     v         v
>                       +---------------------+
>                       |                     |         +---------------+
>                       |    Energy Model     |         | arch_topology |
>                       |                     |<--------|    driver     |
>                       |     Framework       |         +---------------+
>                       |                     | em_rescale_cpu_capacity()
>                       +---------------------+
>                          ^       ^       ^
>                          |       |       | em_register_freq_domain()
>               +----------+       |       +---------+
>               |                  |                 |
>       +---------------+  +---------------+  +--------------+
>       |  cpufreq-dt   |  |   arm_scmi    |  |    Other     |
>       +---------------+  +---------------+  +--------------+
>               ^                  ^                 ^
>               |                  |                 |
>       +--------------+   +---------------+  +--------------+
>       | Device Tree  |   |   Firmware    |  |      ?       |
>       +--------------+   +---------------+  +--------------+
>
> Drivers (typically, but not limited to, CPUFreq drivers) can register
> data in the EM framework using the em_register_freq_domain() API. The
> calling driver must provide a callback function with a standardized
> signature that will be used by the EM framework to build the power
> cost tables of the frequency domain. This design should offer a lot of
> flexibility to calling drivers which are free of reading information
> from any location and to use any technique to compute power costs.
> Moreover, the capacity states registered by drivers in the EM framework
> are not required to match real performance states of the target. This
> is particularly important on targets where the performance states are
> not known by the OS.
>
> On the client side, the EM framework offers APIs to access the power
> cost tables of a CPU (em_cpu_get()), and to estimate the energy
> consumed by the CPUs of a frequency domain (em_fd_energy()). Clients
> such as the task scheduler can then use these APIs to access the shared
> data structures holding the Energy Model of CPUs.
>
> The EM framework also provides an API (em_rescale_cpu_capacity()) to
> re-scale the capacity values of the model asynchronously, after it has
> been created. This is required for architectures where the capacity
> scale factor of CPUs can change at run-time. This is the case for
> Arm/Arm64 for example where the arch_topology driver recomputes the
> capacity scale factors of the CPUs after the maximum frequency of all
> CPUs has been discovered. Although complex, the process of creating and
> re-scaling the EM has to be kept in two separate steps to fulfill the
> needs of the different users. The thermal subsystem doesn't use the
> capacity values and shouldn't have dependencies on subsystems providing
> them. On the other hand, the task scheduler needs the capacity values,
> and it will benefit from seeing them up-to-date when applicable.
>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
> Signed-off-by: Quentin Perret <quentin.perret@arm.com>
> ---
>  include/linux/energy_model.h | 140 ++++++++++++++++++
>  kernel/power/Kconfig         |  15 ++
>  kernel/power/Makefile        |   2 +
>  kernel/power/energy_model.c  | 273 +++++++++++++++++++++++++++++++++++
>  4 files changed, 430 insertions(+)
>  create mode 100644 include/linux/energy_model.h
>  create mode 100644 kernel/power/energy_model.c
>
> diff --git a/include/linux/energy_model.h b/include/linux/energy_model.h
> new file mode 100644
> index 000000000000..88c2f0b9bcb3
> --- /dev/null
> +++ b/include/linux/energy_model.h
> @@ -0,0 +1,140 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +#ifndef _LINUX_ENERGY_MODEL_H
> +#define _LINUX_ENERGY_MODEL_H
> +#include <linux/cpumask.h>
> +#include <linux/jump_label.h>
> +#include <linux/kobject.h>
> +#include <linux/rcupdate.h>
> +#include <linux/sched/cpufreq.h>
> +#include <linux/types.h>
> +
> +#ifdef CONFIG_ENERGY_MODEL
> +struct em_cap_state {
> +       unsigned long capacity;
> +       unsigned long frequency; /* Kilo-hertz */
> +       unsigned long power; /* Milli-watts */
> +};
> +
> +struct em_cs_table {
> +       struct em_cap_state *state; /* Capacity states, in ascending order. */
> +       int nr_cap_states;
> +       struct rcu_head rcu;
> +};
> +
> +struct em_freq_domain {
> +       struct em_cs_table *cs_table; /* Capacity state table, RCU-protected */
> +       unsigned long cpus[0]; /* CPUs of the frequency domain. */
> +};
> +
> +#define EM_CPU_MAX_POWER 0xFFFF
> +
> +struct em_data_callback {
> +       /**
> +        * active_power() - Provide power at the next capacity state of a CPU
> +        * @power       : Active power at the capacity state in mW (modified)
> +        * @freq        : Frequency at the capacity state in kHz (modified)
> +        * @cpu         : CPU for which we do this operation
> +        *
> +        * active_power() must find the lowest capacity state of 'cpu' above
> +        * 'freq' and update 'power' and 'freq' to the matching active power
> +        * and frequency.
> +        *
> +        * The power is the one of a single CPU in the domain, expressed in
> +        * milli-watts. It is expected to fit in the [0, EM_CPU_MAX_POWER]
> +        * range.
> +        *
> +        * Return 0 on success.
> +        */
> +       int (*active_power) (unsigned long *power, unsigned long *freq, int cpu);
> +};
> +#define EM_DATA_CB(_active_power_cb) { .active_power = &_active_power_cb }
> +
> +void em_rescale_cpu_capacity(void);
> +struct em_freq_domain *em_cpu_get(int cpu);
> +int em_register_freq_domain(cpumask_t *span, unsigned int nr_states,
> +                                               struct em_data_callback *cb);
> +
> +/**
> + * em_fd_energy() - Estimates the energy consumed by the CPUs of a freq. domain
> + * @fd         : frequency domain for which energy has to be estimated
> + * @max_util   : highest utilization among CPUs of the domain
> + * @sum_util   : sum of the utilization of all CPUs in the domain
> + *
> + * em_fd_energy() dereferences the capacity state table of the frequency
> + * domain, so it must be called under RCU read lock.
> + *
> + * Return: the sum of the energy consumed by the CPUs of the domain assuming
> + * a capacity state satisfying the max utilization of the domain.
> + */
> +static inline unsigned long em_fd_energy(struct em_freq_domain *fd,
> +                               unsigned long max_util, unsigned long sum_util)
> +{
> +       struct em_cs_table *cs_table;
> +       struct em_cap_state *cs;
> +       unsigned long freq;
> +       int i;
> +
> +       cs_table = rcu_dereference(fd->cs_table);
> +       if (!cs_table)
> +               return 0;
> +
> +       /* Map the utilization value to a frequency */
> +       cs = &cs_table->state[cs_table->nr_cap_states - 1];
> +       freq = map_util_freq(max_util, cs->frequency, cs->capacity);

The 2 lines above deserve more explanation:
1st, you get the max capacity of the freq domain
Then, you estimate what will be the selected frequency according to
the max_utilization.
Might worth to mention that we must keep sync how sched_util and EM
select a freq for a given capacity which is the reason of patch 02

> +
> +       /* Find the lowest capacity state above this frequency */
> +       for (i = 0; i < cs_table->nr_cap_states; i++) {
> +               cs = &cs_table->state[i];
> +               if (cs->frequency >= freq)
> +                       break;
> +       }
> +
> +       return cs->power * sum_util / cs->capacity;

IIUC the formula above, you consider that all CPUs in a frequency
domain has the same capacity. This sounds a reasonable assumption but
it would be good to write that somewhere

> +}
> +
