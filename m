From: Sebastian Reichel <sre@kernel.org>
Subject: Re: [PATCH v3] power:  smb347_charger: Use device managed API's
Date: Sat, 17 Dec 2016 16:35:20 +0100
Message-ID: <20161217153519.lnpkvqqob3tjgrus@earth>
References: <1481368111-4996-1-git-send-email-atul.r@samsung.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="lexnthsgwwmm6zv6"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:39250 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752683AbcLQPf1 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Sat, 17 Dec 2016 10:35:27 -0500
Content-Disposition: inline
In-Reply-To: <1481368111-4996-1-git-send-email-atul.r@samsung.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Atul Raj <atul.r@samsung.com>
Cc: linux-pm@vger.kernel.org, vidushi.koul@samsung.com, atulraj.nith@gmail.com, pankaj.s4@samsung.com


--lexnthsgwwmm6zv6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Sat, Dec 10, 2016 at 04:38:31PM +0530, Atul Raj wrote:
> Using device managed API to make the code simpler
>=20
> using devm_gpio_request_one in place of gpio_request_one
> using devm_request_threaded_irq in place of request_threaded_irq
> using devm_power_supply_register in place of power_supply_register
> using gpiod_* API's in place of gpio_* API's
>=20
> Signed-off-by: Atul Raj <atul.r@samsung.com>
> ---
> Changes in v2:
>   - using gpiod_* API's in place of gpio_* API's
>=20
> Changes in v3
>   - chaning suject as per directory in file path in supply git
>     adding signoff
>     sorry for wrong v2 patch. Kindly ignore v2.
>=20
>  drivers/power/smb347-charger.c |   59 ++++++++++++++++------------------=
------
>  1 file changed, 24 insertions(+), 35 deletions(-)
>=20
> diff --git a/drivers/power/smb347-charger.c b/drivers/power/smb347-charge=
r.c
> index 072c518..5b2b5cb 100644
> --- a/drivers/power/smb347-charger.c
> +++ b/drivers/power/smb347-charger.c

Please rebase your patch against a more modern kernel. The supply
subsystem moved to drivers/power/supply.

> @@ -12,7 +12,7 @@
>   */
> =20
>  #include <linux/err.h>
> -#include <linux/gpio.h>
> +#include <linux/gpio/consumer.h>
>  #include <linux/kernel.h>
>  #include <linux/module.h>
>  #include <linux/init.h>
> @@ -145,6 +145,7 @@ struct smb347_charger {
>  	bool			mains_online;
>  	bool			usb_online;
>  	bool			charging_enabled;
> +	struct gpio_desc	*irq_gpio;
>  	const struct smb347_charger_platform_data *pdata;
>  };
> =20
> @@ -835,21 +836,29 @@ static int smb347_irq_init(struct smb347_charger *s=
mb,
>  			   struct i2c_client *client)
>  {
>  	const struct smb347_charger_platform_data *pdata =3D smb->pdata;
> -	int ret, irq =3D gpio_to_irq(pdata->irq_gpio);
> +	int ret, irq;
> +	struct gpio_desc *gpiod;
> =20
> -	ret =3D gpio_request_one(pdata->irq_gpio, GPIOF_IN, client->name);
> -	if (ret < 0)
> +	smb->irq_gpio =3D gpio_to_desc(pdata->irq_gpio);
> +
> +	irq =3D gpiod_to_irq(smb->irq_gpio);
> +
> +	gpiod =3D devm_gpiod_get_optional(&client->dev, NULL, GPIOD_IN);
> +	if (IS_ERR(gpiod)) {
> +		ret =3D PTR_ERR(gpiod);
>  		goto fail;
> +	}

There seems to be a misunderstanding how to use the gpiod API.
With the gpiod API the gpio description can be removed from the
platform data. Instead gpios are described in the boardcode file
similar to e.g. regulators. There are a few examples in the mainline
tree, just check for board files with "struct gpiod_lookup_table".
Then you get the correct one using

devm_gpiod_get_optional(&client->dev, "gpio-name", GPIOD_IN);

Actually checking the driver: Please just remove all gpio handling.
The boardcode can do all of that and put the correct irq number into
i2c_board_info.irq. This also makes it easier to add ACPI/DT
bindings, which supports doing this transparently.

-- Sebastian

--lexnthsgwwmm6zv6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAlhVWzUACgkQ2O7X88g7
+prGAhAAmEocz1zwguYDext5VuBO2rJITD4sF4a3d9sVw/V0+Pwtd31eJ6M+YqMt
EeSDBq/hc0huQ3BDbI4norblJFiIXH6Uqt4XLN8Af/1b8PjjxDpCQPGDIS1GIFmo
7oW5SJeFGE61TIpzWsZBjf9iH29MTRvS+qOWwLMvfZnyj1qFVLzziyKl6kocCFYc
EkQE88RLnAyXQAoGUD7IMH0NvSGx9qPcuGxezTTsjJyWoQKsHTfb35j01c7S4bGG
PEquCXTkuUOA22ikch3YPUSvCevkVjcoUiB4xG8WEd5WRQxF7omrWgcsgxRu4bac
eVyn2SIjioZ32ZtVw/A9o/Os3SIQTU2si3w+wD8AYZyHFleZRU4aVWKsFTWHcMJR
QYQf93EEzCRdueZC8xGuQ2MQgB6e987zVnNT/N1HmLdxv1R/ZYp1fIByAtEQyg2F
2nqmzIgKiWMe5h6jdBguqb7YwUrbiTbAeuTswNebXYuKjFO0Ej9u0l1N1RmdRxZr
MCQvjIiG+U9SRPATGlwaFBve/tQfQ5QiZEcCa6VsxLqE/0pUuUapJf7bYbBCWG4G
rB742syvvChcj/TbN+ow5lftnKc5JHJfQidDyYks8FD/TDR7CdS9qPvejeN3pa+R
JyfOpL2JmlkkHMIJoTWO5KnbsILsLfuVFtagN4/OpsML8WpUDiw=
=kmEi
-----END PGP SIGNATURE-----

--lexnthsgwwmm6zv6--
