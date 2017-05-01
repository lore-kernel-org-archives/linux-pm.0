From: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
Subject: Re: [PATCH v2 05/14] power: max17042_battery: Change name in
 power_supply_desc to "main-battery"
Date: Mon, 1 May 2017 14:22:53 +0200
Message-ID: <20170501122253.e3nrr4dql2nt3cba@earth>
References: <20170414183259.24382-1-hdegoede@redhat.com>
 <20170414183259.24382-5-hdegoede@redhat.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="uyicbl5f2kwnzrzj"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from bhuna.collabora.co.uk ([46.235.227.227]:57820 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S968841AbdEAMW5 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 1 May 2017 08:22:57 -0400
Content-Disposition: inline
In-Reply-To: <20170414183259.24382-5-hdegoede@redhat.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Hans de Goede <hdegoede@redhat.com>
Cc: Krzysztof Kozlowski <krzk@kernel.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, linux-pm@vger.kernel.org


--uyicbl5f2kwnzrzj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, Apr 14, 2017 at 08:32:50PM +0200, Hans de Goede wrote:
> The max17042 will typically be coupled with some charger IC, almost all
> charger drivers contain:
>=20
> static char *xxx_charger_supplied_to[] =3D {
>         "main-battery",
> };
>=20
> probe()
> {
> 	struct power_supply_config cfg;
>=20
> 	cfg.supplied_to =3D xxx_charger_supplied_to;
> 	cfg.num_supplicants =3D ARRAY_SIZE(xxx_charger_supplied_to);
> 	xxx->charger =3D power_supply_register(dev, &x_charger_desc, &_cfg);
> }
>=20
> Change the name in max17042's power_supply_desc to "main-battery" to
> match, so that power_supply_am_i_supplied() can be used to implement
> POWER_SUPPLY_PROP_STATUS.
>=20
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>

I did not queue this patch and patch 14. First of all: Currently 4/30
chargers have this, which I wouldn't call "almost all". I think this
is not the right solution, especially as it will break once a system
has more than one "main" battery (like some of the newer thinkpads).

For DT based systems we have generic support to specify the
dependency as phandle. This obviously won't work for you.
I suggest to use a device property for supplying the correct name
to the charger instead.

-- Sebastian

> ---
>  drivers/power/supply/max17042_battery.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/power/supply/max17042_battery.c b/drivers/power/supp=
ly/max17042_battery.c
> index f0ff6e8..3249eb0 100644
> --- a/drivers/power/supply/max17042_battery.c
> +++ b/drivers/power/supply/max17042_battery.c
> @@ -866,7 +866,7 @@ static const struct regmap_config max17042_regmap_con=
fig =3D {
>  };
> =20
>  static const struct power_supply_desc max17042_psy_desc =3D {
> -	.name		=3D "max170xx_battery",
> +	.name		=3D "main-battery",
>  	.type		=3D POWER_SUPPLY_TYPE_BATTERY,
>  	.get_property	=3D max17042_get_property,
>  	.set_property	=3D max17042_set_property,
> @@ -876,7 +876,7 @@ static const struct power_supply_desc max17042_psy_de=
sc =3D {
>  };
> =20
>  static const struct power_supply_desc max17042_no_current_sense_psy_desc=
 =3D {
> -	.name		=3D "max170xx_battery",
> +	.name		=3D "main-battery",
>  	.type		=3D POWER_SUPPLY_TYPE_BATTERY,
>  	.get_property	=3D max17042_get_property,
>  	.set_property	=3D max17042_set_property,
> --=20
> 2.9.3
>=20

--uyicbl5f2kwnzrzj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAlkHKJ0ACgkQ2O7X88g7
+prviA/9F9he/xjavpdJ7UO0aTUv/MoJD9+YNJ/PTrfEN0CEoPilQSJ+DDLP5v9m
bA4LG350KMGYESl2rQeMS57W1AJKEJW6B3QylhwDnkvdb2/50/6RQyauSaWODwg7
wAQ44dKwd/7VFTLFBmmi7R2C70PnslIvT1FTb6/dNrG+ttdTuU4CeyDHi5QbNUzY
pS6nWw+tHOphUEwFy7iFjnlnM2NsRlj4PU7TP0grbHITguf7CkZ9cntYIWmiOB+G
lCCIHkuPXSFyRiehHzWGpmyUPw2vGuIEtfkZZ+DWNR/9m4a09838j5lznqvZ3A4o
Es+pBbckmFsTcp/hDSb7O7PJGzrfPiNwZ5H0coIDLIdczRg4K6AJ7HIrFUqPpBd4
AvsFN/9cd76mzft8ofBa9umQpMNPPfseGwuM0X0Hl6FHHdcP67xFfkEImzHcfWGZ
4ESnyLFM232sE8U7YNCXCZTT5nhS6mb8Nst9bC5uO10vjSvoENtNMrGo9kf0q+zW
MAXb51X1OyUfGN7jRNheRPJfOtxXZvAzaaFTaO5bJGnTqMgrbhYjYrHGVaiG6XGU
YfyiPwQIGH/5w+bcMO0VlEXl2id1p/xxYS64wWlngjpDZzuQAdumtYB3mV5925w9
TuNAyMjB2z/M/Y/JhZViFDWWe2z8yE/Iomf4C3fE6ivsp2Ugk5I=
=Z4cj
-----END PGP SIGNATURE-----

--uyicbl5f2kwnzrzj--
