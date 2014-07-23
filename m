From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [PATCH v6 2/7] drivers: cpuidle: implement DT based idle states
 infrastructure
Date: Wed, 23 Jul 2014 18:07:45 +0200
Message-ID: <53CFDDD1.5030002@linaro.org>
References: <1405958786-17243-1-git-send-email-lorenzo.pieralisi@arm.com> <1405958786-17243-3-git-send-email-lorenzo.pieralisi@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wi0-f176.google.com ([209.85.212.176]:64987 "EHLO
	mail-wi0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752625AbaGWQHr (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 23 Jul 2014 12:07:47 -0400
Received: by mail-wi0-f176.google.com with SMTP id bs8so8138573wib.3
        for <linux-pm@vger.kernel.org>; Wed, 23 Jul 2014 09:07:46 -0700 (PDT)
In-Reply-To: <1405958786-17243-3-git-send-email-lorenzo.pieralisi@arm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org
Cc: devicetree@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>, Sudeep Holla <sudeep.holla@arm.com>, Catalin Marinas <catalin.marinas@arm.com>, Charles Garcia Tobin <Charles.Garcia-Tobin@arm.com>, Nicolas Pitre <nico@linaro.org>, Rob Herring <robh+dt@kernel.org>, Grant Likely <grant.likely@linaro.org>, Peter De Schrijver <pdeschrijver@nvidia.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>, Amit Kucheria <amit.kucheria@linaro.org>, Vincent Guittot <vincent.guittot@linaro.org>, Antti Miettinen <ananaza@iki.fi>, Stephen Boyd <sboyd@codeaurora.org>, Kevin Hilman <khilman@linaro.org>, Sebastian Capella <sebcape@gmail.com>, Tomasz Figa <t.figa@samsung.com>, Mark Brown <broonie@kernel.org>, Paul Walmsley <paul@pwsan.com>, Chander Kashyap <chander.kashyap@linaro.org>, Geoff Levand <geoff@infradead.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>

On 07/21/2014 06:06 PM, Lorenzo Pieralisi wrote:
> On most common ARM systems, the low-power states a CPU can be put int=
o are
> not discoverable in HW and require device tree bindings to describe
> power down suspend operations and idle states parameters.
>
> In order to enable DT based idle states and configure idle drivers, t=
his
> patch implements the bulk infrastructure required to parse the device=
 tree
> idle states bindings and initialize the corresponding CPUidle driver =
states
> data.
>
> The parsing API accepts a start index that defines the first idle sta=
te
> that should be initialized by the parsing code in order to give new a=
nd
> legacy driver flexibility over which states should be parsed using th=
e
> new DT mechanism.
>
> The idle states list is obtained from the first cpu in the driver
> cpumask, which implicitly means the parsing code expects idle states
> (and related list of phandles) to be the same for all CPUs in the
> CPUidle driver mask. The kernel does not check this assumption, it mu=
st
> be enforced by the bootloader to ensure correct system behaviour.
>
> Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>

This patch looks good for me but I have a couple of questions below.

> ---
>   drivers/cpuidle/Kconfig          |   8 +++
>   drivers/cpuidle/Makefile         |   1 +
>   drivers/cpuidle/dt_idle_states.c | 138 ++++++++++++++++++++++++++++=
+++++++++++
>   drivers/cpuidle/dt_idle_states.h |   5 ++
>   4 files changed, 152 insertions(+)
>   create mode 100644 drivers/cpuidle/dt_idle_states.c
>   create mode 100644 drivers/cpuidle/dt_idle_states.h
>
> diff --git a/drivers/cpuidle/Kconfig b/drivers/cpuidle/Kconfig
> index 1b96fb9..414e7a96 100644
> --- a/drivers/cpuidle/Kconfig
> +++ b/drivers/cpuidle/Kconfig
> @@ -30,6 +30,14 @@ config CPU_IDLE_GOV_MENU
>   	bool "Menu governor (for tickless system)"
>   	default y
>
> +config DT_IDLE_STATES
> +        bool "Idle states DT support"
> +	depends on ARM || ARM64
> +	help
> +	 Allows the CPU idle framework to initialize CPU idle drivers
> +	 state data by using DT provided nodes compliant with idle states
> +	 device tree bindings.
> +

Wouldn't make sense to make this as an hidden option and let the=20
different drivers to set DT_IDLE_STATES if they depend on it ?

>   menu "ARM CPU Idle Drivers"
>   depends on ARM
>   source "drivers/cpuidle/Kconfig.arm"
> diff --git a/drivers/cpuidle/Makefile b/drivers/cpuidle/Makefile
> index d8bb1ff..b27a062 100644
> --- a/drivers/cpuidle/Makefile
> +++ b/drivers/cpuidle/Makefile
> @@ -4,6 +4,7 @@
>
>   obj-y +=3D cpuidle.o driver.o governor.o sysfs.o governors/
>   obj-$(CONFIG_ARCH_NEEDS_CPU_IDLE_COUPLED) +=3D coupled.o
> +obj-$(CONFIG_DT_IDLE_STATES)		  +=3D dt_idle_states.o
>
>   ###################################################################=
###############
>   # ARM SoC drivers
> diff --git a/drivers/cpuidle/dt_idle_states.c b/drivers/cpuidle/dt_id=
le_states.c
> new file mode 100644
> index 0000000..5413132
> --- /dev/null
> +++ b/drivers/cpuidle/dt_idle_states.c
> @@ -0,0 +1,138 @@
> +/*
> + * DT idle states parsing code.
> + *
> + * Copyright (C) 2014 ARM Ltd.
> + * Author: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> + *
> + * This program is free software; you can redistribute it and/or mod=
ify
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
> +#include <linux/module.h>
> +#include <linux/of.h>
> +#include <linux/of_device.h>
> +
> +#include "dt_idle_states.h"
> +
> +static int init_state_node(struct cpuidle_state *idle_state,
> +			   struct device_node *state_node)
> +{
> +	int err;
> +
> +	err =3D of_property_read_u32(state_node, "wakeup-latency-us",
> +				   &idle_state->exit_latency);
> +	if (err) {
> +		u32 entry_latency, exit_latency;
> +
> +		err =3D of_property_read_u32(state_node, "entry-latency-us",
> +					   &entry_latency);
> +		if (err) {
> +			pr_debug(" * %s missing entry-latency-us property\n",
> +				 state_node->full_name);
> +			return -EINVAL;
> +		}
> +
> +		err =3D of_property_read_u32(state_node, "exit-latency-us",
> +					   &exit_latency);
> +		if (err) {
> +			pr_debug(" * %s missing exit-latency-us property\n",
> +				 state_node->full_name);
> +			return -EINVAL;
> +		}
> +		/*
> +		 * If wakeup-latency-us is missing, default to entry+exit
> +		 * latencies as defined in idle states bindings
> +		 */
> +		idle_state->exit_latency =3D entry_latency + exit_latency;
> +	}
> +
> +	err =3D of_property_read_u32(state_node, "min-residency-us",
> +				   &idle_state->target_residency);
> +	if (err) {
> +		pr_debug(" * %s missing min-residency-us property\n",
> +			     state_node->full_name);
> +		return -EINVAL;
> +	}
> +
> +	idle_state->flags =3D CPUIDLE_FLAG_TIME_VALID;
> +	if (of_property_read_bool(state_node, "local-timer-stop"))
> +		idle_state->flags |=3D CPUIDLE_FLAG_TIMER_STOP;
> +	/*
> +	 * TODO:
> +	 *	replace with kstrdup and pointer assignment when name
> +	 *	and desc become string pointers
> +	 */
> +	strncpy(idle_state->name, state_node->name, CPUIDLE_NAME_LEN - 1);
> +	strncpy(idle_state->desc, state_node->name, CPUIDLE_DESC_LEN - 1);
> +	return 0;
> +}
> +
> +/**
> + * dt_init_idle_driver() - Parse the DT idle states and initialize t=
he
> + *			   idle driver states array
> + *
> + * @drv:	  Pointer to CPU idle driver to be initialized
> + * @start_idx:    First idle state index to be initialized
> + *
> + * On success the states array in the cpuidle driver contains
> + * initialized entries in the states array, starting from index star=
t_idx.
> + *
> + * Return:
> + *	0 on success
> + *	<0 on failure
> + */
> +int dt_init_idle_driver(struct cpuidle_driver *drv, unsigned int sta=
rt_idx)
> +{
> +	unsigned int i, state_idx =3D start_idx;
> +	struct cpuidle_state *idle_state;
> +	struct device_node *state_node, *cpu_node;
> +
> +
> +	if (state_idx >=3D CPUIDLE_STATE_MAX)
> +		return -EINVAL;
> +	/*
> +	 * We get the idle states for the first logical cpu in the
> +	 * driver mask. The kernel does not check idle states on all
> +	 * cpus in the driver mask, they are assumed to be the same
> +	 * by default.
> +	 */
> +	cpu_node =3D of_cpu_device_node_get(cpumask_first(drv->cpumask));
> +
> +	for (i =3D 0; ; i++) {
> +		int err;
> +
> +		state_node =3D of_parse_phandle(cpu_node, "cpu-idle-states", i);
> +		if (!state_node)
> +			break;
> +
> +		if (state_idx =3D=3D CPUIDLE_STATE_MAX) {
> +			pr_warn("State index reached static CPU idle driver states array =
size\n");
> +			break;
> +		}
> +
> +		idle_state =3D &drv->states[state_idx++];
> +		err =3D init_state_node(idle_state, state_node);
> +		if (err)

As the init_state_node error traces are in pr_debug level, a pr_err=20
would help here IMO.

> +			return err;
> +	}
> +
> +	/*
> +	 * If no idle states are detected, return an error and let the idle
> +	 * driver initialization fail accordingly since initializing a driv=
er
> +	 * with simple WFI as an idle state is equivalent to letting the
> +	 * kernel run the default idle loop.
> +	 */
> +	if (!i)
> +		return -ENODATA;
> +
> +	drv->state_count =3D state_idx;
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(dt_init_idle_driver);
> diff --git a/drivers/cpuidle/dt_idle_states.h b/drivers/cpuidle/dt_id=
le_states.h
> new file mode 100644
> index 0000000..728c37c
> --- /dev/null
> +++ b/drivers/cpuidle/dt_idle_states.h
> @@ -0,0 +1,5 @@
> +#ifndef __DT_IDLE_STATES
> +#define __DT_IDLE_STATES
> +
> +int dt_init_idle_driver(struct cpuidle_driver *drv, unsigned int sta=
rt_idx);
> +#endif
>


--=20
  <http://www.linaro.org/> Linaro.org =E2=94=82 Open source software fo=
r ARM SoCs

=46ollow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

