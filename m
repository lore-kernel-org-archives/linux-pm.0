From: Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v3] power: bq24735-charger: Request status GPIO with
 initial input setup
Date: Fri, 2 Sep 2016 17:27:55 +0200
Message-ID: <20160902152755.7jk2dr2rtbkog6w2@earth>
References: <20160901212700.29747-1-contact@paulk.fr>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="x3irnncsmlanjamg"
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20160901212700.29747-1-contact-W9ppeneeCTY@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Paul Kocialkowski <contact-W9ppeneeCTY@public.gmane.org>
Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Dmitry Eremin-Solenikov <dbaryshkov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>
List-Id: linux-pm@vger.kernel.org


--x3irnncsmlanjamg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Paul,

This looks mostly fine now. I have a few more comments, that I
missed last time:

On Thu, Sep 01, 2016 at 11:27:00PM +0200, Paul Kocialkowski wrote:
> This requests the status GPIO with initial input setup. it is required
> to read the GPIO status at probe time and thus correctly avoid sending
> i2c messages when AC is not plugged.
>=20
> When requesting the GPIO without initial input setup, it always reads 0
> which causes probe to fail as it assumes the charger is connected, sends
> i2c messages and fails.
>=20
> While at it, this switches the driver over to gpio consumer.
>=20
> Signed-off-by: Paul Kocialkowski <contact-W9ppeneeCTY@public.gmane.org>
> ---
>  drivers/power/bq24735-charger.c       | 42 +++++++++++++----------------=
------
>  include/linux/power/bq24735-charger.h |  4 +---
>  2 files changed, 17 insertions(+), 29 deletions(-)

Please rebase next version to power-supply's for-next branch:

https://git.kernel.org/cgit/linux/kernel/git/sre/linux-power-supply.git/log=
/?h=3Dfor-next

> diff --git a/drivers/power/bq24735-charger.c b/drivers/power/bq24735-char=
ger.c
> index dc460bb..7f9b305 100644
> --- a/drivers/power/bq24735-charger.c
> +++ b/drivers/power/bq24735-charger.c
> @@ -25,7 +25,8 @@
>  #include <linux/kernel.h>
>  #include <linux/module.h>
>  #include <linux/of.h>
> -#include <linux/of_gpio.h>
> +#include <linux/gpio.h>

No need for <linux/gpio.h>, all gpiod bits used by you are in
<linux/gpio/consumer.h>

