From: Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v2] power: bq24735-charger: Request status GPIO with
 initial input setup
Date: Tue, 30 Aug 2016 01:32:38 +0200
Message-ID: <20160829233237.2jcxb2p5dogazqpa@earth>
References: <20160829181503.9590-1-contact@paulk.fr>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="seaklllrjka5viqk"
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20160829181503.9590-1-contact-W9ppeneeCTY@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Paul Kocialkowski <contact-W9ppeneeCTY@public.gmane.org>
Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Dmitry Eremin-Solenikov <dbaryshkov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>
List-Id: linux-pm@vger.kernel.org


--seaklllrjka5viqk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Aug 29, 2016 at 08:15:03PM +0200, Paul Kocialkowski wrote:
> This requests the status GPIO with initial input setup. it is required
> to read the GPIO status at probe time and thus correctly avoid sending
> i2c messages when AC is not plugged.
>=20
> When requesting the GPIO without initial input setup, it always reads 0
> which causes probe to fail as it assumes the charger is connected, sends
> i2c messages and fails.

That looks mostly fine. I have some more comments, though.

> While at it, this switches the driver over to devm and gpio consumer.

NIT: the driver was already using devm previously

> Signed-off-by: Paul Kocialkowski <contact-W9ppeneeCTY@public.gmane.org>
> ---
>  drivers/power/bq24735-charger.c       | 29 +++++++----------------------
>  include/linux/power/bq24735-charger.h |  3 +--
>  2 files changed, 8 insertions(+), 24 deletions(-)
>=20
> diff --git a/drivers/power/bq24735-charger.c b/drivers/power/bq24735-char=
ger.c
> index dc460bb..5744a88 100644
> --- a/drivers/power/bq24735-charger.c
> +++ b/drivers/power/bq24735-charger.c
> @@ -25,7 +25,8 @@
>  #include <linux/kernel.h>
>  #include <linux/module.h>
>  #include <linux/of.h>
> -#include <linux/of_gpio.h>
> +#include <linux/gpio.h>
> +#include <linux/gpio/consumer.h>
>  #include <linux/power_supply.h>
>  #include <linux/slab.h>
> =20
> @@ -181,8 +182,8 @@ static bool bq24735_charger_is_present(struct bq24735=
 *charger)
>  	int ret;
> =20
>  	if (pdata->status_gpio_valid) {
> -		ret =3D gpio_get_value_cansleep(pdata->status_gpio);
> -		return ret ^=3D pdata->status_gpio_active_low =3D=3D 0;
> +		ret =3D gpiod_get_value_cansleep(pdata->status_gpio);
> +		return ret ^=3D gpiod_is_active_low(pdata->status_gpio) =3D=3D 0;

This looks fishy. The gpiod API outputs converted values already (if
one does not use the raw variant). I think you want to do:

return !gpiod_get_value_cansleep(pdata->status_gpio);

>  	} else {
>  		int ac =3D 0;
> =20
> @@ -308,7 +309,6 @@ static struct bq24735_platform *bq24735_parse_dt_data=
(struct i2c_client *client)
>  	struct device_node *np =3D client->dev.of_node;
>  	u32 val;
>  	int ret;
> -	enum of_gpio_flags flags;
> =20
>  	pdata =3D devm_kzalloc(&client->dev, sizeof(*pdata), GFP_KERNEL);
>  	if (!pdata) {
> @@ -317,11 +317,9 @@ static struct bq24735_platform *bq24735_parse_dt_dat=
a(struct i2c_client *client)
>  		return NULL;
>  	}
> =20
> -	pdata->status_gpio =3D of_get_named_gpio_flags(np, "ti,ac-detect-gpios",
> -						     0, &flags);
> -
> -	if (flags & OF_GPIO_ACTIVE_LOW)
> -		pdata->status_gpio_active_low =3D 1;
> +	pdata->status_gpio =3D devm_gpiod_get(&client->dev, "ti,ac-detect",
> +						GPIOD_IN);
> +	pdata->status_gpio_valid =3D !IS_ERR(pdata->status_gpio);

Just use devm_gpiod_get_optional(). Then instead of
checking if (pdata->status_gpio_valid) you do
if (pdata->status_gpio).

Also you should check for EPROBE_DEFER. With the
_optional() change you can just do

if (IS_ERR(pdata->status_gpio)) {
    ret =3D PTR_ERR(pdata->status_gpio);
    dev_err(&client->dev, "Could not get gpio: %d\n", ret);
    return ret;
}

>  	ret =3D of_property_read_u32(np, "ti,charge-current", &val);
>  	if (!ret)
> @@ -396,19 +394,6 @@ static int bq24735_charger_probe(struct i2c_client *=
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
> -
>  	if (!charger->pdata->status_gpio_valid
>  	    || bq24735_charger_is_present(charger)) {
>  		ret =3D bq24735_read_word(client, BQ24735_MANUFACTURER_ID);
> diff --git a/include/linux/power/bq24735-charger.h b/include/linux/power/=
bq24735-charger.h
> index 6b750c1a..bbc284e 100644
> --- a/include/linux/power/bq24735-charger.h
> +++ b/include/linux/power/bq24735-charger.h
> @@ -28,8 +28,7 @@ struct bq24735_platform {
> =20
>  	const char *name;
> =20
> -	int status_gpio;
> -	int status_gpio_active_low;
> +	struct gpio_desc *status_gpio;
>  	bool status_gpio_valid;
> =20
>  	bool ext_control;

Otherwise looks fine.

-- Sebastian

--seaklllrjka5viqk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCgAGBQJXxMYTAAoJENju1/PIO/qaqfAP/2fny36JvMsy45Crai829pFz
T72XrXAC2C0msDHW6t6zwbSaPVOAW10atOMi/QdpIsDnP3zNfJWpl9eJc632Bu5B
Vb91AB7K4rlUf0yk3gxUnjUjRARbrxYqZeorA8MbhK9h4t3omvgYVaz2TtZTABtO
fngEN/WfLHIyQrCW+g7uzInKLAolJxPFYCga5ZekMX7O8PfR5MXyk5DLE4tz8wMh
REKYhJFrz7NatXKy8fu1iFc09JsxWvJvVnuM8qf1DeE/LnQKRegVTKZIUhqJm4/F
1XbaZekP5eRvS7okdzoTvveb5H3dXW2g6bee6t1eZndrJ9iSNK1UZwdO2cCd8/W6
pgTtd1W+5kUVoQ1gi+z3obMSyV8A7REo9T+RRQbWyWh/WZB4tywzlZFMiyaIJP7Y
7a+Wdob/bCjOs4y9EHJ/tMG7YM4+1dH3iSnoySnRxMe1MIyYdvfOtilG6I24Zj8m
H04SnrH3w9XglkO1BFlJNC/7rNXYPjGjnT+8qv7t7+/b0JeHOjU1sPzxOYZQHMse
KH0Nxe1vWX88CJLzLUrhB59BaL1BuTRXzf7atu6yTxlkLylx5x5tD5gwxPqU0dVu
CjPYWB6kuyIWQKGILyTQb+jS5v3/oMkrgwxONzkJ25wlk8c/k1Ekktkr5H8vDUQ7
WlWBkm6K1fb0mGypK+mD
=Rkaa
-----END PGP SIGNATURE-----

--seaklllrjka5viqk--
