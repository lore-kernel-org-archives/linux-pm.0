From: Daniel Lezcano <daniel.lezcano-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH RFC 1/4] arm64: kernel: implement DT based idle states
 infrastructure
Date: Mon, 24 Mar 2014 16:31:36 +0100
Message-ID: <53304FD8.70106@linaro.org>
References: <1395138028-19630-1-git-send-email-lorenzo.pieralisi@arm.com> <1395138028-19630-2-git-send-email-lorenzo.pieralisi@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1395138028-19630-2-git-send-email-lorenzo.pieralisi-5wv7dgnIgG8@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Lorenzo Pieralisi <lorenzo.pieralisi-5wv7dgnIgG8@public.gmane.org>, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
Cc: devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Sudeep Holla <sudeep.holla-5wv7dgnIgG8@public.gmane.org>, Catalin Marinas <catalin.marinas-5wv7dgnIgG8@public.gmane.org>, Charles Garcia Tobin <Charles.Garcia-Tobin-5wv7dgnIgG8@public.gmane.org>, Nicolas Pitre <nico-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Grant Likely <grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Peter De Schrijver <pdeschrijver-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, Santosh Shilimkar <santosh.shilimkar-l0cyMroinI0@public.gmane.org>, Amit Kucheria <amit.kucheria-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Vincent Guittot <vincent.guittot-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Antti Miettinen <ananaza-X3B1VOXEql0@public.gmane.org>, Stephen Boyd <sboyd-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Kevin Hilman <khilman-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Sebastian Capella <sebastian.capella-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Tomasz Figa <t.figa-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
List-Id: linux-pm@vger.kernel.org


Hi Lorenzo,



On 03/18/2014 11:20 AM, Lorenzo Pieralisi wrote:
> On most common ARM systems, the low-power states a CPU can be put int=
o are
> not discoverable in HW and require device tree bindings to describe
> the respective power domains, power down protocol and idle states par=
ameters.
>
> In order to enable DT based idle states and configure idle drivers, t=
his
> patch implements the bulk infrastructure required to parse the device=
 tree
> idle states bindings and functions to initizialize idle driver and pr=
otocol
> back-ends.
>
> Protocol back-ends (eg PSCI) must register a protocol initializer wit=
h
> the idle state parser so that upon protocol detection, the parsing co=
de
> can call the back-end infrastructure to complete the idle driver
> initialization.
>
> Idle state index 0 is always initialized, ie always considered presen=
t
> on all ARM platforms.
>
> Code that initializes idle states checks the CPU idle driver cpumask =
so
> that multiple CPU idle drivers can be initialized through it in the
> kernel. The CPU idle driver cpumask defines which idle states should =
be
> considered valid for the driver, ie idle states that are valid on a s=
et
> of cpus the idle driver manages.
>
> Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi-5wv7dgnIgG8@public.gmane.org>
> ---
>   arch/arm64/Kconfig                   |   4 +
>   arch/arm64/include/asm/idle_states.h |  20 ++
>   arch/arm64/kernel/Makefile           |   1 +
>   arch/arm64/kernel/idle_states.c      | 397 ++++++++++++++++++++++++=
+++++++++++
>   4 files changed, 422 insertions(+)
>   create mode 100644 arch/arm64/include/asm/idle_states.h
>   create mode 100644 arch/arm64/kernel/idle_states.c
>
> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
> index 27bbcfc..3132572 100644
> --- a/arch/arm64/Kconfig
> +++ b/arch/arm64/Kconfig
> @@ -295,6 +295,10 @@ config ARCH_SUSPEND_POSSIBLE
>   config ARM64_CPU_SUSPEND
>   	def_bool PM_SLEEP
>
> +config ARM64_IDLE_STATES
> +	def_bool CPU_IDLE
> +	select ARM64_CPU_SUSPEND
> +
>   endmenu
>
>   menu "CPU Power Management"
> diff --git a/arch/arm64/include/asm/idle_states.h b/arch/arm64/includ=
e/asm/idle_states.h
> new file mode 100644
> index 0000000..0b9f9ba
> --- /dev/null
> +++ b/arch/arm64/include/asm/idle_states.h
> @@ -0,0 +1,20 @@
> +#ifndef __ARM64_IDLE_STATES
> +#define __ARM64_IDLE_STATES
> +
> +struct idle_state {
> +	u32	index;
> +	u32	entry_latency;
> +	u32	exit_latency;
> +	u32	min_residency;
> +	u32	param;

Could you add a comment for this 'param' field or change the name to eg=
=20
'psci_param' ?

> +	struct device_node *node;
> +	struct idle_state *state;

Why is it needed ?

> +	cpumask_t	cpus;

It sounds strange to have to declare this cpumask here.

> +	bool	logic_state_retained;
> +	bool	cache_state_retained;
> +};

