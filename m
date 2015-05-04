From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [RFC PATCH v2 1/1] drivers: cpuidle: cpuidle-arm: heterogeneous
 systems extension
Date: Mon, 04 May 2015 15:19:15 +0200
Message-ID: <554771D3.5010701@linaro.org>
References: <1429200617-9546-1-git-send-email-lorenzo.pieralisi@arm.com> <1429200617-9546-2-git-send-email-lorenzo.pieralisi@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wg0-f44.google.com ([74.125.82.44]:34248 "EHLO
	mail-wg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752768AbbEDNTT (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 4 May 2015 09:19:19 -0400
Received: by wgso17 with SMTP id o17so149968747wgs.1
        for <linux-pm@vger.kernel.org>; Mon, 04 May 2015 06:19:18 -0700 (PDT)
In-Reply-To: <1429200617-9546-2-git-send-email-lorenzo.pieralisi@arm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org, devicetree@vger.kernel.org
Cc: Howard Chen <howard.chen@linaro.org>, Rob Herring <robh+dt@kernel.org>, Kevin Hilman <khilman@linaro.org>, Sudeep Holla <sudeep.holla@arm.com>, Lina Iyer <lina.iyer@linaro.org>, Grant Likely <grant.likely@linaro.org>, Mathieu Poirier <mathieu.poirier@linaro.org>, Mark Rutland <mark.rutland@arm.com>

On 04/16/2015 06:10 PM, Lorenzo Pieralisi wrote:
> Some ARM systems (eg big.LITTLE ones) can be composed of CPUs having
> different hardware power management configurations and in the context
> of CPUidle, different idle states. The generic ARM CPUidle driver
> treats all possible CPUs as equal and initializes a common idle drive=
r
> through DT idle states for all possible CPUs.
>
> Current driver cannot manage systems where CPUs are heterogeneous
> and therefore can have different idle states.
>
> This patch augments the generic ARM CPUidle driver, by adding code th=
at
> at boot initializes CPUidle drivers by going through the
> cpu_possible_mask and through DT parsing detects the cpus sharing the
> same idle states, thus creating the CPUidle drivers cpumasks.
>
> The drivers are then initialized through the DT idle states interface=
,
> that parses and initializes the DT idle states for the cpus set in th=
e
> drivers cpumasks.
>
> This patch instantiates a static array of idle drivers, some of which
> can turn out to be unused (eg platforms with uniform idle states
> on all possible CPUs), and relies on the config option
> CPU_IDLE_MULTIPLE_DRIVERS to be selected by default; this can cause a
> little memory overhead, but at the same time allows supporting most o=
f
> the current and future ARM platforms through a single generic CPUidle
> driver.
>
> Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> Cc: Howard Chen <howard.chen@linaro.org>
> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: Kevin Hilman <khilman@linaro.org>
> Cc: Sudeep Holla <sudeep.holla@arm.com>
> Cc: Lina Iyer <lina.iyer@linaro.org>
> Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
> Cc: Grant Likely <grant.likely@linaro.org>
> Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
> Cc: Mark Rutland <mark.rutland@arm.com>
> ---
>   drivers/cpuidle/Kconfig.arm   |   1 +
>   drivers/cpuidle/cpuidle-arm.c | 176 +++++++++++++++++++++++++++++++=
+++++------
>   2 files changed, 152 insertions(+), 25 deletions(-)
>
> diff --git a/drivers/cpuidle/Kconfig.arm b/drivers/cpuidle/Kconfig.ar=
m
> index 21340e0..90c6553 100644
> --- a/drivers/cpuidle/Kconfig.arm
> +++ b/drivers/cpuidle/Kconfig.arm
> @@ -3,6 +3,7 @@
>   #
>   config ARM_CPUIDLE
>           bool "Generic ARM/ARM64 CPU idle Driver"
> +        select CPU_IDLE_MULTIPLE_DRIVERS
>           select DT_IDLE_STATES
>           help
>             Select this to enable generic cpuidle driver for ARM.
> diff --git a/drivers/cpuidle/cpuidle-arm.c b/drivers/cpuidle/cpuidle-=
arm.c
> index 545069d..251fa2a 100644
> --- a/drivers/cpuidle/cpuidle-arm.c
> +++ b/drivers/cpuidle/cpuidle-arm.c
> @@ -14,6 +14,7 @@
>   #include <linux/cpuidle.h>
>   #include <linux/cpumask.h>
>   #include <linux/cpu_pm.h>
> +#include <linux/of_device.h>
>   #include <linux/kernel.h>
>   #include <linux/module.h>
>   #include <linux/of.h>
> @@ -58,23 +59,27 @@ static int arm_enter_idle_state(struct cpuidle_de=
vice *dev,
>   	return ret ? -1 : idx;
>   }
>
> -static struct cpuidle_driver arm_idle_driver =3D {
> -	.name =3D "arm_idle",
> -	.owner =3D THIS_MODULE,
> -	/*
> -	 * State at index 0 is standby wfi and considered standard
> -	 * on all ARM platforms. If in some platforms simple wfi
> -	 * can't be used as "state 0", DT bindings must be implemented
> -	 * to work around this issue and allow installing a special
> -	 * handler for idle state index 0.
> -	 */
> -	.states[0] =3D {
> -		.enter                  =3D arm_enter_idle_state,
> -		.exit_latency           =3D 1,
> -		.target_residency       =3D 1,
> -		.power_usage		=3D UINT_MAX,
> -		.name                   =3D "WFI",
> -		.desc                   =3D "ARM WFI",
> +#define ARM_CPUIDLE_MAX_DRIVERS	2
> +
> +static struct cpuidle_driver arm_idle_drivers[ARM_CPUIDLE_MAX_DRIVER=
S] =3D {
> +	[0 ... ARM_CPUIDLE_MAX_DRIVERS - 1] =3D {
> +		.name =3D "arm_idle",
> +		.owner =3D THIS_MODULE,
> +		/*
> +		 * State at index 0 is standby wfi and considered standard
> +		 * on all ARM platforms. If in some platforms simple wfi
> +		 * can't be used as "state 0", DT bindings must be implemented
> +		 * to work around this issue and allow installing a special
> +		 * handler for idle state index 0.
> +		 */
> +		.states[0] =3D {
> +			.enter                  =3D arm_enter_idle_state,
> +			.exit_latency           =3D 1,
> +			.target_residency       =3D 1,
> +			.power_usage		=3D UINT_MAX,
> +			.name                   =3D "WFI",
> +			.desc                   =3D "ARM WFI",
> +		}
>   	}
>   };
>
> @@ -85,17 +90,68 @@ static const struct of_device_id arm_idle_state_m=
atch[] __initconst =3D {
>   };
>
>   /*
> - * arm_idle_init
> + * Compare idle states phandle properties
>    *
> - * Registers the arm specific cpuidle driver with the cpuidle
> - * framework. It relies on core code to parse the idle states
> - * and initialize them using driver data structures accordingly.
> + * Return true if properties are valid and equal, false otherwise

Just a detail. Would be more consistent to return zero when valid and=20
equal ?

>    */
> -static int __init arm_idle_init(void)
> +static bool __init idle_states_cmp(struct property *states1,
> +				   struct property *states2)
> +{
> +	/*
> +	 * NB: Implemented through code from drivers/of/unittest.c
> +	 *     Function is generic and can be moved to generic OF code
> +	 *     if needed
> +	 */
> +	return states1 && states2 &&
> +	       (states1->length =3D=3D states2->length) &&
> +	       states1->value && states2->value &&
> +	       !memcmp(states1->value, states2->value, states1->length);
> +}
> +
> +static int __init arm_idle_init_driver(struct cpuidle_driver *drv)
>   {
> -	int cpu, ret;
> -	struct cpuidle_driver *drv =3D &arm_idle_driver;
> +	int ret, cpu;
>   	struct cpuidle_device *dev;
> +	struct property *curr_idle_states, *idle_states =3D NULL;
> +	struct device_node *cpu_node;
> +
> +	for_each_cpu(cpu, drv->cpumask) {
> +		cpu_node =3D of_cpu_device_node_get(cpu);
> +		curr_idle_states =3D of_find_property(cpu_node,
> +						    "cpu-idle-states", NULL);
> +		of_node_put(cpu_node);
> +
> +		/*
> +		 * Stash the first valid idle states phandle in the cpumask.
> +		 * If curr_idle_states is NULL assigning it to idle_states
> +		 * is harmless and it is managed by idle states comparison
> +		 * code. Keep track of first valid phandle so that
> +		 * subsequent cpus can compare against it.
> +		 */
> +		if (!idle_states)
> +			idle_states =3D curr_idle_states;
> +
> +		/*
> +		 * If idle states phandles are not equal, remove the
> +		 * cpu from the driver mask since a CPUidle driver
> +		 * is only capable of managing uniform idle states.
> +		 *
> +		 * Comparison works also when idle_states and
> +		 * curr_idle_states are the same property, since
> +		 * they can be =3D=3D NULL so the cpu must be removed from
> +		 * the driver mask in that case too (ie cpu has no idle
> +		 * states).
> +		 */
> +		if (!idle_states_cmp(idle_states, curr_idle_states))
> +			cpumask_clear_cpu(cpu, drv->cpumask);
> +	}
> +
> +	/*
> +	 *  If there are no valid states for this driver we rely on arch
> +	 *  default idle behaviour, bail out
> +	 */
> +	if (!idle_states)
> +		return -ENODEV;
>
>   	/*
>   	 * Initialize idle states data, starting at index 1.
> @@ -117,7 +173,7 @@ static int __init arm_idle_init(void)
>   	 * Call arch CPU operations in order to initialize
>   	 * idle states suspend back-end specific data
>   	 */
> -	for_each_possible_cpu(cpu) {
> +	for_each_cpu(cpu, drv->cpumask) {
>   		ret =3D arm_cpuidle_init(cpu);
>
>   		/*
> @@ -157,7 +213,77 @@ out_fail:
>   	}
>
>   	cpuidle_unregister_driver(drv);
> +	return ret;
> +}
> +
> +/*
> + * arm_idle_init
> + *
> + * Registers the arm specific cpuidle driver(s) with the cpuidle
> + * framework. It relies on core code to parse the idle states
> + * and initialize them using driver data structures accordingly.
> + */
> +static int __init arm_idle_init(void)
> +{
> +	int i, ret =3D -ENODEV;
> +	struct cpuidle_driver *drv;
> +	cpumask_var_t tmpmask;
> +
> +	/*
> +	 * These drivers require DT idle states to be present.
> +	 * If no idle states are detected there is no reason to
> +	 * proceed any further hence we return early.
> +	 */
> +	if (!of_find_node_by_name(NULL, "idle-states"))
> +		return -ENODEV;
> +
> +	if (!alloc_cpumask_var(&tmpmask, GFP_KERNEL))
> +		return -ENOMEM;
> +
> +	/*
> +	 * We need to vet idle states to create CPUidle drivers
> +	 * that share a common set of them. Create a tmp mask
> +	 * that we use to keep track of initialized cpus.
> +	 * Start off by initializing the mask with all possible
> +	 * cpus, we clear it as we go, till either all cpus
> +	 * have a CPUidle driver initialized or there are some
> +	 * CPUs that have no idle states or a parsing error
> +	 * occurs.
> +	 */
> +	cpumask_copy(tmpmask, cpu_possible_mask);
> +
> +	for (i =3D 0; !cpumask_empty(tmpmask); i++) {
> +		if (i =3D=3D ARM_CPUIDLE_MAX_DRIVERS) {
> +			pr_warn("number of drivers exceeding static allocation\n");
> +			break;
> +		}
> +
> +		drv =3D &arm_idle_drivers[i];
> +		drv->cpumask =3D kzalloc(cpumask_size(), GFP_KERNEL);
> +		if (!drv->cpumask) {
> +			ret =3D -ENOMEM;
> +			break;
> +		}
> +		/*
> +		 * Force driver mask, arm_idle_init_driver()
> +		 * will tweak it by vetting idle states.
> +		 */
> +		cpumask_copy(drv->cpumask, tmpmask);

Why do you need to copy tmpmask ? Isn't simpler to have a zero-ed=20
cpumask and let the arm_idle_init_driver function to set a bit instead=20
of clearing it ?

> +		ret =3D arm_idle_init_driver(drv);
> +		if (ret) {
> +			kfree(drv->cpumask);
> +			break;
> +		}
> +		/*
> +		 * Remove the cpus that were part of the registered
> +		 * driver from the mask of cpus to be initialized
> +		 * and restart.
> +		 */
> +		cpumask_andnot(tmpmask, tmpmask, drv->cpumask);

If there is a DT definition with just a cluster with the cpuidle driver=
=20
set and another one without any idle state, we will have always a=20
pr_warn because i =3D=3D ARM_CPUIDLE_MAX_DRIVERS due to tmpmask being n=
ever=20
equal to a zero mask. Is it the purpose to detect such cases ?

> +	}
>
> +	free_cpumask_var(tmpmask);
>   	return ret;
>   }
>   device_initcall(arm_idle_init);
>


--=20
  <http://www.linaro.org/> Linaro.org =E2=94=82 Open source software fo=
r ARM SoCs

=46ollow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

