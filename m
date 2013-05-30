From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [PATCH 3/3] ARM: tegra114: cpuidle: add powered-down state
Date: Thu, 30 May 2013 16:35:41 +0200
Message-ID: <51A763BD.6070001@linaro.org>
References: <1369912782-30663-1-git-send-email-josephl@nvidia.com> <1369912782-30663-4-git-send-email-josephl@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-bk0-f52.google.com ([209.85.214.52]:56177 "EHLO
	mail-bk0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932445Ab3E3Ofq (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 30 May 2013 10:35:46 -0400
Received: by mail-bk0-f52.google.com with SMTP id mz10so192438bkb.25
        for <linux-pm@vger.kernel.org>; Thu, 30 May 2013 07:35:45 -0700 (PDT)
In-Reply-To: <1369912782-30663-4-git-send-email-josephl@nvidia.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Joseph Lo <josephl@nvidia.com>
Cc: Stephen Warren <swarren@wwwdotorg.org>, linux-tegra@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Linux PM mailing list <linux-pm@vger.kernel.org>

On 05/30/2013 01:19 PM, Joseph Lo wrote:
> This supports CPU core power down on each CPU when CPU idle. When CPU=
 go
> into this state, it saves it's context and needs a proper configurati=
on
> in flow controller to power gate the CPU when CPU runs into WFI
> instruction. And the CPU also needs to set the IRQ as CPU power down =
idle
> wake up event in flow controller.
>=20
> Signed-off-by: Joseph Lo <josephl@nvidia.com>
> ---

Hi Joseph,

a new flag has been added in the cpuidle framework to let this one to
handle the timer broadcast : CPUIDLE_FLAG_TIMER_STOP

It is the commit b60e6a0eb0273132cbb60a9806abf5f47a4aee1c

You can get rid of the clockevent notify stuff by adding this flag to
the state.

Also, can you clarify why tegra3 code is used in tegra114 ?


>  arch/arm/mach-tegra/cpuidle-tegra114.c | 62 ++++++++++++++++++++++++=
+++++++++-
>  1 file changed, 61 insertions(+), 1 deletion(-)
>=20
> diff --git a/arch/arm/mach-tegra/cpuidle-tegra114.c b/arch/arm/mach-t=
egra/cpuidle-tegra114.c
> index 1d1c602..e7d21f5 100644
> --- a/arch/arm/mach-tegra/cpuidle-tegra114.c
> +++ b/arch/arm/mach-tegra/cpuidle-tegra114.c
> @@ -17,19 +17,79 @@
>  #include <linux/kernel.h>
>  #include <linux/module.h>
>  #include <linux/cpuidle.h>
> +#include <linux/cpu_pm.h>
> +#include <linux/clockchips.h>
> =20
>  #include <asm/cpuidle.h>
> +#include <asm/suspend.h>
> +#include <asm/smp_plat.h>
> +
> +#include "pm.h"
> +#include "sleep.h"
> +
> +#ifdef CONFIG_PM_SLEEP
> +static int tegra114_idle_power_down(struct cpuidle_device *dev,
> +				    struct cpuidle_driver *drv,
> +				    int index);

Isn't possible to move the driver declaration after the
tegra114_idle_power_down function, before the init function, so we
prevent a forward declaration ?

> +#define TEGRA114_MAX_STATES 2
> +#else
> +#define TEGRA114_MAX_STATES 1
> +#endif
> =20
>  static struct cpuidle_driver tegra_idle_driver =3D {
>  	.name =3D "tegra_idle",
>  	.owner =3D THIS_MODULE,
> -	.state_count =3D 1,
> +	.state_count =3D TEGRA114_MAX_STATES,
>  	.states =3D {
>  		[0] =3D ARM_CPUIDLE_WFI_STATE_PWR(600),
> +#ifdef CONFIG_PM_SLEEP
> +		[1] =3D {
> +			.enter			=3D tegra114_idle_power_down,
> +			.exit_latency		=3D 500,
> +			.target_residency	=3D 1000,
> +			.power_usage		=3D 0,
> +			.flags			=3D CPUIDLE_FLAG_TIME_VALID,
> +			.name			=3D "powered-down",
> +			.desc			=3D "CPU power gated",
> +		},
> +#endif
>  	},
>  };
> =20
> +#ifdef CONFIG_PM_SLEEP
> +static int tegra114_idle_power_down(struct cpuidle_device *dev,
> +				    struct cpuidle_driver *drv,
> +				    int index)
> +{
> +	u32 cpu =3D is_smp() ? cpu_logical_map(dev->cpu) : dev->cpu;

IMO, it is up to the tegra_set_cpu_in_lp2 / tegra_clear_cpu_in_lp2
functions to do the cpu map conversion instead of adding this into a
routine working with logical cpu.

> +	local_fiq_disable();
> +
> +	tegra_set_cpu_in_lp2(cpu);
> +	cpu_pm_enter();
> +
> +	clockevents_notify(CLOCK_EVT_NOTIFY_BROADCAST_ENTER, &dev->cpu);
> +	smp_wmb();

Why do you need a memory barrier here ?

> +	cpu_suspend(0, tegra30_sleep_cpu_secondary_finish);
> +
> +	clockevents_notify(CLOCK_EVT_NOTIFY_BROADCAST_EXIT, &dev->cpu);
> +
> +	cpu_pm_exit();
> +	tegra_clear_cpu_in_lp2(cpu);
> +
> +	local_fiq_enable();
> +
> +	smp_rmb();

Why do you need a memory barrier here ?

> +	return index;
> +}
> +#endif
> +
>  int __init tegra114_cpuidle_init(void)
>  {
> +#ifdef CONFIG_PM_SLEEP
> +	tegra_tear_down_cpu =3D tegra30_tear_down_cpu;
> +#endif

Doesn't this code should go in the pm.c file ?

>  	return cpuidle_register(&tegra_idle_driver, NULL);
>  }
>=20


--=20
 <http://www.linaro.org/> Linaro.org =E2=94=82 Open source software for=
 ARM SoCs

=46ollow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

