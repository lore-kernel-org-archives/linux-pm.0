From: Ashwin Chaugule <ashwin.chaugule@linaro.org>
Subject: Re: [PATCH v6 5/7] drivers: cpuidle: CPU idle ARM64 driver
Date: Wed, 23 Jul 2014 12:34:57 -0400
Message-ID: <CAJ5Y-eb7jpX_RZPrBu6rOoCfrn+D4=6P0oaC11qoagBqw9=-Ow@mail.gmail.com>
References: <1405958786-17243-1-git-send-email-lorenzo.pieralisi@arm.com>
 <1405958786-17243-6-git-send-email-lorenzo.pieralisi@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1405958786-17243-6-git-send-email-lorenzo.pieralisi@arm.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Mark Rutland <mark.rutland@arm.com>, Catalin Marinas <catalin.marinas@arm.com>, Tomasz Figa <t.figa@samsung.com>, Chander Kashyap <chander.kashyap@linaro.org>, Vincent Guittot <vincent.guittot@linaro.org>, Nicolas Pitre <nico@linaro.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Grant Likely <grant.likely@linaro.org>, Charles Garcia Tobin <Charles.Garcia-Tobin@arm.com>, Devicetree List <devicetree@vger.kernel.org>, Kevin Hilman <khilman@linaro.org>, linux-pm@vger.kernel.org, Sebastian Capella <sebcape@gmail.com>, Rob Herring <robh+dt@kernel.org>, Antti Miettinen <ananaza@iki.fi>, Paul Walmsley <paul@pwsan.com>, Geoff Levand <geoff@infradead.org>, Peter De Schrijver <pdeschrijver@nvidia.com>, Stephen Boyd <sboyd@codeaurora.org>, Amit Kucheria <amit.kucheria@linaro.org>, Bartlomiej
List-Id: linux-pm@vger.kernel.org

