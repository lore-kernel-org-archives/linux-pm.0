From: Sebastian Reichel <sre@kernel.org>
Subject: Re: [RFC PATCH v1 13/13] watchdog: bd70528: Initial support for ROHM
 BD70528 watchdog block
Date: Wed, 23 Jan 2019 18:47:28 +0100
Message-ID: <20190123174728.uu7zhno5xea2bga7@earth.universe>
References: <cover.1548149337.git.matti.vaittinen@fi.rohmeurope.com>
 <ec70833179d1953dbc91e01901b79d3319ff013d.1548149337.git.matti.vaittinen@fi.rohmeurope.com>
 <20190122154750.GB1705@roeck-us.net>
 <20190122171023.GC2559@localhost.localdomain>
 <20190122174056.GB4964@roeck-us.net>
 <20190122180309.GD2559@localhost.localdomain>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="yuldro3lnu75a5w4"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190122180309.GD2559@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
To: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Cc: Guenter Roeck <linux@roeck-us.net>, mazziesaccount@gmail.com, lee.jones@linaro.org, robh+dt@kernel.org, mark.rutland@arm.com, lgirdwood@gmail.com, broonie@kernel.org, gregkh@linuxfoundation.org, rafael@kernel.org, mturquette@baylibre.com, sboyd@kernel.org, linus.walleij@linaro.org, bgolaszewski@baylibre.com, a.zummo@towertech.it, alexandre.belloni@bootlin.com, wim@linux-watchdog.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org, linux-gpio@vger.kernel.org, linux-pm@vger.kernel.org, linux-rtc@vger.kernel.org, linux-watchdog@vger.kernel.org, mikko.mutanen@fi.rohmeurope.com, heikki.haikola@fi.rohmeurope.com
List-Id: linux-pm@vger.kernel.org


