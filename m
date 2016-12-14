From: Sebastian Reichel <sre@kernel.org>
Subject: Re: [PATCH v2 3/3] power: supply: bq24735-charger: allow chargers to
 share the ac-detect gpio
Date: Wed, 14 Dec 2016 18:01:14 +0100
Message-ID: <20161214170114.ckozfple475kqajh@earth>
References: <1481673405-4547-1-git-send-email-peda@axentia.se>
 <1481673405-4547-4-git-send-email-peda@axentia.se>
 <20161214165921.jsatcznbljd7anqi@earth>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="vachsytpsma2urs7"
Return-path: <linux-gpio-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20161214165921.jsatcznbljd7anqi@earth>
Sender: linux-gpio-owner@vger.kernel.org
To: Peter Rosin <peda@axentia.se>, Linus Walleij <linus.walleij@linaro.org>, Alexandre Courbot <gnurou@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, linux-gpio@vger.kernel.org
List-Id: linux-pm@vger.kernel.org


--vachsytpsma2urs7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

[of course I forgot to actually add gpio people, let's try again]

On Wed, Dec 14, 2016 at 05:59:21PM +0100, Sebastian Reichel wrote:
> Hi,
>=20
> On Wed, Dec 14, 2016 at 12:56:45AM +0100, Peter Rosin wrote:
> > If several parallel bq24735 chargers have their ac-detect gpios wired
> > together (or if only one of the parallel bq24735 chargers have its
> > ac-detect pin wired to a gpio, and the others are assumed to react the
> > same), then all driver instances need to check the same gpio. But the
> > gpio subsystem does not allow sharing gpios, so handle that locally.
>=20
> Adding GPIO subsystem people to see if they can come up with
> something in the gpiod API for this usecase.
>=20
> > However, only do this for the polling case, sharing is not supported if
> > the ac detection is handled with interrupts.
>=20
> Why? I guess you only added the gpio polling stuff for the shared
> gpio feature, so we can skip the gpio polling if we add shared irq
> support instead?
>=20
> > Signed-off-by: Peter Rosin <peda@axentia.se>
> > ---
> >  drivers/power/supply/bq24735-charger.c | 111 +++++++++++++++++++++++++=
++++----
> >  1 file changed, 100 insertions(+), 11 deletions(-)
> >=20
> > diff --git a/drivers/power/supply/bq24735-charger.c b/drivers/power/sup=
ply/bq24735-charger.c
> > index f45876927676..c2403c4d5ece 100644
> > --- a/drivers/power/supply/bq24735-charger.c
> > +++ b/drivers/power/supply/bq24735-charger.c
> > @@ -25,6 +25,7 @@
> >  #include <linux/kernel.h>
> >  #include <linux/module.h>
> >  #include <linux/of.h>
> > +#include <linux/of_gpio.h>
> >  #include <linux/gpio/consumer.h>
> >  #include <linux/power_supply.h>
> >  #include <linux/slab.h>
> > @@ -43,12 +44,24 @@
> >  #define BQ24735_MANUFACTURER_ID		0xfe
> >  #define BQ24735_DEVICE_ID		0xff
> > =20
> > +struct bq24735;
> > +
> > +struct bq24735_shared {
> > +	struct list_head		list;
> > +	struct bq24735			*owner;
> > +	struct gpio_desc		*status_gpio;
> > +};
> > +
> > +static DEFINE_MUTEX(shared_lock);
> > +static LIST_HEAD(shared_list);
> > +
> >  struct bq24735 {
> >  	struct power_supply		*charger;
> >  	struct power_supply_desc	charger_desc;
> >  	struct i2c_client		*client;
> >  	struct bq24735_platform		*pdata;
> >  	struct mutex			lock;
> > +	struct bq24735_shared		*shared;
> >  	struct gpio_desc		*status_gpio;
> >  	struct delayed_work		poll;
> >  	u32				poll_interval;
> > @@ -346,6 +359,75 @@ static struct bq24735_platform *bq24735_parse_dt_d=
ata(struct i2c_client *client)
> >  	return pdata;
> >  }
> > =20
> > +static struct gpio_desc *bq24735_get_status_gpio(struct bq24735 *charg=
er)
> > +{
> > +	struct device *dev =3D &charger->client->dev;
> > +	struct bq24735_shared *shared;
> > +	int gpio;
> > +	enum of_gpio_flags flags;
> > +	int active_low;
> > +	struct list_head *pos;
> > +
> > +	if (of_property_read_bool(dev->of_node, "ti,ac-detect-gpios"))
> > +		gpio =3D of_get_named_gpio_flags(dev->of_node,
> > +					       "ti,ac-detect-gpios", 0, &flags);
> > +	else if (of_property_read_bool(dev->of_node, "ti,ac-detect-gpio"))
> > +		gpio =3D of_get_named_gpio_flags(dev->of_node,
> > +					       "ti,ac-detect-gpio", 0, &flags);
> > +	else
> > +		return NULL;
> > +
> > +	if (!gpio_is_valid(gpio))
> > +		return ERR_PTR(gpio);
> > +	active_low =3D flags & OF_GPIO_ACTIVE_LOW;
> > +
> > +	mutex_lock(&shared_lock);
> > +	list_for_each(pos, &shared_list) {
> > +		shared =3D list_entry(pos, struct bq24735_shared, list);
> > +		if (gpio !=3D desc_to_gpio(shared->status_gpio))
> > +			continue;
> > +		if (!active_low ^ !gpiod_is_active_low(shared->status_gpio))
> > +			continue;
> > +
> > +		get_device(&shared->owner->client->dev);
> > +		dev_dbg(dev, "sharing gpio with %s\n",
> > +			shared->owner->pdata->name);
> > +		charger->shared =3D shared;
> > +		mutex_unlock(&shared_lock);
> > +		return shared->status_gpio;
> > +	}
> > +
> > +	shared =3D devm_kzalloc(dev, sizeof(*shared), GFP_KERNEL);
> > +	if (!shared) {
> > +		mutex_unlock(&shared_lock);
> > +		return ERR_PTR(-ENOMEM);
> > +	}
> > +	shared->owner =3D charger;
> > +	shared->status_gpio =3D gpiod_get(dev, "ti,ac-detect", GPIOD_IN);
> > +	if (!IS_ERR(shared->status_gpio)) {
> > +		charger->shared =3D shared;
> > +		list_add(&shared->list, &shared_list);
> > +	}
> > +	mutex_unlock(&shared_lock);
> > +
> > +	return shared->status_gpio;
> > +}
> > +
> > +static void bq24735_put_status_gpio(struct bq24735 *charger)
> > +{
> > +	if (!charger->shared)
> > +		return;
> > +
> > +	mutex_lock(&shared_lock);
> > +	if (charger->shared->owner !=3D charger) {
> > +		put_device(&charger->shared->owner->client->dev);
> > +	} else {
> > +		list_del(&charger->shared->list);
> > +		gpiod_put(charger->shared->status_gpio);
> > +	}
> > +	mutex_unlock(&shared_lock);
> > +}
> > +
> >  static int bq24735_charger_probe(struct i2c_client *client,
> >  				 const struct i2c_device_id *id)
> >  {
> > @@ -402,9 +484,7 @@ static int bq24735_charger_probe(struct i2c_client =
*client,
> > =20
> >  	i2c_set_clientdata(client, charger);
> > =20
> > -	charger->status_gpio =3D devm_gpiod_get_optional(&client->dev,
> > -						       "ti,ac-detect",
> > -						       GPIOD_IN);
> > +	charger->status_gpio =3D bq24735_get_status_gpio(charger);
> >  	if (IS_ERR(charger->status_gpio)) {
> >  		ret =3D PTR_ERR(charger->status_gpio);
> >  		dev_err(&client->dev, "Getting gpio failed: %d\n", ret);
> > @@ -416,28 +496,30 @@ static int bq24735_charger_probe(struct i2c_clien=
t *client,
> >  		if (ret < 0) {
> >  			dev_err(&client->dev, "Failed to read manufacturer id : %d\n",
> >  				ret);
> > -			return ret;
> > +			goto out;
> >  		} else if (ret !=3D 0x0040) {
> >  			dev_err(&client->dev,
> >  				"manufacturer id mismatch. 0x0040 !=3D 0x%04x\n", ret);
> > -			return -ENODEV;
> > +			ret =3D -ENODEV;
> > +			goto out;
> >  		}
> > =20
> >  		ret =3D bq24735_read_word(client, BQ24735_DEVICE_ID);
> >  		if (ret < 0) {
> >  			dev_err(&client->dev, "Failed to read device id : %d\n", ret);
> > -			return ret;
> > +			goto out;
> >  		} else if (ret !=3D 0x000B) {
> >  			dev_err(&client->dev,
> >  				"device id mismatch. 0x000b !=3D 0x%04x\n", ret);
> > -			return -ENODEV;
> > +			ret =3D -ENODEV;
> > +			goto out;
> >  		}
> >  	}
> > =20
> >  	ret =3D bq24735_config_charger(charger);
> >  	if (ret < 0) {
> >  		dev_err(&client->dev, "failed in configuring charger");
> > -		return ret;
> > +		goto out;
> >  	}
> > =20
> >  	/* check for AC adapter presence */
> > @@ -445,7 +527,7 @@ static int bq24735_charger_probe(struct i2c_client =
*client,
> >  		ret =3D bq24735_enable_charging(charger);
> >  		if (ret < 0) {
> >  			dev_err(&client->dev, "Failed to enable charging\n");
> > -			return ret;
> > +			goto out;
> >  		}
> >  	}
> > =20
> > @@ -455,7 +537,7 @@ static int bq24735_charger_probe(struct i2c_client =
*client,
> >  		ret =3D PTR_ERR(charger->charger);
> >  		dev_err(&client->dev, "Failed to register power supply: %d\n",
> >  			ret);
> > -		return ret;
> > +		goto out;
> >  	}
> > =20
> >  	if (client->irq) {
> > @@ -470,7 +552,7 @@ static int bq24735_charger_probe(struct i2c_client =
*client,
> >  			dev_err(&client->dev,
> >  				"Unable to register IRQ %d err %d\n",
> >  				client->irq, ret);
> > -			return ret;
> > +			goto out;
> >  		}
> >  	} else if (charger->status_gpio) {
> >  		ret =3D of_property_read_u32(client->dev.of_node,
> > @@ -487,6 +569,11 @@ static int bq24735_charger_probe(struct i2c_client=
 *client,
> >  	}
> > =20
> >  	return 0;
> > +
> > +out:
> > +	bq24735_put_status_gpio(charger);
> > +
> > +	return ret;
> >  }
> > =20
> >  static int bq24735_charger_remove(struct i2c_client *client)
> > @@ -496,6 +583,8 @@ static int bq24735_charger_remove(struct i2c_client=
 *client)
> >  	if (charger->poll_interval)
> >  		cancel_delayed_work_sync(&charger->poll);
> > =20
> > +	bq24735_put_status_gpio(charger);
> > +
> >  	return 0;
> >  }
> > =20
> > --=20
> > 2.1.4
> >=20



--vachsytpsma2urs7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAlhRetoACgkQ2O7X88g7
+poI4w/+LjtAtApZZ1uzjkkg2WDnJLm6lynHQUPqm1NzsIZ8vL0YOrqgJcplVMsZ
4h+v8Y++3pFuzsHax7InGf5L4C9t58XfC30x50ciL7YDcWwgKAER6ON4hxkwUpYH
r2qd/AGmZ6MHTaUCKAW1OSHuwpsEf115YVw3euKYyVuVGE9LoLW1/nD5AlPxXoSS
q5Qv+XfTFAeKCWJrEDG78/7LhqfxfHIdhuXDTyVIAlsNK9/cZF5Gu94l8rXWaI5/
FPKVIL2a4OiVBtIoYlLHjd4/i//HHdTa3hMB69LGCdKP0g4ecOMvmEiXXAJzLtfy
STV7acuNeJkdGceMYrK1nbyEson6yPKADuoNgNDgxoOWWdS9cruDBj58YtwAxjYT
Vtr293hah/RBVRd2P0lm6F82zmvtVw+xzeXFCBLjI0MEiwiFS5yyEMViOn2jUohT
wY0QuPcmpUZ5ZdWxc1Ccj0GXQslS04ALCOLX8MD/A2BkwynWJWGzg1E3MOBK9yVo
SXHbuvoH0pfFvwoz6PnH5rPKvcSirqLkBTrpFXDfDy2CoCZ7XtZKaRfUUFr0Q98A
J4pP5HcuUiP1ny7t3z3612SFR3sL6g2KL8qY51j+rjUttoS/npUKk3QyGexW+KvM
sqQGLtrarhJPHmm1xNU4a7cqsBN9bD7cXnHEksN77rDQHwy+kFI=
=IH8h
-----END PGP SIGNATURE-----

--vachsytpsma2urs7--