IMHO, there is useless duplication of structure definition / declaratio=
n.

I suggest to stick as much as possible to the cpuidle structures, that=20
is cpuidle_state and cpuidle_driver.

Instead of using the intermediate, idle_states[CPUIDLE_STATE_MAX], use=20
the drv->states directly and drv->cpumask. That will prevent extra copy=
=20
and definition/declaration for nothing. And fill the structure directly=
=20
from parse_idle_states_node / parse_idle_states.

All this comes from the need of the state ordering, right ?

> +struct cpuidle_driver;
> +
> +int __init arm_init_idle_driver(struct cpuidle_driver *drv);
> +#endif
> diff --git a/arch/arm64/kernel/Makefile b/arch/arm64/kernel/Makefile
> index 2d4554b..2afc9a0 100644
> --- a/arch/arm64/kernel/Makefile
> +++ b/arch/arm64/kernel/Makefile
> @@ -19,6 +19,7 @@ arm64-obj-$(CONFIG_HW_PERF_EVENTS)	+=3D perf_event.=
o
>   arm64-obj-$(CONFIG_HAVE_HW_BREAKPOINT)+=3D hw_breakpoint.o
>   arm64-obj-$(CONFIG_EARLY_PRINTK)	+=3D early_printk.o
>   arm64-obj-$(CONFIG_ARM64_CPU_SUSPEND)	+=3D sleep.o suspend.o
> +arm64-obj-$(CONFIG_ARM64_IDLE_STATES)	+=3D idle_states.o
>   arm64-obj-$(CONFIG_JUMP_LABEL)		+=3D jump_label.o
>
>   obj-y					+=3D $(arm64-obj-y) vdso/
> diff --git a/arch/arm64/kernel/idle_states.c b/arch/arm64/kernel/idle=
_states.c
> new file mode 100644
> index 0000000..0386cff
> --- /dev/null
> +++ b/arch/arm64/kernel/idle_states.c
> @@ -0,0 +1,397 @@
> +/*
> + * ARM device tree idle states parsing code.
> + *
> + * Copyright (C) 2014 ARM Ltd.
> + * Author: Lorenzo Pieralisi <lorenzo.pieralisi-5wv7dgnIgG8@public.gmane.org>
> + *
> + * This program is free software; you can redistribute it and/or mod=
ify
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
> +typedef int (*idle_states_initializer)(struct cpumask *, struct idle=
_state *,
> +				       unsigned int);
> +
> +struct protocol_init {
> +	const char *prot;
> +	idle_states_initializer prot_init;
> +};
> +
> +static const struct protocol_init protocols[] __initconst =3D {
> +	{}
> +};
> +
> +static __init const struct protocol_init *get_protocol(const char *s=
tr)
> +{
> +	int i;
> +
> +	if (!str)
> +		return NULL;
> +
> +	for (i =3D 0; protocols[i].prot; i++)
> +		if (!strcmp(protocols[i].prot, str))
> +			return &protocols[i];
> +
> +	return NULL;
> +}
> +
> +static void __init idle_state_cpu_mask(int cpu, struct idle_state *i=
dle_state,
> +				       struct device_node *cn)
> +{
> +	int i =3D 0;
> +	struct device_node *cpu_state;
> +
> +	do {
> +		cpu_state =3D of_parse_phandle(cn, "cpu-idle-states", i++);
> +		if (cpu_state && idle_state->node =3D=3D cpu_state)
> +			cpumask_set_cpu(cpu, &idle_state->cpus);
> +		of_node_put(cpu_state);
> +	} while (cpu_state);
> +}
> +
> +static int __init parse_idle_states_node(struct device_node *parent,=
 int cnt,
> +					 const cpumask_t *cpus)
> +{
> +	struct device_node *state;
> +	struct idle_state *idle_state;
> +	int cpu;
> +
> +	for_each_child_of_node(parent, state) {
> +
> +		if (!of_device_is_compatible(state, "arm,idle-state")) {
> +			pr_warn(" %s has child nodes that are not idle states\n",
> +				parent->full_name);
> +			continue;
> +		}
> +
> +		idle_state =3D &idle_states[cnt];
> +
> +		pr_debug(" * %s...\n", state->full_name);
> +
> +		idle_state->node =3D state;

It is a bit confusing to use 'state' variable name here, is it possible=
=20
to change to something like 'node' or whatever ?

> +		/*
> +		 * Check cpus on which the idle state is valid
> +		 */
> +		for_each_possible_cpu(cpu) {
> +			struct device_node *cn;
> +
> +			cn =3D of_get_cpu_node(cpu, NULL);
> +			if (!cn) {
> +				pr_err("missing device node for CPU %d\n", cpu);
> +				continue;
> +			}
> +			idle_state_cpu_mask(cpu, idle_state, cn);
> +		}
> +
> +		/*
> +		 * The driver cpumask is not a subset of cpus on which the
> +		 * idle state is valid, hence the idle state is skipped for
> +		 * this driver.
> +		 */
> +		if (!cpumask_subset(cpus, &idle_state->cpus))
> +			continue;
> +
> +		if (of_property_read_u32(state, "index", &idle_state->index)) {
> +			pr_debug(" * %s missing index property\n",
> +				     state->full_name);
> +			continue;
> +		}
> +
> +		if (of_property_read_u32(state, "entry-latency-us",
> +					 &idle_state->entry_latency)) {
> +			pr_debug(" * %s missing entry latency property\n",
> +				     state->full_name);
> +			continue;
> +		}
> +
> +		if (of_property_read_u32(state, "exit-latency-us",
> +					 &idle_state->exit_latency)) {
> +			pr_debug(" * %s missing exit latency property\n",
> +				     state->full_name);
> +			continue;
> +		}
> +
> +		if (of_property_read_u32(state, "min-residency-us",
> +					 &idle_state->min_residency)) {
> +			pr_debug(" * %s missing min-residency property\n",
> +				     state->full_name);
> +			continue;
> +		}
> +
> +		if (of_property_read_u32(state, "entry-method-param",
> +					 &idle_state->param)) {
> +			pr_debug(" * %s missing entry-method-param property\n",
> +				     state->full_name);
> +			continue;
> +		}
> +
> +		if (++cnt =3D=3D CPUIDLE_STATE_MAX) {
> +			pr_warn("Number of parsed states equal static CPU idle state limi=
t\n");
> +			of_node_put(state);
> +			break;
> +		}
> +	}
> +
> +	return cnt;
> +}
> +
> +static int __init parse_idle_states(struct device_node *root, int cn=
t,
> +				    const cpumask_t *cpus)
> +{
> +	int head_idx, curr_idx;
> +	struct device_node *curr =3D root;
> +
> +	/*
> +	 * Breadth-first DT idle states parsing
> +	 *
> +	 * Sweep idle states level in the device tree and use the
> +	 * idle_states array to stash the visited nodes, as a queue.
> +	 *
> +	 * parse_idle_states_node() updates the idle_states array by
> +	 * initializing entries, stashing the device tree node for the
> +	 * corresponding state (struct idle_state.node) and incrementing
> +	 * the idle states counter that is returned so that curr_idx is
> +	 * kept up-to-date while descending into tree levels.
> +	 *
> +	 * Store the initial counter head_idx and curr_idx and use head_idx
> +	 * as a queue of node indices to be visited.
> +	 *
> +	 * When we reach the max number of CPU idle states or
> +	 * head_idx =3D=3D curr_idx (empty nodes queue) we are done.
> +	 */
> +	head_idx =3D curr_idx =3D cnt;
> +
> +	do {
> +		curr_idx =3D parse_idle_states_node(curr, curr_idx, cpus);
> +		if (curr_idx =3D=3D CPUIDLE_STATE_MAX || head_idx =3D=3D curr_idx)
> +			break;
> +		/*
> +		 * idle_states array is updated by parse_idle_states_node(),
> +		 * we can use the initialized states as a queue of nodes
> +		 * that need to be checked for their idle states siblings.
> +		 * head_idx works as a pointer into the queue to get the
> +		 * next node to be parsed.
> +		 */
> +		curr =3D idle_states[head_idx++].node;
> +	} while (curr);
> +
> +	return curr_idx;
> +}
> +
> +/*
> + * Sort states according to their index value, higher indexes
> + * imply higher power savings, as expected by the CPU idle subsystem=
=2E
> + */
> +static void __init sort_states(int count)
> +{
> +	int i, j;
> +	struct idle_state *idle_state;
> +
> +	/*
> +	 * move pointers instead of entries
> +	 */
> +	for (i =3D 0; i < count; i++)
> +		idle_states[i].state =3D &idle_states[i];
> +
> +	/*
> +	 * Selection sort is acceptable here, since the
> +	 * number of states is small (<=3DCPUIDLE_STATE_MAX)
> +	 *
> +	 * Index starts from 1, we know index 0 is standby wfi and
> +	 * it is always the idle state with higher power consumption
> +	 */
> +	for (i =3D 1; i < count - 1; i++) {
> +		u32 elem =3D i;
> +		for (j =3D i+1; j < count; j++) {
> +			if (idle_states[j].state->index <
> +					idle_states[elem].state->index)
> +				elem =3D j;
> +		}
> +		if (i !=3D elem) {
> +			idle_state =3D idle_states[i].state;
> +			idle_states[i].state =3D idle_states[elem].state;
> +			idle_states[elem].state =3D idle_state;
> +		}
> +	}
> +}
> +
> +/*
> + * arm_dt_init_idle_states - Parse DT idle states and initialize the=
 protocol
> + *			     back-end
> + *
> + * @prot: pointer to the protocol initializer. Initialized only if r=
eturn code
> + *        is >0
> + * @cpus: CPU idle driver cpumask
> + *
> + * Returns:
> + *	Number of idle states detected upon success
> + *	<0 on failure
> + */
> +static int __init arm_dt_init_idle_states(const struct protocol_init=
 **prot,
> +					  const cpumask_t *cpus)
> +{
> +	struct device_node *cpups;
> +	const char *entry_method;
> +	/* start from 1, stanbywfi is always there */
> +	int cnt =3D 1, ret =3D 0;
> +
> +	if (!prot)
> +		return -EINVAL;
> +
> +	cpups =3D of_find_node_by_path("/cpus/idle-states");
> +
> +	if (!cpups)
> +		return -ENODEV;
> +
> +	cnt =3D parse_idle_states(cpups, cnt, cpus);
> +
> +	if (cnt =3D=3D 1) {
> +		ret =3D -ENODATA;
> +		goto put_node;
> +	}

If 'cnt' is always 1 when calling parse_idle_states, it would be more=20
logical to do:

cnt =3D parse_idle_states(cpups, cpus);
if (cnt < 0) {
	ret =3D -ENODATA;
	goto put_node;
}

and change parse_idle_states consequently.

> +
> +	/*
> +	 * idle driver expects states to sorted in terms of power
> +	 * consumption
> +	 */
> +	sort_states(cnt);

Isn't possible to sort the states with the index when parsing the DT=20
instead ?

> +	if (of_property_read_string(cpups, "entry-method", &entry_method)) =
{
> +		pr_warn(" * %s missing entry_method property\n",
> +			    cpups->full_name);
> +		ret =3D -EOPNOTSUPP;
> +		goto put_node;
> +	}
> +
> +	*prot =3D get_protocol(entry_method);
> +	if (!*prot) {
> +		pr_warn("Missing protocol initializer\n");
> +		ret =3D -EOPNOTSUPP;
> +		goto put_node;
> +	}
> +
> +	pr_debug("detected %u idle states\n", cnt);
> +
> +put_node:
> +	of_node_put(cpups);
> +	return ret ? : cnt;
> +}
> +
> +/*
> + * arm_enter_idle_state - Programs CPU to enter the specified state
> + *
> + * @dev: cpuidle device
> + * @drv: cpuidle driver
> + * @idx: state index
> + *
> + * Called from the CPUidle framework to program the device to the
> + * specified target state selected by the governor.
> + */
> +static int arm_enter_idle_state(struct cpuidle_device *dev,
> +				struct cpuidle_driver *drv, int idx)
> +{
> +	int ret;
> +
> +	if (!idx) {
> +		/*
> +		 * idle index 0 is just standby wfi, does not require CPU
> +		 * to be suspended
> +		 */
> +		cpu_do_idle();
> +		return idx;
> +	}
> +
> +	cpu_pm_enter();
> +	/*
> +	 * Pass idle state index to cpu_suspend which in turn will call
> +	 * the CPU ops suspend protocol with idle index as a parameter
> +	 */
> +	ret =3D cpu_suspend(idx);
> +
> +	cpu_pm_exit();
> +
> +	return ret ? : idx;

Are we sure the cpu_suspend will always return a negative value ? If th=
e=20
underlying returns 1, like the exynos4/5's cpuidle driver does, that=20
will mess up the cpuidle governor with bad inputs.

> +}
> +
> +int __init arm_init_idle_driver(struct cpuidle_driver *drv)
> +{
> +	int i,  idle_states_nb;
> +	struct idle_state *idle_state;
> +	struct cpuidle_state *s;
> +	const struct protocol_init *prot;
> +
> +	drv->states[0].exit_latency =3D 1;
> +	drv->states[0].target_residency =3D 1;
> +	drv->states[0].flags =3D CPUIDLE_FLAG_TIME_VALID;
> +	drv->states[0].enter =3D arm_enter_idle_state;
> +	strncpy(drv->states[0].name, "ARM WFI", CPUIDLE_NAME_LEN);
> +	strncpy(drv->states[0].desc, "ARM WFI", CPUIDLE_DESC_LEN);

The drv->states[0].name|desc is an array but I hope with some cleanups=20
in the acpi cpuidle driver, we can change it to a const char *.

Is it possible to change it as:
drv->states[0].name =3D "ARM WFI";
drv->states[0].desc =3D "ARM WFI";

?

> +	idle_states_nb =3D arm_dt_init_idle_states(&prot, drv->cpumask);
> +
> +	if (idle_states_nb < 0) {
> +		/*
> +		 * No DT based idle states detected
> +		 * Initialize driver count and exit successfully.
> +		 */
> +		drv->state_count =3D 1;
> +		return 0;
> +	}

If we are not able to initialize the cpuidle driver, wouldn't make sens=
e=20
to let the default idle function instead of defining a single state=20
driver ? If no cpuidle driver is registered, the idle mainloop will=20
switch to the default idle function. That should save the system to=20
enter the cpuidle framework and the governor with all its computations=20
for nothing, no ?

> +	/*
> +	 * We finally have some idle states to initialize.
> +	 * Driver state 0 corresponds to WFI, start from index 1 and count =
up
> +	 * to idle_states_nb (parsed idle states + WFI).
> +	 * arm_dt_init_idle_states() ensures that CPUIDLE_STATE_MAX is not
> +	 * exceeded.
> +	 */

I don't know the arm64 architecture but on armv7 there are some=20
implementations which do not support the WFI instruction alone (eg.=20
omap4), if that could happen for arm64, the driver is assuming WFI is=20
always supported.

> +	s =3D &drv->states[1];
> +	for (i =3D 1; i < idle_states_nb; i++, s++) {
> +		idle_state =3D idle_states[i].state;
> +		if (!idle_state)
> +			break;
> +
> +		strncpy(s->name, idle_state->node->name, CPUIDLE_NAME_LEN);
> +		strncpy(s->desc, idle_state->node->name, CPUIDLE_DESC_LEN);

Same comment than above.

> +
> +		s->exit_latency =3D
> +			idle_state->entry_latency + idle_state->exit_latency;
> +		s->target_residency =3D idle_state->min_residency;
> +		/*
> +		 * TBD: flag for timers is set implicitly for now but must be
> +		 * linked to power domains.
> +		 */
> +		if (!idle_state->logic_state_retained)
> +			s->flags |=3D CPUIDLE_FLAG_TIMER_STOP;

The exynos use per cpu timer which are not local, so they are not shut=20
down when 'logic_state_retained' is reached (If I refer to the calxeda=20
driver, it should be the same). Is the TBD comment describing such case=
 ?

> +		s->flags |=3D CPUIDLE_FLAG_TIME_VALID;
> +		s->enter =3D arm_enter_idle_state;
> +	}
> +
> +	/*
> +	 * If we are here, we have a protocol back-end to initialize.
> +	 *
> +	 * If protocol initializer fails reset states count to 1 (wfi)
> +	 */
> +	if (prot->prot_init(drv->cpumask, idle_states, idle_states_nb))
> +		i =3D 1;

It should fail instead, as mentioned above with the single-state-driver=
=20
comment.

> +
> +	pr_info("idle states initialized, prototocol: %s states count: %u",
> +		prot->prot, i);
> +
> +	drv->state_count =3D i;
> +	return 0;
> +}


   -- Daniel


--=20
  <http://www.linaro.org/> Linaro.org =E2=94=82 Open source software fo=
r ARM SoCs

=46ollow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

--
To unsubscribe from this list: send the line "unsubscribe devicetree" i=
n
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
