From: Sebastian Reichel <sebastian.reichel-ZGY8ohtN/8pPYcu2f3hruQ@public.gmane.org>
Subject: Re: [PATCH v5 8/9] power: supply: sbs-battery: Add alert callback
Date: Mon, 1 May 2017 14:32:30 +0200
Message-ID: <20170501123230.zwcrojjmzqjsgdqu@earth>
References: <1493628599-30552-1-git-send-email-preid@electromag.com.au>
 <1493628599-30552-9-git-send-email-preid@electromag.com.au>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="whe5g3z4phz4bruj"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1493628599-30552-9-git-send-email-preid-qgqNFa1JUf/o2iN0hyhwsIdd74u8MsAO@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Phil Reid <preid-qgqNFa1JUf/o2iN0hyhwsIdd74u8MsAO@public.gmane.org>
Cc: wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, peda-koto5C5qi+TLoDKTGw+V6w@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-pm@vger.kernel.org


--whe5g3z4phz4bruj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, May 01, 2017 at 04:49:58PM +0800, Phil Reid wrote:
> To simplify the sbs-manager code and notification of battery removal
> use the i2c alert callback to notify the sbs-battery driver that an
> event has occurred.
>=20
> Signed-off-by: Phil Reid <preid-qgqNFa1JUf/o2iN0hyhwsIdd74u8MsAO@public.gmane.org>

Thanks, queued.

-- Sebastian

>  drivers/power/supply/sbs-battery.c | 16 +++++++++++++---
>  1 file changed, 13 insertions(+), 3 deletions(-)
>=20
> diff --git a/drivers/power/supply/sbs-battery.c b/drivers/power/supply/sb=
s-battery.c
> index 8bb2eb3..a719892 100644
> --- a/drivers/power/supply/sbs-battery.c
> +++ b/drivers/power/supply/sbs-battery.c
> @@ -675,21 +675,30 @@ static int sbs_get_property(struct power_supply *ps=
y,
>  	return 0;
>  }
> =20
> -static irqreturn_t sbs_irq(int irq, void *devid)
> +static void sbs_supply_changed(struct sbs_info *chip)
>  {
> -	struct sbs_info *chip =3D devid;
>  	struct power_supply *battery =3D chip->power_supply;
>  	int ret;
> =20
>  	ret =3D gpiod_get_value_cansleep(chip->gpio_detect);
>  	if (ret < 0)
> -		return ret;
> +		return;
>  	chip->is_present =3D ret;
>  	power_supply_changed(battery);
> +}
> =20
> +static irqreturn_t sbs_irq(int irq, void *devid)
> +{
> +	sbs_supply_changed(devid);
>  	return IRQ_HANDLED;
>  }
> =20
> +static void sbs_alert(struct i2c_client *client, enum i2c_alert_protocol=
 prot,
> +	unsigned int data)
> +{
> +	sbs_supply_changed(i2c_get_clientdata(client));
> +}
> +
>  static void sbs_external_power_changed(struct power_supply *psy)
>  {
>  	struct sbs_info *chip =3D power_supply_get_drvdata(psy);
> @@ -917,6 +926,7 @@ static int sbs_suspend(struct device *dev)
>  static struct i2c_driver sbs_battery_driver =3D {
>  	.probe		=3D sbs_probe,
>  	.remove		=3D sbs_remove,
> +	.alert		=3D sbs_alert,
>  	.id_table	=3D sbs_id,
>  	.driver =3D {
>  		.name	=3D "sbs-battery",
> --=20
> 1.8.3.1
>=20

--whe5g3z4phz4bruj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAlkHKt4ACgkQ2O7X88g7
+prDag/+I80dX+8rJU8//FzMbpJl11hWPBeRfu3g5aASRA7iQm8pKKfKb2KujGW5
V6RRB1In5GOioySgfXNqEvrySP6Iqa795HFXnL9xsI/bKuNlBCXQ7SYqKXYoUDIK
Nem15080qN3b+kS1axjXUgWq84q85Ba3AgN5TyFm51l7swdQ3QQJCq0Z2PUIQEbv
ypfedpoFcnnry8JdaXTO8xmj07QaAW0tZNL107NvzP9/WYenJToSTl836pa/BT0R
KNHY2dUl/aC59TngmGT+sFD3IT3/ERxI9ysp9AX8YyPQXKwTgwUIi+fyDrKwauB4
v5IYse0ZzEt8A+5Rjix+ltUXLaa2h9CRrCB3CdQHtSgu6AGqWJqaCOw7cnyMBceE
wFAh8HzAe4pn0ZcYNZQ5hr82E7rNh/+i/dbWK14qgdinu2X/cszdPpLg7VZLCZs1
DoG0VwtPGfDL76oxiSOKh6YGxrsjn7PN4KTohg5XNt0+qunmLxEwh+t8m7Tv+q3r
taVo2nZe8ECdeeIXrv8dGddq0/NKmg4q6QlVIltVKDmycoElvT3+257UqhvLEvai
2WKDugS79h9x3C8BJFoFDqRCcMQdXXSnORS6llnN7c+j/LPA53tu+EhnOX/wW1w4
rp4B8EJhlUt4WbyjaxsgZh1MorxtEmwnXWZirk9sDRMVHGuv9l8=
=hhVO
-----END PGP SIGNATURE-----

--whe5g3z4phz4bruj--
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
