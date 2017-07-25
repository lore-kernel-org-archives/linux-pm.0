From: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
Subject: Re: [RFC v1 5/6] power: supply: bq27xxx: Flag identical chip data
 when in debug mode
Date: Tue, 25 Jul 2017 15:04:42 +0200
Message-ID: <20170725130441.xejsh6yuubzqaclr@earth>
References: <20170709021700.14354-1-liam@networkimprov.net>
 <20170709021700.14354-6-liam@networkimprov.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="6f3uu3vxzxgr3q6m"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from bhuna.collabora.co.uk ([46.235.227.227]:33122 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751799AbdGYNEq (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 25 Jul 2017 09:04:46 -0400
Content-Disposition: inline
In-Reply-To: <20170709021700.14354-6-liam@networkimprov.net>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Liam Breck <liam@networkimprov.net>
Cc: Pali =?iso-8859-1?Q?Roh=E1r?= <pali.rohar@gmail.com>, linux-pm@vger.kernel.org, Paul Kocialkowski <contact@paulk.fr>, Liam Breck <kernel@networkimprov.net>


--6f3uu3vxzxgr3q6m
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Sat, Jul 08, 2017 at 07:16:59PM -0700, Liam Breck wrote:
> From: Liam Breck <kernel@networkimprov.net>
>=20
> The driver has 13 unique register maps, several of which are shared
> by multiple chips. When adding support for a new chip, it's easy to
> add a duplicate map by mistake.

Which is not that bad. Sure, some bytes wasted, but your code also
wastes some bytes. This is something, that should normally tested
@ compile time using static checkers. Independently the patch has
some issues:

> In debug mode we now scan bq27xxx_chip_data[n].regs/props/dm_regs for
> duplicates.
>=20
> Signed-off-by: Liam Breck <kernel@networkimprov.net>
> ---
>  drivers/power/supply/bq27xxx_battery.c | 36 ++++++++++++++++++++++++++++=
+++++-
>  1 file changed, 35 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/power/supply/bq27xxx_battery.c b/drivers/power/suppl=
y/bq27xxx_battery.c
> index 5d3893a9..54755c88 100644
> --- a/drivers/power/supply/bq27xxx_battery.c
> +++ b/drivers/power/supply/bq27xxx_battery.c
> @@ -883,7 +883,7 @@ static struct bq27xxx_dm_reg bq27621_dm_regs[] =3D {
>  	.props =3D bq27##ref##_props,		\
>  	.props_size =3D ARRAY_SIZE(bq27##ref##_props) }
> =20
> -static struct {
> +static struct bq27xxx_chip_datum {
>  	u32 opts;
>  	int acts_like; //todo drop this when opts fully implemented
>  	u32 unseal_key;
> @@ -918,6 +918,38 @@ static struct {
>  	[BQ27621]   =3D BQ27XXX_DATA(621,   BQ27421, 0x80008000, BQ27XXX_O_CFGU=
P | BQ27XXX_O_RAM),
>  };
> =20
> +static void __maybe_unused bq27xxx_battery_dbg_dupes(struct bq27xxx_devi=
ce_info *di)

If there are multiple bq27xxx batteries installed in the system the
code is executed multiple times, so let's modify this a bit:

> +{
> +	const size_t max =3D ARRAY_SIZE(bq27xxx_chip_data);
> +	const char * const msg =3D "bq27xxx_chip_data[%d].%s & [%d].%s are iden=
tical\n";
> +	struct bq27xxx_chip_datum *a, *b;
> +	int i, j;

static checked =3D false;

if (checked)
    return;

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

checked =3D true;

> +}
> +#ifndef DEBUG
> +#define bq27xxx_battery_dbg_dupes(di)
> +#endif
> +
>  static DEFINE_MUTEX(bq27xxx_list_lock);
>  static LIST_HEAD(bq27xxx_battery_devices);
> =20
> @@ -1989,6 +2021,8 @@ int bq27xxx_battery_setup(struct bq27xxx_device_inf=
o *di)
>  		.drv_data =3D di,
>  	};
> =20
> +	bq27xxx_battery_dbg_dupes(di);

Add #ifdef DEBUG here and drop the above.

>  	INIT_DELAYED_WORK(&di->work, bq27xxx_battery_poll);
>  	mutex_init(&di->lock);
> =20
> --=20
> 2.13.1
>=20

--6f3uu3vxzxgr3q6m
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAll3QeYACgkQ2O7X88g7
+pppqxAAl71MNVOVpVYxe3hX+uFexzLkTaB9osu0ffAN/VdyXIoWDqqhlnnwA9+i
wF1SZopnNhDGXdyQoyfFKvq9gOgWFwD5BnqR3/BlV2SNEbs5+Be6Tu3j63WHinD/
7NhcjB5uebDlyic/JrGei8A8itlHEVxESLqPPjo3Wc8cLwcGy4O1DSsoL2TaHBN5
euNQPU8TB+4tozkLRxZsgxhlkwnNJFdmYwc1j6HYCv9O186JOyvMysFie092d1Tl
H+vSjjL1sztSQBI82VGn0HirUBgmGVfmvhsCGLoP2nSqQl78nWU2KY7PkFs9xVgO
NFNVCSBEZYmyyDLcYveFaQeunIJXclmDlbsJSIVG3BfU0R+/mp4CHO1dUwD/jyJE
qj8qqyN9kDUJudUPbWU3H9J2KGCaYT+Y9yWC3Bdc/A+kBi703CGI5+nsqHocj7K/
sBtyAudZWosL+8Mqtn++EiK/Fd6cdxjBbfnbaM8WhEv63nzTytyMOkP7myUsdJgR
h0OHDiARGj9RRuQ0WGcPdRFQs9+MhGw7Pr8w713xWXR/ei5lUtjcT1CRgfZRxa8h
f+GUaeK+TKFf7i0TTIxpi9INPvdaSSiS/3JyiOggr9lh6OWitRuq08hTuCfned8Z
U+sBsSZtA0V1jhRyaV9mT3OdXetWVEmDsjz0n6Ar/0tHiLQTfr0=
=04uX
-----END PGP SIGNATURE-----

--6f3uu3vxzxgr3q6m--
