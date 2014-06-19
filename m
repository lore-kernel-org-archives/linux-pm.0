From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Subject: Re: [PATCH v4 5/6] drivers: cpuidle: CPU idle ARM64 driver
Date: Thu, 19 Jun 2014 10:08:27 +0100
Message-ID: <20140619090826.GC5401@e102568-lin.cambridge.arm.com>
References: <1402503520-8611-1-git-send-email-lorenzo.pieralisi@arm.com>
 <1402503520-8611-6-git-send-email-lorenzo.pieralisi@arm.com>
 <CAL_JsqK_sRuns3sTnLXEfb9wC02q13wtDm4ZgXR8isWtQCxJ0A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: 8BIT
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from service87.mimecast.com ([91.220.42.44]:54425 "EHLO
	service87.mimecast.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757879AbaFSJIc convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 19 Jun 2014 05:08:32 -0400
In-Reply-To: <CAL_JsqK_sRuns3sTnLXEfb9wC02q13wtDm4ZgXR8isWtQCxJ0A@mail.gmail.com>
Content-Disposition: inline
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Rob Herring <robherring2@gmail.com>
Cc: Mark Rutland <Mark.Rutland@arm.com>, Catalin Marinas <Catalin.Marinas@arm.com>, Tomasz Figa <t.figa@samsung.com>, Chander Kashyap <chander.kashyap@linaro.org>, Vincent Guittot <vincent.guittot@linaro.org>, Nicolas Pitre <nico@linaro.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "grant.likely@linaro.org" <grant.likely@linaro.org>, Charles Garcia-Tobin <Charles.Garcia-Tobin@arm.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Kevin Hilman <khilman@linaro.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Sebastian Capella <sebcape@gmail.com>, Mark Brown <broonie@kernel.org>, Antti Miettinen <ananaza@iki.fi>, Paul Walmsley <paul@pwsan.com>, Peter De Schrijver <pdeschrijver@nvidia.com>, Stephen Boyd <sboyd@codeaurora.org>, Amit Kucheria <amit.kucheria@linaro.o>

On Thu, Jun 19, 2014 at 04:02:18AM +0100, Rob Herring wrote:
> On Wed, Jun 11, 2014 at 11:18 AM, Lorenzo Pieralisi
> <lorenzo.pieralisi@arm.com> wrote:
> > This patch implements a generic CPU idle driver for ARM64 machines.
> 
> I fail to see anything arm64 specific here. The idle states binding is
> for both arm32 and arm64, right? If not, please make it for both.
> Otherwise, I'm okay with the binding for the most part. I need to take
> another pass at it though.

cpu_suspend prototypes differ and that has implications, in particular
related to how to initialize the cpu_suspend back-end. I think that with some
effort we might have a single common driver for arm32/64, I have to check if
it is worth the additional ifdeffery that is likely to be needed.

Certainly the DT bindings are generic for arm32/arm64 and we are trying
to make code using them generic too, the best we can.

I will post a v5 soon, please let me know if that's ok to go when time
comes.

Thank you,
Lorenzo

> 
> Rob
> 
> > It relies on the DT idle states infrastructure to initialize idle
> > states count and respective parameters. Current code assumes the driver
> > is managing idle states on all possible CPUs but can be easily
> > generalized to support heterogenous systems and build cpumasks at
> > runtime using MIDRs or DT cpu nodes compatible properties.
> >
> > Suspend back-ends (eg PSCI) must register a suspend initializer with
> > the CPU idle driver so that the suspend backend call can be detected,
> > and the driver code can call the back-end infrastructure to complete the
> > suspend backend initialization.
> >
> > Idle state index 0 is always initialized as a simple wfi state, ie always
> > considered present and functional on all ARM64 platforms.
> >
> > Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> > ---
> >  drivers/cpuidle/Kconfig         |   5 ++
> >  drivers/cpuidle/Kconfig.arm64   |  13 ++++
> >  drivers/cpuidle/Makefile        |   4 +
> >  drivers/cpuidle/cpuidle-arm64.c | 168 ++++++++++++++++++++++++++++++++++++++++
> >  4 files changed, 190 insertions(+)
> >  create mode 100644 drivers/cpuidle/Kconfig.arm64
> >  create mode 100644 drivers/cpuidle/cpuidle-arm64.c
> >
> > diff --git a/drivers/cpuidle/Kconfig b/drivers/cpuidle/Kconfig
> > index 760ce20..360c086 100644
> > --- a/drivers/cpuidle/Kconfig
> > +++ b/drivers/cpuidle/Kconfig
> > @@ -44,6 +44,11 @@ depends on ARM
> >  source "drivers/cpuidle/Kconfig.arm"
> >  endmenu
> >
> > +menu "ARM64 CPU Idle Drivers"
> > +depends on ARM64
> > +source "drivers/cpuidle/Kconfig.arm64"
> > +endmenu
> > +
> >  menu "MIPS CPU Idle Drivers"
> >  depends on MIPS
> >  source "drivers/cpuidle/Kconfig.mips"
> > diff --git a/drivers/cpuidle/Kconfig.arm64 b/drivers/cpuidle/Kconfig.arm64
> > new file mode 100644
> > index 0000000..b83612c
> > --- /dev/null
> > +++ b/drivers/cpuidle/Kconfig.arm64
> > @@ -0,0 +1,13 @@
> > +#
> > +# ARM64 CPU Idle drivers
> > +#
> > +
> > +config ARM64_CPUIDLE
> > +       bool "Generic ARM64 CPU idle Driver"
> > +       select OF_IDLE_STATES
> > +       help
> > +         Select this to enable generic cpuidle driver for ARM v8.
> > +         It provides a generic idle driver whose idle states are configured
> > +         at run-time through DT nodes. The CPUidle suspend backend is
> > +         initialized by the device tree parsing code on matching the entry
> > +         method to the respective CPU operations.
> > diff --git a/drivers/cpuidle/Makefile b/drivers/cpuidle/Makefile
> > index d5ebf4b..e496242 100644
> > --- a/drivers/cpuidle/Makefile
> > +++ b/drivers/cpuidle/Makefile
> > @@ -23,6 +23,10 @@ obj-$(CONFIG_ARM_EXYNOS_CPUIDLE)        += cpuidle-exynos.o
> >  obj-$(CONFIG_MIPS_CPS_CPUIDLE)         += cpuidle-cps.o
> >
> >  ###############################################################################
> > +# ARM64 drivers
> > +obj-$(CONFIG_ARM64_CPUIDLE)            += cpuidle-arm64.o
> > +
> > +###############################################################################
> >  # POWERPC drivers
> >  obj-$(CONFIG_PSERIES_CPUIDLE)          += cpuidle-pseries.o
> >  obj-$(CONFIG_POWERNV_CPUIDLE)          += cpuidle-powernv.o
> > diff --git a/drivers/cpuidle/cpuidle-arm64.c b/drivers/cpuidle/cpuidle-arm64.c
> > new file mode 100644
> > index 0000000..4c932f8
> > --- /dev/null
> > +++ b/drivers/cpuidle/cpuidle-arm64.c
> > @@ -0,0 +1,168 @@
> > +/*
> > + * ARM64 generic CPU idle driver.
> > + *
> > + * Copyright (C) 2014 ARM Ltd.
> > + * Author: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> > + *
> > + * This program is free software; you can redistribute it and/or modify
> > + * it under the terms of the GNU General Public License version 2 as
> > + * published by the Free Software Foundation.
> > + */
> > +
> > +#define pr_fmt(fmt) "CPUidle arm64: " fmt
> > +
> > +#include <linux/cpuidle.h>
> > +#include <linux/cpumask.h>
> > +#include <linux/cpu_pm.h>
> > +#include <linux/kernel.h>
> > +#include <linux/module.h>
> > +#include <linux/of.h>
> > +
> > +#include <asm/psci.h>
> > +#include <asm/suspend.h>
> > +
> > +#include "of_idle_states.h"
> > +
> > +typedef int (*suspend_init_fn)(struct cpuidle_driver *,
> > +                              struct device_node *[]);
> > +
> > +struct cpu_suspend_ops {
> > +       const char *id;
> > +       suspend_init_fn init_fn;
> > +};
> > +
> > +static const struct cpu_suspend_ops suspend_operations[] __initconst = {
> > +       {"arm,psci", psci_dt_register_idle_states},
> > +       {}
> > +};
> > +
> > +static __init const struct cpu_suspend_ops *get_suspend_ops(const char *str)
> > +{
> > +       int i;
> > +
> > +       if (!str)
> > +               return NULL;
> > +
> > +       for (i = 0; suspend_operations[i].id; i++)
> > +               if (!strcmp(suspend_operations[i].id, str))
> > +                       return &suspend_operations[i];
> > +
> > +       return NULL;
> > +}
> > +
> > +/*
> > + * arm_enter_idle_state - Programs CPU to enter the specified state
> > + *
> > + * dev: cpuidle device
> > + * drv: cpuidle driver
> > + * idx: state index
> > + *
> > + * Called from the CPUidle framework to program the device to the
> > + * specified target state selected by the governor.
> > + */
> > +static int arm_enter_idle_state(struct cpuidle_device *dev,
> > +                               struct cpuidle_driver *drv, int idx)
> > +{
> > +       int ret;
> > +
> > +       if (!idx) {
> > +               cpu_do_idle();
> > +               return idx;
> > +       }
> > +
> > +       cpu_pm_enter();
> > +       /*
> > +        * Pass idle state index to cpu_suspend which in turn will call
> > +        * the CPU ops suspend protocol with idle index as a parameter.
> > +        *
> > +        * Some states would not require context to be saved and flushed
> > +        * to DRAM, so calling cpu_suspend would not be stricly necessary.
> > +        * When power domains specifications for ARM CPUs are finalized then
> > +        * this code can be optimized to prevent saving registers if not
> > +        * needed.
> > +        */
> > +       ret = cpu_suspend(idx);
> > +
> > +       cpu_pm_exit();
> > +
> > +       return ret ? -1 : idx;
> > +}
> > +
> > +struct cpuidle_driver arm64_idle_driver = {
> > +       .name = "arm64_idle",
> > +       .owner = THIS_MODULE,
> > +};
> > +
> > +static struct device_node *state_nodes[CPUIDLE_STATE_MAX] __initdata;
> > +
> > +/*
> > + * arm64_idle_init
> > + *
> > + * Registers the arm64 specific cpuidle driver with the cpuidle
> > + * framework. It relies on core code to parse the idle states
> > + * and initialize them using driver data structures accordingly.
> > + */
> > +static int __init arm64_idle_init(void)
> > +{
> > +       int i, ret;
> > +       const char *entry_method;
> > +       struct device_node *idle_states_node;
> > +       const struct cpu_suspend_ops *suspend_init;
> > +       struct cpuidle_driver *drv = &arm64_idle_driver;
> > +
> > +       idle_states_node = of_find_node_by_path("/cpus/idle-states");
> > +       if (!idle_states_node)
> > +               return -ENOENT;
> > +
> > +       if (of_property_read_string(idle_states_node, "entry-method",
> > +                                   &entry_method)) {
> > +               pr_warn(" * %s missing entry-method property\n",
> > +                           idle_states_node->full_name);
> > +               of_node_put(idle_states_node);
> > +               ret = -EOPNOTSUPP;
> > +               goto put_node;
> > +       }
> > +
> > +       suspend_init = get_suspend_ops(entry_method);
> > +       if (!suspend_init) {
> > +               pr_warn("Missing suspend initializer\n");
> > +               ret = -EOPNOTSUPP;
> > +               goto put_node;
> > +       }
> > +
> > +       /*
> > +        * State at index 0 is standby wfi and considered standard
> > +        * on all ARM platforms. If in some platforms simple wfi
> > +        * can't be used as "state 0", DT bindings must be implemented
> > +        * to work around this issue and allow installing a special
> > +        * handler for idle state index 0.
> > +        */
> > +       drv->states[0].exit_latency = 1;
> > +       drv->states[0].target_residency = 1;
> > +       drv->states[0].flags = CPUIDLE_FLAG_TIME_VALID;
> > +       strncpy(drv->states[0].name, "ARM WFI", CPUIDLE_NAME_LEN);
> > +       strncpy(drv->states[0].desc, "ARM WFI", CPUIDLE_DESC_LEN);
> > +
> > +       drv->cpumask = (struct cpumask *) cpu_possible_mask;
> > +       /*
> > +        * Start at index 1, request idle state nodes to be filled
> > +        */
> > +       ret = of_init_idle_driver(drv, state_nodes, 1, true);
> > +       if (ret)
> > +               goto put_node;
> > +
> > +       if (suspend_init->init_fn(drv, state_nodes)) {
> > +               ret = -EOPNOTSUPP;
> > +               goto put_node;
> > +       }
> > +
> > +       for (i = 0; i < drv->state_count; i++)
> > +               drv->states[i].enter = arm_enter_idle_state;
> > +
> > +       ret = cpuidle_register(drv, NULL);
> > +
> > +put_node:
> > +       of_node_put(idle_states_node);
> > +       return ret;
> > +}
> > +device_initcall(arm64_idle_init);
> > --
> > 1.8.4
> >
> >
> > --
> > To unsubscribe from this list: send the line "unsubscribe devicetree" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 

