From: Sebastian Reichel <sre@kernel.org>
Subject: Re: [PATCH 06/15] power: supply: bq24190_charger: Use i2c-core
 irq-mapping code
Date: Mon, 20 Mar 2017 05:46:43 +0100
Message-ID: <20170320044643.keud4saopjscd5jf@earth>
References: <20170317095527.10487-1-hdegoede@redhat.com>
 <20170317095527.10487-7-hdegoede@redhat.com>
 <1489771454.19767.73.camel@linux.intel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="sndk4qf6n4zunler"
Return-path: <linux-i2c-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1489771454.19767.73.camel@linux.intel.com>
Sender: linux-i2c-owner@vger.kernel.org
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Hans de Goede <hdegoede@redhat.com>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, Wolfram Sang <wsa@the-dreams.de>, Lee Jones <lee.jones@linaro.org>, MyungJoo Ham <myungjoo.ham@samsung.com>, Chanwoo Choi <cw00.choi@samsung.com>, linux-acpi@vger.kernel.org, Takashi Iwai <tiwai@suse.de>, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org


--sndk4qf6n4zunler
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, Mar 17, 2017 at 07:24:14PM +0200, Andy Shevchenko wrote:
> On Fri, 2017-03-17 at 10:55 +0100, Hans de Goede wrote:
> > The i2c-core already maps of irqs before calling the driver's probe
> > function and there are no in tree users of
> > bq24190_platform_data->gpio_int.
> >=20
> > Remove the redundant custom irq-mapping code and just use client->irq.
> >=20
>=20
> Nice! I did similar clean up to some other driver, so,
>=20
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
>=20
> P.S. This should be first in the series against bq24190.

Right.

Acked-by: Sebastian Reichel <sre@kernel.org>

-- Sebastian

> > Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> > ---
> > =A0drivers/power/supply/bq24190_charger.c | 61 ++-----------------------
> > ---------
> > =A0include/linux/power/bq24190_charger.h=A0=A0|=A0=A01 -
> > =A02 files changed, 2 insertions(+), 60 deletions(-)
> >=20
> > diff --git a/drivers/power/supply/bq24190_charger.c
> > b/drivers/power/supply/bq24190_charger.c
> > index 7bca8d0..9c4b171 100644
> > --- a/drivers/power/supply/bq24190_charger.c
> > +++ b/drivers/power/supply/bq24190_charger.c
> > @@ -154,8 +154,6 @@ struct bq24190_dev_info {
> > =A0	struct bq24190_platform_data	*pdata;
> > =A0	char				model_name[I2C_NAME_SIZE]
> > ;
> > =A0	kernel_ulong_t			model;
> > -	unsigned int			gpio_int;
> > -	unsigned int			irq;
> > =A0	struct mutex			f_reg_lock;
> > =A0	u8				f_reg;
> > =A0	u8				ss_reg;
> > @@ -1296,56 +1294,11 @@ static int bq24190_hw_init(struct
> > bq24190_dev_info *bdi)
> > =A0	return ret;
> > =A0}
> > =A0
> > -#ifdef CONFIG_OF
> > -static int bq24190_setup_dt(struct bq24190_dev_info *bdi)
> > -{
> > -	bdi->irq =3D irq_of_parse_and_map(bdi->dev->of_node, 0);
> > -	if (bdi->irq <=3D 0)
> > -		return -1;
> > -
> > -	return 0;
> > -}
> > -#else
> > -static int bq24190_setup_dt(struct bq24190_dev_info *bdi)
> > -{
> > -	return -1;
> > -}
> > -#endif
> > -
> > -static int bq24190_setup_pdata(struct bq24190_dev_info *bdi,
> > -		struct bq24190_platform_data *pdata)
> > -{
> > -	int ret;
> > -
> > -	if (!gpio_is_valid(pdata->gpio_int))
> > -		return -1;
> > -
> > -	ret =3D gpio_request(pdata->gpio_int, dev_name(bdi->dev));
> > -	if (ret < 0)
> > -		return -1;
> > -
> > -	ret =3D gpio_direction_input(pdata->gpio_int);
> > -	if (ret < 0)
> > -		goto out;
> > -
> > -	bdi->irq =3D gpio_to_irq(pdata->gpio_int);
> > -	if (!bdi->irq)
> > -		goto out;
> > -
> > -	bdi->gpio_int =3D pdata->gpio_int;
> > -	return 0;
> > -
> > -out:
> > -	gpio_free(pdata->gpio_int);
> > -	return -1;
> > -}
> > -
> > =A0static int bq24190_probe(struct i2c_client *client,
> > =A0		const struct i2c_device_id *id)
> > =A0{
> > =A0	struct i2c_adapter *adapter =3D to_i2c_adapter(client-
> > >dev.parent);
> > =A0	struct device *dev =3D &client->dev;
> > -	struct bq24190_platform_data *pdata =3D client-
> > >dev.platform_data;
> > =A0	struct power_supply_config charger_cfg =3D {}, battery_cfg =3D
> > {};
> > =A0	struct bq24190_dev_info *bdi;
> > =A0	int ret;
> > @@ -1372,12 +1325,7 @@ static int bq24190_probe(struct i2c_client
> > *client,
> > =A0
> > =A0	i2c_set_clientdata(client, bdi);
> > =A0
> > -	if (dev->of_node)
> > -		ret =3D bq24190_setup_dt(bdi);
> > -	else
> > -		ret =3D bq24190_setup_pdata(bdi, pdata);
> > -
> > -	if (ret) {
> > +	if (!client->irq) {
> > =A0		dev_err(dev, "Can't get irq info\n");
> > =A0		return -EINVAL;
> > =A0	}
> > @@ -1417,7 +1365,7 @@ static int bq24190_probe(struct i2c_client
> > *client,
> > =A0		goto out3;
> > =A0	}
> > =A0
> > -	ret =3D devm_request_threaded_irq(dev, bdi->irq, NULL,
> > +	ret =3D devm_request_threaded_irq(dev, client->irq, NULL,
> > =A0			bq24190_irq_handler_thread,
> > =A0			IRQF_TRIGGER_FALLING | IRQF_ONESHOT,
> > =A0			"bq24190-charger", bdi);
> > @@ -1439,8 +1387,6 @@ static int bq24190_probe(struct i2c_client
> > *client,
> > =A0
> > =A0out1:
> > =A0	pm_runtime_disable(dev);
> > -	if (bdi->gpio_int)
> > -		gpio_free(bdi->gpio_int);
> > =A0	return ret;
> > =A0}
> > =A0
> > @@ -1457,9 +1403,6 @@ static int bq24190_remove(struct i2c_client
> > *client)
> > =A0	power_supply_unregister(bdi->charger);
> > =A0	pm_runtime_disable(bdi->dev);
> > =A0
> > -	if (bdi->gpio_int)
> > -		gpio_free(bdi->gpio_int);
> > -
> > =A0	return 0;
> > =A0}
> > =A0
> > diff --git a/include/linux/power/bq24190_charger.h
> > b/include/linux/power/bq24190_charger.h
> > index cb49717..8d918cb 100644
> > --- a/include/linux/power/bq24190_charger.h
> > +++ b/include/linux/power/bq24190_charger.h
> > @@ -10,7 +10,6 @@
> > =A0#define _BQ24190_CHARGER_H_
> > =A0
> > =A0struct bq24190_platform_data {
> > -	unsigned int	gpio_int;	/* GPIO pin that's
> > connected to INT# */
> > =A0	bool no_register_reset;
> > =A0};
> > =A0
>=20
> --=20
> Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Intel Finland Oy

--sndk4qf6n4zunler
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAljPXrMACgkQ2O7X88g7
+pr4tA/+POQjDFKfpMEqyFGvSN51CUjvjEktWG0dRokBSyTjAFY+Xny4n4lSl1JS
IBLthsceQNZMLo+Nnz4zeNFuVNJeuN14F9xl4+P9N8qCve6jLi0/OlAf2bB6T8oK
/TbzgsDTuZ7k8xYMWcozOJbY27qGmoc3AOgTQtDV5HsZVbICutXSdoawI05UB4Hb
llLxBVFxjShCNRnbUtyNci5Bn7ltQz9NnNPBQOqAwTy5f5qpPf+7K0Ah8gUsJLnx
W8qWfdFMUx2UE3dg8Qdlxn0jEeIVQkep5TWeSniG37WUVl3yClefR/LtBmfAceBz
/RHeVX7lwFztoEnDWo3y3fbDs+PZoruDPjnh6SR8YqXJCOp/zj3swmfcs/Aja7cG
fuXQO+VAv52t3BQNI8Rfbn9ULkv6wUW7STHi/jw1bDcUoPXclWKiGdOjasfZoeCd
lQlOIcMi5EtG+V3Pf7W0imCCXHxb0hjflw7GDwtJSXC8PnOOcmd43vgQGRNUF59r
I7yksKkRVItCy89oc03kLEjs7qUHbcmtEfGOpHKQK3T9OLyGTPBCoU87tY+hAlyv
8+5B6NpSNROoq72LHjuZba/CHS85J9TaGvTujcb11z0ocDOJNublostPevHkH1B5
srca0M0c+v9vQssqMpB24NBQKCVj1KkyQUJq0wdSzKW6i6/i4cA=
=ntJu
-----END PGP SIGNATURE-----

--sndk4qf6n4zunler--
