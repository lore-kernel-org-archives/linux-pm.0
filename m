From: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Subject: Re: [PATCH v2 4/5] ARM: EXYNOS: add exynos_get_boot_addr() helper
Date: Wed, 18 Mar 2015 16:21:33 +0100
Message-ID: <1426692093.23982.4.camel@AMDC1943>
References: <1426684197-22281-1-git-send-email-b.zolnierkie@samsung.com>
 <1426684197-22281-5-git-send-email-b.zolnierkie@samsung.com>
 <CAJKOXPf3pT=NFv31gNqkP=Sq6uacs4VfO6035o+rrLPRYZarLw@mail.gmail.com>
 <1554212.H7UVZkpb2L@amdc1032>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-reply-to: <1554212.H7UVZkpb2L@amdc1032>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: Kukjin Kim <kgene.kim@samsung.com>, Kukjin Kim <kgene@kernel.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, Tomasz Figa <tomasz.figa@gmail.com>, Colin Cross <ccross@google.com>, Kyungmin Park <kyungmin.park@samsung.com>, Marek Szyprowski <m.szyprowski@samsung.com>, linux-samsung-soc@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Russell King <rmk+kernel@arm.linux.org.uk>
List-Id: linux-pm@vger.kernel.org

On =C5=9Bro, 2015-03-18 at 16:18 +0100, Bartlomiej Zolnierkiewicz wrote=
:
> On Wednesday, March 18, 2015 02:43:49 PM Krzysztof Kozlowski wrote:
> > 2015-03-18 14:09 GMT+01:00 Bartlomiej Zolnierkiewicz <b.zolnierkie@=
samsung.com>:
> > > Add get_cpu_boot_addr() firmware operation and then
> > > exynos_get_boot_addr() helper.
> > >
> > > This is a preparation for adding coupled cpuidle support
> > > for Exynos3250 SoC.
> > >
> > > There should be no functional changes caused by this patch.
> > >
> > > Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
> > > Cc: Russell King <rmk+kernel@arm.linux.org.uk>
> > > Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.co=
m>
> > > ---
> > >  arch/arm/include/asm/firmware.h |  4 ++++
> > >  arch/arm/mach-exynos/firmware.c | 17 +++++++++++++++++
> > >  arch/arm/mach-exynos/platsmp.c  | 25 +++++++++++++++++++++++++
> > >  3 files changed, 46 insertions(+)
> > >
> > > diff --git a/arch/arm/include/asm/firmware.h b/arch/arm/include/a=
sm/firmware.h
> > > index 89aefe1..34c1d96 100644
> > > --- a/arch/arm/include/asm/firmware.h
> > > +++ b/arch/arm/include/asm/firmware.h
> > > @@ -34,6 +34,10 @@ struct firmware_ops {
> > >          */
> > >         int (*set_cpu_boot_addr)(int cpu, unsigned long boot_addr=
);
> > >         /*
> > > +        * Gets boot address of specified physical CPU
> > > +        */
> > > +       int (*get_cpu_boot_addr)(int cpu, unsigned long *boot_add=
r);
> > > +       /*
> > >          * Boots specified physical CPU
> > >          */
> > >         int (*cpu_boot)(int cpu);
> > > diff --git a/arch/arm/mach-exynos/firmware.c b/arch/arm/mach-exyn=
os/firmware.c
> > > index f236877..c9e4481 100644
> > > --- a/arch/arm/mach-exynos/firmware.c
> > > +++ b/arch/arm/mach-exynos/firmware.c
> > > @@ -104,6 +104,22 @@ static int exynos_set_cpu_boot_addr(int cpu,=
 unsigned long boot_addr)
> > >         return 0;
> > >  }
> > >
> > > +static int exynos_get_cpu_boot_addr(int cpu, unsigned long *boot=
_addr)
> > > +{
> > > +       void __iomem *boot_reg;
> > > +
> > > +       if (!sysram_ns_base_addr)
> > > +               return -ENODEV;
> > > +
> > > +       boot_reg =3D sysram_ns_base_addr + 0x1c;
> > > +
> > > +       if (soc_is_exynos4412())
> > > +               boot_reg +=3D 4 * cpu;
> > > +
> > > +       *boot_addr =3D __raw_readl(boot_reg);
> > > +       return 0;
> > > +}
> > > +
> > >  static int exynos_cpu_suspend(unsigned long arg)
> > >  {
> > >         flush_cache_all();
> > > @@ -138,6 +154,7 @@ static int exynos_resume(void)
> > >  static const struct firmware_ops exynos_firmware_ops =3D {
> > >         .do_idle                =3D IS_ENABLED(CONFIG_EXYNOS_CPU_=
SUSPEND) ? exynos_do_idle : NULL,
> > >         .set_cpu_boot_addr      =3D exynos_set_cpu_boot_addr,
> > > +       .get_cpu_boot_addr      =3D exynos_get_cpu_boot_addr,
> > >         .cpu_boot               =3D exynos_cpu_boot,
> > >         .suspend                =3D IS_ENABLED(CONFIG_PM_SLEEP) ?=
 exynos_suspend : NULL,
> > >         .resume                 =3D IS_ENABLED(CONFIG_EXYNOS_CPU_=
SUSPEND) ? exynos_resume : NULL,
> > > diff --git a/arch/arm/mach-exynos/platsmp.c b/arch/arm/mach-exyno=
s/platsmp.c
> > > index b7cfcdc..449edd1 100644
> > > --- a/arch/arm/mach-exynos/platsmp.c
> > > +++ b/arch/arm/mach-exynos/platsmp.c
> > > @@ -272,6 +272,31 @@ fail:
> > >         return ret;
> > >  }
> > >
> > > +static int exynos_get_boot_addr(u32 core_id, unsigned long *boot=
_addr)
> > > +{
> > > +       int ret;
> > > +
> > > +       /*
> > > +        * Try to get boot address using firmware first
> > > +        * and fall back to boot register if it fails.
> > > +        */
> > > +       ret =3D call_firmware_op(get_cpu_boot_addr, core_id, boot=
_addr);
> > > +       if (ret && ret !=3D -ENOSYS)
> > > +               goto fail;
> >=20
> > The exynos_get_cpu_boot_addr() returns ENODEV. Do you really want t=
o
> > check for ENOSYS here?
>=20
> Yes.  When secure firmware is not present on the board the call_firmw=
are_op()
> itself returns -ENOSYS (exynos_get_cpu_boot_addr() is not called in t=
his
> case) and it needs to be handled in a special way.

Right, my mistake. Rest looks good:

Reviewed-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>

Best regards,
Krzysztof
