From: Sebastian Reichel <sre@kernel.org>
Subject: Re: [RFC v2 3/5] power: supply: bq27xxx: Enable data memory update
 for certain chips
Date: Sat, 12 Aug 2017 12:04:43 -0400
Message-ID: <20170812160443.5fvelnzw5gzdgu5j@earth>
References: <20170807062216.19988-1-liam@networkimprov.net>
 <20170807062216.19988-4-liam@networkimprov.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="35jrubkdozsg65vv"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:56608 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751344AbdHLQEp (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Sat, 12 Aug 2017 12:04:45 -0400
Content-Disposition: inline
In-Reply-To: <20170807062216.19988-4-liam@networkimprov.net>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Liam Breck <liam@networkimprov.net>
Cc: Pali =?iso-8859-1?Q?Roh=E1r?= <pali.rohar@gmail.com>, linux-pm@vger.kernel.org, Paul Kocialkowski <contact@paulk.fr>, Liam Breck <kernel@networkimprov.net>


--35jrubkdozsg65vv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

Looks mostly fine to me.

On Sun, Aug 06, 2017 at 11:22:14PM -0700, Liam Breck wrote:
> From: Liam Breck <kernel@networkimprov.net>
>=20
> Support data memory update on BQ27425. Parameters from TI datasheets are =
also
> provided for BQ27500, 545, 421, 441, 621; however these are commented out,
> as they are not tested.
>=20
> Add BQ27XXX_O_CFGUP & _O_RAM for use in bq27xxx_chip_data[n].opts
> and by data memory update functions.
>=20
> Signed-off-by: Liam Breck <kernel@networkimprov.net>
> ---
>  drivers/power/supply/bq27xxx_battery.c | 171 ++++++++++++++++++++++++---=
------
>  include/linux/power/bq27xxx_battery.h  |   1 -
>  2 files changed, 126 insertions(+), 46 deletions(-)
>=20
> diff --git a/drivers/power/supply/bq27xxx_battery.c b/drivers/power/suppl=
y/bq27xxx_battery.c
> index b186216d..8e535890 100644
> --- a/drivers/power/supply/bq27xxx_battery.c
> +++ b/drivers/power/supply/bq27xxx_battery.c
> @@ -58,7 +58,7 @@
> =20
>  #include <linux/power/bq27xxx_battery.h>
> =20
> -#define DRIVER_VERSION		"1.2.0"
> +#define DRIVER_VERSION		"1.3.0"

I think we should just drop the driver version thing. The correct
driver version is the kernel version.

>  #define BQ27XXX_MANUFACTURER	"Texas Instruments"
> =20
> @@ -785,46 +785,138 @@ static enum power_supply_property bq27421_props[] =
=3D {
>  #define bq27441_props bq27421_props
>  #define bq27621_props bq27421_props
> =20
> +struct bq27xxx_dm_reg {
> +	u8 subclass_id;
> +	u8 offset;
> +	u8 bytes;
> +	u16 min, max;
> +};
> +
> +enum bq27xxx_dm_reg_id {
> +	BQ27XXX_DM_DESIGN_CAPACITY =3D 0,
> +	BQ27XXX_DM_DESIGN_ENERGY,
> +	BQ27XXX_DM_TERMINATE_VOLTAGE,
> +};
> +
> +#define bq27000_dm_regs 0
> +#define bq27010_dm_regs 0
> +#define bq2750x_dm_regs 0
> +#define bq2751x_dm_regs 0
> +#define bq2752x_dm_regs 0
> +
> +#if 0 /* not yet tested */
> +static struct bq27xxx_dm_reg bq27500_dm_regs[] =3D {
> +	[BQ27XXX_DM_DESIGN_CAPACITY]   =3D { 48, 10, 2,    0, 65535 },
> +	[BQ27XXX_DM_DESIGN_ENERGY]     =3D { }, /* missing on chip */
> +	[BQ27XXX_DM_TERMINATE_VOLTAGE] =3D { 80, 48, 2, 1000, 32767 },
> +};
> +#else
> +#define bq27500_dm_regs 0
> +#endif

I guess we can just drop the untested bits and add them once
somebody needs/tested them. The values are directly from the
datasheet anyways, right?

> +/* todo create data memory definitions from datasheets and test on chips=
 */
> +#define bq27510g1_dm_regs 0
> +#define bq27510g2_dm_regs 0
> +#define bq27510g3_dm_regs 0
> +#define bq27520g1_dm_regs 0
> +#define bq27520g2_dm_regs 0
> +#define bq27520g3_dm_regs 0
> +#define bq27520g4_dm_regs 0
> +#define bq27530_dm_regs 0
> +#define bq27531_dm_regs 0
> +#define bq27541_dm_regs 0
> +#define bq27542_dm_regs 0
> +#define bq27546_dm_regs 0
> +#define bq27742_dm_regs 0
> +
> +#if 0 /* not yet tested */
> +static struct bq27xxx_dm_reg bq27545_dm_regs[] =3D {
> +	[BQ27XXX_DM_DESIGN_CAPACITY]   =3D { 48, 23, 2,    0, 32767 },
> +	[BQ27XXX_DM_DESIGN_ENERGY]     =3D { 48, 25, 2,    0, 32767 },
> +	[BQ27XXX_DM_TERMINATE_VOLTAGE] =3D { 80, 67, 2, 2800,  3700 },
> +};
> +#else
> +#define bq27545_dm_regs 0
> +#endif
> +
> +#if 0 /* not yet tested */
> +static struct bq27xxx_dm_reg bq27421_dm_regs[] =3D {
> +	[BQ27XXX_DM_DESIGN_CAPACITY]   =3D { 82, 10, 2,    0,  8000 },
> +	[BQ27XXX_DM_DESIGN_ENERGY]     =3D { 82, 12, 2,    0, 32767 },
> +	[BQ27XXX_DM_TERMINATE_VOLTAGE] =3D { 82, 16, 2, 2500,  3700 },
> +};
> +#else
> +#define bq27421_dm_regs 0
> +#endif
> +
> +static struct bq27xxx_dm_reg bq27425_dm_regs[] =3D {
> +	[BQ27XXX_DM_DESIGN_CAPACITY]   =3D { 82, 12, 2,    0, 32767 },
> +	[BQ27XXX_DM_DESIGN_ENERGY]     =3D { 82, 14, 2,    0, 32767 },
> +	[BQ27XXX_DM_TERMINATE_VOLTAGE] =3D { 82, 18, 2, 2800,  3700 },
> +};
> +
> +#if 0 /* not yet tested */
> +#define bq27441_dm_regs bq27421_dm_regs
> +#else
> +#define bq27441_dm_regs 0
> +#endif
> +
> +#if 0 /* not yet tested */
> +static struct bq27xxx_dm_reg bq27621_dm_regs[] =3D {
> +	[BQ27XXX_DM_DESIGN_CAPACITY]   =3D { 82, 3, 2,    0,  8000 },
> +	[BQ27XXX_DM_DESIGN_ENERGY]     =3D { 82, 5, 2,    0, 32767 },
> +	[BQ27XXX_DM_TERMINATE_VOLTAGE] =3D { 82, 9, 2, 2500,  3700 },
> +};
> +#else
> +#define bq27621_dm_regs 0
> +#endif
> +
>  #define BQ27XXX_O_ZERO	0x00000001
>  #define BQ27XXX_O_OTDC	0x00000002
>  #define BQ27XXX_O_UTOT  0x00000004
> +#define BQ27XXX_O_CFGUP	0x00000008
> +#define BQ27XXX_O_RAM	0x00000010
> =20
> -#define BQ27XXX_DATA(ref, opt) {		\
> +#define BQ27XXX_DATA(ref, key, opt) {		\
>  	.opts =3D (opt),				\
> +	.unseal_key =3D key,			\
>  	.regs  =3D ref##_regs,			\
> +	.dm_regs =3D ref##_dm_regs,		\
>  	.props =3D ref##_props,			\
>  	.props_size =3D ARRAY_SIZE(ref##_props) }
> =20
>  static struct {
>  	u32 opts;
> +	u32 unseal_key;
>  	u8 *regs;
> +	struct bq27xxx_dm_reg *dm_regs;
>  	enum power_supply_property *props;
>  	size_t props_size;
>  } bq27xxx_chip_data[] =3D {
> -	[BQ27000]   =3D BQ27XXX_DATA(bq27000,   BQ27XXX_O_ZERO),
> -	[BQ27010]   =3D BQ27XXX_DATA(bq27010,   BQ27XXX_O_ZERO),
> -	[BQ2750X]   =3D BQ27XXX_DATA(bq2750x,   BQ27XXX_O_OTDC),
> -	[BQ2751X]   =3D BQ27XXX_DATA(bq2751x,   BQ27XXX_O_OTDC),
> -	[BQ2752X]   =3D BQ27XXX_DATA(bq2752x,   BQ27XXX_O_OTDC),
> -	[BQ27500]   =3D BQ27XXX_DATA(bq27500,   BQ27XXX_O_OTDC),
> -	[BQ27510G1] =3D BQ27XXX_DATA(bq27510g1, BQ27XXX_O_OTDC),
> -	[BQ27510G2] =3D BQ27XXX_DATA(bq27510g2, BQ27XXX_O_OTDC),
> -	[BQ27510G3] =3D BQ27XXX_DATA(bq27510g3, BQ27XXX_O_OTDC),
> -	[BQ27520G1] =3D BQ27XXX_DATA(bq27520g1, BQ27XXX_O_OTDC),
> -	[BQ27520G2] =3D BQ27XXX_DATA(bq27520g2, BQ27XXX_O_OTDC),
> -	[BQ27520G3] =3D BQ27XXX_DATA(bq27520g3, BQ27XXX_O_OTDC),
> -	[BQ27520G4] =3D BQ27XXX_DATA(bq27520g4, BQ27XXX_O_OTDC),
> -	[BQ27530]   =3D BQ27XXX_DATA(bq27530,   BQ27XXX_O_UTOT),
> -	[BQ27531]   =3D BQ27XXX_DATA(bq27531,   BQ27XXX_O_UTOT),
> -	[BQ27541]   =3D BQ27XXX_DATA(bq27541,   BQ27XXX_O_OTDC),
> -	[BQ27542]   =3D BQ27XXX_DATA(bq27542,   BQ27XXX_O_OTDC),
> -	[BQ27546]   =3D BQ27XXX_DATA(bq27546,   BQ27XXX_O_OTDC),
> -	[BQ27742]   =3D BQ27XXX_DATA(bq27742,   BQ27XXX_O_OTDC),
> -	[BQ27545]   =3D BQ27XXX_DATA(bq27545,   BQ27XXX_O_OTDC),
> -	[BQ27421]   =3D BQ27XXX_DATA(bq27421,   BQ27XXX_O_UTOT),
> -	[BQ27425]   =3D BQ27XXX_DATA(bq27425,   BQ27XXX_O_UTOT),
> -	[BQ27441]   =3D BQ27XXX_DATA(bq27441,   BQ27XXX_O_UTOT),
> -	[BQ27621]   =3D BQ27XXX_DATA(bq27621,   BQ27XXX_O_UTOT),
> +	[BQ27000]   =3D BQ27XXX_DATA(bq27000,   0         , BQ27XXX_O_ZERO),
> +	[BQ27010]   =3D BQ27XXX_DATA(bq27010,   0         , BQ27XXX_O_ZERO),
> +	[BQ2750X]   =3D BQ27XXX_DATA(bq2750x,   0         , BQ27XXX_O_OTDC),
> +	[BQ2751X]   =3D BQ27XXX_DATA(bq2751x,   0         , BQ27XXX_O_OTDC),
> +	[BQ2752X]   =3D BQ27XXX_DATA(bq2752x,   0         , BQ27XXX_O_OTDC),
> +	[BQ27500]   =3D BQ27XXX_DATA(bq27500,   0x04143672, BQ27XXX_O_OTDC),
> +	[BQ27510G1] =3D BQ27XXX_DATA(bq27510g1, 0         , BQ27XXX_O_OTDC),
> +	[BQ27510G2] =3D BQ27XXX_DATA(bq27510g2, 0         , BQ27XXX_O_OTDC),
> +	[BQ27510G3] =3D BQ27XXX_DATA(bq27510g3, 0         , BQ27XXX_O_OTDC),
> +	[BQ27520G1] =3D BQ27XXX_DATA(bq27520g1, 0         , BQ27XXX_O_OTDC),
> +	[BQ27520G2] =3D BQ27XXX_DATA(bq27520g2, 0         , BQ27XXX_O_OTDC),
> +	[BQ27520G3] =3D BQ27XXX_DATA(bq27520g3, 0         , BQ27XXX_O_OTDC),
> +	[BQ27520G4] =3D BQ27XXX_DATA(bq27520g4, 0         , BQ27XXX_O_OTDC),
> +	[BQ27530]   =3D BQ27XXX_DATA(bq27530,   0         , BQ27XXX_O_UTOT),
> +	[BQ27531]   =3D BQ27XXX_DATA(bq27531,   0         , BQ27XXX_O_UTOT),
> +	[BQ27541]   =3D BQ27XXX_DATA(bq27541,   0         , BQ27XXX_O_OTDC),
> +	[BQ27542]   =3D BQ27XXX_DATA(bq27542,   0         , BQ27XXX_O_OTDC),
> +	[BQ27546]   =3D BQ27XXX_DATA(bq27546,   0         , BQ27XXX_O_OTDC),
> +	[BQ27742]   =3D BQ27XXX_DATA(bq27742,   0         , BQ27XXX_O_OTDC),
> +	[BQ27545]   =3D BQ27XXX_DATA(bq27545,   0x04143672, BQ27XXX_O_OTDC),
> +	[BQ27421]   =3D BQ27XXX_DATA(bq27421,   0x80008000, BQ27XXX_O_UTOT | BQ=
27XXX_O_CFGUP | BQ27XXX_O_RAM),
> +	[BQ27425]   =3D BQ27XXX_DATA(bq27425,   0x04143672, BQ27XXX_O_UTOT | BQ=
27XXX_O_CFGUP),
> +	[BQ27441]   =3D BQ27XXX_DATA(bq27441,   0x80008000, BQ27XXX_O_UTOT | BQ=
27XXX_O_CFGUP | BQ27XXX_O_RAM),
> +	[BQ27621]   =3D BQ27XXX_DATA(bq27621,   0x80008000, BQ27XXX_O_UTOT | BQ=
27XXX_O_CFGUP | BQ27XXX_O_RAM),
>  };
> =20
>  static DEFINE_MUTEX(bq27xxx_list_lock);
> @@ -834,13 +926,6 @@ static LIST_HEAD(bq27xxx_battery_devices);
> =20
>  #define BQ27XXX_DM_SZ	32
> =20
> -struct bq27xxx_dm_reg {
> -	u8 subclass_id;
> -	u8 offset;
> -	u8 bytes;
> -	u16 min, max;
> -};
> -
>  /**
>   * struct bq27xxx_dm_buf - chip data memory buffer
>   * @class: data memory subclass_id
> @@ -873,12 +958,6 @@ static inline u16 *bq27xxx_dm_reg_ptr(struct bq27xxx=
_dm_buf *buf,
>  	return NULL;
>  }
> =20
> -enum bq27xxx_dm_reg_id {
> -	BQ27XXX_DM_DESIGN_CAPACITY =3D 0,
> -	BQ27XXX_DM_DESIGN_ENERGY,
> -	BQ27XXX_DM_TERMINATE_VOLTAGE,
> -};
> -
>  static const char * const bq27xxx_dm_reg_name[] =3D {
>  	[BQ27XXX_DM_DESIGN_CAPACITY] =3D "design-capacity",
>  	[BQ27XXX_DM_DESIGN_ENERGY] =3D "design-energy",
> @@ -1121,9 +1200,9 @@ static void bq27xxx_battery_update_dm_block(struct =
bq27xxx_device_info *di,
>  	}
> =20
>  #ifdef CONFIG_BATTERY_BQ27XXX_DT_UPDATES_NVM
> -	if (!di->ram_chip && !bq27xxx_dt_to_nvm) {
> +	if (!(di->opts & BQ27XXX_O_RAM) && !bq27xxx_dt_to_nvm) {
>  #else
> -	if (!di->ram_chip) {
> +	if (!(di->opts & BQ27XXX_O_RAM)) {
>  #endif
>  		/* devicetree and NVM differ; defer to NVM */
>  		dev_warn(di->dev, "%s has %u; update to %u disallowed "
> @@ -1191,7 +1270,7 @@ static inline int bq27xxx_battery_soft_reset(struct=
 bq27xxx_device_info *di)
>  static int bq27xxx_battery_write_dm_block(struct bq27xxx_device_info *di,
>  					  struct bq27xxx_dm_buf *buf)
>  {
> -	bool cfgup =3D di->chip =3D=3D BQ27421; /* assume related chips need cf=
gupdate */
> +	bool cfgup =3D di->opts & BQ27XXX_O_CFGUP;
>  	int ret;
> =20
>  	if (!buf->dirty)
> @@ -1290,7 +1369,7 @@ static void bq27xxx_battery_set_config(struct bq27x=
xx_device_info *di,
> =20
>  	bq27xxx_battery_seal(di);
> =20
> -	if (updated && di->chip !=3D BQ27421) { /* not a cfgupdate chip, so res=
et */
> +	if (updated && !(di->opts & BQ27XXX_O_CFGUP)) {
>  		bq27xxx_write(di, BQ27XXX_REG_CTRL, BQ27XXX_RESET, false);
>  		BQ27XXX_MSLEEP(300); /* reset time is not documented */
>  	}
> @@ -1900,8 +1979,10 @@ int bq27xxx_battery_setup(struct bq27xxx_device_in=
fo *di)
>  	INIT_DELAYED_WORK(&di->work, bq27xxx_battery_poll);
>  	mutex_init(&di->lock);
> =20
> -	di->regs =3D bq27xxx_chip_data[di->chip].regs;
> -	di->opts =3D bq27xxx_chip_data[di->chip].opts;
> +	di->regs       =3D bq27xxx_chip_data[di->chip].regs;
> +	di->unseal_key =3D bq27xxx_chip_data[di->chip].unseal_key;
> +	di->dm_regs    =3D bq27xxx_chip_data[di->chip].dm_regs;
> +	di->opts       =3D bq27xxx_chip_data[di->chip].opts;
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
> 2.13.2
>=20

--35jrubkdozsg65vv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAlmPJxgACgkQ2O7X88g7
+pqzaA/+NGdqECkxzF7UomRGzUznxTvEWnkF5M4SjNk2OrDzMFeyNci4uOl3Zy8b
Sp9QmGMeCtwGZOm8b6QWhl/gB55KHGl29K7lvpwbya9VaP7MvheCEbU/bx1JfrGz
udFnNiT83l35tHMT3bB5ExseVgigqPoQudpkEOFEIs7yZ3XzK5jmi0hVDSsyWJ7c
55ipsxFTXPvnwrmmqsXZCGksERfh4RTt9knE9SrS9pCjR8RIc8MD6iAWLhGOTVS4
+k9Ce0jUiZInnrNGZAGLNwr5ZvePcv08soiwH9YnAisqPbyHgf1uM2ylk3wTPcEZ
1dP7JPa7fEeZrmZXQzNu5B9QBOOe+StEb7q1iLZ3xO3nrDnFW8Schfa4jYzs4uSO
sWoTACeLVd1r/wneozab7D7Lw4Iib8D7HLUBGT06P67zpImZlVmzimddyqRdV45P
fPrlMCHgfL9Z6tMfMlEVchCCRSX1hkQfJJk3dzqAFpoH2zlzaTW9pA63ry/tovMn
b7g/ZAfFKScoxwbJkRMEghV66KtXInBBe0lsAKmuw0M+0/aPsuVjDYG1p6260Svt
mK5Al8CKvndlawqbHhgwsoCL3/1Uf3yoH2XeSqiN3d3L6GPayamah+23K7xZJuY8
mZho7u6ylzXoRysLwYJU0jnl3vyBduK5gHd7o/3IuE7sEFuqVug=
=xYuW
-----END PGP SIGNATURE-----

--35jrubkdozsg65vv--
