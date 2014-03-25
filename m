From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Subject: Re: [PATCH RFC 1/4] arm64: kernel: implement DT based idle states
 infrastructure
Date: Tue, 25 Mar 2014 12:42:17 +0000
Message-ID: <20140325124217.GB17526@e102568-lin.cambridge.arm.com>
References: <1395138028-19630-1-git-send-email-lorenzo.pieralisi@arm.com>
 <1395138028-19630-2-git-send-email-lorenzo.pieralisi@arm.com>
 <53304FD8.70106@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: 8BIT
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from service87.mimecast.com ([91.220.42.44]:50164 "EHLO
	service87.mimecast.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751877AbaCYMmX convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 25 Mar 2014 08:42:23 -0400
In-Reply-To: <53304FD8.70106@linaro.org>
Content-Disposition: inline
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Mark Rutland <Mark.Rutland@arm.com>, Sudeep Holla <Sudeep.Holla@arm.com>, Catalin Marinas <Catalin.Marinas@arm.com>, Charles Garcia-Tobin <Charles.Garcia-Tobin@arm.com>, Nicolas Pitre <nico@linaro.org>, Rob Herring <robh+dt@kernel.org>, "grant.likely@linaro.org" <grant.likely@linaro.org>, Peter De Schrijver <pdeschrijver@nvidia.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>, Amit Kucheria <amit.kucheria@linaro.org>, Vincent Guittot <vincent.guittot@linaro.org>, Antti Miettinen <ananaza@iki.fi>, Stephen Boyd <sboyd@codeaurora.org>, Kevin Hilman <khilman@linaro.org>, Sebastian Capella <sebastian.capella@linaro.org>, Tomasz Figa <t.figa@samsung.com>

Hi Daniel,

On Mon, Mar 24, 2014 at 03:31:36PM +0000, Daniel Lezcano wrote:

[...]

> > diff --git a/arch/arm64/include/asm/idle_states.h b/arch/arm64/include/asm/idle_states.h
> > new file mode 100644
> > index 0000000..0b9f9ba
> > --- /dev/null
> > +++ b/arch/arm64/include/asm/idle_states.h
> > @@ -0,0 +1,20 @@
> > +#ifndef __ARM64_IDLE_STATES
> > +#define __ARM64_IDLE_STATES
> > +
> > +struct idle_state {
> > +     u32     index;
> > +     u32     entry_latency;
> > +     u32     exit_latency;
> > +     u32     min_residency;
> > +     u32     param;
> 
> Could you add a comment for this 'param' field or change the name to eg
> 'psci_param' ?

I can, problem is that it is not necessarily tied to PSCI or put it
differently, it is an opaque parameter that is used by the suspend
backend to enter the idle state. For PSCI is the power_state parameter
in the PSCI suspend call, for other backends might mean something
different.

> 
> > +     struct device_node *node;
> > +     struct idle_state *state;
> 
> Why is it needed ?

To swap pointers while sorting the array, probably will disappear, see
below.

> > +     cpumask_t       cpus;
> 
> It sounds strange to have to declare this cpumask here.

I think I can do away with it, given your comments below.

> > +     bool    logic_state_retained;
> > +     bool    cache_state_retained;
> > +};
> 
> IMHO, there is useless duplication of structure definition / declaration.
> 
> I suggest to stick as much as possible to the cpuidle structures, that
> is cpuidle_state and cpuidle_driver.
> 
> Instead of using the intermediate, idle_states[CPUIDLE_STATE_MAX], use
> the drv->states directly and drv->cpumask. That will prevent extra copy
> and definition/declaration for nothing. And fill the structure directly
> from parse_idle_states_node / parse_idle_states.
> 
> All this comes from the need of the state ordering, right ?

Yes and the problem is that idle states in the cpuidle_driver are stored in
an array, filling it while parsing will probably require some copies (moves),
still doable, I will look into that.

> > +struct cpuidle_driver;
> > +
> > +int __init arm_init_idle_driver(struct cpuidle_driver *drv);
> > +#endif
> > diff --git a/arch/arm64/kernel/Makefile b/arch/arm64/kernel/Makefile
> > index 2d4554b..2afc9a0 100644
> > --- a/arch/arm64/kernel/Makefile
> > +++ b/arch/arm64/kernel/Makefile
> > @@ -19,6 +19,7 @@ arm64-obj-$(CONFIG_HW_PERF_EVENTS)  += perf_event.o
> >   arm64-obj-$(CONFIG_HAVE_HW_BREAKPOINT)+= hw_breakpoint.o
> >   arm64-obj-$(CONFIG_EARLY_PRINTK)    += early_printk.o
> >   arm64-obj-$(CONFIG_ARM64_CPU_SUSPEND)       += sleep.o suspend.o
> > +arm64-obj-$(CONFIG_ARM64_IDLE_STATES)        += idle_states.o
> >   arm64-obj-$(CONFIG_JUMP_LABEL)              += jump_label.o
> >
> >   obj-y                                       += $(arm64-obj-y) vdso/
> > diff --git a/arch/arm64/kernel/idle_states.c b/arch/arm64/kernel/idle_states.c
> > new file mode 100644
> > index 0000000..0386cff
> > --- /dev/null
> > +++ b/arch/arm64/kernel/idle_states.c
> > @@ -0,0 +1,397 @@
> > +/*
> > + * ARM device tree idle states parsing code.
> > + *
> > + * Copyright (C) 2014 ARM Ltd.
> > + * Author: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> > + *
> > + * This program is free software; you can redistribute it and/or modify
> > + * it under the terms of the GNU General Public License version 2 as
> > + * published by the Free Software Foundation.
> > + */
> > +
> > +#include <linux/cpuidle.h>
> > +#include <linux/cpumask.h>
> > +#include <linux/cpu_pm.h>
> > +#include <linux/errno.h>
> > +#include <linux/kernel.h>
> > +#include <linux/module.h>
> > +#include <linux/of.h>
> > +
> > +#include <asm/idle_states.h>
> > +#include <asm/psci.h>
> > +#include <asm/suspend.h>
> > +
> > +static struct idle_state idle_states[CPUIDLE_STATE_MAX] __initdata;
> > +typedef int (*idle_states_initializer)(struct cpumask *, struct idle_state *,
> > +                                    unsigned int);
> > +
> > +struct protocol_init {
> > +     const char *prot;
> > +     idle_states_initializer prot_init;
> > +};
> > +
> > +static const struct protocol_init protocols[] __initconst = {
> > +     {}
> > +};
> > +
> > +static __init const struct protocol_init *get_protocol(const char *str)
> > +{
> > +     int i;
> > +
> > +     if (!str)
> > +             return NULL;
> > +
> > +     for (i = 0; protocols[i].prot; i++)
> > +             if (!strcmp(protocols[i].prot, str))
> > +                     return &protocols[i];
> > +
> > +     return NULL;
> > +}
> > +
> > +static void __init idle_state_cpu_mask(int cpu, struct idle_state *idle_state,
> > +                                    struct device_node *cn)
> > +{
> > +     int i = 0;
> > +     struct device_node *cpu_state;
> > +
> > +     do {
> > +             cpu_state = of_parse_phandle(cn, "cpu-idle-states", i++);
> > +             if (cpu_state && idle_state->node == cpu_state)
> > +                     cpumask_set_cpu(cpu, &idle_state->cpus);
> > +             of_node_put(cpu_state);
> > +     } while (cpu_state);
> > +}
> > +
> > +static int __init parse_idle_states_node(struct device_node *parent, int cnt,
> > +                                      const cpumask_t *cpus)
> > +{
> > +     struct device_node *state;
> > +     struct idle_state *idle_state;
> > +     int cpu;
> > +
> > +     for_each_child_of_node(parent, state) {
> > +
> > +             if (!of_device_is_compatible(state, "arm,idle-state")) {
> > +                     pr_warn(" %s has child nodes that are not idle states\n",
> > +                             parent->full_name);
> > +                     continue;
> > +             }
> > +
> > +             idle_state = &idle_states[cnt];
> > +
> > +             pr_debug(" * %s...\n", state->full_name);
> > +
> > +             idle_state->node = state;
> 
> It is a bit confusing to use 'state' variable name here, is it possible
> to change to something like 'node' or whatever ?

Yes, absolutely.

[...]

> > +/*
> > + * arm_dt_init_idle_states - Parse DT idle states and initialize the protocol
> > + *                        back-end
> > + *
> > + * @prot: pointer to the protocol initializer. Initialized only if return code
> > + *        is >0
> > + * @cpus: CPU idle driver cpumask
> > + *
> > + * Returns:
> > + *   Number of idle states detected upon success
> > + *   <0 on failure
> > + */
> > +static int __init arm_dt_init_idle_states(const struct protocol_init **prot,
> > +                                       const cpumask_t *cpus)
> > +{
> > +     struct device_node *cpups;
> > +     const char *entry_method;
> > +     /* start from 1, stanbywfi is always there */
> > +     int cnt = 1, ret = 0;
> > +
> > +     if (!prot)
> > +             return -EINVAL;
> > +
> > +     cpups = of_find_node_by_path("/cpus/idle-states");
> > +
> > +     if (!cpups)
> > +             return -ENODEV;
> > +
> > +     cnt = parse_idle_states(cpups, cnt, cpus);
> > +
> > +     if (cnt == 1) {
> > +             ret = -ENODATA;
> > +             goto put_node;
> > +     }
> 
> If 'cnt' is always 1 when calling parse_idle_states, it would be more
> logical to do:
> 
> cnt = parse_idle_states(cpups, cpus);
> if (cnt < 0) {
>         ret = -ENODATA;
>         goto put_node;
> }
> 
> and change parse_idle_states consequently.

Yes I think it can be reworked to be made clearer, see below for default
wfi state.

> > +
> > +     /*
> > +      * idle driver expects states to sorted in terms of power
> > +      * consumption
> > +      */
> > +     sort_states(cnt);
> 
> Isn't possible to sort the states with the index when parsing the DT
> instead ?

Yes, I will do that (what field to use for comparison is still up in the
air though :))

> > +     if (of_property_read_string(cpups, "entry-method", &entry_method)) {
> > +             pr_warn(" * %s missing entry_method property\n",
> > +                         cpups->full_name);
> > +             ret = -EOPNOTSUPP;
> > +             goto put_node;
> > +     }
> > +
> > +     *prot = get_protocol(entry_method);
> > +     if (!*prot) {
> > +             pr_warn("Missing protocol initializer\n");
> > +             ret = -EOPNOTSUPP;
> > +             goto put_node;
> > +     }
> > +
> > +     pr_debug("detected %u idle states\n", cnt);
> > +
> > +put_node:
> > +     of_node_put(cpups);
> > +     return ret ? : cnt;
> > +}
> > +
> > +/*
> > + * arm_enter_idle_state - Programs CPU to enter the specified state
> > + *
> > + * @dev: cpuidle device
> > + * @drv: cpuidle driver
> > + * @idx: state index
> > + *
> > + * Called from the CPUidle framework to program the device to the
> > + * specified target state selected by the governor.
> > + */
> > +static int arm_enter_idle_state(struct cpuidle_device *dev,
> > +                             struct cpuidle_driver *drv, int idx)
> > +{
> > +     int ret;
> > +
> > +     if (!idx) {
> > +             /*
> > +              * idle index 0 is just standby wfi, does not require CPU
> > +              * to be suspended
> > +              */
> > +             cpu_do_idle();
> > +             return idx;
> > +     }
> > +
> > +     cpu_pm_enter();
> > +     /*
> > +      * Pass idle state index to cpu_suspend which in turn will call
> > +      * the CPU ops suspend protocol with idle index as a parameter
> > +      */
> > +     ret = cpu_suspend(idx);
> > +
> > +     cpu_pm_exit();
> > +
> > +     return ret ? : idx;
> 
> Are we sure the cpu_suspend will always return a negative value ? If the
> underlying returns 1, like the exynos4/5's cpuidle driver does, that
> will mess up the cpuidle governor with bad inputs.

cpu_suspend works a bit differently on ARM64, the suspend finisher is
defined through cpu_ops and we are in control of what it returns (eg
PSCI back-end, patch 2 in this series).

Well-spotted anyway, I must force the return value to be < 0 (if suspend
fails) to avoid issues.

> > +}
> > +
> > +int __init arm_init_idle_driver(struct cpuidle_driver *drv)
> > +{
> > +     int i,  idle_states_nb;
> > +     struct idle_state *idle_state;
> > +     struct cpuidle_state *s;
> > +     const struct protocol_init *prot;
> > +
> > +     drv->states[0].exit_latency = 1;
> > +     drv->states[0].target_residency = 1;
> > +     drv->states[0].flags = CPUIDLE_FLAG_TIME_VALID;
> > +     drv->states[0].enter = arm_enter_idle_state;
> > +     strncpy(drv->states[0].name, "ARM WFI", CPUIDLE_NAME_LEN);
> > +     strncpy(drv->states[0].desc, "ARM WFI", CPUIDLE_DESC_LEN);
> 
> The drv->states[0].name|desc is an array but I hope with some cleanups
> in the acpi cpuidle driver, we can change it to a const char *.
> 
> Is it possible to change it as:
> drv->states[0].name = "ARM WFI";
> drv->states[0].desc = "ARM WFI";
> 
> ?

Let me see first if I can address the questions below, related to WFI.

> > +     idle_states_nb = arm_dt_init_idle_states(&prot, drv->cpumask);
> > +
> > +     if (idle_states_nb < 0) {
> > +             /*
> > +              * No DT based idle states detected
> > +              * Initialize driver count and exit successfully.
> > +              */
> > +             drv->state_count = 1;
> > +             return 0;
> > +     }
> 
> If we are not able to initialize the cpuidle driver, wouldn't make sense
> to let the default idle function instead of defining a single state
> driver ? If no cpuidle driver is registered, the idle mainloop will
> switch to the default idle function. That should save the system to
> enter the cpuidle framework and the governor with all its computations
> for nothing, no ?

Yes, that makes sense.

> > +     /*
> > +      * We finally have some idle states to initialize.
> > +      * Driver state 0 corresponds to WFI, start from index 1 and count up
> > +      * to idle_states_nb (parsed idle states + WFI).
> > +      * arm_dt_init_idle_states() ensures that CPUIDLE_STATE_MAX is not
> > +      * exceeded.
> > +      */
> 
> I don't know the arm64 architecture but on armv7 there are some
> implementations which do not support the WFI instruction alone (eg.
> omap4), if that could happen for arm64, the driver is assuming WFI is
> always supported.

That's a sore point and I thought about that.

We must define what's "a standard wfi". I really hope we won't have
to override it as in arm32 for some platforms.

Having said that, I think it is fair to call cpu_do_idle for index 0, if
there are platform quirks they should be dealt with by overriding
cpu_do_idle.

Another solution would consist in always calling cpu_suspend() for all
states and then the suspend backend can put CPU in whatever version of wfi
the platform provide there.

I need to think more about this, I do not want to save the context for
nothing and at the same time have generic code.

> > +     s = &drv->states[1];
> > +     for (i = 1; i < idle_states_nb; i++, s++) {
> > +             idle_state = idle_states[i].state;
> > +             if (!idle_state)
> > +                     break;
> > +
> > +             strncpy(s->name, idle_state->node->name, CPUIDLE_NAME_LEN);
> > +             strncpy(s->desc, idle_state->node->name, CPUIDLE_DESC_LEN);
> 
> Same comment than above.

Ok.

> > +
> > +             s->exit_latency =
> > +                     idle_state->entry_latency + idle_state->exit_latency;
> > +             s->target_residency = idle_state->min_residency;
> > +             /*
> > +              * TBD: flag for timers is set implicitly for now but must be
> > +              * linked to power domains.
> > +              */
> > +             if (!idle_state->logic_state_retained)
> > +                     s->flags |= CPUIDLE_FLAG_TIMER_STOP;
> 
> The exynos use per cpu timer which are not local, so they are not shut
> down when 'logic_state_retained' is reached (If I refer to the calxeda
> driver, it should be the same). Is the TBD comment describing such case ?

Yes, the code above is temporary. The only way to fix it is to compare
the idle state power domain to the timer (tick_device) power domain and
check if that power domain goes down when the specific idle state is entered.

That's the reason why I went great lengths when defining the bindings
and that's good you flagged this up so that people are aware.

Let me know please if you want me to add that code (power domain parsing -
and additional bindings for timers and idle states) before considering merging
this code since I suspect changes are significant to handle this specific
niggle (an age-old one, it is really time we solved it).

> > +             s->flags |= CPUIDLE_FLAG_TIME_VALID;
> > +             s->enter = arm_enter_idle_state;
> > +     }
> > +
> > +     /*
> > +      * If we are here, we have a protocol back-end to initialize.
> > +      *
> > +      * If protocol initializer fails reset states count to 1 (wfi)
> > +      */
> > +     if (prot->prot_init(drv->cpumask, idle_states, idle_states_nb))
> > +             i = 1;
> 
> It should fail instead, as mentioned above with the single-state-driver
> comment.

Agreed.

Thank you very much for the review.
Lorenzo

