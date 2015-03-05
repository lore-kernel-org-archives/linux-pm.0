From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [RFC/PATCH 4/6] ARM: shmobile: r8a7791: Add Core-Standby CPUIdle
 support for r8a7791
Date: Thu, 05 Mar 2015 19:11:48 +0100
Message-ID: <54F89C64.2050605@linaro.org>
References: <1425444946-3084-1-git-send-email-keita.kobayashi.ym@renesas.com> <1425444946-3084-5-git-send-email-keita.kobayashi.ym@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-we0-f178.google.com ([74.125.82.178]:43110 "EHLO
	mail-we0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756802AbbCESLw (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 5 Mar 2015 13:11:52 -0500
Received: by wesu56 with SMTP id u56so54637062wes.10
        for <linux-pm@vger.kernel.org>; Thu, 05 Mar 2015 10:11:51 -0800 (PST)
In-Reply-To: <1425444946-3084-5-git-send-email-keita.kobayashi.ym@renesas.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Keita Kobayashi <keita.kobayashi.ym@renesas.com>, horms@verge.net.au, rjw@rjwysocki.net
Cc: linux-sh@vger.kernel.org, linux-pm@vger.kernel.org, magnus.damm@gmail.com

On 03/04/2015 05:55 AM, Keita Kobayashi wrote:
> This patch Add the wfi and Core-Standby for CPUIdle power states
> support for the r8a7791 SoC.
>
> Signed-off-by: Keita Kobayashi <keita.kobayashi.ym@renesas.com>
> ---
>   arch/arm/mach-shmobile/pm-r8a7791.c | 41 ++++++++++++++++++++++++++=
+++++++++++
>   1 file changed, 41 insertions(+)
>
> diff --git a/arch/arm/mach-shmobile/pm-r8a7791.c b/arch/arm/mach-shmo=
bile/pm-r8a7791.c
> index 25f107b..6c00d37 100644
> --- a/arch/arm/mach-shmobile/pm-r8a7791.c
> +++ b/arch/arm/mach-shmobile/pm-r8a7791.c
> @@ -10,8 +10,13 @@
>    * for more details.
>    */
>
> +#include <linux/cpuidle.h>
>   #include <linux/kernel.h>
>   #include <linux/smp.h>
> +#include <linux/platform_data/renesas-cpuidle.h>
> +#include <linux/pm.h>
> +#include <asm/cpuidle.h>
> +#include <asm/cputype.h>
>   #include <asm/io.h>
>   #include "common.h"
>   #include "pm-rcar.h"
> @@ -43,6 +48,41 @@ static inline void r8a7791_sysc_init(void) {}
>
>   #endif /* CONFIG_SMP */
>
> +#ifdef CONFIG_ARM_RENESAS_CPUIDLE
> +static struct cpuidle_driver r8a7791_cpuidle_driver =3D {
> +	.name =3D "rcar_r8a7791_cpuidle",
> +	.owner =3D THIS_MODULE,
> +	.states =3D {
> +		[0] =3D ARM_CPUIDLE_WFI_STATE,
> +		[1] =3D {
> +			.name =3D "Core-Standby",
> +			.desc =3D "Core Standby Mode",
> +			.exit_latency =3D 2800,
> +			.target_residency =3D 2800,
> +			.enter =3D shmobile_smp_apmu_enter_cpuidle,
> +		},
> +	},
> +	.state_count =3D 2,
> +};

It would be nice to have the code self contained. I am pretty sure this=
=20
possible to have the cpuidle bits into drivers/cpuidle and the low leve=
l=20
pm code here.

> +static struct renesas_cpuidle_driver r8a7791_cpuidle =3D {
> +	.target_cpu	=3D ARM_CPU_PART_CORTEX_A15,
> +	.renesas_drv	=3D &r8a7791_cpuidle_driver,
> +};
> +
> +static struct renesas_cpuidle r8a7791_data =3D {
> +	.num_drvs	=3D 1,
> +	.rcd		=3D &r8a7791_cpuidle,
> +};
> +
> +static void __init r8a7791_cpuidle_init(void)
> +{
> +	shmobile_cpuidle_set_driver(&r8a7791_data);
> +}
> +#else
> +static void __init r8a7791_cpuidle_init(void) {}
> +#endif
> +
>   void __init r8a7791_pm_init(void)
>   {
>   	void __iomem *p;
> @@ -70,4 +110,5 @@ void __init r8a7791_pm_init(void)
>
>   	r8a7791_sysc_init();
>   	shmobile_smp_apmu_suspend_init();
> +	r8a7791_cpuidle_init();
>   }
>


--=20
  <http://www.linaro.org/> Linaro.org =E2=94=82 Open source software fo=
r ARM SoCs

=46ollow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

