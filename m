From: Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH v5 3/8] drivers: cpuidle: implement DT based idle states
 infrastructure
Date: Wed, 25 Jun 2014 16:59:49 +0100
Message-ID: <20140625155949.GF15240@leverpostej>
References: <1403705421-17597-1-git-send-email-lorenzo.pieralisi@arm.com>
 <1403705421-17597-4-git-send-email-lorenzo.pieralisi@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from cam-admin0.cambridge.arm.com ([217.140.96.50]:41869 "EHLO
	cam-admin0.cambridge.arm.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757465AbaFYP7y (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 25 Jun 2014 11:59:54 -0400
Content-Disposition: inline
In-Reply-To: <1403705421-17597-4-git-send-email-lorenzo.pieralisi@arm.com>
Content-Language: en-US
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>
Cc: "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Sudeep Holla <Sudeep.Holla@arm.com>, Catalin Marinas <Catalin.Marinas@arm.com>, Charles Garcia-Tobin <Charles.Garcia-Tobin@arm.com>, Nicolas Pitre <nico@linaro.org>, Rob Herring <robh+dt@kernel.org>, "grant.likely@linaro.org" <grant.likely@linaro.org>, Peter De Schrijver <pdeschrijver@nvidia.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, Amit Kucheria <amit.kucheria@linaro.org>, Vincent Guittot <vincent.guittot@linaro.org>, Antti Miettinen <ananaza@iki.fi>, Stephen Boyd <sboyd@codeaurora.org>, Kevin Hilman <khilman@linaro.org>, Sebastian Capella <sebcape@gmail.com>, Tomasz Figa <t.figa@samsung.com>, Mark Brown <broonie@kernel>

On Wed, Jun 25, 2014 at 03:10:16PM +0100, Lorenzo Pieralisi wrote:
> On most common ARM systems, the low-power states a CPU can be put into are
> not discoverable in HW and require device tree bindings to describe
> power down suspend operations and idle states parameters.
> 
> In order to enable DT based idle states and configure idle drivers, this
> patch implements the bulk infrastructure required to parse the device tree
> idle states bindings and initialize the corresponding CPUidle driver states
> data.
> 
> Code that initializes idle states checks the CPU idle driver cpumask so
> that multiple CPU idle drivers can be initialized through it in the
> kernel. The CPU idle driver cpumask defines which idle states should be
> considered valid for the driver, ie idle states that are valid on a set
> of cpus the idle driver manages.
> 
> Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> ---
>  drivers/cpuidle/Kconfig          |   8 ++
>  drivers/cpuidle/Makefile         |   1 +
>  drivers/cpuidle/dt_idle_states.c | 283 +++++++++++++++++++++++++++++++++++++++
>  drivers/cpuidle/dt_idle_states.h |   8 ++
>  4 files changed, 300 insertions(+)
>  create mode 100644 drivers/cpuidle/dt_idle_states.c
>  create mode 100644 drivers/cpuidle/dt_idle_states.h
> 
> diff --git a/drivers/cpuidle/Kconfig b/drivers/cpuidle/Kconfig
> index 1b96fb9..414e7a96 100644
> --- a/drivers/cpuidle/Kconfig
> +++ b/drivers/cpuidle/Kconfig
> @@ -30,6 +30,14 @@ config CPU_IDLE_GOV_MENU
>  	bool "Menu governor (for tickless system)"
>  	default y
>  
> +config DT_IDLE_STATES
> +        bool "Idle states DT support"
> +	depends on ARM || ARM64
> +	help
> +	 Allows the CPU idle framework to initialize CPU idle drivers
> +	 state data by using DT provided nodes compliant with idle states
> +	 device tree bindings.
> +
>  menu "ARM CPU Idle Drivers"
>  depends on ARM
>  source "drivers/cpuidle/Kconfig.arm"
> diff --git a/drivers/cpuidle/Makefile b/drivers/cpuidle/Makefile
> index d8bb1ff..b27a062 100644
> --- a/drivers/cpuidle/Makefile
> +++ b/drivers/cpuidle/Makefile
> @@ -4,6 +4,7 @@
>  
>  obj-y += cpuidle.o driver.o governor.o sysfs.o governors/
>  obj-$(CONFIG_ARCH_NEEDS_CPU_IDLE_COUPLED) += coupled.o
> +obj-$(CONFIG_DT_IDLE_STATES)		  += dt_idle_states.o
>  
>  ##################################################################################
>  # ARM SoC drivers
> diff --git a/drivers/cpuidle/dt_idle_states.c b/drivers/cpuidle/dt_idle_states.c
> new file mode 100644
> index 0000000..5c16001c
> --- /dev/null
> +++ b/drivers/cpuidle/dt_idle_states.c
> @@ -0,0 +1,283 @@
> +/*
> + * DT idle states parsing code.
> + *
> + * Copyright (C) 2014 ARM Ltd.
> + * Author: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + */
> +
> +#define pr_fmt(fmt) "DT idle-states: " fmt
> +
> +#include <linux/cpuidle.h>
> +#include <linux/cpumask.h>
> +#include <linux/errno.h>
> +#include <linux/kernel.h>
> +#include <linux/list.h>
> +#include <linux/list_sort.h>
> +#include <linux/module.h>
> +#include <linux/of.h>
> +#include <linux/slab.h>
> +
> +#include "dt_idle_states.h"
> +
> +struct state_elem {
> +	struct list_head list;
> +	struct device_node *node;
> +	u32 val;
> +};

Ah. So the fixed-size entry parameter requirement is because this code
is in charge of allocating and freeing these structs?

> +
> +static struct list_head head __initdata = LIST_HEAD_INIT(head);
> +
> +static bool __init state_cpu_valid(struct device_node *state_node,
> +				   struct device_node *cpu_node)
> +{
> +	int i = 0;
> +	struct device_node *cpu_state;
> +
> +	while ((cpu_state = of_parse_phandle(cpu_node,
> +					     "cpu-idle-states", i++))) {
> +		if (cpu_state && state_node == cpu_state) {

You can drop the cpu_state NULL check, it's implicit in the while loop.

> +			of_node_put(cpu_state);
> +			return true;
> +		}
> +		of_node_put(cpu_state);
> +	}
> +	return false;
> +}

Is it possible to use a bool ret variable to avoid the two of_node_put
cases? Or does that end up making this larger?

> +static bool __init state_cpus_valid(const cpumask_t *cpus,
> +				    struct device_node *state_node)
> +{
> +	int cpu;
> +	struct device_node *cpu_node;
> +
> +	/*
> +	 * Check if state is valid on driver cpumask cpus
> +	 */
> +	for_each_cpu(cpu, cpus) {
> +		cpu_node = of_get_cpu_node(cpu, NULL);
> +
> +		if (!cpu_node) {
> +			pr_err("Missing device node for CPU %d\n", cpu);
> +			return false;
> +		}
> +
> +		if (!state_cpu_valid(state_node, cpu_node))
> +			return false;
> +	}
> +
> +	return true;
> +}

Doesn't this leave all the cpu node refcounts incremented? (it's painful
to get device node refcounting right, I know).

I think you can use the similarly named of_cpu_device_node_get to find
the CPU node. It uses the pointer stored in cpu->dev.of_node, so it
doesn't have to walk the tree to find the CPU node. It also doesn't
increment the refcount.

Unless this is too early for that?

> +static void __init init_state_node(struct cpuidle_driver *drv,
> +				   struct device_node *state_node,
> +				   int *cnt)
> +{
> +	struct cpuidle_state *idle_state;
> +
> +	pr_debug(" * %s...\n", state_node->full_name);
> +
> +	idle_state = &drv->states[*cnt];
> +
> +	if (of_property_read_u32(state_node, "wakeup-latency-us",
> +				 &idle_state->exit_latency)) {

I'm not a fan of this construction, as the obvious reading is that we
take the branch if we succeeded (which obviously isn't true as
of_property_read_* return error codes). 

Could we change it to something like:

	err = of_property_read_u32(state_node, "wakeup-latency-us",
				   &idle_state->exit_latency);
	if (err) {

> +		u32 entry_latency, exit_latency;
> +
> +		if (of_property_read_u32(state_node, "entry-latency-us",
> +					 &entry_latency)) {
> +			pr_debug(" * %s missing entry-latency-us property\n",
> +				 state_node->full_name);
> +			return;
> +		}

Returning without error code? Do the fields have sane default values?

Or is this safe because we didn't increment cnt?

> +
> +		if (of_property_read_u32(state_node, "exit-latency-us",
> +					 &exit_latency)) {
> +			pr_debug(" * %s missing exit-latency-us property\n",
> +				 state_node->full_name);
> +			return;
> +		}
> +		/*
> +		 * If wakeup-latency-us is missing, default to entry+exit
> +		 * latencies as defined in idle states bindings
> +		 */
> +		idle_state->exit_latency = entry_latency + exit_latency;
> +	}
> +
> +	if (of_property_read_u32(state_node, "min-residency-us",
> +				 &idle_state->target_residency)) {
> +		pr_debug(" * %s missing min-residency-us property\n",
> +			     state_node->full_name);
> +		return;
> +	}
> +
> +	idle_state->flags = CPUIDLE_FLAG_TIME_VALID;
> +	if (!of_property_read_bool(state_node, "timer-state-retained"))
> +		idle_state->flags |= CPUIDLE_FLAG_TIMER_STOP;
> + 	strncpy(idle_state->name, state_node->name, CPUIDLE_NAME_LEN);
> +	strncpy(idle_state->desc, state_node->name, CPUIDLE_NAME_LEN);

Does the name make sense as a desc? Is a desc necessary?

CPUIDLE_DESC_LEN seems to exist, and is double CPUIDLE_NAME_LEN.

> +static void __init add_idle_states(struct cpuidle_driver *drv,
> +				   struct device_node *idle_states)
> +{
> +	struct device_node *state_node;
> +
> +	for_each_child_of_node(idle_states, state_node) {
> +		if ((!of_device_is_compatible(state_node, "arm,idle-state"))) {

Holy brackets batman! I think we can drop the outer ones given there's
no assignment we want to supress warnings for.

> +			pr_warn(" * %s: children of /cpus/idle-states must be \"arm,idle-state\" compatible\n",
> +				     state_node->full_name);

Presumably the entire reason for having the compatible string is for
future extensibility.

It would probably be better to have something like:

	pr_warn("Node %s has unrecognised/missing compatible string\n",
		state_node->full_name);

> +			continue;
> +		}
> +		/*
> +		 * If memory allocation fails, better bail out.
> +		 * Initialized nodes are freed at initialization
> +		 * completion in of_init_idle_driver().
> +		 */
> +		if ((add_state_node(drv->cpumask, state_node) == -ENOMEM))
> +			break;

Can we not return? Or is the list sort important in the error case too?

> +	}
> +	/*
> +	 * Sort the states list before initializing the CPUidle driver
> +	 * states array.
> +	 */
> +	list_sort(NULL, &head, state_cmp);
> +}
> +
> +/**
> + * dt_init_idle_driver() - Parse the DT idle states and initialize the
> + *			   idle driver states array
> + *
> + * @drv:	  Pointer to CPU idle driver to be initialized
> + * @state_nodes:  Array of struct device_nodes to be initialized if
> + *		  init_nodes == true. Must be sized CPUIDLE_STATE_MAX
> + * @start_idx:    First idle state index to be initialized
> + * @init_nodes:   Boolean to request device nodes initialization
> + *
> + * On success the states array in the cpuidle driver contains
> + * initialized entries in the states array, starting from index start_idx.
> + * If init_nodes == true, on success the state_nodes array is initialized
> + * with idle state DT node pointers, starting from index start_idx,
> + * in a 1:1 relation with the idle driver states array.
> + *
> + * Return:
> + *	0 on success
> + *	<0 on failure
> + */
> +int __init dt_init_idle_driver(struct cpuidle_driver *drv,
> +			       struct device_node *state_nodes[],
> +			       unsigned int start_idx, bool init_nodes)
> +{
> +	struct device_node *idle_states_node;
> +	int ret;
> +
> +	if (start_idx >= CPUIDLE_STATE_MAX) {
> +		pr_warn("State index exceeds static CPU idle driver states array size\n");
> +		return -EINVAL;
> +	}
> +
> +	if (WARN(init_nodes && !state_nodes,
> +		"Requested nodes stashing in an invalid nodes container\n"))
> +		return -EINVAL;

That warning message is somewhat confusing, and I'm not sure I
follow the logic.

Thanks,
Mark
