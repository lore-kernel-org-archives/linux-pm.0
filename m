From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH v2 18/21] mfd: htc-pasic3: Prepare driver for leds-pasic3
Date: Wed, 19 Aug 2015 07:58:26 +0100
Message-ID: <20150819065826.GH6180@x1>
References: <cover.1439843482.git.petr.cvek@tul.cz>
 <55D25ABC.1000405@tul.cz>
 <20150818065207.GC6180@x1>
 <55D39D25.7010909@tul.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-leds-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <55D39D25.7010909@tul.cz>
Sender: linux-leds-owner@vger.kernel.org
To: Petr Cvek <petr.cvek@tul.cz>
Cc: robert.jarzmik@free.fr, philipp.zabel@gmail.com, daniel@zonque.org, haojian.zhuang@gmail.com, sameo@linux.intel.com, cooloney@gmail.com, rpurdie@rpsys.net, j.anaszewski@samsung.com, linux@arm.linux.org.uk, sre@kernel.org, dbaryshkov@gmail.com, dwmw2@infradead.org, linux-leds@vger.kernel.org, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-pm@vger.kernel.org

On Tue, 18 Aug 2015, Petr Cvek wrote:

> Dne 18.8.2015 v 08:52 Lee Jones napsal(a):
> > On Tue, 18 Aug 2015, Petr Cvek wrote:
> >=20
> >> Fix register definitions and prepare structures for new leds-pasic=
3
> >> driver.
> >>
> >> Signed-off-by: Petr Cvek <petr.cvek@tul.cz>
> >> ---
> >>  drivers/mfd/htc-pasic3.c       | 54 ++++++++++++++++-----------
> >>  include/linux/mfd/htc-pasic3.h | 85 +++++++++++++++++++++++++++++=
++-----------
> >>  2 files changed, 97 insertions(+), 42 deletions(-)
> >>
> >> diff --git a/drivers/mfd/htc-pasic3.c b/drivers/mfd/htc-pasic3.c
> >> index e88d4f6..16e156d 100644
> >> --- a/drivers/mfd/htc-pasic3.c
> >> +++ b/drivers/mfd/htc-pasic3.c
> >> @@ -3,6 +3,9 @@
> >>   *
> >>   * Copyright (C) 2006 Philipp Zabel <philipp.zabel@gmail.com>
> >>   *
> >> + * 2015:	Added registers for LED and RESET, see htc-pasic3.h
> >> + *		-- Petr Cvek
> >> + *
> >=20
> > This is pretty unconventional.
> >=20
> > Please look to see what others have done.
>=20
> LED support: Petr Cvek <petr.cvek@tul.cz>

We can see what changes/support you added in the Git log.  No need to
reflect that here at all.  If everyone did that, the headers would be
a complete mess.

Just:
 * Copyright (C) 2015 Petr Cvek <petr.cvek@tul.cz>

=2E.. will do fine.

> >> @@ -130,6 +140,7 @@ static int __init pasic3_probe(struct platform=
_device *pdev)
> >>  	struct device *dev =3D &pdev->dev;
> >>  	struct pasic3_data *asic;
> >>  	struct resource *r;
> >> +	struct pasic3_leds_pdata *leds_pdata;
> >>  	int ret;
> >>  	int irq =3D 0;
> >> =20
> >> @@ -162,6 +173,8 @@ static int __init pasic3_probe(struct platform=
_device *pdev)
> >>  	/* calculate bus shift from mem resource */
> >>  	asic->bus_shift =3D (resource_size(r) - 5) >> 3;
> >> =20
> >> +	spin_lock_init(&asic->lock);
> >> +
> >>  	if (pdata && pdata->clock_rate) {
> >>  		ds1wm_pdata.clock_rate =3D pdata->clock_rate;
> >>  		/* the first 5 PASIC3 registers control the DS1WM */
> >> @@ -172,13 +185,12 @@ static int __init pasic3_probe(struct platfo=
rm_device *pdev)
> >>  			dev_warn(dev, "failed to register DS1WM\n");
> >>  	}
> >> =20
> >> -	if (pdata && pdata->led_pdata) {
> >> -		led_cell.platform_data =3D pdata->led_pdata;
> >> -		led_cell.pdata_size =3D sizeof(struct pasic3_leds_machinfo);
> >> -		ret =3D mfd_add_devices(&pdev->dev, pdev->id, &led_cell, 1, r,
> >> -				      0, NULL);
> >> -		if (ret < 0)
> >> -			dev_warn(dev, "failed to register LED device\n");
> >> +	if (pdata && pdata->pasic3_leds) {
> >> +		leds_pdata =3D dev_get_platdata(&pdata->pasic3_leds->dev);
> >=20
> > Whoa!  You're passing a pointer to a device through pdata?
> >=20
> > I don't like that at all.  Please explain.
>=20
> >=20
> >> +		if (leds_pdata) {
> >> +			leds_pdata->mfd_dev =3D dev;
> >> +			platform_device_register(pdata->pasic3_leds);
> >=20
> > What's the idea here?
>=20
> Actually, I don't know how to do this in a clean way as
> pasic3_read_register() and pasic3_write_register() require device
> struct to pass address for accessing the registers. Only way would
> be to rewrite all functions which call pasic3_*_register() (removing
> struct device *dev and change it to struct pasic3_data *asic).

I'm still not entirely sure what the problem is.

Why are you calling platform_device_register() instead of using the
MFD API?

Where does the 'struct device' actually get loaded into pdata?

--=20
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
=46ollow Linaro: Facebook | Twitter | Blog
