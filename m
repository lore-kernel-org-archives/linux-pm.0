From: Rob Herring <robherring2@gmail.com>
Subject: Re: [PATCH RFC 1/4] arm64: kernel: implement DT based idle states infrastructure
Date: Tue, 18 Mar 2014 08:27:29 -0500
Message-ID: <CAL_Jsq+M8fCreXrd7R1m=3_LKD_+jma3Pha06hRoTPMpcOb1_g@mail.gmail.com>
References: <1395138028-19630-1-git-send-email-lorenzo.pieralisi@arm.com>
	<1395138028-19630-2-git-send-email-lorenzo.pieralisi@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-vc0-f179.google.com ([209.85.220.179]:59925 "EHLO
	mail-vc0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752139AbaCRN1b (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 18 Mar 2014 09:27:31 -0400
In-Reply-To: <1395138028-19630-2-git-send-email-lorenzo.pieralisi@arm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Mark Rutland <mark.rutland@arm.com>, Sudeep Holla <sudeep.holla@arm.com>, Catalin Marinas <catalin.marinas@arm.com>, Charles Garcia Tobin <Charles.Garcia-Tobin@arm.com>, Nicolas Pitre <nico@linaro.org>, Rob Herring <robh+dt@kernel.org>, Grant Likely <grant.likely@linaro.org>, Peter De Schrijver <pdeschrijver@nvidia.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, Amit Kucheria <amit.kucheria@linaro.org>, Vincent Guittot <vincent.guittot@linaro.org>, Antti Miettinen <ananaza@iki.fi>, Stephen Boyd <sboyd@codeaurora.org>, Kevin Hilman <khilman@linaro.org>, Sebastian Capella <sebastian.capella@linaro.org>, Tomasz Figa <t.figa@samsu>

On Tue, Mar 18, 2014 at 5:20 AM, Lorenzo Pieralisi
<lorenzo.pieralisi@arm.com> wrote:
> On most common ARM systems, the low-power states a CPU can be put into are
> not discoverable in HW and require device tree bindings to describe
> the respective power domains, power down protocol and idle states parameters.
>
> In order to enable DT based idle states and configure idle drivers, this
> patch implements the bulk infrastructure required to parse the device tree
> idle states bindings and functions to initizialize idle driver and protocol
> back-ends.
>
> Protocol back-ends (eg PSCI) must register a protocol initializer with
> the idle state parser so that upon protocol detection, the parsing code
> can call the back-end infrastructure to complete the idle driver
> initialization.
>
> Idle state index 0 is always initialized, ie always considered present
> on all ARM platforms.
>
> Code that initializes idle states checks the CPU idle driver cpumask so
> that multiple CPU idle drivers can be initialized through it in the
> kernel. The CPU idle driver cpumask defines which idle states should be
> considered valid for the driver, ie idle states that are valid on a set
> of cpus the idle driver manages.
>
> Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> ---
>  arch/arm64/Kconfig                   |   4 +
>  arch/arm64/include/asm/idle_states.h |  20 ++
>  arch/arm64/kernel/Makefile           |   1 +
>  arch/arm64/kernel/idle_states.c      | 397 +++++++++++++++++++++++++++++++++++

This all belongs in drivers/cpuidle either as part of your driver or
as library calls the driver can use as it is very obvious it is
dependent on cpuidle.


>  4 files changed, 422 insertions(+)
>  create mode 100644 arch/arm64/include/asm/idle_states.h
>  create mode 100644 arch/arm64/kernel/idle_states.c
>
> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
> index 27bbcfc..3132572 100644
> --- a/arch/arm64/Kconfig
> +++ b/arch/arm64/Kconfig
> @@ -295,6 +295,10 @@ config ARCH_SUSPEND_POSSIBLE
>  config ARM64_CPU_SUSPEND
>         def_bool PM_SLEEP
>
> +config ARM64_IDLE_STATES

Idle states apply to ARM as well, right?

OF_IDLE_STATES?

> +       def_bool CPU_IDLE
> +       select ARM64_CPU_SUSPEND

This should probably get renamed to ARCH_CPU_SUSPEND. There's no need
for different names for arm and arm64.

> +
>  endmenu
>
>  menu "CPU Power Management"
> diff --git a/arch/arm64/include/asm/idle_states.h b/arch/arm64/include/asm/idle_states.h
> new file mode 100644
> index 0000000..0b9f9ba
> --- /dev/null
> +++ b/arch/arm64/include/asm/idle_states.h
> @@ -0,0 +1,20 @@
> +#ifndef __ARM64_IDLE_STATES
> +#define __ARM64_IDLE_STATES
> +
> +struct idle_state {
> +       u32     index;
> +       u32     entry_latency;
> +       u32     exit_latency;
> +       u32     min_residency;
> +       u32     param;
> +       struct device_node *node;
> +       struct idle_state *state;
> +       cpumask_t       cpus;
> +       bool    logic_state_retained;
> +       bool    cache_state_retained;
> +};
> +
> +struct cpuidle_driver;
> +
> +int __init arm_init_idle_driver(struct cpuidle_driver *drv);
> +#endif
> diff --git a/arch/arm64/kernel/Makefile b/arch/arm64/kernel/Makefile
> index 2d4554b..2afc9a0 100644
> --- a/arch/arm64/kernel/Makefile
> +++ b/arch/arm64/kernel/Makefile
> @@ -19,6 +19,7 @@ arm64-obj-$(CONFIG_HW_PERF_EVENTS)    += perf_event.o
>  arm64-obj-$(CONFIG_HAVE_HW_BREAKPOINT)+= hw_breakpoint.o
>  arm64-obj-$(CONFIG_EARLY_PRINTK)       += early_printk.o
>  arm64-obj-$(CONFIG_ARM64_CPU_SUSPEND)  += sleep.o suspend.o
> +arm64-obj-$(CONFIG_ARM64_IDLE_STATES)  += idle_states.o
>  arm64-obj-$(CONFIG_JUMP_LABEL)         += jump_label.o
>
>  obj-y                                  += $(arm64-obj-y) vdso/
> diff --git a/arch/arm64/kernel/idle_states.c b/arch/arm64/kernel/idle_states.c
> new file mode 100644
> index 0000000..0386cff
> --- /dev/null
> +++ b/arch/arm64/kernel/idle_states.c
> @@ -0,0 +1,397 @@
> +/*
> + * ARM device tree idle states parsing code.
> + *
> + * Copyright (C) 2014 ARM Ltd.
> + * Author: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + */
> +
> +#include <linux/cpuidle.h>
> +#include <linux/cpumask.h>
> +#include <linux/cpu_pm.h>
> +#include <linux/errno.h>
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/of.h>
> +
> +#include <asm/idle_states.h>
> +#include <asm/psci.h>
> +#include <asm/suspend.h>
> +
> +static struct idle_state idle_states[CPUIDLE_STATE_MAX] __initdata;
> +typedef int (*idle_states_initializer)(struct cpumask *, struct idle_state *,
> +                                      unsigned int);
> +
> +struct protocol_init {
> +       const char *prot;
> +       idle_states_initializer prot_init;
> +};
> +
> +static const struct protocol_init protocols[] __initconst = {
> +       {}
> +};
> +
> +static __init const struct protocol_init *get_protocol(const char *str)
> +{

This needs a better name or to be removed until you actually need it.
What protocols do you expect to have? This kind of looks like GUFI
trying to do DT vs. ACPI backends.

> +       int i;
> +
> +       if (!str)
> +               return NULL;
> +
> +       for (i = 0; protocols[i].prot; i++)
> +               if (!strcmp(protocols[i].prot, str))
> +                       return &protocols[i];
> +
> +       return NULL;
> +}
> +
> +static void __init idle_state_cpu_mask(int cpu, struct idle_state *idle_state,
> +                                      struct device_node *cn)
> +{
> +       int i = 0;
> +       struct device_node *cpu_state;
> +
> +       do {
> +               cpu_state = of_parse_phandle(cn, "cpu-idle-states", i++);
> +               if (cpu_state && idle_state->node == cpu_state)
> +                       cpumask_set_cpu(cpu, &idle_state->cpus);
> +               of_node_put(cpu_state);
> +       } while (cpu_state);
> +}
> +
> +static int __init parse_idle_states_node(struct device_node *parent, int cnt,
> +                                        const cpumask_t *cpus)
> +{
> +       struct device_node *state;

node or np or state_node so it is clear this is a device_node.

> +       struct idle_state *idle_state;
> +       int cpu;
> +
> +       for_each_child_of_node(parent, state) {
> +
> +               if (!of_device_is_compatible(state, "arm,idle-state")) {
> +                       pr_warn(" %s has child nodes that are not idle states\n",
> +                               parent->full_name);
> +                       continue;
> +               }
> +
> +               idle_state = &idle_states[cnt];
> +
> +               pr_debug(" * %s...\n", state->full_name);
> +
> +               idle_state->node = state;
> +               /*
> +                * Check cpus on which the idle state is valid
> +                */
> +               for_each_possible_cpu(cpu) {
> +                       struct device_node *cn;
> +
> +                       cn = of_get_cpu_node(cpu, NULL);
> +                       if (!cn) {
> +                               pr_err("missing device node for CPU %d\n", cpu);
> +                               continue;
> +                       }
> +                       idle_state_cpu_mask(cpu, idle_state, cn);
> +               }
> +
> +               /*
> +                * The driver cpumask is not a subset of cpus on which the
> +                * idle state is valid, hence the idle state is skipped for
> +                * this driver.
> +                */
> +               if (!cpumask_subset(cpus, &idle_state->cpus))
> +                       continue;
> +
> +               if (of_property_read_u32(state, "index", &idle_state->index)) {
> +                       pr_debug(" * %s missing index property\n",
> +                                    state->full_name);
> +                       continue;
> +               }
> +
> +               if (of_property_read_u32(state, "entry-latency-us",
> +                                        &idle_state->entry_latency)) {
> +                       pr_debug(" * %s missing entry latency property\n",
> +                                    state->full_name);
> +                       continue;
> +               }
> +
> +               if (of_property_read_u32(state, "exit-latency-us",
> +                                        &idle_state->exit_latency)) {
> +                       pr_debug(" * %s missing exit latency property\n",
> +                                    state->full_name);
> +                       continue;
> +               }
> +
> +               if (of_property_read_u32(state, "min-residency-us",
> +                                        &idle_state->min_residency)) {
> +                       pr_debug(" * %s missing min-residency property\n",
> +                                    state->full_name);
> +                       continue;
> +               }
> +
> +               if (of_property_read_u32(state, "entry-method-param",
> +                                        &idle_state->param)) {
> +                       pr_debug(" * %s missing entry-method-param property\n",
> +                                    state->full_name);
> +                       continue;
> +               }
> +
> +               if (++cnt == CPUIDLE_STATE_MAX) {
> +                       pr_warn("Number of parsed states equal static CPU idle state limit\n");
> +                       of_node_put(state);
> +                       break;
> +               }
> +       }
> +
> +       return cnt;
> +}
> +
> +static int __init parse_idle_states(struct device_node *root, int cnt,
> +                                   const cpumask_t *cpus)
> +{
> +       int head_idx, curr_idx;
> +       struct device_node *curr = root;
> +
> +       /*
> +        * Breadth-first DT idle states parsing
> +        *
> +        * Sweep idle states level in the device tree and use the
> +        * idle_states array to stash the visited nodes, as a queue.
> +        *
> +        * parse_idle_states_node() updates the idle_states array by
> +        * initializing entries, stashing the device tree node for the
> +        * corresponding state (struct idle_state.node) and incrementing
> +        * the idle states counter that is returned so that curr_idx is
> +        * kept up-to-date while descending into tree levels.
> +        *
> +        * Store the initial counter head_idx and curr_idx and use head_idx
> +        * as a queue of node indices to be visited.
> +        *
> +        * When we reach the max number of CPU idle states or
> +        * head_idx == curr_idx (empty nodes queue) we are done.
> +        */
> +       head_idx = curr_idx = cnt;
> +
> +       do {
> +               curr_idx = parse_idle_states_node(curr, curr_idx, cpus);
> +               if (curr_idx == CPUIDLE_STATE_MAX || head_idx == curr_idx)
> +                       break;
> +               /*
> +                * idle_states array is updated by parse_idle_states_node(),
> +                * we can use the initialized states as a queue of nodes
> +                * that need to be checked for their idle states siblings.
> +                * head_idx works as a pointer into the queue to get the
> +                * next node to be parsed.
> +                */
> +               curr = idle_states[head_idx++].node;
> +       } while (curr);

I still object to index property and this is why. You need to be able
to determine state order by actual h/w properties. That is what you
are doing in your head when you define the indexes.

You really want a linked list here that you can sort as you go and not
care what order you parse DT nodes. Not to mention you don't know how
many states you will have.

Rob
