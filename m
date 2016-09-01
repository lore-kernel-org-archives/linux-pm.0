From: Paul Kocialkowski <contact-W9ppeneeCTY@public.gmane.org>
Subject: Re: [PATCH v2] power: bq24735-charger: Request status GPIO with
 initial input setup
Date: Thu, 01 Sep 2016 23:41:53 +0200
Message-ID: <1472766113.3813.1.camel@paulk.fr>
References: <20160829181503.9590-1-contact@paulk.fr>
         <20160829233237.2jcxb2p5dogazqpa@earth>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-dktxMpjRLH3VNkdXRySM"
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20160829233237.2jcxb2p5dogazqpa@earth>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Dmitry Eremin-Solenikov <dbaryshkov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>
List-Id: linux-pm@vger.kernel.org


--=-dktxMpjRLH3VNkdXRySM
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Le mardi 30 ao=C3=BBt 2016 =C3=A0 01:32 +0200, Sebastian Reichel a =C3=A9cr=
it=C2=A0:
> Hi,
>=20
> On Mon, Aug 29, 2016 at 08:15:03PM +0200, Paul Kocialkowski wrote:
> >=20
> > This requests the status GPIO with initial input setup. it is required
> > to read the GPIO status at probe time and thus correctly avoid sending
> > i2c messages when AC is not plugged.
> >=20
> > When requesting the GPIO without initial input setup, it always reads 0
> > which causes probe to fail as it assumes the charger is connected, send=
s
> > i2c messages and fails.
>=20
> That looks mostly fine. I have some more comments, though.

Thanks for the review, v3 sent. Feel free to add your Signed-off-by line si=
nce
your suggestions heavily influenced v3!

