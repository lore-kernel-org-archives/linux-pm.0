From: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
Subject: Re: [RFC v2 1/5] power: supply: bq27xxx: Create single chip data
 table
Date: Wed, 9 Aug 2017 18:08:24 +0200
Message-ID: <20170809160621.xcfwrerbe2ztehd4@earth>
References: <20170807062216.19988-1-liam@networkimprov.net>
 <20170807062216.19988-2-liam@networkimprov.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="qssyszxa6c2ey73u"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from bhuna.collabora.co.uk ([46.235.227.227]:43124 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752613AbdHIQIb (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 9 Aug 2017 12:08:31 -0400
Content-Disposition: inline
In-Reply-To: <20170807062216.19988-2-liam@networkimprov.net>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Liam Breck <liam@networkimprov.net>
Cc: Pali =?iso-8859-1?Q?Roh=E1r?= <pali.rohar@gmail.com>, linux-pm@vger.kernel.org, Paul Kocialkowski <contact@paulk.fr>, Liam Breck <kernel@networkimprov.net>


--qssyszxa6c2ey73u
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Sun, Aug 06, 2017 at 11:22:12PM -0700, Liam Breck wrote:
> From: Liam Breck <kernel@networkimprov.net>
>=20
> To support new features which require different data for each chip, we
> unify the bq27xxx_regs and bq27xxx_battery_props tables into a single one.
>=20
> No functional changes to the driver.
>=20
> Signed-off-by: Liam Breck <kernel@networkimprov.net>

Looks fine to me.

-- Sebastian

> ---
>  drivers/power/supply/bq27xxx_battery.c | 121 ++++++++++++++++-----------=
------
>  1 file changed, 60 insertions(+), 61 deletions(-)
>=20
> diff --git a/drivers/power/supply/bq27xxx_battery.c b/drivers/power/suppl=
y/bq27xxx_battery.c
> index ed44439d..dd84e3d9 100644
> --- a/drivers/power/supply/bq27xxx_battery.c
> +++ b/drivers/power/supply/bq27xxx_battery.c
> @@ -132,8 +132,8 @@ enum bq27xxx_reg_index {
>  	[BQ27XXX_DM_CKSUM] =3D 0x60
> =20
>  /* Register mappings */
> -static u8 bq27xxx_regs[][BQ27XXX_REG_MAX] =3D {
> -	[BQ27000] =3D {
> +static u8
> +	bq27000_regs[BQ27XXX_REG_MAX] =3D {
>  		[BQ27XXX_REG_CTRL] =3D 0x00,
>  		[BQ27XXX_REG_TEMP] =3D 0x06,
>  		[BQ27XXX_REG_INT_TEMP] =3D INVALID_REG_ADDR,
> @@ -157,7 +157,7 @@ static u8 bq27xxx_regs[][BQ27XXX_REG_MAX] =3D {
>  		[BQ27XXX_DM_DATA] =3D INVALID_REG_ADDR,
>  		[BQ27XXX_DM_CKSUM] =3D INVALID_REG_ADDR,
>  	},
> -	[BQ27010] =3D {
> +	bq27010_regs[BQ27XXX_REG_MAX] =3D {
>  		[BQ27XXX_REG_CTRL] =3D 0x00,
>  		[BQ27XXX_REG_TEMP] =3D 0x06,
>  		[BQ27XXX_REG_INT_TEMP] =3D INVALID_REG_ADDR,
> @@ -181,7 +181,7 @@ static u8 bq27xxx_regs[][BQ27XXX_REG_MAX] =3D {
>  		[BQ27XXX_DM_DATA] =3D INVALID_REG_ADDR,
>  		[BQ27XXX_DM_CKSUM] =3D INVALID_REG_ADDR,
>  	},
> -	[BQ2750X] =3D {
> +	bq2750x_regs[BQ27XXX_REG_MAX] =3D {
>  		[BQ27XXX_REG_CTRL] =3D 0x00,
>  		[BQ27XXX_REG_TEMP] =3D 0x06,
>  		[BQ27XXX_REG_INT_TEMP] =3D 0x28,
> @@ -201,7 +201,7 @@ static u8 bq27xxx_regs[][BQ27XXX_REG_MAX] =3D {
>  		[BQ27XXX_REG_AP] =3D INVALID_REG_ADDR,
>  		BQ27XXX_DM_REG_ROWS,
>  	},
> -	[BQ2751X] =3D {
> +	bq2751x_regs[BQ27XXX_REG_MAX] =3D {
>  		[BQ27XXX_REG_CTRL] =3D 0x00,
>  		[BQ27XXX_REG_TEMP] =3D 0x06,
>  		[BQ27XXX_REG_INT_TEMP] =3D 0x28,
> @@ -221,7 +221,7 @@ static u8 bq27xxx_regs[][BQ27XXX_REG_MAX] =3D {
>  		[BQ27XXX_REG_AP] =3D INVALID_REG_ADDR,
>  		BQ27XXX_DM_REG_ROWS,
>  	},
> -	[BQ27500] =3D {
> +	bq27500_regs[BQ27XXX_REG_MAX] =3D {
>  		[BQ27XXX_REG_CTRL] =3D 0x00,
>  		[BQ27XXX_REG_TEMP] =3D 0x06,
>  		[BQ27XXX_REG_INT_TEMP] =3D INVALID_REG_ADDR,
> @@ -241,7 +241,7 @@ static u8 bq27xxx_regs[][BQ27XXX_REG_MAX] =3D {
>  		[BQ27XXX_REG_AP] =3D 0x24,
>  		BQ27XXX_DM_REG_ROWS,
>  	},
> -	[BQ27510G1] =3D {
> +	bq27510g1_regs[BQ27XXX_REG_MAX] =3D {
>  		[BQ27XXX_REG_CTRL] =3D 0x00,
>  		[BQ27XXX_REG_TEMP] =3D 0x06,
>  		[BQ27XXX_REG_INT_TEMP] =3D INVALID_REG_ADDR,
> @@ -261,7 +261,7 @@ static u8 bq27xxx_regs[][BQ27XXX_REG_MAX] =3D {
>  		[BQ27XXX_REG_AP] =3D 0x24,
>  		BQ27XXX_DM_REG_ROWS,
>  	},
> -	[BQ27510G2] =3D {
> +	bq27510g2_regs[BQ27XXX_REG_MAX] =3D {
>  		[BQ27XXX_REG_CTRL] =3D 0x00,
>  		[BQ27XXX_REG_TEMP] =3D 0x06,
>  		[BQ27XXX_REG_INT_TEMP] =3D INVALID_REG_ADDR,
> @@ -281,7 +281,7 @@ static u8 bq27xxx_regs[][BQ27XXX_REG_MAX] =3D {
>  		[BQ27XXX_REG_AP] =3D 0x24,
>  		BQ27XXX_DM_REG_ROWS,
>  	},
> -	[BQ27510G3] =3D {
> +	bq27510g3_regs[BQ27XXX_REG_MAX] =3D {
>  		[BQ27XXX_REG_CTRL] =3D 0x00,
>  		[BQ27XXX_REG_TEMP] =3D 0x06,
>  		[BQ27XXX_REG_INT_TEMP] =3D 0x28,
> @@ -301,7 +301,7 @@ static u8 bq27xxx_regs[][BQ27XXX_REG_MAX] =3D {
>  		[BQ27XXX_REG_AP] =3D INVALID_REG_ADDR,
>  		BQ27XXX_DM_REG_ROWS,
>  	},
> -	[BQ27520G1] =3D {
> +	bq27520g1_regs[BQ27XXX_REG_MAX] =3D {
>  		[BQ27XXX_REG_CTRL] =3D 0x00,
>  		[BQ27XXX_REG_TEMP] =3D 0x06,
>  		[BQ27XXX_REG_INT_TEMP] =3D INVALID_REG_ADDR,
> @@ -321,7 +321,7 @@ static u8 bq27xxx_regs[][BQ27XXX_REG_MAX] =3D {
>  		[BQ27XXX_REG_AP] =3D 0x24,
>  		BQ27XXX_DM_REG_ROWS,
>  	},
> -	[BQ27520G2] =3D {
> +	bq27520g2_regs[BQ27XXX_REG_MAX] =3D {
>  		[BQ27XXX_REG_CTRL] =3D 0x00,
>  		[BQ27XXX_REG_TEMP] =3D 0x06,
>  		[BQ27XXX_REG_INT_TEMP] =3D 0x36,
> @@ -341,7 +341,7 @@ static u8 bq27xxx_regs[][BQ27XXX_REG_MAX] =3D {
>  		[BQ27XXX_REG_AP] =3D 0x24,
>  		BQ27XXX_DM_REG_ROWS,
>  	},
> -	[BQ27520G3] =3D {
> +	bq27520g3_regs[BQ27XXX_REG_MAX] =3D {
>  		[BQ27XXX_REG_CTRL] =3D 0x00,
>  		[BQ27XXX_REG_TEMP] =3D 0x06,
>  		[BQ27XXX_REG_INT_TEMP] =3D 0x36,
> @@ -361,7 +361,7 @@ static u8 bq27xxx_regs[][BQ27XXX_REG_MAX] =3D {
>  		[BQ27XXX_REG_AP] =3D 0x24,
>  		BQ27XXX_DM_REG_ROWS,
>  	},
> -	[BQ27520G4] =3D {
> +	bq27520g4_regs[BQ27XXX_REG_MAX] =3D {
>  		[BQ27XXX_REG_CTRL] =3D 0x00,
>  		[BQ27XXX_REG_TEMP] =3D 0x06,
>  		[BQ27XXX_REG_INT_TEMP] =3D 0x28,
> @@ -381,7 +381,7 @@ static u8 bq27xxx_regs[][BQ27XXX_REG_MAX] =3D {
>  		[BQ27XXX_REG_AP] =3D INVALID_REG_ADDR,
>  		BQ27XXX_DM_REG_ROWS,
>  	},
> -	[BQ27530] =3D {
> +	bq27530_regs[BQ27XXX_REG_MAX] =3D {
>  		[BQ27XXX_REG_CTRL] =3D 0x00,
>  		[BQ27XXX_REG_TEMP] =3D 0x06,
>  		[BQ27XXX_REG_INT_TEMP] =3D 0x32,
> @@ -401,7 +401,7 @@ static u8 bq27xxx_regs[][BQ27XXX_REG_MAX] =3D {
>  		[BQ27XXX_REG_AP] =3D 0x24,
>  		BQ27XXX_DM_REG_ROWS,
>  	},
> -	[BQ27541] =3D {
> +	bq27541_regs[BQ27XXX_REG_MAX] =3D {
>  		[BQ27XXX_REG_CTRL] =3D 0x00,
>  		[BQ27XXX_REG_TEMP] =3D 0x06,
>  		[BQ27XXX_REG_INT_TEMP] =3D 0x28,
> @@ -421,7 +421,7 @@ static u8 bq27xxx_regs[][BQ27XXX_REG_MAX] =3D {
>  		[BQ27XXX_REG_AP] =3D 0x24,
>  		BQ27XXX_DM_REG_ROWS,
>  	},
> -	[BQ27545] =3D {
> +	bq27545_regs[BQ27XXX_REG_MAX] =3D {
>  		[BQ27XXX_REG_CTRL] =3D 0x00,
>  		[BQ27XXX_REG_TEMP] =3D 0x06,
>  		[BQ27XXX_REG_INT_TEMP] =3D 0x28,
> @@ -441,7 +441,7 @@ static u8 bq27xxx_regs[][BQ27XXX_REG_MAX] =3D {
>  		[BQ27XXX_REG_AP] =3D 0x24,
>  		BQ27XXX_DM_REG_ROWS,
>  	},
> -	[BQ27421] =3D {
> +	bq27421_regs[BQ27XXX_REG_MAX] =3D {
>  		[BQ27XXX_REG_CTRL] =3D 0x00,
>  		[BQ27XXX_REG_TEMP] =3D 0x02,
>  		[BQ27XXX_REG_INT_TEMP] =3D 0x1e,
> @@ -460,10 +460,9 @@ static u8 bq27xxx_regs[][BQ27XXX_REG_MAX] =3D {
>  		[BQ27XXX_REG_DCAP] =3D 0x3c,
>  		[BQ27XXX_REG_AP] =3D 0x18,
>  		BQ27XXX_DM_REG_ROWS,
> -	},
> -};
> +	};
> =20
> -static enum power_supply_property bq27000_battery_props[] =3D {
> +static enum power_supply_property bq27000_props[] =3D {
>  	POWER_SUPPLY_PROP_STATUS,
>  	POWER_SUPPLY_PROP_PRESENT,
>  	POWER_SUPPLY_PROP_VOLTAGE_NOW,
> @@ -485,7 +484,7 @@ static enum power_supply_property bq27000_battery_pro=
ps[] =3D {
>  	POWER_SUPPLY_PROP_MANUFACTURER,
>  };
> =20
> -static enum power_supply_property bq27010_battery_props[] =3D {
> +static enum power_supply_property bq27010_props[] =3D {
>  	POWER_SUPPLY_PROP_STATUS,
>  	POWER_SUPPLY_PROP_PRESENT,
>  	POWER_SUPPLY_PROP_VOLTAGE_NOW,
> @@ -505,7 +504,7 @@ static enum power_supply_property bq27010_battery_pro=
ps[] =3D {
>  	POWER_SUPPLY_PROP_MANUFACTURER,
>  };
> =20
> -static enum power_supply_property bq2750x_battery_props[] =3D {
> +static enum power_supply_property bq2750x_props[] =3D {
>  	POWER_SUPPLY_PROP_STATUS,
>  	POWER_SUPPLY_PROP_PRESENT,
>  	POWER_SUPPLY_PROP_VOLTAGE_NOW,
> @@ -523,7 +522,7 @@ static enum power_supply_property bq2750x_battery_pro=
ps[] =3D {
>  	POWER_SUPPLY_PROP_MANUFACTURER,
>  };
> =20
> -static enum power_supply_property bq2751x_battery_props[] =3D {
> +static enum power_supply_property bq2751x_props[] =3D {
>  	POWER_SUPPLY_PROP_STATUS,
>  	POWER_SUPPLY_PROP_PRESENT,
>  	POWER_SUPPLY_PROP_VOLTAGE_NOW,
> @@ -541,7 +540,7 @@ static enum power_supply_property bq2751x_battery_pro=
ps[] =3D {
>  	POWER_SUPPLY_PROP_MANUFACTURER,
>  };
> =20
> -static enum power_supply_property bq27500_battery_props[] =3D {
> +static enum power_supply_property bq27500_props[] =3D {
>  	POWER_SUPPLY_PROP_STATUS,
>  	POWER_SUPPLY_PROP_PRESENT,
>  	POWER_SUPPLY_PROP_VOLTAGE_NOW,
> @@ -562,7 +561,7 @@ static enum power_supply_property bq27500_battery_pro=
ps[] =3D {
>  	POWER_SUPPLY_PROP_MANUFACTURER,
>  };
> =20
> -static enum power_supply_property bq27510g1_battery_props[] =3D {
> +static enum power_supply_property bq27510g1_props[] =3D {
>  	POWER_SUPPLY_PROP_STATUS,
>  	POWER_SUPPLY_PROP_PRESENT,
>  	POWER_SUPPLY_PROP_VOLTAGE_NOW,
> @@ -583,7 +582,7 @@ static enum power_supply_property bq27510g1_battery_p=
rops[] =3D {
>  	POWER_SUPPLY_PROP_MANUFACTURER,
>  };
> =20
> -static enum power_supply_property bq27510g2_battery_props[] =3D {
> +static enum power_supply_property bq27510g2_props[] =3D {
>  	POWER_SUPPLY_PROP_STATUS,
>  	POWER_SUPPLY_PROP_PRESENT,
>  	POWER_SUPPLY_PROP_VOLTAGE_NOW,
> @@ -604,7 +603,7 @@ static enum power_supply_property bq27510g2_battery_p=
rops[] =3D {
>  	POWER_SUPPLY_PROP_MANUFACTURER,
>  };
> =20
> -static enum power_supply_property bq27510g3_battery_props[] =3D {
> +static enum power_supply_property bq27510g3_props[] =3D {
>  	POWER_SUPPLY_PROP_STATUS,
>  	POWER_SUPPLY_PROP_PRESENT,
>  	POWER_SUPPLY_PROP_VOLTAGE_NOW,
> @@ -622,7 +621,7 @@ static enum power_supply_property bq27510g3_battery_p=
rops[] =3D {
>  	POWER_SUPPLY_PROP_MANUFACTURER,
>  };
> =20
> -static enum power_supply_property bq27520g1_battery_props[] =3D {
> +static enum power_supply_property bq27520g1_props[] =3D {
>  	POWER_SUPPLY_PROP_STATUS,
>  	POWER_SUPPLY_PROP_PRESENT,
>  	POWER_SUPPLY_PROP_VOLTAGE_NOW,
> @@ -642,7 +641,7 @@ static enum power_supply_property bq27520g1_battery_p=
rops[] =3D {
>  	POWER_SUPPLY_PROP_MANUFACTURER,
>  };
> =20
> -static enum power_supply_property bq27520g2_battery_props[] =3D {
> +static enum power_supply_property bq27520g2_props[] =3D {
>  	POWER_SUPPLY_PROP_STATUS,
>  	POWER_SUPPLY_PROP_PRESENT,
>  	POWER_SUPPLY_PROP_VOLTAGE_NOW,
> @@ -663,7 +662,7 @@ static enum power_supply_property bq27520g2_battery_p=
rops[] =3D {
>  	POWER_SUPPLY_PROP_MANUFACTURER,
>  };
> =20
> -static enum power_supply_property bq27520g3_battery_props[] =3D {
> +static enum power_supply_property bq27520g3_props[] =3D {
>  	POWER_SUPPLY_PROP_STATUS,
>  	POWER_SUPPLY_PROP_PRESENT,
>  	POWER_SUPPLY_PROP_VOLTAGE_NOW,
> @@ -683,7 +682,7 @@ static enum power_supply_property bq27520g3_battery_p=
rops[] =3D {
>  	POWER_SUPPLY_PROP_MANUFACTURER,
>  };
> =20
> -static enum power_supply_property bq27520g4_battery_props[] =3D {
> +static enum power_supply_property bq27520g4_props[] =3D {
>  	POWER_SUPPLY_PROP_STATUS,
>  	POWER_SUPPLY_PROP_PRESENT,
>  	POWER_SUPPLY_PROP_VOLTAGE_NOW,
> @@ -700,7 +699,7 @@ static enum power_supply_property bq27520g4_battery_p=
rops[] =3D {
>  	POWER_SUPPLY_PROP_MANUFACTURER,
>  };
> =20
> -static enum power_supply_property bq27530_battery_props[] =3D {
> +static enum power_supply_property bq27530_props[] =3D {
>  	POWER_SUPPLY_PROP_STATUS,
>  	POWER_SUPPLY_PROP_PRESENT,
>  	POWER_SUPPLY_PROP_VOLTAGE_NOW,
> @@ -718,7 +717,7 @@ static enum power_supply_property bq27530_battery_pro=
ps[] =3D {
>  	POWER_SUPPLY_PROP_MANUFACTURER,
>  };
> =20
> -static enum power_supply_property bq27541_battery_props[] =3D {
> +static enum power_supply_property bq27541_props[] =3D {
>  	POWER_SUPPLY_PROP_STATUS,
>  	POWER_SUPPLY_PROP_PRESENT,
>  	POWER_SUPPLY_PROP_VOLTAGE_NOW,
> @@ -737,7 +736,7 @@ static enum power_supply_property bq27541_battery_pro=
ps[] =3D {
>  	POWER_SUPPLY_PROP_MANUFACTURER,
>  };
> =20
> -static enum power_supply_property bq27545_battery_props[] =3D {
> +static enum power_supply_property bq27545_props[] =3D {
>  	POWER_SUPPLY_PROP_STATUS,
>  	POWER_SUPPLY_PROP_PRESENT,
>  	POWER_SUPPLY_PROP_VOLTAGE_NOW,
> @@ -755,7 +754,7 @@ static enum power_supply_property bq27545_battery_pro=
ps[] =3D {
>  	POWER_SUPPLY_PROP_MANUFACTURER,
>  };
> =20
> -static enum power_supply_property bq27421_battery_props[] =3D {
> +static enum power_supply_property bq27421_props[] =3D {
>  	POWER_SUPPLY_PROP_STATUS,
>  	POWER_SUPPLY_PROP_PRESENT,
>  	POWER_SUPPLY_PROP_VOLTAGE_NOW,
> @@ -770,32 +769,32 @@ static enum power_supply_property bq27421_battery_p=
rops[] =3D {
>  	POWER_SUPPLY_PROP_MANUFACTURER,
>  };
> =20
> -#define BQ27XXX_PROP(_id, _prop)		\
> -	[_id] =3D {				\
> -		.props =3D _prop,			\
> -		.size =3D ARRAY_SIZE(_prop),	\
> -	}
> +#define BQ27XXX_DATA(ref) {			\
> +	.regs  =3D ref##_regs,			\
> +	.props =3D ref##_props,			\
> +	.props_size =3D ARRAY_SIZE(ref##_props) }
> =20
>  static struct {
> +	u8 *regs;
>  	enum power_supply_property *props;
> -	size_t size;
> -} bq27xxx_battery_props[] =3D {
> -	BQ27XXX_PROP(BQ27000, bq27000_battery_props),
> -	BQ27XXX_PROP(BQ27010, bq27010_battery_props),
> -	BQ27XXX_PROP(BQ2750X, bq2750x_battery_props),
> -	BQ27XXX_PROP(BQ2751X, bq2751x_battery_props),
> -	BQ27XXX_PROP(BQ27500, bq27500_battery_props),
> -	BQ27XXX_PROP(BQ27510G1, bq27510g1_battery_props),
> -	BQ27XXX_PROP(BQ27510G2, bq27510g2_battery_props),
> -	BQ27XXX_PROP(BQ27510G3, bq27510g3_battery_props),
> -	BQ27XXX_PROP(BQ27520G1, bq27520g1_battery_props),
> -	BQ27XXX_PROP(BQ27520G2, bq27520g2_battery_props),
> -	BQ27XXX_PROP(BQ27520G3, bq27520g3_battery_props),
> -	BQ27XXX_PROP(BQ27520G4, bq27520g4_battery_props),
> -	BQ27XXX_PROP(BQ27530, bq27530_battery_props),
> -	BQ27XXX_PROP(BQ27541, bq27541_battery_props),
> -	BQ27XXX_PROP(BQ27545, bq27545_battery_props),
> -	BQ27XXX_PROP(BQ27421, bq27421_battery_props),
> +	size_t props_size;
> +} bq27xxx_chip_data[] =3D {
> +	[BQ27000]   =3D BQ27XXX_DATA(bq27000),
> +	[BQ27010]   =3D BQ27XXX_DATA(bq27010),
> +	[BQ2750X]   =3D BQ27XXX_DATA(bq2750x),
> +	[BQ2751X]   =3D BQ27XXX_DATA(bq2751x),
> +	[BQ27500]   =3D BQ27XXX_DATA(bq27500),
> +	[BQ27510G1] =3D BQ27XXX_DATA(bq27510g1),
> +	[BQ27510G2] =3D BQ27XXX_DATA(bq27510g2),
> +	[BQ27510G3] =3D BQ27XXX_DATA(bq27510g3),
> +	[BQ27520G1] =3D BQ27XXX_DATA(bq27520g1),
> +	[BQ27520G2] =3D BQ27XXX_DATA(bq27520g2),
> +	[BQ27520G3] =3D BQ27XXX_DATA(bq27520g3),
> +	[BQ27520G4] =3D BQ27XXX_DATA(bq27520g4),
> +	[BQ27530]   =3D BQ27XXX_DATA(bq27530),
> +	[BQ27541]   =3D BQ27XXX_DATA(bq27541),
> +	[BQ27545]   =3D BQ27XXX_DATA(bq27545),
> +	[BQ27421]   =3D BQ27XXX_DATA(bq27421),
>  };
> =20
>  static DEFINE_MUTEX(bq27xxx_list_lock);
> @@ -1884,7 +1883,7 @@ int bq27xxx_battery_setup(struct bq27xxx_device_inf=
o *di)
> =20
>  	INIT_DELAYED_WORK(&di->work, bq27xxx_battery_poll);
>  	mutex_init(&di->lock);
> -	di->regs =3D bq27xxx_regs[di->chip];
> +	di->regs =3D bq27xxx_chip_data[di->chip].regs;
> =20
>  	psy_desc =3D devm_kzalloc(di->dev, sizeof(*psy_desc), GFP_KERNEL);
>  	if (!psy_desc)
> @@ -1892,8 +1891,8 @@ int bq27xxx_battery_setup(struct bq27xxx_device_inf=
o *di)
> =20
>  	psy_desc->name =3D di->name;
>  	psy_desc->type =3D POWER_SUPPLY_TYPE_BATTERY;
> -	psy_desc->properties =3D bq27xxx_battery_props[di->chip].props;
> -	psy_desc->num_properties =3D bq27xxx_battery_props[di->chip].size;
> +	psy_desc->properties =3D bq27xxx_chip_data[di->chip].props;
> +	psy_desc->num_properties =3D bq27xxx_chip_data[di->chip].props_size;
>  	psy_desc->get_property =3D bq27xxx_battery_get_property;
>  	psy_desc->external_power_changed =3D bq27xxx_external_power_changed;
> =20
> --=20
> 2.13.2
>=20

--qssyszxa6c2ey73u
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAlmLM3cACgkQ2O7X88g7
+pphvg//deY0e+wRGSTnP1inLAIvakbv3f9mwt09oI16BoL0DpgtpUwF8Slh1PVp
hpzSV+IBSzp4QUJ7uXO8I6OHbRqwqumwT4e+lkDlF2WBMxUGn1rXJxbVsRfIPgG3
GDaIyMU3IUO4bp1jMTagdFX5P86t1kzops9W/m4P08J/kuW+OliWRusLc8C0O/yO
zFQJjq5fpQAFdOUWE8QRrfkOF7weqi4vBROFiSlIBYciUxwLT9jlZCaNghin0xO3
xDqJDr/KBncLkmpIKu3A8Orx/CemUNs3dJ6WHQBadB927UtXVs8F/iyqHMPIOxuQ
82jQH/pdZnbj5lG0CJ8kV7+D14xwwVeLXPO8TMmy1jkPaoZRecivQ7FfVuf6Gb5K
HTAbQdClscY0ZZ4sTIuxCFjitQtEEkCtYqvs9xNTqWWOCrtZiMZuRmaTFrnt5XdZ
cCpCInFeGaPI9xd8WZJUxW4bDZ3GG9vCH0YAJuDoFjOchfJ8W35alFCG8jBkgmy0
zPRoHOUfS2Ij2RmH0ya6H+Wcd/jv65csAPtvCX3VToiWn9OTeTeWbWxpHde5GO+B
PX3szmPwE6gD8xPu09oEJ/nFSLDXz/wldLEqrQEDgejUHrzg9lR9PQHB24Z1XGk/
rRQO/iF9kf6BKKg1vXA6gdSvf7PuZmjA80xdD4CmOWOz2ncwyy0=
=KS+a
-----END PGP SIGNATURE-----

--qssyszxa6c2ey73u--
