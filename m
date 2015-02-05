From: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Subject: Re: [PATCH] ARM: EXYNOS: cpuidle: Fix build breakage on !SMP
Date: Thu, 05 Feb 2015 08:12:20 +0100
Message-ID: <1423120340.29408.0.camel@AMDC1943>
References: <1423045646-20592-1-git-send-email-k.kozlowski@samsung.com>
 <8043345.BDfdhXvZOx@amdc1032>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <8043345.BDfdhXvZOx@amdc1032>
Sender: linux-kernel-owner@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>, Kukjin Kim <kgene@kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org, linux-samsung-soc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Marek Szyprowski <m.szyprowski@samsung.com>, Kyungmin Park <kyungmin.park@samsung.com>
List-Id: linux-pm@vger.kernel.org

On =C5=9Bro, 2015-02-04 at 19:07 +0100, Bartlomiej Zolnierkiewicz wrote=
:
> Hi,
>=20
> On Wednesday, February 04, 2015 11:27:26 AM Krzysztof Kozlowski wrote=
:
> > The Exynos cpuidle driver has coupled cpuidle built-in so it cannot=
 be
> > built without SMP:
> >=20
> > arch/arm/mach-exynos/pm.c: In function =E2=80=98exynos_cpu0_enter_a=
ftr=E2=80=99:
> > arch/arm/mach-exynos/pm.c:246:4: error: implicit declaration of fun=
ction =E2=80=98arch_send_wakeup_ipi_mask=E2=80=99 [-Werror=3Dimplicit-f=
unction-declaration]
> > arch/arm/mach-exynos/built-in.o: In function `exynos_pre_enter_aftr=
':
> > ../arch/arm/mach-exynos/pm.c:300: undefined reference to `cpu_boot_=
reg_base'
> > arch/arm/mach-exynos/built-in.o: In function `exynos_cpu1_powerdown=
':
> > ../arch/arm/mach-exynos/pm.c:282: undefined reference to `exynos_cp=
u_power_down'
> >=20
> > Make the cpuidle driver depending on SMP because this will be the
> > fastest way to fix build break without adding a bunch of ifdefs in =
few
> > places.
>=20
> There shouldn't be a lot of new ifdefs (please see below) and I would
> very much prefer for cpuidle to stay supported also on UP kernels.

Sure, I'm fine with your patch.

Best regards,
Krzysztof

