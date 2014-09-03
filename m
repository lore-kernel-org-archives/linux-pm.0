From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [PATCH v8 3/8] drivers: cpuidle: implement DT based idle states
 infrastructure
Date: Wed, 03 Sep 2014 15:25:39 +0200
Message-ID: <540716D3.2000502@linaro.org>
References: <1409585324-3678-1-git-send-email-lorenzo.pieralisi@arm.com> <1409585324-3678-4-git-send-email-lorenzo.pieralisi@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wg0-f47.google.com ([74.125.82.47]:44830 "EHLO
	mail-wg0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932596AbaICNZp (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 3 Sep 2014 09:25:45 -0400
Received: by mail-wg0-f47.google.com with SMTP id z12so8514825wgg.30
        for <linux-pm@vger.kernel.org>; Wed, 03 Sep 2014 06:25:43 -0700 (PDT)
In-Reply-To: <1409585324-3678-4-git-send-email-lorenzo.pieralisi@arm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org
Cc: devicetree@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>, Sudeep Holla <sudeep.holla@arm.com>, Catalin Marinas <catalin.marinas@arm.com>, Charles Garcia Tobin <Charles.Garcia-Tobin@arm.com>, Nicolas Pitre <nico@linaro.org>, Rob Herring <robh+dt@kernel.org>, Grant Likely <grant.likely@linaro.org>, Peter De Schrijver <pdeschrijver@nvidia.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>, Amit Kucheria <amit.kucheria@linaro.org>, Vincent Guittot <vincent.guittot@linaro.org>, Antti Miettinen <ananaza@iki.fi>, Stephen Boyd <sboyd@codeaurora.org>, Kevin Hilman <khilman@linaro.org>, Sebastian Capella <sebcape@gmail.com>, Tomasz Figa <t.figa@samsung.com>, Mark Brown <broonie@kernel.org>, Paul Walmsley <paul@pwsan.com>, Chander Kashyap <k.chander@samsung.com>, Geoff Levand <geoff@infradead.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Ashwin

On 09/01/2014 05:28 PM, Lorenzo Pieralisi wrote:
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
> The idle states node(s) is obtained from the phandle list of the firs=
t cpu
> in the driver cpumask;  the kernel checks that the idle state node ph=
andle
> is the same for all CPUs in the driver cpumask before declaring the i=
dle state
> as valid and start parsing its content.
>
> The idle state enter function pointer is initialized through DT match
> structures passed in by the CPUidle driver, so that ARM legacy code c=
an
> cope with platform specific idle entry method based on compatible
> string matching and the code used to initialize the enter function po=
inter
> can be moved to the DT generic layer.
>
> Acked-by: Catalin Marinas <catalin.marinas@arm.com>
> Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>

nice !

Acked-by: Daniel Lezcano <daniel.lezcano@linaro.org>

> ---
>   drivers/cpuidle/Kconfig          |   3 +
>   drivers/cpuidle/Makefile         |   1 +
>   drivers/cpuidle/dt_idle_states.c | 213 ++++++++++++++++++++++++++++=
+++++++++++
>   drivers/cpuidle/dt_idle_states.h |   7 ++
>   4 files changed, 224 insertions(+)
>   create mode 100644 drivers/cpuidle/dt_idle_states.c
>   create mode 100644 drivers/cpuidle/dt_idle_states.h
>
> diff --git a/drivers/cpuidle/Kconfig b/drivers/cpuidle/Kconfig
> index 32748c3..8deb934 100644
> --- a/drivers/cpuidle/Kconfig
> +++ b/drivers/cpuidle/Kconfig
> @@ -25,6 +25,9 @@ config CPU_IDLE_GOV_MENU
>   	bool "Menu governor (for tickless system)"
>   	default y
>
> +config DT_IDLE_STATES
> +	bool
> +
>   menu "ARM CPU Idle Drivers"
>   depends on ARM
>   source "drivers/cpuidle/Kconfig.arm"
> diff --git a/drivers/cpuidle/Makefile b/drivers/cpuidle/Makefile
> index 11edb31..002b653 100644
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
> index 0000000..52f4d11
> --- /dev/null
> +++ b/drivers/cpuidle/dt_idle_states.c
> @@ -0,0 +1,213 @@
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
> +			   const struct of_device_id *matches,
> +			   struct device_node *state_node)
> +{
> +	int err;
> +	const struct of_device_id *match_id;
> +
> +	match_id =3D of_match_node(matches, state_node);
> +	if (!match_id)
> +		return -ENODEV;
> +	/*
> +	 * CPUidle drivers are expected to initialize the const void *data
> +	 * pointer of the passed in struct of_device_id array to the idle
> +	 * state enter function.
> +	 */
> +	idle_state->enter =3D match_id->data;
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
> +/*
> + * Check that the idle state is uniform across all CPUs in the CPUid=
le driver
> + * cpumask
> + */
> +static bool idle_state_valid(struct device_node *state_node, unsigne=
d int idx,
> +			     const cpumask_t *cpumask)
> +{
> +	int cpu;
> +	struct device_node *cpu_node, *curr_state_node;
> +	bool valid =3D true;
> +
> +	/*
> +	 * Compare idle state phandles for index idx on all CPUs in the
> +	 * CPUidle driver cpumask. Start from next logical cpu following
> +	 * cpumask_first(cpumask) since that's the CPU state_node was
> +	 * retrieved from. If a mismatch is found bail out straight
> +	 * away since we certainly hit a firmware misconfiguration.
> +	 */
> +	for (cpu =3D cpumask_next(cpumask_first(cpumask), cpumask);
> +	     cpu < nr_cpu_ids; cpu =3D cpumask_next(cpu, cpumask)) {
> +		cpu_node =3D of_cpu_device_node_get(cpu);
> +		curr_state_node =3D of_parse_phandle(cpu_node, "cpu-idle-states",
> +						   idx);
> +		if (state_node !=3D curr_state_node)
> +			valid =3D false;
> +
> +		of_node_put(curr_state_node);
> +		of_node_put(cpu_node);
> +		if (!valid)
> +			break;
> +	}
> +
> +	return valid;
> +}
> +
> +/**
> + * dt_init_idle_driver() - Parse the DT idle states and initialize t=
he
> + *			   idle driver states array
> + * @drv:	  Pointer to CPU idle driver to be initialized
> + * @matches:	  Array of of_device_id match structures to search in f=
or
> + *		  compatible idle state nodes. The data pointer for each valid
> + *		  struct of_device_id entry in the matches array must point to
> + *		  a function with the following signature, that corresponds to
> + *		  the CPUidle state enter function signature:
> + *
> + *		  int (*)(struct cpuidle_device *dev,
> + *			  struct cpuidle_driver *drv,
> + *			  int index);
> + *
> + * @start_idx:    First idle state index to be initialized
> + *
> + * If DT idle states are detected and are valid the state count and =
states
> + * array entries in the cpuidle driver are initialized accordingly s=
tarting
> + * from index start_idx.
> + *
> + * Return: number of valid DT idle states parsed, <0 on failure
> + */
> +int dt_init_idle_driver(struct cpuidle_driver *drv,
> +			const struct of_device_id *matches,
> +			unsigned int start_idx)
> +{
> +	struct cpuidle_state *idle_state;
> +	struct device_node *state_node, *cpu_node;
> +	int i, err =3D 0;
> +	const cpumask_t *cpumask;
> +	unsigned int state_idx =3D start_idx;
> +
> +	if (state_idx >=3D CPUIDLE_STATE_MAX)
> +		return -EINVAL;
> +	/*
> +	 * We get the idle states for the first logical cpu in the
> +	 * driver mask (or cpu_possible_mask if the driver cpumask is not s=
et)
> +	 * and we check through idle_state_valid() if they are uniform
> +	 * across CPUs, otherwise we hit a firmware misconfiguration.
> +	 */
> +	cpumask =3D drv->cpumask ? : cpu_possible_mask;
> +	cpu_node =3D of_cpu_device_node_get(cpumask_first(cpumask));
> +
> +	for (i =3D 0; ; i++) {
> +		state_node =3D of_parse_phandle(cpu_node, "cpu-idle-states", i);
> +		if (!state_node)
> +			break;
> +
> +		if (!idle_state_valid(state_node, i, cpumask)) {
> +			pr_warn("%s idle state not valid, bailing out\n",
> +				state_node->full_name);
> +			err =3D -EINVAL;
> +			break;
> +		}
> +
> +		if (state_idx =3D=3D CPUIDLE_STATE_MAX) {
> +			pr_warn("State index reached static CPU idle driver states array =
size\n");
> +			break;
> +		}
> +
> +		idle_state =3D &drv->states[state_idx++];
> +		err =3D init_state_node(idle_state, matches, state_node);
> +		if (err) {
> +			pr_err("Parsing idle state node %s failed with err %d\n",
> +			       state_node->full_name, err);
> +			err =3D -EINVAL;
> +			break;
> +		}
> +		of_node_put(state_node);
> +	}
> +
> +	of_node_put(state_node);
> +	of_node_put(cpu_node);
> +	if (err)
> +		return err;
> +	/*
> +	 * Update the driver state count only if some valid DT idle states
> +	 * were detected
> +	 */
> +	if (i)
> +		drv->state_count =3D state_idx;
> +
> +	/*
> +	 * Return the number of present and valid DT idle states, which can
> +	 * also be 0 on platforms with missing DT idle states or legacy DT
> +	 * configuration predating the DT idle states bindings.
> +	 */
> +	return i;
> +}
> +EXPORT_SYMBOL_GPL(dt_init_idle_driver);
> diff --git a/drivers/cpuidle/dt_idle_states.h b/drivers/cpuidle/dt_id=
le_states.h
> new file mode 100644
> index 0000000..4818134
> --- /dev/null
> +++ b/drivers/cpuidle/dt_idle_states.h
> @@ -0,0 +1,7 @@
> +#ifndef __DT_IDLE_STATES
> +#define __DT_IDLE_STATES
> +
> +int dt_init_idle_driver(struct cpuidle_driver *drv,
> +			const struct of_device_id *matches,
> +			unsigned int start_idx);
> +#endif
>


--=20
  <http://www.linaro.org/> Linaro.org =E2=94=82 Open source software fo=
r ARM SoCs

=46ollow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

