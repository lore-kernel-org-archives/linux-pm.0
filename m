From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Subject: Re: [PATCH v5 3/8] drivers: cpuidle: implement DT based idle states
 infrastructure
Date: Thu, 26 Jun 2014 17:01:35 +0100
Message-ID: <20140626160135.GC27364@e102568-lin.cambridge.arm.com>
References: <1403705421-17597-1-git-send-email-lorenzo.pieralisi@arm.com>
 <1403705421-17597-4-git-send-email-lorenzo.pieralisi@arm.com>
 <20140625155949.GF15240@leverpostej>
Mime-Version: 1.0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: 8BIT
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from service87.mimecast.com ([91.220.42.44]:58971 "EHLO
	service87.mimecast.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754076AbaFZQBm convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 26 Jun 2014 12:01:42 -0400
In-Reply-To: <20140625155949.GF15240@leverpostej>
Content-Disposition: inline
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Mark Rutland <mark.rutland@arm.com>
Cc: "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Sudeep Holla <Sudeep.Holla@arm.com>, Catalin Marinas <Catalin.Marinas@arm.com>, Charles Garcia-Tobin <Charles.Garcia-Tobin@arm.com>, Nicolas Pitre <nico@linaro.org>, Rob Herring <robh+dt@kernel.org>, "grant.likely@linaro.org" <grant.likely@linaro.org>, Peter De Schrijver <pdeschrijver@nvidia.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, Amit Kucheria <amit.kucheria@linaro.org>, Vincent Guittot <vincent.guittot@linaro.org>, Antti Miettinen <ananaza@iki.fi>, Stephen Boyd <sboyd@codeaurora.org>, Kevin Hilman <khilman@linaro.org>, Sebastian Capella <sebcape@gmail.com>, Tomasz Figa <t.figa@samsung.com>, Mark Brown <broonie@kernel>

On Wed, Jun 25, 2014 at 04:59:49PM +0100, Mark Rutland wrote:
> On Wed, Jun 25, 2014 at 03:10:16PM +0100, Lorenzo Pieralisi wrote:

[...]

> > diff --git a/drivers/cpuidle/dt_idle_states.c b/drivers/cpuidle/dt_idle_states.c
> > new file mode 100644
> > index 0000000..5c16001c
> > --- /dev/null
> > +++ b/drivers/cpuidle/dt_idle_states.c
> > @@ -0,0 +1,283 @@
> > +/*
> > + * DT idle states parsing code.
> > + *
> > + * Copyright (C) 2014 ARM Ltd.
> > + * Author: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> > + *
> > + * This program is free software; you can redistribute it and/or modify
> > + * it under the terms of the GNU General Public License version 2 as
> > + * published by the Free Software Foundation.
> > + */
> > +
> > +#define pr_fmt(fmt) "DT idle-states: " fmt
> > +
> > +#include <linux/cpuidle.h>
> > +#include <linux/cpumask.h>
> > +#include <linux/errno.h>
> > +#include <linux/kernel.h>
> > +#include <linux/list.h>
> > +#include <linux/list_sort.h>
> > +#include <linux/module.h>
> > +#include <linux/of.h>
> > +#include <linux/slab.h>
> > +
> > +#include "dt_idle_states.h"
> > +
> > +struct state_elem {
> > +	struct list_head list;
> > +	struct device_node *node;
> > +	u32 val;
> > +};
> 
> Ah. So the fixed-size entry parameter requirement is because this code
> is in charge of allocating and freeing these structs?

Nope, I use this struct to sort the states and val is the value that
determines the order (ie power-rank) in this patch. If I used the
phandle lists for ordering nodes, this struct would disappear completely,
I have to check if that's feasible.

> > +
> > +static struct list_head head __initdata = LIST_HEAD_INIT(head);
> > +
> > +static bool __init state_cpu_valid(struct device_node *state_node,
> > +				   struct device_node *cpu_node)
> > +{
> > +	int i = 0;
> > +	struct device_node *cpu_state;
> > +
> > +	while ((cpu_state = of_parse_phandle(cpu_node,
> > +					     "cpu-idle-states", i++))) {
> > +		if (cpu_state && state_node == cpu_state) {
> 
> You can drop the cpu_state NULL check, it's implicit in the while loop.

Yep.

> > +			of_node_put(cpu_state);
> > +			return true;
> > +		}
> > +		of_node_put(cpu_state);
> > +	}
> > +	return false;
> > +}
> 
> Is it possible to use a bool ret variable to avoid the two of_node_put
> cases? Or does that end up making this larger?

No, I think you are right.

> > +static bool __init state_cpus_valid(const cpumask_t *cpus,
> > +				    struct device_node *state_node)
> > +{
> > +	int cpu;
> > +	struct device_node *cpu_node;
> > +
> > +	/*
> > +	 * Check if state is valid on driver cpumask cpus
> > +	 */
> > +	for_each_cpu(cpu, cpus) {
> > +		cpu_node = of_get_cpu_node(cpu, NULL);
> > +
> > +		if (!cpu_node) {
> > +			pr_err("Missing device node for CPU %d\n", cpu);
> > +			return false;
> > +		}
> > +
> > +		if (!state_cpu_valid(state_node, cpu_node))
> > +			return false;
> > +	}
> > +
> > +	return true;
> > +}
> 
> Doesn't this leave all the cpu node refcounts incremented? (it's painful
> to get device node refcounting right, I know).
> 
> I think you can use the similarly named of_cpu_device_node_get to find
> the CPU node. It uses the pointer stored in cpu->dev.of_node, so it
> doesn't have to walk the tree to find the CPU node. It also doesn't
> increment the refcount.
> 
> Unless this is too early for that?

