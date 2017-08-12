From: Sebastian Reichel <sre@kernel.org>
Subject: Re: [RFC v2 4/5] power: supply: bq27xxx: Flag identical chip data
 when in debug mode
Date: Sat, 12 Aug 2017 12:25:48 -0400
Message-ID: <20170812162548.tziieaxckzfq7eog@earth>
References: <20170807062216.19988-1-liam@networkimprov.net>
 <20170807062216.19988-5-liam@networkimprov.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="h3vmz6hzhwsspefy"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:57494 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750864AbdHLQZt (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Sat, 12 Aug 2017 12:25:49 -0400
Content-Disposition: inline
In-Reply-To: <20170807062216.19988-5-liam@networkimprov.net>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Liam Breck <liam@networkimprov.net>
Cc: Pali =?iso-8859-1?Q?Roh=E1r?= <pali.rohar@gmail.com>, linux-pm@vger.kernel.org, Paul Kocialkowski <contact@paulk.fr>, Liam Breck <kernel@networkimprov.net>


--h3vmz6hzhwsspefy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Sun, Aug 06, 2017 at 11:22:15PM -0700, Liam Breck wrote:
> From: Liam Breck <kernel@networkimprov.net>
>=20
> The driver has 13 unique register maps, several of which are shared
> by multiple chips. When adding support for a new chip, it's easy to
> add a duplicate map by mistake.
>=20
> In debug mode we now scan bq27xxx_chip_data[n].regs/props/dm_regs for
> duplicates.
>=20
> Signed-off-by: Liam Breck <kernel@networkimprov.net>
> ---

This should be done by static code analysis using coccinelle or
something similar, so that it's catched by build bots and not by
users. Even worse the loop is called for each bq27xxx battery in the
system.

-- Sebastian

>  drivers/power/supply/bq27xxx_battery.c | 40 ++++++++++++++++++++++++++++=
+++++-
>  1 file changed, 39 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/power/supply/bq27xxx_battery.c b/drivers/power/suppl=
y/bq27xxx_battery.c
> index 8e535890..d85f9ec2 100644
> --- a/drivers/power/supply/bq27xxx_battery.c
> +++ b/drivers/power/supply/bq27xxx_battery.c
> @@ -885,7 +885,7 @@ static struct bq27xxx_dm_reg bq27621_dm_regs[] =3D {
>  	.props =3D ref##_props,			\
>  	.props_size =3D ARRAY_SIZE(ref##_props) }
> =20
> -static struct {
> +static struct bq27xxx_chip_datum {
>  	u32 opts;
>  	u32 unseal_key;
>  	u8 *regs;
> @@ -919,6 +919,40 @@ static struct {
>  	[BQ27621]   =3D BQ27XXX_DATA(bq27621,   0x80008000, BQ27XXX_O_UTOT | BQ=
27XXX_O_CFGUP | BQ27XXX_O_RAM),
>  };
> =20
> +static void __maybe_unused bq27xxx_battery_dbg_dupes(struct bq27xxx_devi=
ce_info *di)
> +{
> +	static bool once =3D false;
> +	const size_t max =3D ARRAY_SIZE(bq27xxx_chip_data);
> +	const char * const msg =3D "bq27xxx_chip_data[%d].%s & [%d].%s are iden=
tical\n";
> +	struct bq27xxx_chip_datum *a, *b;
> +	int i, j;
> +
> +	if (once)
> +		return;
> +	once =3D true;
> +
> +	for (i =3D 1; i < max-1; i++) {
> +		a =3D bq27xxx_chip_data + i;
> +
> +		for (j =3D i+1; j < max; j++) {
> +			b =3D bq27xxx_chip_data + j;
> +
> +			if (a->regs !=3D b->regs &&
> +			    !memcmp(a->regs, b->regs, sizeof(bq27000_regs)))
> +				dev_warn(di->dev, msg, i, "regs", j, "regs");
> +
> +			if (a->props !=3D b->props &&
> +			    a->props_size =3D=3D b->props_size &&
> +			    !memcmp(a->props, b->props, a->props_size))
> +				dev_warn(di->dev, msg, i, "props", j, "props");
> +
> +			if (a->dm_regs !=3D b->dm_regs &&
> +			    !memcmp(a->dm_regs, b->dm_regs, sizeof(bq27500_dm_regs)))
> +				dev_warn(di->dev, msg, i, "dm_regs", j, "dm_regs");
> +		}
> +	}
> +}
> +
>  static DEFINE_MUTEX(bq27xxx_list_lock);
>  static LIST_HEAD(bq27xxx_battery_devices);
> =20
> @@ -1976,6 +2010,10 @@ int bq27xxx_battery_setup(struct bq27xxx_device_in=
fo *di)
>  		.drv_data =3D di,
>  	};
> =20
> +#ifdef DEBUG
> +	bq27xxx_battery_dbg_dupes(di);
> +#endif
> +
>  	INIT_DELAYED_WORK(&di->work, bq27xxx_battery_poll);
>  	mutex_init(&di->lock);
> =20
> --=20
> 2.13.2
>=20

--h3vmz6hzhwsspefy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAlmPLAwACgkQ2O7X88g7
+ppJLQ//VLjExHzgxw/pXz4z3Bk3L+J08coUVuVE7e/cSCMzMUA0peFdzR7EyRgf
YteZ6h3/Ls3majXxgIkhdfx8RAihkKvH72StFQZVKlZrEvtcZ5LSvl3tMLXjupvj
JWmxHawynPq0iOfH4Mx3ttrEZuBX4iXEPq6ou3toZjy91ES6WutXVeFvn53Z3p0n
cB6J/rt7m6ADtvp8wf50EIlyYBlBXpRX9KdYLrQsBuCcZoxgO7VEfJQk7XIdHbB9
N1JCrb87I5J71cVROYhCQw8qLlCdWpLBd3h0pdRMhaP59dxsVPiYLgBpnxVX6Rb/
dQt3A62IhZ0uDl3sVAuHs9kAgIjRi5yra5vr5feA+5Y5eDh+y/AH2fzbIfOObE6Z
nBBmbaCA6QmIG6Uzmy8wZmX3iITdca2w8R3hdbXfSupTQ9ngtG6Q3Zsz3TwatLK7
ldxdGFjwx/byn3EQODCfe8hxyJ0KqvsDpthEe5NmUE777T3fTM04lyX5OxOC4MZr
LtjmGx3ygSIsmtI4OQLScxlLdXyaUmvq2eKKF73hCF02BemkERPv0KkF5NSnPfGf
r/64GxkJ1gM/YSwKgQzB3Z0OSoeF3/ivnmqeD0YCN0o7sbFZyTN/18fnYpic1ZKw
yHKbtFRc7pRmx5h4MtdFwpUOysXHIS9T6Jeu1pnbZXhmvEaP4ok=
=Savr
-----END PGP SIGNATURE-----

--h3vmz6hzhwsspefy--