> +#include <linux/gpio/consumer.h>
>  #include <linux/power_supply.h>
>  #include <linux/slab.h>
> =20
> @@ -178,11 +179,9 @@ static int bq24735_config_charger(struct bq24735 *ch=
arger)
>  static bool bq24735_charger_is_present(struct bq24735 *charger)
>  {
>  	struct bq24735_platform *pdata =3D charger->pdata;
> -	int ret;
> =20
> -	if (pdata->status_gpio_valid) {
> -		ret =3D gpio_get_value_cansleep(pdata->status_gpio);
> -		return ret ^=3D pdata->status_gpio_active_low =3D=3D 0;
> +	if (pdata->status_gpio) {
> +		return !gpiod_get_value_cansleep(pdata->status_gpio);
>  	} else {
>  		int ac =3D 0;
> =20
> @@ -308,7 +307,6 @@ static struct bq24735_platform *bq24735_parse_dt_data=
(struct i2c_client *client)
>  	struct device_node *np =3D client->dev.of_node;
>  	u32 val;
>  	int ret;
> -	enum of_gpio_flags flags;
> =20
>  	pdata =3D devm_kzalloc(&client->dev, sizeof(*pdata), GFP_KERNEL);
>  	if (!pdata) {
> @@ -317,11 +315,13 @@ static struct bq24735_platform *bq24735_parse_dt_da=
ta(struct i2c_client *client)
>  		return NULL;
>  	}
> =20
> -	pdata->status_gpio =3D of_get_named_gpio_flags(np, "ti,ac-detect-gpios",
> -						     0, &flags);
> -
> -	if (flags & OF_GPIO_ACTIVE_LOW)
> -		pdata->status_gpio_active_low =3D 1;
> +	pdata->status_gpio =3D devm_gpiod_get_optional(&client->dev,
> +				"ti,ac-detect", GPIOD_IN);
> +	if (IS_ERR(pdata->status_gpio)) {
> +		ret =3D PTR_ERR(pdata->status_gpio);
> +		dev_err(&client->dev, "Getting gpio failed: %d\n", ret);
> +		return (struct bq24735_platform *) pdata->status_gpio;
> +	}
> =20
>  	ret =3D of_property_read_u32(np, "ti,charge-current", &val);
>  	if (!ret)
> @@ -357,8 +357,11 @@ static int bq24735_charger_probe(struct i2c_client *=
client,
>  	charger->charging =3D true;
>  	charger->pdata =3D client->dev.platform_data;
> =20
> -	if (IS_ENABLED(CONFIG_OF) && !charger->pdata && client->dev.of_node)
> +	if (IS_ENABLED(CONFIG_OF) && !charger->pdata && client->dev.of_node) {
>  		charger->pdata =3D bq24735_parse_dt_data(client);
> +		if (IS_ERR(charger->pdata))
> +			return PTR_ERR(charger->pdata);
> +	}
> =20
>  	if (!charger->pdata) {
>  		dev_err(&client->dev, "no platform data provided\n");
> @@ -396,20 +399,7 @@ static int bq24735_charger_probe(struct i2c_client *=
client,
> =20
>  	i2c_set_clientdata(client, charger);
> =20
> -	if (gpio_is_valid(charger->pdata->status_gpio)) {
> -		ret =3D devm_gpio_request(&client->dev,
> -					charger->pdata->status_gpio,
> -					name);
> -		if (ret) {
> -			dev_err(&client->dev,
> -				"Failed GPIO request for GPIO %d: %d\n",
> -				charger->pdata->status_gpio, ret);
> -		}
> -
> -		charger->pdata->status_gpio_valid =3D !ret;
> -	}

Do the devm_gpiod_get_optional() call here and store the result in
"struct bq24735" instead of in pdata. It's not DT specific. The
gpiod interface can also get it's data from boardcode (or acpi, if
that becomes important at some point).

(Check Documentation/gpio/board.txt for details)

> -
> -	if (!charger->pdata->status_gpio_valid
> +	if (!charger->pdata->status_gpio
>  	    || bq24735_charger_is_present(charger)) {
>  		ret =3D bq24735_read_word(client, BQ24735_MANUFACTURER_ID);
>  		if (ret < 0) {
> diff --git a/include/linux/power/bq24735-charger.h b/include/linux/power/=
bq24735-charger.h
> index 6b750c1a..afdb3704 100644
> --- a/include/linux/power/bq24735-charger.h
> +++ b/include/linux/power/bq24735-charger.h
> @@ -28,9 +28,7 @@ struct bq24735_platform {
> =20
>  	const char *name;
> =20
> -	int status_gpio;
> -	int status_gpio_active_low;
> -	bool status_gpio_valid;
> +	struct gpio_desc *status_gpio;

Move the gpio_desc into the private "struct bq24735" (but keep
dropping all gpio bits from the bq24735_platform).

-- Sebastian

--x3irnncsmlanjamg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCgAGBQJXyZp4AAoJENju1/PIO/qa/7UP/AsA6u8X2YQTBaWwYB33H0Uj
F82o0GYkeGqVdfAK4q9nqAm2ENd7I1qW/MI+JtwTT4WAKRDXH3qjiXnGEXU+G7Vx
wy360UMsezopCvryk0IVdGPdezCuYQsTtEzkOOBQQM4bmoabYXjeUPzulXT8ssSL
Cyc22gX2zND3xAdzqAIi5Z87644s5LFNEcyWMEz8aSMzxU7LY/GATdYzIqs62hGe
SxH7k3iHlUIvEu/7jW5xPHR/NayRkR3tO5IcZXR57EP+LUzty9CaSWdfyqOJq5ke
bRWpnqFe7PiJPmtyPaMMGna5IV2C5R4BouAxyA7eQKGIWVRMjk+P9qvC0GS+dNa4
oUU/H9evf1sGmYhlJviJgbaqSnZKUd5NrDCM2+jNI4ofZKjRXbBBTUFTrFW90M1C
MudCgiKWAn14HKkB2pyg4/g7Yg8M6DmXhpOrBfKuADDy58aJSlFh1puYTu11ExY8
ccQQhSeW1sI1C1hHkhbEk09VIaZpKqXkeTpB4xmgODCrDxwLqKZIgevrHtv0kSyj
uGbJK1ZTV2o0KTrr35GSdggTpHMls1iAcWQg1T8HDZ+7IYQCl+FUkBTMizXVbXEh
CwgiK3yoVB15nDaV+pndpEk8rZYxI1Fe5OoFOt0WOYOz63e4tsr4cMxQkCw2apYE
6lbwQaL2r23wVJI1JFoc
=XJER
-----END PGP SIGNATURE-----

--x3irnncsmlanjamg--