> > While at it, this switches the driver over to devm and gpio consumer.
>=20
> NIT: the driver was already using devm previously
>=20
> >=20
> > Signed-off-by: Paul Kocialkowski <contact-W9ppeneeCTY@public.gmane.org>
> > ---
> > =C2=A0drivers/power/bq24735-charger.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0| 29 +++++++----------------------
> > =C2=A0include/linux/power/bq24735-charger.h |=C2=A0=C2=A03 +--
> > =C2=A02 files changed, 8 insertions(+), 24 deletions(-)
> >=20
> > diff --git a/drivers/power/bq24735-charger.c b/drivers/power/bq24735-
> > charger.c
> > index dc460bb..5744a88 100644
> > --- a/drivers/power/bq24735-charger.c
> > +++ b/drivers/power/bq24735-charger.c
> > @@ -25,7 +25,8 @@
> > =C2=A0#include <linux/kernel.h>
> > =C2=A0#include <linux/module.h>
> > =C2=A0#include <linux/of.h>
> > -#include <linux/of_gpio.h>
> > +#include <linux/gpio.h>
> > +#include <linux/gpio/consumer.h>
> > =C2=A0#include <linux/power_supply.h>
> > =C2=A0#include <linux/slab.h>
> > =C2=A0
> > @@ -181,8 +182,8 @@ static bool bq24735_charger_is_present(struct bq247=
35
> > *charger)
> > =C2=A0	int ret;
> > =C2=A0
> > =C2=A0	if (pdata->status_gpio_valid) {
> > -		ret =3D gpio_get_value_cansleep(pdata->status_gpio);
> > -		return ret ^=3D pdata->status_gpio_active_low =3D=3D 0;
> > +		ret =3D gpiod_get_value_cansleep(pdata->status_gpio);
> > +		return ret ^=3D gpiod_is_active_low(pdata->status_gpio) =3D=3D 0;
>=20
> This looks fishy. The gpiod API outputs converted values already (if
> one does not use the raw variant). I think you want to do:
>=20
> return !gpiod_get_value_cansleep(pdata->status_gpio);
>=20
> >=20
> > =C2=A0	} else {
> > =C2=A0		int ac =3D 0;
> > =C2=A0
> > @@ -308,7 +309,6 @@ static struct bq24735_platform
> > *bq24735_parse_dt_data(struct i2c_client *client)
> > =C2=A0	struct device_node *np =3D client->dev.of_node;
> > =C2=A0	u32 val;
> > =C2=A0	int ret;
> > -	enum of_gpio_flags flags;
> > =C2=A0
> > =C2=A0	pdata =3D devm_kzalloc(&client->dev, sizeof(*pdata), GFP_KERNEL)=
;
> > =C2=A0	if (!pdata) {
> > @@ -317,11 +317,9 @@ static struct bq24735_platform
> > *bq24735_parse_dt_data(struct i2c_client *client)
> > =C2=A0		return NULL;
> > =C2=A0	}
> > =C2=A0
> > -	pdata->status_gpio =3D of_get_named_gpio_flags(np, "ti,ac-detect-
> > gpios",
> > -						=C2=A0=C2=A0=C2=A0=C2=A0=C2=A00, &flags);
> > -
> > -	if (flags & OF_GPIO_ACTIVE_LOW)
> > -		pdata->status_gpio_active_low =3D 1;
> > +	pdata->status_gpio =3D devm_gpiod_get(&client->dev, "ti,ac-detect",
> > +						GPIOD_IN);
> > +	pdata->status_gpio_valid =3D !IS_ERR(pdata->status_gpio);
>=20
> Just use devm_gpiod_get_optional(). Then instead of
> checking if (pdata->status_gpio_valid) you do
> if (pdata->status_gpio).
>=20
> Also you should check for EPROBE_DEFER. With the
> _optional() change you can just do
>=20
> if (IS_ERR(pdata->status_gpio)) {
> =C2=A0=C2=A0=C2=A0=C2=A0ret =3D PTR_ERR(pdata->status_gpio);
> =C2=A0=C2=A0=C2=A0=C2=A0dev_err(&client->dev, "Could not get gpio: %d\n",=
 ret);
> =C2=A0=C2=A0=C2=A0=C2=A0return ret;
> }
>=20
> >=20
> > =C2=A0	ret =3D of_property_read_u32(np, "ti,charge-current", &val);
> > =C2=A0	if (!ret)
> > @@ -396,19 +394,6 @@ static int bq24735_charger_probe(struct i2c_client
> > *client,
> > =C2=A0
> > =C2=A0	i2c_set_clientdata(client, charger);
> > =C2=A0
> > -	if (gpio_is_valid(charger->pdata->status_gpio)) {
> > -		ret =3D devm_gpio_request(&client->dev,
> > -					charger->pdata->status_gpio,
> > -					name);
> > -		if (ret) {
> > -			dev_err(&client->dev,
> > -				"Failed GPIO request for GPIO %d: %d\n",
> > -				charger->pdata->status_gpio, ret);
> > -		}
> > -
> > -		charger->pdata->status_gpio_valid =3D !ret;
> > -	}
> > -
> > =C2=A0	if (!charger->pdata->status_gpio_valid
> > =C2=A0	=C2=A0=C2=A0=C2=A0=C2=A0|| bq24735_charger_is_present(charger)) =
{
> > =C2=A0		ret =3D bq24735_read_word(client, BQ24735_MANUFACTURER_ID);
> > diff --git a/include/linux/power/bq24735-charger.h
> > b/include/linux/power/bq24735-charger.h
> > index 6b750c1a..bbc284e 100644
> > --- a/include/linux/power/bq24735-charger.h
> > +++ b/include/linux/power/bq24735-charger.h
> > @@ -28,8 +28,7 @@ struct bq24735_platform {
> > =C2=A0
> > =C2=A0	const char *name;
> > =C2=A0
> > -	int status_gpio;
> > -	int status_gpio_active_low;
> > +	struct gpio_desc *status_gpio;
> > =C2=A0	bool status_gpio_valid;
> > =C2=A0
> > =C2=A0	bool ext_control;
>=20
> Otherwise looks fine.
>=20
> -- Sebastian
--=20
Paul Kocialkowski, developer of low-level free software for embedded device=
s

Website: https://www.paulk.fr/
Coding blog: https://code.paulk.fr/
Git repositories: https://git.paulk.fr/ https://git.code.paulk.fr/
--=-dktxMpjRLH3VNkdXRySM
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQIcBAABCAAGBQJXyKChAAoJEIT9weqP7pUMjF0P/Asziu+nrvWeBmf81KKfQZf4
u6Xs4pmD+1fPGlOCkdqAAK7zkoXXD4cQvyNjijOf9oJauahEcJhMJZBoIZlKe3+u
aPCvfhRRT8tE5b5aZxhG0rMWF2lSTb/PI7m9RZg276jtVD0Hapv/+8yoA82+iXCY
EEpTt8vFp8eFoXtYle+k0adL7JGe6j8F0iVLTl7P0ZxW5lJgKMmJmYOc12KEKCoe
ZzOObTsBNDcsNNDL+WT4sjr4RjgwcW5F1XumuUP7Zg3F4OCDqHor4N8TMp75enpz
6BcEgDbKSGCs5MCRsQOWTeMjONBbV3e2EK3EUaQ5DNCDneqO0cp/mPxUX4iRiDf8
+rAS9teslgz1AGSx5onBdt2vlPXm5VFa10mAmISkztZ5s8T00PVCpWlV86sMWnEV
X8dhx5DFDzhT9HjbodLtcevP0cvYKjz9ZZaRW7B5g+iajDQ+njMOOy3cbd61WZA/
+mV/E42+U6rDkmc5JBKb9wU3EVc6hTbKwaanoTOsnkXd3cnhaeIZOZt63PA251CE
d4PRplIXOnPAAgLQHbzBxnp1LVObMRzcBcR7CbX+Kyi7zXRojrRkj5Pr4XDRZvLD
rBJr0ySwDWMP7xi7jx26nGmimS8t8MjnzhSS7bKf3SaQdrG4v80mJfX5CiAZCteZ
rc7YRfLS9+SNP2NakXJR
=gdni
-----END PGP SIGNATURE-----

--=-dktxMpjRLH3VNkdXRySM--
