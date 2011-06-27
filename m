From: Magnus Damm <magnus.damm@gmail.com>
Subject: Re: [PATCH 10/10 v6] ARM / shmobile: Support for I/O
 power domains for SH7372 (v8)
Date: Tue, 28 Jun 2011 08:21:20 +0900
Message-ID: <BANLkTi=UfhzhhQ1EcVNJPnoH_KQdXF5Ckg@mail.gmail.com>
References: <201106112223.04972.rjw@sisk.pl> <201106252331.43354.rjw@sisk.pl>
	<BANLkTi=2kiNh4YgiCxVUV+32XXL9_ya59g@mail.gmail.com>
	<201106272125.12700.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <201106272125.12700.rjw@sisk.pl>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: linux-sh@vger.kernel.org, Greg Kroah-Hartman <gregkh@suse.de>, LKML <linux-kernel@vger.kernel.org>, Linux PM mailing list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Tue, Jun 28, 2011 at 4:25 AM, Rafael J. Wysocki <rjw@sisk.pl> wrote:
> On Monday, June 27, 2011, Magnus Damm wrote:
>> On Sun, Jun 26, 2011 at 6:31 AM, Rafael J. Wysocki <rjw@sisk.pl> wrote:
>> > From: Rafael J. Wysocki <rjw@sisk.pl>
>> >
>> > Use the generic power domains support introduced by the previous
>> > patch to implement support for power domains on SH7372.
>> >
>> > Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
>> > Acked-by: Paul Mundt <lethal@linux-sh.org>
>> > ---
>>
>> Hi Rafael,
>>
>> Thanks for your work on this. I've been working on up-porting my A3RV
>> prototype, and I came across these minor details:
>>
>> > --- linux-2.6.orig/arch/arm/mach-shmobile/board-mackerel.c
>> > +++ linux-2.6/arch/arm/mach-shmobile/board-mackerel.c
>> > @@ -1582,6 +1582,10 @@ static void __init mackerel_init(void)
>> >
>> > =A0 =A0 =A0 =A0platform_add_devices(mackerel_devices, ARRAY_SIZE(macke=
rel_devices));
>> >
>> > + =A0 =A0 =A0 sh7372_init_pm_domain(SH7372_A4LC);
>> > + =A0 =A0 =A0 sh7372_add_device_to_domain(SH7372_A4LC, &lcdc_device);
>> > + =A0 =A0 =A0 sh7372_add_device_to_domain(SH7372_A4LC, &hdmi_lcdc_devi=
ce);
>> > +
>> > =A0 =A0 =A0 =A0hdmi_init_pm_clock();
>> > =A0 =A0 =A0 =A0sh7372_pm_init();
>> > =A0}
>> > Index: linux-2.6/arch/arm/mach-shmobile/include/mach/sh7372.h
>> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>> > --- linux-2.6.orig/arch/arm/mach-shmobile/include/mach/sh7372.h
>> > +++ linux-2.6/arch/arm/mach-shmobile/include/mach/sh7372.h
>> > @@ -12,6 +12,7 @@
>> > =A0#define __ASM_SH7372_H__
>> >
>> > =A0#include <linux/sh_clk.h>
>> > +#include <linux/pm_domain.h>
>> >
>> > =A0/*
>> > =A0* Pin Function Controller:
>> > @@ -470,4 +471,31 @@ extern struct clk sh7372_fsibck_clk;
>> > =A0extern struct clk sh7372_fsidiva_clk;
>> > =A0extern struct clk sh7372_fsidivb_clk;
>> >
>> > +struct platform_device;
>> > +
>> > +struct sh7372_pm_domain {
>> > + =A0 =A0 =A0 struct generic_pm_domain genpd;
>> > + =A0 =A0 =A0 unsigned int bit_shift;
>> > +};
>> > +
>> > +static inline struct sh7372_pm_domain *to_sh7372_pd(struct generic_pm=
_domain *d)
>> > +{
>> > + =A0 =A0 =A0 return container_of(d, struct sh7372_pm_domain, genpd);
>> > +}
>> > +
>> > +#ifdef CONFIG_PM
>> > +extern struct sh7372_pm_domain sh7372_a4lc_domain;
>> > +#define SH7372_A4LC =A0 =A0(&sh7372_a4lc_domain)
>> > +
>> > +extern void sh7372_init_pm_domain(struct sh7372_pm_domain *sh7372_pd);
>> > +extern void sh7372_add_device_to_domain(struct sh7372_pm_domain *sh73=
72_pd,
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 struct platform_device *pdev);
>> > +#else
>> > +#define SH7372_A4LC =A0 =A0NULL
>> > +
>> > +static inline void sh7372_init_pm_domain(struct sh7372_pm_domain *sh7=
372_pd) {}
>> > +static inline void sh7372_add_device_to_domain(struct sh7372_pm_domai=
n *pd,
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0struct platform_device *pdev) {}
>> > +#endif /* CONFIG_PM */
>> > +
>> > =A0#endif /* __ASM_SH7372_H__ */
>>
>> Wouldn't it be easier to simply get rid of SH7372_A4LC?
>
> Not really, because the code won't build for both CONFIG_PM_RUNTIME and
> CONFIG_SUSPEND unset (resulting in CONFIG_PM unset).
>
>> Perhaps you have some special intention behind your #define, but for me =
the
>> following change is working just fine:
>
> Well, if CONFIG_PM is unset, sh7372_a4lc is not defined.

True, but in the CONFIG_PM=3Dn case sh7372_a4lc is never used by
sh7372_init_pm_domain() or sh7372_add_device_to_domain().

How about letting the preprocessor do the work for us instead? This
certainly builds without SH7372_A4LC in case of CONFIG_PM=3Dn:

#else
#define sh7372_init_pm_domain(pd) do { } while(0)
#define sh7372_add_device_to_domain(pd, pdev) do { } while(0)
#endif /* CONFIG_PM */

Cheers,

/ magnus