I think I can use of_cpu_device_node_get(...), but I should still manage
refcount properly on that, which I am not doing here, good catch.

> > +static void __init init_state_node(struct cpuidle_driver *drv,
> > +				   struct device_node *state_node,
> > +				   int *cnt)
> > +{
> > +	struct cpuidle_state *idle_state;
> > +
> > +	pr_debug(" * %s...\n", state_node->full_name);
> > +
> > +	idle_state = &drv->states[*cnt];
> > +
> > +	if (of_property_read_u32(state_node, "wakeup-latency-us",
> > +				 &idle_state->exit_latency)) {
> 
> I'm not a fan of this construction, as the obvious reading is that we
> take the branch if we succeeded (which obviously isn't true as
> of_property_read_* return error codes). 
> 
> Could we change it to something like:
> 
> 	err = of_property_read_u32(state_node, "wakeup-latency-us",
> 				   &idle_state->exit_latency);
> 	if (err) {

You are right, I will update it.

> > +		u32 entry_latency, exit_latency;
> > +
> > +		if (of_property_read_u32(state_node, "entry-latency-us",
> > +					 &entry_latency)) {
> > +			pr_debug(" * %s missing entry-latency-us property\n",
> > +				 state_node->full_name);
> > +			return;
> > +		}
> 
> Returning without error code? Do the fields have sane default values?
> 
> Or is this safe because we didn't increment cnt?

The latter, but it isn't nice, agreed, it is just an internal interface
though. I will make it less opaque and easier to understand.

> > +
> > +		if (of_property_read_u32(state_node, "exit-latency-us",
> > +					 &exit_latency)) {
> > +			pr_debug(" * %s missing exit-latency-us property\n",
> > +				 state_node->full_name);
> > +			return;
> > +		}
> > +		/*
> > +		 * If wakeup-latency-us is missing, default to entry+exit
> > +		 * latencies as defined in idle states bindings
> > +		 */
> > +		idle_state->exit_latency = entry_latency + exit_latency;
> > +	}
> > +
> > +	if (of_property_read_u32(state_node, "min-residency-us",
> > +				 &idle_state->target_residency)) {
> > +		pr_debug(" * %s missing min-residency-us property\n",
> > +			     state_node->full_name);
> > +		return;
> > +	}
> > +
> > +	idle_state->flags = CPUIDLE_FLAG_TIME_VALID;
> > +	if (!of_property_read_bool(state_node, "timer-state-retained"))
> > +		idle_state->flags |= CPUIDLE_FLAG_TIMER_STOP;
> > + 	strncpy(idle_state->name, state_node->name, CPUIDLE_NAME_LEN);
> > +	strncpy(idle_state->desc, state_node->name, CPUIDLE_NAME_LEN);
> 
> Does the name make sense as a desc? Is a desc necessary?
> 
> CPUIDLE_DESC_LEN seems to exist, and is double CPUIDLE_NAME_LEN.

Yes, that's a copy and paste typo that I missed. BTW this code is likely
to disappear, since the way CPUidle driver manages these strings is changing.

As to is desc really needed, I need to check all existing drivers to
provide a complete answer.

> > +static void __init add_idle_states(struct cpuidle_driver *drv,
> > +				   struct device_node *idle_states)
> > +{
> > +	struct device_node *state_node;
> > +
> > +	for_each_child_of_node(idle_states, state_node) {
> > +		if ((!of_device_is_compatible(state_node, "arm,idle-state"))) {
> 
> Holy brackets batman! I think we can drop the outer ones given there's
> no assignment we want to supress warnings for.

Eheh sorry, should be a leftover, fixed.

> > +			pr_warn(" * %s: children of /cpus/idle-states must be \"arm,idle-state\" compatible\n",
> > +				     state_node->full_name);
> 
> Presumably the entire reason for having the compatible string is for
> future extensibility.
> 
> It would probably be better to have something like:
> 
> 	pr_warn("Node %s has unrecognised/missing compatible string\n",
> 		state_node->full_name);
> 

It makes sense, so I will change the pr_warn.

> > +			continue;
> > +		}
> > +		/*
> > +		 * If memory allocation fails, better bail out.
> > +		 * Initialized nodes are freed at initialization
> > +		 * completion in of_init_idle_driver().
> > +		 */
> > +		if ((add_state_node(drv->cpumask, state_node) == -ENOMEM))
> > +			break;
> 
> Can we not return? Or is the list sort important in the error case too?

Well, we might have a valid list of states that have to be sorted and I
think that's correct to break and not just return in that case.

Let's see if I can avoid the sorting altogether.

> > +	}
> > +	/*
> > +	 * Sort the states list before initializing the CPUidle driver
> > +	 * states array.
> > +	 */
> > +	list_sort(NULL, &head, state_cmp);
> > +}
> > +
> > +/**
> > + * dt_init_idle_driver() - Parse the DT idle states and initialize the
> > + *			   idle driver states array
> > + *
> > + * @drv:	  Pointer to CPU idle driver to be initialized
> > + * @state_nodes:  Array of struct device_nodes to be initialized if
> > + *		  init_nodes == true. Must be sized CPUIDLE_STATE_MAX
> > + * @start_idx:    First idle state index to be initialized
> > + * @init_nodes:   Boolean to request device nodes initialization
> > + *
> > + * On success the states array in the cpuidle driver contains
> > + * initialized entries in the states array, starting from index start_idx.
> > + * If init_nodes == true, on success the state_nodes array is initialized
> > + * with idle state DT node pointers, starting from index start_idx,
> > + * in a 1:1 relation with the idle driver states array.
> > + *
> > + * Return:
> > + *	0 on success
> > + *	<0 on failure
> > + */
> > +int __init dt_init_idle_driver(struct cpuidle_driver *drv,
> > +			       struct device_node *state_nodes[],
> > +			       unsigned int start_idx, bool init_nodes)
> > +{
> > +	struct device_node *idle_states_node;
> > +	int ret;
> > +
> > +	if (start_idx >= CPUIDLE_STATE_MAX) {
> > +		pr_warn("State index exceeds static CPU idle driver states array size\n");
> > +		return -EINVAL;
> > +	}
> > +
> > +	if (WARN(init_nodes && !state_nodes,
> > +		"Requested nodes stashing in an invalid nodes container\n"))
> > +		return -EINVAL;
> 
> That warning message is somewhat confusing, and I'm not sure I
> follow the logic.

It is a belt and braces check to make sure that, if the dt init code is
requested to fill in the state_nodes array (init_nodes == true), at least
the array base was passed and it is not a NULL pointer. I think I'd better
remove it and let the kernel oops if the interface is used wrongly, that would
be a kernel bug and there is not much to WARN about.

Thanks,
Lorenzo