>=20
> > Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
> > ---
> >  arch/arm/mach-exynos/pm.c   | 2 ++
> >  drivers/cpuidle/Kconfig.arm | 3 ++-
> >  2 files changed, 4 insertions(+), 1 deletion(-)
> >=20
> > diff --git a/arch/arm/mach-exynos/pm.c b/arch/arm/mach-exynos/pm.c
> > index e6209dadc00d..17db00ff7f3a 100644
> > --- a/arch/arm/mach-exynos/pm.c
> > +++ b/arch/arm/mach-exynos/pm.c
> > @@ -181,6 +181,7 @@ void exynos_enter_aftr(void)
> >  	cpu_pm_exit();
> >  }
> > =20
> > +#ifdef CONFIG_ARM_EXYNOS_CPUIDLE
> >  static atomic_t cpu1_wakeup =3D ATOMIC_INIT(0);
> > =20
> >  static int exynos_cpu0_enter_aftr(void)
> > @@ -302,3 +303,4 @@ struct cpuidle_exynos_data cpuidle_coupled_exyn=
os_data =3D {
> >  	.pre_enter_aftr		=3D exynos_pre_enter_aftr,
> >  	.post_enter_aftr		=3D exynos_post_enter_aftr,
> >  };
> > +#endif /* CONFIG_ARM_EXYNOS_CPUIDLE */
> > diff --git a/drivers/cpuidle/Kconfig.arm b/drivers/cpuidle/Kconfig.=
arm
> > index 8e07c9419153..5eb86a4f74d9 100644
> > --- a/drivers/cpuidle/Kconfig.arm
> > +++ b/drivers/cpuidle/Kconfig.arm
> > @@ -55,7 +55,8 @@ config ARM_AT91_CPUIDLE
> >  config ARM_EXYNOS_CPUIDLE
> >  	bool "Cpu Idle Driver for the Exynos processors"
> >  	depends on ARCH_EXYNOS
> > -	select ARCH_NEEDS_CPU_IDLE_COUPLED if SMP
> > +	depends on SMP
> > +	select ARCH_NEEDS_CPU_IDLE_COUPLED
> >  	help
> >  	  Select this to enable cpuidle for Exynos processors
>=20
> How's about the patch below instead?  It builds fine for UP and SMP.
> I will do more testing tomorrow (unfortunately it seems that somethin=
g
> else broke Origen4210 in -next).
>=20
> From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
> Subject: [PATCH] ARM: EXYNOS: cpuidle: Fix build breakage on !SMP
>=20
> The Exynos cpuidle driver has coupled cpuidle built-in so it cannot b=
e
> built without SMP:
>=20
> arch/arm/mach-exynos/pm.c: In function =E2=80=98exynos_cpu0_enter_aft=
r=E2=80=99:
> arch/arm/mach-exynos/pm.c:246:4: error: implicit declaration of funct=
ion =E2=80=98arch_send_wakeup_ipi_mask=E2=80=99 [-Werror=3Dimplicit-fun=
ction-declaration]
> arch/arm/mach-exynos/built-in.o: In function `exynos_pre_enter_aftr':
> ../arch/arm/mach-exynos/pm.c:300: undefined reference to `cpu_boot_re=
g_base'
> arch/arm/mach-exynos/built-in.o: In function `exynos_cpu1_powerdown':
> ../arch/arm/mach-exynos/pm.c:282: undefined reference to `exynos_cpu_=
power_down'
>=20
> Fix it by adding missing checks for SMP.
>=20
> Reported-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
> Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
> ---
>  arch/arm/mach-exynos/exynos.c    |    2 +-
>  arch/arm/mach-exynos/pm.c        |    2 ++
>  drivers/cpuidle/cpuidle-exynos.c |    3 ++-
>  3 files changed, 5 insertions(+), 2 deletions(-)
>=20
> Index: b/arch/arm/mach-exynos/exynos.c
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- a/arch/arm/mach-exynos/exynos.c	2015-02-04 18:30:23.555819717 +01=
00
> +++ b/arch/arm/mach-exynos/exynos.c	2015-02-04 18:43:23.539807815 +01=
00
> @@ -211,7 +211,7 @@ static void __init exynos_dt_machine_ini
>  	if (!IS_ENABLED(CONFIG_SMP))
>  		exynos_sysram_init();
> =20
> -#ifdef CONFIG_ARM_EXYNOS_CPUIDLE
> +#if defined(CONFIG_SMP) && defined(CONFIG_ARM_EXYNOS_CPUIDLE)
>  	if (of_machine_is_compatible("samsung,exynos4210"))
>  		exynos_cpuidle.dev.platform_data =3D &cpuidle_coupled_exynos_data;
>  #endif
> Index: b/arch/arm/mach-exynos/pm.c
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- a/arch/arm/mach-exynos/pm.c	2015-02-04 18:30:23.563819719 +0100
> +++ b/arch/arm/mach-exynos/pm.c	2015-02-04 18:47:32.951804008 +0100
> @@ -181,6 +181,7 @@ void exynos_enter_aftr(void)
>  	cpu_pm_exit();
>  }
> =20
> +#if defined(CONFIG_SMP) && defined(CONFIG_ARM_EXYNOS_CPUIDLE)
>  static atomic_t cpu1_wakeup =3D ATOMIC_INIT(0);
> =20
>  static int exynos_cpu0_enter_aftr(void)
> @@ -302,3 +303,4 @@ struct cpuidle_exynos_data cpuidle_coupl
>  	.pre_enter_aftr		=3D exynos_pre_enter_aftr,
>  	.post_enter_aftr		=3D exynos_post_enter_aftr,
>  };
> +#endif /* CONFIG_SMP && CONFIG_ARM_EXYNOS_CPUIDLE */
> Index: b/drivers/cpuidle/cpuidle-exynos.c
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- a/drivers/cpuidle/cpuidle-exynos.c	2015-02-04 18:30:32.935819577 =
+0100
> +++ b/drivers/cpuidle/cpuidle-exynos.c	2015-02-04 18:46:01.619805400 =
+0100
> @@ -117,7 +117,8 @@ static int exynos_cpuidle_probe(struct p
>  {
>  	int ret;
> =20
> -	if (of_machine_is_compatible("samsung,exynos4210")) {
> +	if (IS_ENABLED(CONFIG_SMP) &&
> +	    of_machine_is_compatible("samsung,exynos4210")) {
>  		exynos_cpuidle_pdata =3D pdev->dev.platform_data;
> =20
>  		ret =3D cpuidle_register(&exynos_coupled_idle_driver,
