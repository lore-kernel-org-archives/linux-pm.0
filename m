From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [PATCH 4/7] cpuidle: calxeda: add support to use PSCI calls
Date: Mon, 29 Jul 2013 16:14:51 +0200
Message-ID: <51F678DB.3030308@linaro.org>
References: <1375048598-15637-1-git-send-email-robherring2@gmail.com> <1375048598-15637-5-git-send-email-robherring2@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-ea0-f179.google.com ([209.85.215.179]:61335 "EHLO
	mail-ea0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752810Ab3G2OOw (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 29 Jul 2013 10:14:52 -0400
Received: by mail-ea0-f179.google.com with SMTP id b10so531334eae.38
        for <linux-pm@vger.kernel.org>; Mon, 29 Jul 2013 07:14:50 -0700 (PDT)
In-Reply-To: <1375048598-15637-5-git-send-email-robherring2@gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Rob Herring <robherring2@gmail.com>
Cc: linux-arm-kernel@lists.infradead.org, Rob Herring <rob.herring@calxeda.com>, "Rafael J. Wysocki" <rjw@sisk.pl>, linux-pm@vger.kernel.org

On 07/28/2013 11:56 PM, Rob Herring wrote:
> From: Rob Herring <rob.herring@calxeda.com>
>=20
> This updates the Calxeda cpuidle driver to use PSCI calls to powergat=
e
> cores. This is needed to enable cpuidle for the ECX-2000.
>=20
> This could possibly become a generic PSCI driver, but there are no ot=
her
> PSCI users in the kernel other than mach-virt.
>=20
> Signed-off-by: Rob Herring <rob.herring@calxeda.com>
> Cc: "Rafael J. Wysocki" <rjw@sisk.pl>
> Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
> Cc: linux-pm@vger.kernel.org
> ---

Acked-by: Daniel Lezcano <daniel.lezcano@linaro.org>

Rob,

Shall I take the patch in my tree ?

Thanks
  -- Daniel


>  drivers/cpuidle/cpuidle-calxeda.c | 40 ++++++-----------------------=
----------
>  1 file changed, 6 insertions(+), 34 deletions(-)
>=20
> diff --git a/drivers/cpuidle/cpuidle-calxeda.c b/drivers/cpuidle/cpui=
dle-calxeda.c
> index 0e6e408..01cfecf3 100644
> --- a/drivers/cpuidle/cpuidle-calxeda.c
> +++ b/drivers/cpuidle/cpuidle-calxeda.c
> @@ -22,51 +22,23 @@
> =20
>  #include <linux/cpuidle.h>
>  #include <linux/init.h>
> -#include <linux/io.h>
>  #include <linux/of.h>
> -#include <linux/time.h>
> -#include <linux/delay.h>
> -#include <linux/suspend.h>
>  #include <asm/cpuidle.h>
> -#include <asm/proc-fns.h>
> -#include <asm/smp_scu.h>
>  #include <asm/suspend.h>
> -#include <asm/cacheflush.h>
> -#include <asm/cp15.h>
> -
> -extern void highbank_set_cpu_jump(int cpu, void *jump_addr);
> -extern void *scu_base_addr;
> -
> -static noinline void calxeda_idle_restore(void)
> -{
> -	set_cr(get_cr() | CR_C);
> -	set_auxcr(get_auxcr() | 0x40);
> -	scu_power_mode(scu_base_addr, SCU_PM_NORMAL);
> -}
> +#include <asm/psci.h>
> =20
>  static int calxeda_idle_finish(unsigned long val)
>  {
> -	/* Already flushed cache, but do it again as the outer cache functi=
ons
> -	 * dirty the cache with spinlocks */
> -	flush_cache_all();
> -
> -	set_auxcr(get_auxcr() & ~0x40);
> -	set_cr(get_cr() & ~CR_C);
> -
> -	scu_power_mode(scu_base_addr, SCU_PM_DORMANT);
> -
> -	cpu_do_idle();
> -
> -	/* Restore things if we didn't enter power-gating */
> -	calxeda_idle_restore();
> -	return 1;
> +	const struct psci_power_state ps =3D {
> +		.type =3D PSCI_POWER_STATE_TYPE_POWER_DOWN,
> +	};
> +	return psci_ops.cpu_suspend(ps, __pa(cpu_resume));
>  }
> =20
>  static int calxeda_pwrdown_idle(struct cpuidle_device *dev,
>  				struct cpuidle_driver *drv,
>  				int index)
>  {
> -	highbank_set_cpu_jump(smp_processor_id(), cpu_resume);
>  	cpu_suspend(0, calxeda_idle_finish);
>  	return index;
>  }
> @@ -90,7 +62,7 @@ static struct cpuidle_driver calxeda_idle_driver =3D=
 {
> =20
>  static int __init calxeda_cpuidle_init(void)
>  {
> -	if (!of_machine_is_compatible("calxeda,highbank"))
> +	if (!of_machine_is_compatible("calxeda,highbank") || !psci_ops.cpu_=
suspend)
>  		return -ENODEV;
> =20
>  	return cpuidle_register(&calxeda_idle_driver, NULL);
>=20


--=20
 <http://www.linaro.org/> Linaro.org =E2=94=82 Open source software for=
 ARM SoCs

=46ollow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

