From: Paul Kocialkowski <contact-W9ppeneeCTY@public.gmane.org>
Subject: Re: [PATCH v3] power: bq24735-charger: Request status GPIO with
 initial input setup
Date: Sat, 03 Sep 2016 00:11:13 +0200
Message-ID: <1472854273.32173.3.camel@paulk.fr>
References: <20160901212700.29747-1-contact@paulk.fr>
         <20160902152755.7jk2dr2rtbkog6w2@earth>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-Xrc7w1qK+Z2EUW6GRC0Q"
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20160902152755.7jk2dr2rtbkog6w2@earth>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Dmitry Eremin-Solenikov <dbaryshkov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>
List-Id: linux-pm@vger.kernel.org


--=-Xrc7w1qK+Z2EUW6GRC0Q
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

Le vendredi 02 septembre 2016 =C3=A0 17:27 +0200, Sebastian Reichel a =C3=
=A9crit=C2=A0:
> Hi Paul,
>=20
> This looks mostly fine now. I have a few more comments, that I
> missed last time:

Thanks for the review and for the useful suggestions. I have applied them t=
o v4.

> On Thu, Sep 01, 2016 at 11:27:00PM +0200, Paul Kocialkowski wrote:
> >=20
> > This requests the status GPIO with initial input setup. it is required
> > to read the GPIO status at probe time and thus correctly avoid sending
> > i2c messages when AC is not plugged.
> >=20
> > When requesting the GPIO without initial input setup, it always reads 0
> > which causes probe to fail as it assumes the charger is connected, send=
s
> > i2c messages and fails.
> >=20
> > While at it, this switches the driver over to gpio consumer.
> >=20
> > Signed-off-by: Paul Kocialkowski <contact-W9ppeneeCTY@public.gmane.org>
> > ---
> > =C2=A0drivers/power/bq24735-charger.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0| 42 +++++++++++++-------------------
> > ---
> > =C2=A0include/linux/power/bq24735-charger.h |=C2=A0=C2=A04 +---
> > =C2=A02 files changed, 17 insertions(+), 29 deletions(-)
>=20
> Please rebase next version to power-supply's for-next branch:
>=20
> https://git.kernel.org/cgit/linux/kernel/git/sre/linux-power-supply.git/l=
og/?h
> =3Dfor-next
>=20
> >=20
> > diff --git a/drivers/power/bq24735-charger.c b/drivers/power/bq24735-
> > charger.c
> > index dc460bb..7f9b305 100644
> > --- a/drivers/power/bq24735-charger.c
> > +++ b/drivers/power/bq24735-charger.c
> > @@ -25,7 +25,8 @@
> > =C2=A0#include <linux/kernel.h>
> > =C2=A0#include <linux/module.h>
> > =C2=A0#include <linux/of.h>
> > -#include <linux/of_gpio.h>
> > +#include <linux/gpio.h>
>=20
> No need for <linux/gpio.h>, all gpiod bits used by you are in
> <linux/gpio/consumer.h>
>=20
> >=20
> > +#include <linux/gpio/consumer.h>
> > =C2=A0#include <linux/power_supply.h>
> > =C2=A0#include <linux/slab.h>
> > =C2=A0
> > @@ -178,11 +179,9 @@ static int bq24735_config_charger(struct bq24735
> > *charger)
> > =C2=A0static bool bq24735_charger_is_present(struct bq24735 *charger)
> > =C2=A0{
> > =C2=A0	struct bq24735_platform *pdata =3D charger->pdata;
> > -	int ret;
> > =C2=A0
> > -	if (pdata->status_gpio_valid) {
> > -		ret =3D gpio_get_value_cansleep(pdata->status_gpio);
> > -		return ret ^=3D pdata->status_gpio_active_low =3D=3D 0;
> > +	if (pdata->status_gpio) {
> > +		return !gpiod_get_value_cansleep(pdata->status_gpio);
> > =C2=A0	} else {
> > =C2=A0		int ac =3D 0;
> > =C2=A0
> > @@ -308,7 +307,6 @@ static struct bq24735_platform
> > *bq24735_parse_dt_data(struct i2c_client *client)
> > =C2=A0	struct device_node *np =3D client->dev.of_node;
> > =C2=A0	u32 val;
> > =C2=A0	int ret;
> > -	enum of_gpio_flags flags;
> > =C2=A0
> > =C2=A0	pdata =3D devm_kzalloc(&client->dev, sizeof(*pdata), GFP_KERNEL)=
;
> > =C2=A0	if (!pdata) {
> > @@ -317,11 +315,13 @@ static struct bq24735_platform
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
> > +	pdata->status_gpio =3D devm_gpiod_get_optional(&client->dev,
> > +				"ti,ac-detect", GPIOD_IN);
> > +	if (IS_ERR(pdata->status_gpio)) {
> > +		ret =3D PTR_ERR(pdata->status_gpio);
> > +		dev_err(&client->dev, "Getting gpio failed: %d\n", ret);
> > +		return (struct bq24735_platform *) pdata->status_gpio;
> > +	}
> > =C2=A0
> > =C2=A0	ret =3D of_property_read_u32(np, "ti,charge-current", &val);
> > =C2=A0	if (!ret)
> > @@ -357,8 +357,11 @@ static int bq24735_charger_probe(struct i2c_client
> > *client,
> > =C2=A0	charger->charging =3D true;
> > =C2=A0	charger->pdata =3D client->dev.platform_data;
> > =C2=A0
> > -	if (IS_ENABLED(CONFIG_OF) && !charger->pdata && client-
> > >dev.of_node)
> > +	if (IS_ENABLED(CONFIG_OF) && !charger->pdata && client-
> > >dev.of_node) {
> > =C2=A0		charger->pdata =3D bq24735_parse_dt_data(client);
> > +		if (IS_ERR(charger->pdata))
> > +			return PTR_ERR(charger->pdata);
> > +	}
> > =C2=A0
> > =C2=A0	if (!charger->pdata) {
> > =C2=A0		dev_err(&client->dev, "no platform data provided\n");
> > @@ -396,20 +399,7 @@ static int bq24735_charger_probe(struct i2c_client
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
>=20
> Do the devm_gpiod_get_optional() call here and store the result in
> "struct bq24735" instead of in pdata. It's not DT specific. The
> gpiod interface can also get it's data from boardcode (or acpi, if
> that becomes important at some point).
>=20
> (Check Documentation/gpio/board.txt for details)
>=20
> >=20
> > -
> > -	if (!charger->pdata->status_gpio_valid
> > +	if (!charger->pdata->status_gpio
> > =C2=A0	=C2=A0=C2=A0=C2=A0=C2=A0|| bq24735_charger_is_present(charger)) =
{
> > =C2=A0		ret =3D bq24735_read_word(client, BQ24735_MANUFACTURER_ID);
> > =C2=A0		if (ret < 0) {
> > diff --git a/include/linux/power/bq24735-charger.h
> > b/include/linux/power/bq24735-charger.h
> > index 6b750c1a..afdb3704 100644
> > --- a/include/linux/power/bq24735-charger.h
> > +++ b/include/linux/power/bq24735-charger.h
> > @@ -28,9 +28,7 @@ struct bq24735_platform {
> > =C2=A0
> > =C2=A0	const char *name;
> > =C2=A0
> > -	int status_gpio;
> > -	int status_gpio_active_low;
> > -	bool status_gpio_valid;
> > +	struct gpio_desc *status_gpio;
>=20
> Move the gpio_desc into the private "struct bq24735" (but keep
> dropping all gpio bits from the bq24735_platform).
>=20
> -- Sebastian
--=20
Paul Kocialkowski, developer of low-level free software for embedded device=
s

Website: https://www.paulk.fr/
Coding blog: https://code.paulk.fr/
Git repositories: https://git.paulk.fr/ https://git.code.paulk.fr/
--=-Xrc7w1qK+Z2EUW6GRC0Q
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQIcBAABCAAGBQJXyfkBAAoJEIT9weqP7pUMTXYP/3FVZuk7Wx9OCfv7NEg5ILhh
+5gBLC4F53ARrPVEUn9jz3Wcod0r3hzO0kJS9+zBEcgm+T4O+FUdSLel3H7ZjYrR
OcMC6o/C5lMYs4C1zzmw+DbjeYTdHwkgcs48FdncckW5JyhbJbVRLXjAPS4ZY9OQ
+zsZ5uNkgywTfw8A2mwir5WGEmlo2GT0M5a6y0dlMa+b03hCjHBW4NjR1VXKT/iJ
VPYds+S/MTt8m9C6EcHYfuFVPyrkbWSeZ9p0/RI8BZdAepuYkY0fmUaY3nT9bBsb
udF7I13MWbmtWjI+j2eAAsCoDxAKosUk07XAD6Qp00yUL1YW6YjEIjXRrrcC1hHT
r2s2cXieHxqAuxOeJsrkLeiVt+1OCu7FpdseGehmkTN5FmHz8nvQVwDsQ1R3X/01
oUTOyYnVkWlxOVyf+MIXdPh7SjMTwYKiTZ5V+UPR969Y9vxjvxCw23LfNBfeI6s0
nRDr01778cxveoCxYWZ0Nee26LE7jNWMsiAaBpT+Z+FuNrPzCoS7jYTw2ZPvwX/9
oF051KxgSiw3ZAmft/SwFhW6yXE5Tty9KtJLmDDjgYYJv7HqlUAH+2AQugu2lbE5
eOyVkcJpEsKfhkw0UP3VS8R0pQvcEFGKAnY9Bieu+sxItCYcO7WLGLO4z2EmQ7s1
MP2iGROS0tQztyuFqjJy
=BeDn
-----END PGP SIGNATURE-----

--=-Xrc7w1qK+Z2EUW6GRC0Q--
