From: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Subject: Re: [RFT PATCH 2/4] compal-laptop: Check return value of
 power_supply_register
Date: Mon, 09 Feb 2015 08:56:23 +0100
Message-ID: <1423468583.4909.4.camel@AMDC1943>
References: <1422358221-13199-1-git-send-email-k.kozlowski@samsung.com>
 <1422358221-13199-3-git-send-email-k.kozlowski@samsung.com>
 <20150207024245.GB36295@fury.dvhart.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <stable-owner@vger.kernel.org>
In-reply-to: <20150207024245.GB36295@fury.dvhart.com>
Sender: stable-owner@vger.kernel.org
To: Darren Hart <dvhart@infradead.org>
Cc: Dmitry Artamonow <mad_soft@inbox.ru>, Marek Belisko <marek@goldelico.com>, Cezary Jackiewicz <cezary.jackiewicz@gmail.com>, Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, stable@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On pi=C4=85, 2015-02-06 at 18:42 -0800, Darren Hart wrote:
> On Tue, Jan 27, 2015 at 12:30:19PM +0100, Krzysztof Kozlowski wrote:
> > The return value of power_supply_register() call was not checked an=
d
> > even on error probe() function returned 0. If registering failed th=
en
> > during unbind the driver tried to unregister power supply which was=
 not
> > actually registered.
> >=20
> > This could lead to memory corruption because power_supply_unregiste=
r()
> > unconditionally cleans up given power supply.
> >=20
> > Fix this by checking return status of power_supply_register() call.=
 In
> > case of failure, unregister the hwmon device and fail the probe. Ad=
d a
> > fixme note about missing hwmon_device_unregister() in driver remova=
l.
> >=20
> > Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
> > Fixes: 9be0fcb5ed46 ("compal-laptop: add JHL90, battery & hwmon int=
erface")
> > Cc: <stable@vger.kernel.org>
> > ---
> >  drivers/platform/x86/compal-laptop.c | 7 ++++++-
> >  1 file changed, 6 insertions(+), 1 deletion(-)
> >=20
> > diff --git a/drivers/platform/x86/compal-laptop.c b/drivers/platfor=
m/x86/compal-laptop.c
> > index 15c0fab2bfa1..cf55a9246f12 100644
> > --- a/drivers/platform/x86/compal-laptop.c
> > +++ b/drivers/platform/x86/compal-laptop.c
> > @@ -1036,12 +1036,16 @@ static int compal_probe(struct platform_dev=
ice *pdev)
> > =20
> >  	/* Power supply */
> >  	initialize_power_supply_data(data);
> > -	power_supply_register(&compal_device->dev, &data->psy);
> > +	err =3D power_supply_register(&compal_device->dev, &data->psy);
> > +	if (err < 0)
> > +		goto psy_err;
> > =20
> >  	platform_set_drvdata(pdev, data);
> > =20
> >  	return 0;
> > =20
> > +psy_err:
> > +	hwmon_device_unregister(hwmon_dev);
> >  remove:
> >  	sysfs_remove_group(&pdev->dev.kobj, &compal_platform_attr_group);
> >  	return err;
> > @@ -1072,6 +1076,7 @@ static int compal_remove(struct platform_devi=
ce *pdev)
> > =20
> >  	data =3D platform_get_drvdata(pdev);
> >  	power_supply_unregister(&data->psy);
> > +	/* FIXME: missing hwmon_device_unregister() */
>=20
> Is this FIXME a leftover? Is there a reason we can't fix this now ins=
tead of
> adding a FIXME?

This is not a leftover. I think this should be fixed but:
1. I cannot test this driver,
2. I am not such familiar with hwmon API,
so my fix could be wrong and introduce more errors than fixes.

If you also think hwmon_device_unregister() is needed then I could send
new version of patch. Also I would be happy if someone else fixed this.

Best regards,
Krzysztof
