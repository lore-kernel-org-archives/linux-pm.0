From: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
Subject: Re: [RFC v1 4/6] power: supply: bq27xxx: Add chip data options for
 cfgupdate & ram-only
Date: Tue, 25 Jul 2017 13:24:58 +0200
Message-ID: <20170725112458.m7k2h6o4yz3z4kp6@earth>
References: <20170709021700.14354-1-liam@networkimprov.net>
 <20170709021700.14354-5-liam@networkimprov.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="axcrigyesorzgyvv"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from bhuna.collabora.co.uk ([46.235.227.227]:32865 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750860AbdGYLZC (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 25 Jul 2017 07:25:02 -0400
Content-Disposition: inline
In-Reply-To: <20170709021700.14354-5-liam@networkimprov.net>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Liam Breck <liam@networkimprov.net>
Cc: Pali =?iso-8859-1?Q?Roh=E1r?= <pali.rohar@gmail.com>, linux-pm@vger.kernel.org, Paul Kocialkowski <contact@paulk.fr>, Liam Breck <kernel@networkimprov.net>


--axcrigyesorzgyvv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Sat, Jul 08, 2017 at 07:16:58PM -0700, Liam Breck wrote:
> From: Liam Breck <kernel@networkimprov.net>
>=20
> Add BQ27XXX_O_CFGUP & _O_RAM for use in bq27xxx_chip_data[n].opts
> Replace related uses of di->chip =3D=3D BQ27nnn with (BQ27XXX_O_XYZ & di-=
>opts)

In the kernel we prefer (variable & mask), so it should be (di->opts
& BQ27XXX_O_XYZ). Otherwise looks good.

-- Sebastian

> No functional changes to the driver.
>=20
> Signed-off-by: Liam Breck <kernel@networkimprov.net>
> ---
>  drivers/power/supply/bq27xxx_battery.c | 22 +++++++++++-----------
>  include/linux/power/bq27xxx_battery.h  |  1 -
>  2 files changed, 11 insertions(+), 12 deletions(-)
>=20
> diff --git a/drivers/power/supply/bq27xxx_battery.c b/drivers/power/suppl=
y/bq27xxx_battery.c
> index 0bd46fae..5d3893a9 100644
> --- a/drivers/power/supply/bq27xxx_battery.c
> +++ b/drivers/power/supply/bq27xxx_battery.c
> @@ -871,6 +871,9 @@ static struct bq27xxx_dm_reg bq27621_dm_regs[] =3D {
>  #define bq27621_dm_regs 0
>  #endif
> =20
> +#define BQ27XXX_O_CFGUP  0x00000001
> +#define BQ27XXX_O_RAM    0x00000002
> +
>  #define BQ27XXX_DATA(ref, act, key, opt) {	\
>  	.opts =3D (opt),				\
>  	.acts_like =3D act,			\
> @@ -909,10 +912,10 @@ static struct {
>  	[BQ27546]   =3D BQ27XXX_DATA(546,   BQ27541, 0, 0),
>  	[BQ27742]   =3D BQ27XXX_DATA(742,   BQ27541, 0, 0),
>  	[BQ27545]   =3D BQ27XXX_DATA(545,   0,       0x04143672, 0),
> -	[BQ27421]   =3D BQ27XXX_DATA(421,   0,       0x80008000, 0),
> -	[BQ27425]   =3D BQ27XXX_DATA(425,   BQ27421, 0x04143672, 0),
> -	[BQ27441]   =3D BQ27XXX_DATA(441,   BQ27421, 0x80008000, 0),
> -	[BQ27621]   =3D BQ27XXX_DATA(621,   BQ27421, 0x80008000, 0),
> +	[BQ27421]   =3D BQ27XXX_DATA(421,   0,       0x80008000, BQ27XXX_O_CFGU=
P | BQ27XXX_O_RAM),
> +	[BQ27425]   =3D BQ27XXX_DATA(425,   BQ27421, 0x04143672, BQ27XXX_O_CFGU=
P),
> +	[BQ27441]   =3D BQ27XXX_DATA(441,   BQ27421, 0x80008000, BQ27XXX_O_CFGU=
P | BQ27XXX_O_RAM),
> +	[BQ27621]   =3D BQ27XXX_DATA(621,   BQ27421, 0x80008000, BQ27XXX_O_CFGU=
P | BQ27XXX_O_RAM),
>  };
> =20
>  static DEFINE_MUTEX(bq27xxx_list_lock);
> @@ -1196,9 +1199,9 @@ static void bq27xxx_battery_update_dm_block(struct =
bq27xxx_device_info *di,
>  	}
> =20
>  #ifdef CONFIG_BATTERY_BQ27XXX_DT_UPDATES_NVM
> -	if (!di->ram_chip && !bq27xxx_dt_to_nvm) {
> +	if (!(BQ27XXX_O_RAM & di->opts) && !bq27xxx_dt_to_nvm) {
>  #else
> -	if (!di->ram_chip) {
> +	if (!(BQ27XXX_O_RAM & di->opts)) {
>  #endif
>  		/* devicetree and NVM differ; defer to NVM */
>  		dev_warn(di->dev, "%s has %u; update to %u disallowed "
> @@ -1266,7 +1269,7 @@ static inline int bq27xxx_battery_soft_reset(struct=
 bq27xxx_device_info *di)
>  static int bq27xxx_battery_write_dm_block(struct bq27xxx_device_info *di,
>  					  struct bq27xxx_dm_buf *buf)
>  {
> -	bool cfgup =3D di->chip =3D=3D BQ27421; /* assume related chips need cf=
gupdate */
> +	bool cfgup =3D BQ27XXX_O_CFGUP & di->opts;
>  	int ret;
> =20
>  	if (!buf->dirty)
> @@ -1365,7 +1368,7 @@ static void bq27xxx_battery_set_config(struct bq27x=
xx_device_info *di,
> =20
>  	bq27xxx_battery_seal(di);
> =20
> -	if (updated && di->chip !=3D BQ27421) { /* not a cfgupdate chip, so res=
et */
> +	if (updated && !(BQ27XXX_O_CFGUP & di->opts)) {
>  		bq27xxx_write(di, BQ27XXX_REG_CTRL, BQ27XXX_RESET, false);
>  		BQ27XXX_MSLEEP(300); /* reset time is not documented */
>  	}
> @@ -1993,9 +1996,6 @@ int bq27xxx_battery_setup(struct bq27xxx_device_inf=
o *di)
>  	di->unseal_key =3D bq27xxx_chip_data[di->chip].unseal_key;
>  	di->dm_regs    =3D bq27xxx_chip_data[di->chip].dm_regs;
>  	di->opts       =3D bq27xxx_chip_data[di->chip].opts;
> -	di->ram_chip =3D di->chip =3D=3D BQ27421 ||
> -		       di->chip =3D=3D BQ27441 ||
> -		       di->chip =3D=3D BQ27621;
> =20
>  	psy_desc =3D devm_kzalloc(di->dev, sizeof(*psy_desc), GFP_KERNEL);
>  	if (!psy_desc)
> diff --git a/include/linux/power/bq27xxx_battery.h b/include/linux/power/=
bq27xxx_battery.h
> index 77fe94f1..8a8a3f61 100644
> --- a/include/linux/power/bq27xxx_battery.h
> +++ b/include/linux/power/bq27xxx_battery.h
> @@ -71,7 +71,6 @@ struct bq27xxx_device_info {
>  	struct device *dev;
>  	int id;
>  	enum bq27xxx_chip chip;
> -	bool ram_chip;
>  	u32 opts;
>  	const char *name;
>  	struct bq27xxx_dm_reg *dm_regs;
> --=20
> 2.13.1
>=20

--axcrigyesorzgyvv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAll3KooACgkQ2O7X88g7
+pr5OQ/+PNrPHT87wkAO/GvNWUz3T7LOlAXCvtnQjIHP8+wC2BN8/efLsCPNkz1S
L0bTL8WR/XvfN7Wzdm+vi/vw/RPIhnVX0a+B56zsNQBs2KmBsx1vTSsQQti8D3Eq
yT4GbVThh+9/f3OUVbUAUu6YhyJ3bO5wBE58B5s2kxvTLx4JyFQLBnCFASubxXV0
RetmlxXok1hyW/cPMIJTC5JMiNedFjrElI3lzKy0t6+X/sTvuA0YxndEooDBegYl
9Mn/j2ciT41/PsQSWwIOHByiWrofuGDlAdixYLBqy/qQZV2ason3y5nlDE/RHbLh
zRVZ4Bfi3Bf9FZAbvqrbHxKZzLxd6Eh1sm88Cbg536kBygyf0ntoxaRbGyu/kQU5
ryOlGZuwUHpyMZQ8mBEqKPJDY11+EjOOtW/LCXyP25n6Ms7xT/2lQ62fxyma6GVo
zxV9FqWdyTtMPrSc4ZSHuuUrwaQHAdbUffFD2cLjyVQ6RT8wFh6v3Tpopy2JGthx
xsy91fYUiiBh6c9o4mYDl3ZbVbDb7jld9tTIxt5ffKSka7SV2oU1/iYUNgCYToXD
4yM1EM3sUVbXEQaX2iqN1DXTYxREF8jyZnL2idFuzx8CaB1ouO6k7UOQSjCB+9SR
7JDKe3xX4R8mp5qcbIpKJqoxAeQQWLPbOX9Tcs9gCg+xNU9PhoI=
=dzdv
-----END PGP SIGNATURE-----

--axcrigyesorzgyvv--