On 21 July 2014 12:06, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com> wrote:
> This patch implements a generic CPU idle driver for ARM64 machines.
>
> It relies on the DT idle states infrastructure to initialize idle
> states count and respective parameters. Current code assumes the driver
> is managing idle states on all possible CPUs but can be easily
> generalized to support heterogenous systems and build cpumasks at
> runtime using MIDRs or DT cpu nodes compatible properties.
>
> The driver relies on the arm64 CPU operations to call the idle
> initialization hook used to parse and save suspend back-end specific
> idle states information upon probing.
>
> Idle state index 0 is always initialized as a simple wfi state, ie always
> considered present and functional on all ARM64 platforms.
>
> Idle state indices higher than 0 trigger idle state entry by calling
> the cpu_suspend function, that does save the CPU context and executes
> the CPU operations suspend back-end hook. cpu_suspend passes the idle
> state index as a parameter so that the CPU operations suspend back-end
> can retrieve the required idle state data by using the idle state
> index to execute a look-up on its internal data structures.
>
> Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> ---
>  drivers/cpuidle/Kconfig         |   5 ++
>  drivers/cpuidle/Kconfig.arm64   |  14 +++++
>  drivers/cpuidle/Makefile        |   4 ++
>  drivers/cpuidle/cpuidle-arm64.c | 128 ++++++++++++++++++++++++++++++++++++++++
>  4 files changed, 151 insertions(+)
>  create mode 100644 drivers/cpuidle/Kconfig.arm64
>  create mode 100644 drivers/cpuidle/cpuidle-arm64.c
>
> diff --git a/drivers/cpuidle/Kconfig b/drivers/cpuidle/Kconfig
> index 414e7a96..ebf0c2e 100644
> --- a/drivers/cpuidle/Kconfig
> +++ b/drivers/cpuidle/Kconfig
> @@ -43,6 +43,11 @@ depends on ARM
>  source "drivers/cpuidle/Kconfig.arm"
>  endmenu
>
> +menu "ARM64 CPU Idle Drivers"
> +depends on ARM64
> +source "drivers/cpuidle/Kconfig.arm64"
> +endmenu
> +
>  menu "MIPS CPU Idle Drivers"
>  depends on MIPS
>  source "drivers/cpuidle/Kconfig.mips"
> diff --git a/drivers/cpuidle/Kconfig.arm64 b/drivers/cpuidle/Kconfig.arm64
> new file mode 100644
> index 0000000..d0a08ed
> --- /dev/null
> +++ b/drivers/cpuidle/Kconfig.arm64
> @@ -0,0 +1,14 @@
> +#
> +# ARM64 CPU Idle drivers
> +#
> +
> +config ARM64_CPUIDLE
> +       bool "Generic ARM64 CPU idle Driver"
> +       select ARM64_CPU_SUSPEND
> +       select DT_IDLE_STATES
> +       help
> +         Select this to enable generic cpuidle driver for ARM64.
> +         It provides a generic idle driver whose idle states are configured
> +         at run-time through DT nodes. The CPUidle suspend backend is
> +         initialized by calling the CPU operations init idle hook
> +         provided by architecture code.
> diff --git a/drivers/cpuidle/Makefile b/drivers/cpuidle/Makefile
> index b27a062..706cb7f 100644
> --- a/drivers/cpuidle/Makefile
> +++ b/drivers/cpuidle/Makefile
> @@ -23,6 +23,10 @@ obj-$(CONFIG_ARM_EXYNOS_CPUIDLE)        += cpuidle-exynos.o
>  obj-$(CONFIG_MIPS_CPS_CPUIDLE)         += cpuidle-cps.o
>
>  ###############################################################################
> +# ARM64 drivers
> +obj-$(CONFIG_ARM64_CPUIDLE)            += cpuidle-arm64.o
> +
> +###############################################################################
>  # POWERPC drivers
>  obj-$(CONFIG_PSERIES_CPUIDLE)          += cpuidle-pseries.o
>  obj-$(CONFIG_POWERNV_CPUIDLE)          += cpuidle-powernv.o
> diff --git a/drivers/cpuidle/cpuidle-arm64.c b/drivers/cpuidle/cpuidle-arm64.c
> new file mode 100644
> index 0000000..1aeb426
> --- /dev/null
> +++ b/drivers/cpuidle/cpuidle-arm64.c
> @@ -0,0 +1,128 @@
> +/*
> + * ARM64 generic CPU idle driver.
> + *
> + * Copyright (C) 2014 ARM Ltd.
> + * Author: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + */
> +
> +#define pr_fmt(fmt) "CPUidle arm64: " fmt
> +
> +#include <linux/cpuidle.h>
> +#include <linux/cpumask.h>
> +#include <linux/cpu_pm.h>
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/of.h>
> +#include <linux/slab.h>
> +
> +#include <asm/cpuidle.h>
> +#include <asm/suspend.h>
> +
> +#include "dt_idle_states.h"
> +
> +/*
> + * arm_enter_idle_state - Programs CPU to enter the specified state
> + *
> + * dev: cpuidle device
> + * drv: cpuidle driver
> + * idx: state index
> + *
> + * Called from the CPUidle framework to program the device to the
> + * specified target state selected by the governor.
> + */
> +static int arm_enter_idle_state(struct cpuidle_device *dev,
> +                               struct cpuidle_driver *drv, int idx)
> +{
> +       int ret;
> +
> +       if (!idx) {
> +               cpu_do_idle();
> +               return idx;
> +       }
> +
> +       ret = cpu_pm_enter();
> +       if (!ret) {
> +               /*
> +                * Pass idle state index to cpu_suspend which in turn will
> +                * call the CPU ops suspend protocol with idle index as a
> +                * parameter.
> +                */
> +               ret = cpu_suspend(idx);
> +
> +               cpu_pm_exit();
> +       }
> +
> +       return ret ? -1 : idx;
> +}
> +
> +struct cpuidle_driver arm64_idle_driver = {
> +       .name = "arm64_idle",
> +       .owner = THIS_MODULE,
> +       /*
> +        * State at index 0 is standby wfi and considered standard
> +        * on all ARM platforms. If in some platforms simple wfi
> +        * can't be used as "state 0", DT bindings must be implemented
> +        * to work around this issue and allow installing a special
> +        * handler for idle state index 0.
> +        */
> +       .states[0] = {
> +               .enter                  = arm_enter_idle_state,
> +               .exit_latency           = 1,
> +               .target_residency       = 1,
> +               .power_usage            = UINT_MAX,
> +               .flags                  = CPUIDLE_FLAG_TIME_VALID,
> +               .name                   = "WFI",
> +               .desc                   = "ARM64 WFI",
> +       }
> +};
> +
> +/*
> + * arm64_idle_init
> + *
> + * Registers the arm64 specific cpuidle driver with the cpuidle
> + * framework. It relies on core code to parse the idle states
> + * and initialize them using driver data structures accordingly.
> + */
> +static int __init arm64_idle_init(void)
> +{
> +       int i, ret;
> +       struct cpuidle_driver *drv = &arm64_idle_driver;
> +
> +       drv->cpumask = kzalloc(cpumask_size(), GFP_KERNEL);
> +       if (!drv->cpumask)
> +               return -ENOMEM;
> +
> +       cpumask_copy(drv->cpumask, cpu_possible_mask);
> +       /*
> +        * Start at index 1, request idle state nodes to be filled
> +        */
> +       ret = dt_init_idle_driver(drv, 1);
> +       if (ret)
> +               goto free_mem;
> +       /*
> +        * Call arch CPU operations in order to initialize
> +        * idle states suspend back-end specific data
> +        */
> +       for_each_cpu(i, drv->cpumask) {
> +               ret = cpu_init_idle(i);
> +               if (ret)
> +                       goto free_mem;
> +       }
> +
> +       for (i = 1; i < drv->state_count; i++)
> +               drv->states[i].enter = arm_enter_idle_state;
> +
> +       ret = cpuidle_register(drv, NULL);
> +       if (ret)
> +               goto free_mem;
> +
> +       return 0;
> +free_mem:
> +       kfree(drv->cpumask);
> +       return ret;
> +}
> +device_initcall(arm64_idle_init);
> --
> 1.9.1
>
>
>

Reviewed-by: Ashwin Chaugule <ashwin.chaugule@linaro.org>

> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
