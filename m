From: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
Subject: Re: [PATCH] power: supply: core: Add support for supplied-from
 device-property
Date: Mon, 15 May 2017 15:33:42 +0200
Message-ID: <20170515133342.b23cp5lh47g4co6a@earth>
References: <20170508151354.21711-1-hdegoede@redhat.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="5oezuuyjiydob6e2"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from bhuna.collabora.co.uk ([46.235.227.227]:60489 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933811AbdEONdv (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 15 May 2017 09:33:51 -0400
Content-Disposition: inline
In-Reply-To: <20170508151354.21711-1-hdegoede@redhat.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Hans de Goede <hdegoede@redhat.com>
Cc: linux-pm@vger.kernel.org


--5oezuuyjiydob6e2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, May 08, 2017 at 05:13:54PM +0200, Hans de Goede wrote:
> On devicetree using platforms the devicetree can provide info on which
> power-supplies supply another power-supply through phandles.
>=20
> This commit adds support for providing this info on non devicetree
> platforms through the platform code setting a supplied-from
> device-property on the power-supplies parent device.
>
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>

Thanks, queued.

-- Sebastian

> ---
>  drivers/power/supply/power_supply_core.c | 24 +++++++++++++++++++++++-
>  1 file changed, 23 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/power/supply/power_supply_core.c b/drivers/power/sup=
ply/power_supply_core.c
> index 7ec7c7c202bd..0c09144193a6 100644
> --- a/drivers/power/supply/power_supply_core.c
> +++ b/drivers/power/supply/power_supply_core.c
> @@ -274,8 +274,30 @@ static int power_supply_check_supplies(struct power_=
supply *psy)
>  	return power_supply_populate_supplied_from(psy);
>  }
>  #else
> -static inline int power_supply_check_supplies(struct power_supply *psy)
> +static int power_supply_check_supplies(struct power_supply *psy)
>  {
> +	int nval, ret;
> +
> +	if (!psy->dev.parent)
> +		return 0;
> +
> +	nval =3D device_property_read_string_array(psy->dev.parent,
> +						 "supplied-from", NULL, 0);
> +	if (nval <=3D 0)
> +		return 0;
> +
> +	psy->supplied_from =3D devm_kmalloc_array(&psy->dev, nval,
> +						sizeof(char *), GFP_KERNEL);
> +	if (!psy->supplied_from)
> +		return -ENOMEM;
> +
> +	ret =3D device_property_read_string_array(psy->dev.parent,
> +		"supplied-from", (const char **)psy->supplied_from, nval);
> +	if (ret < 0)
> +		return ret;
> +
> +	psy->num_supplies =3D nval;
> +
>  	return 0;
>  }
>  #endif
> --=20
> 2.12.2
>=20

--5oezuuyjiydob6e2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAlkZrjYACgkQ2O7X88g7
+prNURAApSzJDIQVSGeWMXXqia5cS6CrYXqkr94A1n/fRmuHDBzqCUDg8wSCziYQ
8XCuQWllQddCmEKFplUJBxC5v0cqJf+GcGJy7kQh7myplvPbmN8DiImIlIMLKejy
rMsD4JREJVp83CPGyw4ZCzKY6IV+k7YOeUy6u/oS4YGp3GtqLhIUPGRdabNSSFSR
6Mr4rdVHsbsQxqKgO58x7TeYxihHErJiRc0ous6yX7xBnLYjiZ6xOVAG7wPGPfJf
L03mMdPARk8s3E6LCkuc2ThxPd4kiT36YpAOjV5vXlJOPceGMOOaLQ+E9jSAlO+6
MDURQza8/USKDHGV73oTwLn+1tOrUHu+oH1qIWVxPP6qCJGx47HDgRw5PGTNkbaE
ZBmKen61GxClFB7iuOIAQhoBgXVzQpv2OjK5iW7vpdAh9R7KUsleMQKQ60qPsH2X
ICciOqHOYKtZUCNjA4BtboFlG02itd5jhrSLbho1ZmDUqBcPVpv0lnXOVh4OxfMb
0hUhH3DN9nZbb4HdRmVs5sb9M8Wen45Yz6R+iVOTPNf16IgwjpQciiPXZu5FTogS
zzjuVGITUEbRpRyug00RVl1hNrDCiV/Fi0Jw4VPPMKAiS24eBB+aVZ/gG8IStvWz
Q92ibmJtjFffEYGxlm77jL/UOrj9C/0C9b3Fhi83AztWpp2wQLk=
=T5vc
-----END PGP SIGNATURE-----

--5oezuuyjiydob6e2--