--yuldro3lnu75a5w4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Jan 22, 2019 at 08:03:09PM +0200, Matti Vaittinen wrote:
> On Tue, Jan 22, 2019 at 09:40:56AM -0800, Guenter Roeck wrote:
> > On Tue, Jan 22, 2019 at 07:10:23PM +0200, Matti Vaittinen wrote:
> > > On Tue, Jan 22, 2019 at 07:47:50AM -0800, Guenter Roeck wrote:
> > > > On Tue, Jan 22, 2019 at 11:48:36AM +0200, Matti Vaittinen wrote:
> > > > > Initial support for watchdog block included in ROHM BD70528
> > > > > power management IC.
> > > > >=20
> > > > > Configurations for low power states are still to be checked.
> > > > >=20
> > > > > Signed-off-by: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
> > > > > ---
> > > > >  drivers/watchdog/Kconfig       |  12 +++
> > > > >  drivers/watchdog/Makefile      |   1 +
> > > > >  drivers/watchdog/bd70528_wdt.c | 161 +++++++++++++++++++++++++++=
++++++++++++++
> > > > >  3 files changed, 174 insertions(+)
> > > > >  create mode 100644 drivers/watchdog/bd70528_wdt.c
> > > > >=20
> > > > > diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
> > > > > index 57f017d74a97..f30e3a3e886e 100644
> > > > > --- a/drivers/watchdog/Kconfig
> > > > > +++ b/drivers/watchdog/Kconfig
> > > > > @@ -90,6 +90,18 @@ config SOFT_WATCHDOG_PRETIMEOUT
> > > > >  	  watchdog. Be aware that governors might affect the watchdog b=
ecause it
> > > > >  	  is purely software, e.g. the panic governor will stall it!
> > > > > =20
> > > > > +config BD70528_WATCHDOG
> > > > > +	tristate "ROHM BD70528 PMIC Watchdog"
> > > > > +	depends on MFD_ROHM_BD70528
> > > > > +	select WATCHDOG_CORE
> > > > > +	help
> > > > > +	  Support for the watchdog in the ROHM BD70528 PMIC. Watchdog t=
rigger
> > > > > +	  cause system reset.
> > > > > +
> > > > > +	  Say Y here to include support for the ROHM BD70528 watchdog.
> > > > > +	  Alternatively say M to compile the driver as a module,
> > > > > +	  which will be called bd70528_wdt.
> > > > > +
> > > > >  config DA9052_WATCHDOG
> > > > >  	tristate "Dialog DA9052 Watchdog"
> > > > >  	depends on PMIC_DA9052 || COMPILE_TEST
> > > > > diff --git a/drivers/watchdog/Makefile b/drivers/watchdog/Makefile
> > > > > index a0917ef28e07..1ce87a3b1172 100644
> > > > > --- a/drivers/watchdog/Makefile
> > > > > +++ b/drivers/watchdog/Makefile
> > > > > @@ -204,6 +204,7 @@ obj-$(CONFIG_WATCHDOG_SUN4V)		+=3D sun4v_wdt.o
> > > > >  obj-$(CONFIG_XEN_WDT) +=3D xen_wdt.o
> > > > > =20
> > > > >  # Architecture Independent
> > > > > +obj-$(CONFIG_BD70528_WATCHDOG) +=3D bd70528_wdt.o
> > > > >  obj-$(CONFIG_DA9052_WATCHDOG) +=3D da9052_wdt.o
> > > > >  obj-$(CONFIG_DA9055_WATCHDOG) +=3D da9055_wdt.o
> > > > >  obj-$(CONFIG_DA9062_WATCHDOG) +=3D da9062_wdt.o
> > > > > diff --git a/drivers/watchdog/bd70528_wdt.c b/drivers/watchdog/bd=
70528_wdt.c
> > > > > new file mode 100644
> > > > > index 000000000000..e9a32566f595
> > > > > --- /dev/null
> > > > > +++ b/drivers/watchdog/bd70528_wdt.c
> > > > > @@ -0,0 +1,161 @@
> > > > > +// SPDX-License-Identifier: GPL-2.0
> > > > > +// Copyright (C) 2018 ROHM Semiconductors
> > > > > +// ROHM BD70528MWV watchdog driver
> > > > > +
> > > > > +#include <linux/bcd.h>
> > > > > +#include <linux/kernel.h>
> > > > > +#include <linux/mfd/rohm-bd70528.h>
> > > > > +#include <linux/module.h>
> > > > > +#include <linux/of.h>
> > > > > +#include <linux/platform_device.h>
> > > > > +#include <linux/regmap.h>
> > > > > +#include <linux/watchdog.h>
> > > > > +
> > > > > +static int bd70528_wdt_set(struct bd70528 *bd70528, int enable)
> > > > > +{
> > > > > +	int ret;
> > > > > +
> > > > > +	if (bd70528->rtc_timer_lock)
> > > > > +		mutex_lock(bd70528->rtc_timer_lock);
> > > >=20
> > > > This looks awkward. I don't think the if() is necessary.
> > >=20
> > > Right. Now when only bd70528 MFD driver uses this WDT this if is not
> > > required.
> > >=20
> > That doesn't warrant the conditional. It just bloats the code.
> > If there is only one user, the mutex will always be acquired.
>=20
> Yep. What I meant was that the only possible parent is bd70528 MFD
> driver which always initializes the mutex pointer. So pointer should be
> always set. I can imagine some other ROHM PMIC having almost identical
> watchdog block - in which case we might want to re-use this WDT driver
> with this PMIC. And if this PMIC has no RTC, then we may not need this
> mutex. But this is all speculation and I will remove check - or see how
> this changes when I see what to do with the driver's private data.
>=20
> > > > > +static const struct watchdog_info bd70528_wdt_info =3D {
> > > > > +	.identity =3D "bd70528-wdt",
> > > > > +	.options =3D WDIOF_SETTIMEOUT | WDIOF_KEEPALIVEPING | WDIOF_MAG=
ICCLOSE,
> > > > > +};
> > > > > +
> > > > > +static const struct watchdog_ops bd70528_wdt_ops =3D {
> > > > > +	.start		=3D bd70528_wdt_start,
> > > > > +	.stop		=3D bd70528_wdt_stop,
> > > > > +	/*
> > > > > +	 *  bd70528 WDT ping is same as enable. Eg, writing 'enable' to=
 enabled
> > > > > +	 * WDT will restart the timeout
> > > > > +	 */
> > > > Unnecessary comment.
> > > >=20
> > >=20
> > > Ok. I will remove the comment if this is obvious to others. For me it
> > > was not obvious. I was first writing a separate ping and start functi=
ons
> > > untill I realized that it is the same operation. But this was my first
> > > WDT driver so I don't know if this is a normal for all WDTs.
> > >=20
> > It is documented as part of the API.
> I'd better read the documentation then. Thanks for pointing this out.
> I'll remove the comment.
>=20
> > > > > +static int bd70528_wdt_probe(struct platform_device *pdev)
> > > > > +{
> > > > > +	struct bd70528 *tmp;
> > > > > +	struct bd70528 *bd70528;
> > > > > +	int ret;
> > > > > +
> > > > > +	tmp =3D dev_get_drvdata(pdev->dev.parent);
> > > > > +	if (!tmp) {
> > > > > +		dev_err(&pdev->dev, "No MFD driver data\n");
> > > > > +		return -EINVAL;
> > > > > +	}
> > > > > +	bd70528 =3D devm_kzalloc(&pdev->dev, sizeof(*bd70528), GFP_KERN=
EL);
> > > > > +	if (!bd70528)
> > > > > +		return -ENOMEM;
> > > > > +
> > > > > +	*bd70528 =3D *tmp;
> > > > > +	bd70528->chip.dev =3D &pdev->dev;
> > > >=20
> > > > This is wrong.
> > > > You should not copy the parent's driver data but have local driver
> > > > data as needed which then points to the parent's driver data if
> > > > needed. I assume this is why the mutex is a pointer, but that
> > > > just shows that the whole approach is wrong.
> > >=20
> > > Mutex is a pointer because we want to use same mutex from WDT and RTC.
> > > We can sure point to parent data but then we still need our own dev
> > > pointer. So we can have a struct with pointer to parent data and dev
> > > pointer - but I'm not at all sure it is any clearer.
> >=20
> > As I said, that is wrong. To say it in plaintext, I won't accept
> > the driver if it copies the parent's driver data. The driver should
> > have and use its own driver data, and only maintain a pointer to
> > its parent's driver data. And most definitely you don't want to
> > copy and use any device data structure from the parent.
>=20
> Allright. At the moment the WDT driver only needs regmap pointer from
> parent. I'm not sure if it will later need DT or "chip type" - but I
> will change this.

You probably want to use this:

dev_get_regmap(pdev->dev.parent, NULL);

-- Sebastian

--yuldro3lnu75a5w4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAlxIqK0ACgkQ2O7X88g7
+pqNGQ/+KAoHYFu1wj/LtcHF9K5Ev5qjzke4xSM82vZmQ21RTQSrYBU5N17Mk7KR
Hl4RatrvmB2h4JbZ3huWlrE+NygB9+syPpbXW5kQh+NHMP6bm/ywrVE+7tYUT/lL
Oi1qw42yhyZO4gqizWHbm4hKEn/avt7WmVlJnwleeOYVceuGNvcAzORQ2MTrl+Lc
kWaSZ+eIx8Ihl6bnTSd6zfPykY3cxLvLjHmF/ISrUh26YRHRacLiLo4vu+1Suhnl
hiaGk4hQaGO7yMTAh/TBmMhiV9IdQVKViOAwUEBMXz/b3VQJqfWU3ugbswqSOU4O
exBgw2IJT9IktSqofpWd2i7fcfGuDO9PWkvb75+x/P0bvymzsFRZVHtTYOkipIMx
atdUlPdk/l/y0as7OH2livgvblz2dyunrlZHWt7w0q4XHuPC1c7m3yuEfVTqFaDf
buug8djFPkXeT5do5HQgGnLIUKSZOlWgR6pLyFUWXBpIlTaRmIVBMJ/4pH2j1zHO
j5FroaPPmcbnnF4rMwpWMN9iE+7Kdu3eZym3+iM3Lq3XpGV7EalfaGFrkRuTNGpB
36YcP0OatJQreRdCPo55Juw4u31oGPqsHb6WHRLTj41aNG4xL+hdd2g8maVqxTrX
R5AWk5/T4omcA0n/rytakOT40s3M4FATFEmH/LEe6/nuwltHTkQ=
=24nB
-----END PGP SIGNATURE-----

--yuldro3lnu75a5w4--
