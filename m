From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [PATCH 10/12] ARM: shmobile: r8a7740: Add CPUIdle
Date: Mon, 27 May 2013 13:03:31 +0200
Message-ID: <51A33D83.905@linaro.org>
References: <1369645193-3595-1-git-send-email-horms+renesas@verge.net.au> <1369645193-3595-11-git-send-email-horms+renesas@verge.net.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <1369645193-3595-11-git-send-email-horms+renesas@verge.net.au>
Sender: linux-sh-owner@vger.kernel.org
To: Simon Horman <horms+renesas@verge.net.au>
Cc: Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>, linux-sh@vger.kernel.org, Bastian Hecht <hechtb+renesas@gmail.com>, Magnus Damm <magnus.damm@gmail.com>, Bastian Hecht <hechtb@gmail.com>, arm@kernel.org, linux-arm-kernel@lists.infradead.org, "rafael >> \"'Rafael J. Wysocki'\"" <rafael.j.wysocki@intel.com>, Linux PM mailing list <linux-pm@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On 05/27/2013 10:59 AM, Simon Horman wrote:
> From: Bastian Hecht <hechtb@gmail.com>
>=20
> We make use of the r8a7740 Suspend To Ram code to plug together a
> CPUIdle driver.
>=20
> Signed-off-by: Bastian Hecht <hechtb+renesas@gmail.com>
> Acked-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> ---

Shouldn't it go through Rafael's tree ? Or does the patch contains some
dependencies on a code only visible in the ARM tree ?

>  arch/arm/mach-shmobile/Makefile               |    2 +-
>  arch/arm/mach-shmobile/cpuidle-r8a7740.c      |   62 +++++++++++++++=
++++++++++
>  arch/arm/mach-shmobile/include/mach/r8a7740.h |    1 +
>  arch/arm/mach-shmobile/pm-r8a7740.c           |    1 +
>  4 files changed, 65 insertions(+), 1 deletion(-)
>  create mode 100644 arch/arm/mach-shmobile/cpuidle-r8a7740.c
>=20
> diff --git a/arch/arm/mach-shmobile/Makefile b/arch/arm/mach-shmobile=
/Makefile
> index 0568894..2852dcf 100644
> --- a/arch/arm/mach-shmobile/Makefile
> +++ b/arch/arm/mach-shmobile/Makefile
> @@ -30,7 +30,7 @@ obj-$(CONFIG_SUSPEND)		+=3D suspend.o
>  obj-$(CONFIG_CPU_IDLE)		+=3D cpuidle.o
>  obj-$(CONFIG_ARCH_SHMOBILE)	+=3D pm-rmobile.o
>  obj-$(CONFIG_ARCH_SH7372)	+=3D pm-sh7372.o sleep-sh7372.o
> -obj-$(CONFIG_ARCH_R8A7740)	+=3D pm-r8a7740.o sleep-r8a7740.o
> +obj-$(CONFIG_ARCH_R8A7740)	+=3D pm-r8a7740.o sleep-r8a7740.o cpuidle=
-r8a7740.o
>  obj-$(CONFIG_ARCH_R8A7779)	+=3D pm-r8a7779.o
>  obj-$(CONFIG_ARCH_SH73A0)	+=3D pm-sh73a0.o
> =20
> diff --git a/arch/arm/mach-shmobile/cpuidle-r8a7740.c b/arch/arm/mach=
-shmobile/cpuidle-r8a7740.c
> new file mode 100644
> index 0000000..48c7a6c
> --- /dev/null
> +++ b/arch/arm/mach-shmobile/cpuidle-r8a7740.c
> @@ -0,0 +1,62 @@
> +/*
> + * CPUIdle code for SoC r8a7740
> + *
> + * Copyright (C) 2013 Bastian Hecht
> + *
> + * This file is subject to the terms and conditions of the GNU Gener=
al Public
> + * License.  See the file "COPYING" in the main directory of this ar=
chive
> + * for more details.
> + */
> +#include <linux/cpuidle.h>
> +#include <linux/module.h>
> +#include <asm/cpuidle.h>
> +#include <mach/common.h>
> +#include <mach/r8a7740.h>
> +
> +#if defined(CONFIG_SUSPEND) && defined(CONFIG_CPU_IDLE)
> +static int r8a7740_enter_a3sm_pll_on(struct cpuidle_device *dev,
> +					struct cpuidle_driver *drv, int index)
> +{
> +	r8a7740_enter_a3sm_common(1);
> +	return 1;
> +}
> +
> +static int r8a7740_enter_a3sm_pll_off(struct cpuidle_device *dev,
> +					struct cpuidle_driver *drv, int index)
> +{
> +	r8a7740_enter_a3sm_common(0);
> +	return 2;
> +}
> +
> +static struct cpuidle_driver r8a7740_cpuidle_driver =3D {
> +	.name			=3D "r8a7740_cpuidle",
> +	.owner			=3D THIS_MODULE,
> +	.en_core_tk_irqen	=3D 1,
> +	.state_count		=3D 3,
> +	.safe_state_index	=3D 0, /* C1 */
> +	.states[0] =3D ARM_CPUIDLE_WFI_STATE,
> +	.states[1] =3D {
> +		.name =3D "C2",
> +		.desc =3D "A3SM PLL ON",
> +		.exit_latency =3D 40,
> +		.target_residency =3D 30 + 40,
> +		.flags =3D CPUIDLE_FLAG_TIME_VALID,
> +		.enter =3D r8a7740_enter_a3sm_pll_on,
> +	},
> +	.states[2] =3D {
> +		.name =3D "C3",
> +		.desc =3D "A3SM PLL OFF",
> +		.exit_latency =3D 120,
> +		.target_residency =3D 30 + 120,
> +		.flags =3D CPUIDLE_FLAG_TIME_VALID,
> +		.enter =3D r8a7740_enter_a3sm_pll_off,
> +	},
> +};
> +
> +void r8a7740_cpuidle_init(void)
> +{
> +	shmobile_cpuidle_set_driver(&r8a7740_cpuidle_driver);
> +}
> +#else
> +void r8a7740_cpuidle_init(void) {}
> +#endif
> diff --git a/arch/arm/mach-shmobile/include/mach/r8a7740.h b/arch/arm=
/mach-shmobile/include/mach/r8a7740.h
> index 5cfe5d9..3b538e3 100644
> --- a/arch/arm/mach-shmobile/include/mach/r8a7740.h
> +++ b/arch/arm/mach-shmobile/include/mach/r8a7740.h
> @@ -545,6 +545,7 @@ extern void r8a7740_pinmux_init(void);
>  extern void r8a7740_pm_init(void);
>  extern void r8a7740_resume(void);
>  extern void r8a7740_shutdown(void);
> +extern void r8a7740_cpuidle_init(void);
>  extern void r8a7740_enter_a3sm_common(int);
> =20
>  #ifdef CONFIG_PM
> diff --git a/arch/arm/mach-shmobile/pm-r8a7740.c b/arch/arm/mach-shmo=
bile/pm-r8a7740.c
> index fe3c867..2f196bd 100644
> --- a/arch/arm/mach-shmobile/pm-r8a7740.c
> +++ b/arch/arm/mach-shmobile/pm-r8a7740.c
> @@ -237,4 +237,5 @@ static void r8a7740_suspend_init(void) {}
>  void __init r8a7740_pm_init(void)
>  {
>  	r8a7740_suspend_init();
> +	r8a7740_cpuidle_init();
>  }
>=20


--=20
 <http://www.linaro.org/> Linaro.org =E2=94=82 Open source software for=
 ARM SoCs

=46ollow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

