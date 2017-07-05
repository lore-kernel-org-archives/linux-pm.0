From: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
Subject: Re: [PATCH v14 09/11] power: supply: bq27xxx: Enable data memory
 update for certain chips
Date: Wed, 5 Jul 2017 11:47:32 +0200
Message-ID: <20170705094732.jxpf3yoiqb276e36@earth>
References: <20170607183759.20261-1-liam@networkimprov.net>
 <20170607183759.20261-10-liam@networkimprov.net>
 <20170615160218.sq5jychjn7x2dhyq@earth>
 <CAKvHMgT-QW1GXizipj0bRk7DMhwv=NsZJnvoQ_9OEjf_MgfJgg@mail.gmail.com>
 <20170616103307.bfl6ig66qeq2qvz6@earth>
 <CAKvHMgSP6KR+4LRb0p3amAXyD=-r6Ap_i06cTffhnVOvE7NLJQ@mail.gmail.com>
 <20170703164833.govvgqz7xxbeuycv@earth>
 <CAKvHMgQr98kEtp6obizO94zy84990uZ=2_iowfn+EFQDUvPHmg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="lxgd2nh4unmbmov4"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from bhuna.collabora.co.uk ([46.235.227.227]:58644 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750841AbdGEJrh (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 5 Jul 2017 05:47:37 -0400
Content-Disposition: inline
In-Reply-To: <CAKvHMgQr98kEtp6obizO94zy84990uZ=2_iowfn+EFQDUvPHmg@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Liam Breck <liam@networkimprov.net>
Cc: Pali Rohar <pali.rohar@gmail.com>, linux-pm@vger.kernel.org, Paul Kocialkowski <contact@paulk.fr>, Liam Breck <kernel@networkimprov.net>


--lxgd2nh4unmbmov4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Jul 04, 2017 at 04:24:05PM -0700, Liam Breck wrote:
> OK, below is a minimal change to bq27xxx_battery.c creating a single
> data table for all chips. It can easily be extended with new fields
> for my patchset.

Patch looks good.

> This is probably safe to upstream without testing on all the chips, as
> it was mostly search/replace. However various conditionals test the
> chip ID, so when adding the rest of the IDs (previously only in
> real_chip) in the next patch, I'd have to touch that code, but I have
> no way of testing all the affected parts. I could use .acts_like =3D
> OTHER_ID in the data table to minimize that risk. Thoughts?

As far as I can see there are only a couple of different things
di->chip is used for:

di->chip =3D=3D BQ27421 =3D> flag_cfgupdate,
di->chip =3D=3D BQ27000 || di->chip =3D=3D BQ27010 =3D> flag_single,
di->chip =3D=3D BQ27530 || di->chip =3D=3D BQ27421 =3D> flag_temp_ot_ut,

If we add those flags to bq27xxx_battery_data we do not need
to check di->chip in the driver at all.

-- Sebastian

> From: Liam Breck <kernel@networkimprov.net>
> Subject: [PATCH] power: supply: bq27xxx: create single chip data table
>=20
> Unify data previously in bq27xxx_regs & bq27xxx_battery_props into a
> single table.
> There is no functional change to the driver.
>=20
> ---
>  drivers/power/supply/bq27xxx_battery.c | 121 ++++++++++++++++-----------=
------
>  1 file changed, 60 insertions(+), 61 deletions(-)
>=20
> diff --git a/drivers/power/supply/bq27xxx_battery.c
> b/drivers/power/supply/bq27xxx_battery.c
> index ed44439d0112c..db42e4961c68f 100644
> --- a/drivers/power/supply/bq27xxx_battery.c
> +++ b/drivers/power/supply/bq27xxx_battery.c
> @@ -132,8 +132,8 @@ enum bq27xxx_reg_index {
>      [BQ27XXX_DM_CKSUM] =3D 0x60
>=20
>  /* Register mappings */
> -static u8 bq27xxx_regs[][BQ27XXX_REG_MAX] =3D {
> -    [BQ27000] =3D {
> +static u8
> +    bq27000_regs[BQ27XXX_REG_MAX] =3D {
>          [BQ27XXX_REG_CTRL] =3D 0x00,
>          [BQ27XXX_REG_TEMP] =3D 0x06,
>          [BQ27XXX_REG_INT_TEMP] =3D INVALID_REG_ADDR,
> @@ -157,7 +157,7 @@ static u8 bq27xxx_regs[][BQ27XXX_REG_MAX] =3D {
>          [BQ27XXX_DM_DATA] =3D INVALID_REG_ADDR,
>          [BQ27XXX_DM_CKSUM] =3D INVALID_REG_ADDR,
>      },
> -    [BQ27010] =3D {
> +    bq27010_regs[BQ27XXX_REG_MAX] =3D {
>          [BQ27XXX_REG_CTRL] =3D 0x00,
>          [BQ27XXX_REG_TEMP] =3D 0x06,
>          [BQ27XXX_REG_INT_TEMP] =3D INVALID_REG_ADDR,
> @@ -181,7 +181,7 @@ static u8 bq27xxx_regs[][BQ27XXX_REG_MAX] =3D {
>          [BQ27XXX_DM_DATA] =3D INVALID_REG_ADDR,
>          [BQ27XXX_DM_CKSUM] =3D INVALID_REG_ADDR,
>      },
> -    [BQ2750X] =3D {
> +    bq2750x_regs[BQ27XXX_REG_MAX] =3D {
>          [BQ27XXX_REG_CTRL] =3D 0x00,
>          [BQ27XXX_REG_TEMP] =3D 0x06,
>          [BQ27XXX_REG_INT_TEMP] =3D 0x28,
> @@ -201,7 +201,7 @@ static u8 bq27xxx_regs[][BQ27XXX_REG_MAX] =3D {
>          [BQ27XXX_REG_AP] =3D INVALID_REG_ADDR,
>          BQ27XXX_DM_REG_ROWS,
>      },
> -    [BQ2751X] =3D {
> +    bq2751x_regs[BQ27XXX_REG_MAX] =3D {
>          [BQ27XXX_REG_CTRL] =3D 0x00,
>          [BQ27XXX_REG_TEMP] =3D 0x06,
>          [BQ27XXX_REG_INT_TEMP] =3D 0x28,
> @@ -221,7 +221,7 @@ static u8 bq27xxx_regs[][BQ27XXX_REG_MAX] =3D {
>          [BQ27XXX_REG_AP] =3D INVALID_REG_ADDR,
>          BQ27XXX_DM_REG_ROWS,
>      },
> -    [BQ27500] =3D {
> +    bq27500_regs[BQ27XXX_REG_MAX] =3D {
>          [BQ27XXX_REG_CTRL] =3D 0x00,
>          [BQ27XXX_REG_TEMP] =3D 0x06,
>          [BQ27XXX_REG_INT_TEMP] =3D INVALID_REG_ADDR,
> @@ -241,7 +241,7 @@ static u8 bq27xxx_regs[][BQ27XXX_REG_MAX] =3D {
>          [BQ27XXX_REG_AP] =3D 0x24,
>          BQ27XXX_DM_REG_ROWS,
>      },
> -    [BQ27510G1] =3D {
> +    bq27510g1_regs[BQ27XXX_REG_MAX] =3D {
>          [BQ27XXX_REG_CTRL] =3D 0x00,
>          [BQ27XXX_REG_TEMP] =3D 0x06,
>          [BQ27XXX_REG_INT_TEMP] =3D INVALID_REG_ADDR,
> @@ -261,7 +261,7 @@ static u8 bq27xxx_regs[][BQ27XXX_REG_MAX] =3D {
>          [BQ27XXX_REG_AP] =3D 0x24,
>          BQ27XXX_DM_REG_ROWS,
>      },
> -    [BQ27510G2] =3D {
> +    bq27510g2_regs[BQ27XXX_REG_MAX] =3D {
>          [BQ27XXX_REG_CTRL] =3D 0x00,
>          [BQ27XXX_REG_TEMP] =3D 0x06,
>          [BQ27XXX_REG_INT_TEMP] =3D INVALID_REG_ADDR,
> @@ -281,7 +281,7 @@ static u8 bq27xxx_regs[][BQ27XXX_REG_MAX] =3D {
>          [BQ27XXX_REG_AP] =3D 0x24,
>          BQ27XXX_DM_REG_ROWS,
>      },
> -    [BQ27510G3] =3D {
> +    bq27510g3_regs[BQ27XXX_REG_MAX] =3D {
>          [BQ27XXX_REG_CTRL] =3D 0x00,
>          [BQ27XXX_REG_TEMP] =3D 0x06,
>          [BQ27XXX_REG_INT_TEMP] =3D 0x28,
> @@ -301,7 +301,7 @@ static u8 bq27xxx_regs[][BQ27XXX_REG_MAX] =3D {
>          [BQ27XXX_REG_AP] =3D INVALID_REG_ADDR,
>          BQ27XXX_DM_REG_ROWS,
>      },
> -    [BQ27520G1] =3D {
> +    bq27520g1_regs[BQ27XXX_REG_MAX] =3D {
>          [BQ27XXX_REG_CTRL] =3D 0x00,
>          [BQ27XXX_REG_TEMP] =3D 0x06,
>          [BQ27XXX_REG_INT_TEMP] =3D INVALID_REG_ADDR,
> @@ -321,7 +321,7 @@ static u8 bq27xxx_regs[][BQ27XXX_REG_MAX] =3D {
>          [BQ27XXX_REG_AP] =3D 0x24,
>          BQ27XXX_DM_REG_ROWS,
>      },
> -    [BQ27520G2] =3D {
> +    bq27520g2_regs[BQ27XXX_REG_MAX] =3D {
>          [BQ27XXX_REG_CTRL] =3D 0x00,
>          [BQ27XXX_REG_TEMP] =3D 0x06,
>          [BQ27XXX_REG_INT_TEMP] =3D 0x36,
> @@ -341,7 +341,7 @@ static u8 bq27xxx_regs[][BQ27XXX_REG_MAX] =3D {
>          [BQ27XXX_REG_AP] =3D 0x24,
>          BQ27XXX_DM_REG_ROWS,
>      },
> -    [BQ27520G3] =3D {
> +    bq27520g3_regs[BQ27XXX_REG_MAX] =3D {
>          [BQ27XXX_REG_CTRL] =3D 0x00,
>          [BQ27XXX_REG_TEMP] =3D 0x06,
>          [BQ27XXX_REG_INT_TEMP] =3D 0x36,
> @@ -361,7 +361,7 @@ static u8 bq27xxx_regs[][BQ27XXX_REG_MAX] =3D {
>          [BQ27XXX_REG_AP] =3D 0x24,
>          BQ27XXX_DM_REG_ROWS,
>      },
> -    [BQ27520G4] =3D {
> +    bq27520g4_regs[BQ27XXX_REG_MAX] =3D {
>          [BQ27XXX_REG_CTRL] =3D 0x00,
>          [BQ27XXX_REG_TEMP] =3D 0x06,
>          [BQ27XXX_REG_INT_TEMP] =3D 0x28,
> @@ -381,7 +381,7 @@ static u8 bq27xxx_regs[][BQ27XXX_REG_MAX] =3D {
>          [BQ27XXX_REG_AP] =3D INVALID_REG_ADDR,
>          BQ27XXX_DM_REG_ROWS,
>      },
> -    [BQ27530] =3D {
> +    bq27530_regs[BQ27XXX_REG_MAX] =3D {
>          [BQ27XXX_REG_CTRL] =3D 0x00,
>          [BQ27XXX_REG_TEMP] =3D 0x06,
>          [BQ27XXX_REG_INT_TEMP] =3D 0x32,
> @@ -401,7 +401,7 @@ static u8 bq27xxx_regs[][BQ27XXX_REG_MAX] =3D {
>          [BQ27XXX_REG_AP] =3D 0x24,
>          BQ27XXX_DM_REG_ROWS,
>      },
> -    [BQ27541] =3D {
> +    bq27541_regs[BQ27XXX_REG_MAX] =3D {
>          [BQ27XXX_REG_CTRL] =3D 0x00,
>          [BQ27XXX_REG_TEMP] =3D 0x06,
>          [BQ27XXX_REG_INT_TEMP] =3D 0x28,
> @@ -421,7 +421,7 @@ static u8 bq27xxx_regs[][BQ27XXX_REG_MAX] =3D {
>          [BQ27XXX_REG_AP] =3D 0x24,
>          BQ27XXX_DM_REG_ROWS,
>      },
> -    [BQ27545] =3D {
> +    bq27545_regs[BQ27XXX_REG_MAX] =3D {
>          [BQ27XXX_REG_CTRL] =3D 0x00,
>          [BQ27XXX_REG_TEMP] =3D 0x06,
>          [BQ27XXX_REG_INT_TEMP] =3D 0x28,
> @@ -441,7 +441,7 @@ static u8 bq27xxx_regs[][BQ27XXX_REG_MAX] =3D {
>          [BQ27XXX_REG_AP] =3D 0x24,
>          BQ27XXX_DM_REG_ROWS,
>      },
> -    [BQ27421] =3D {
> +    bq27421_regs[BQ27XXX_REG_MAX] =3D {
>          [BQ27XXX_REG_CTRL] =3D 0x00,
>          [BQ27XXX_REG_TEMP] =3D 0x02,
>          [BQ27XXX_REG_INT_TEMP] =3D 0x1e,
> @@ -460,10 +460,9 @@ static u8 bq27xxx_regs[][BQ27XXX_REG_MAX] =3D {
>          [BQ27XXX_REG_DCAP] =3D 0x3c,
>          [BQ27XXX_REG_AP] =3D 0x18,
>          BQ27XXX_DM_REG_ROWS,
> -    },
> -};
> +    };
>=20
> -static enum power_supply_property bq27000_battery_props[] =3D {
> +static enum power_supply_property bq27000_props[] =3D {
>      POWER_SUPPLY_PROP_STATUS,
>      POWER_SUPPLY_PROP_PRESENT,
>      POWER_SUPPLY_PROP_VOLTAGE_NOW,
> @@ -485,7 +484,7 @@ static enum power_supply_property
> bq27000_battery_props[] =3D {
>      POWER_SUPPLY_PROP_MANUFACTURER,
>  };
>=20
> -static enum power_supply_property bq27010_battery_props[] =3D {
> +static enum power_supply_property bq27010_props[] =3D {
>      POWER_SUPPLY_PROP_STATUS,
>      POWER_SUPPLY_PROP_PRESENT,
>      POWER_SUPPLY_PROP_VOLTAGE_NOW,
> @@ -505,7 +504,7 @@ static enum power_supply_property
> bq27010_battery_props[] =3D {
>      POWER_SUPPLY_PROP_MANUFACTURER,
>  };
>=20
> -static enum power_supply_property bq2750x_battery_props[] =3D {
> +static enum power_supply_property bq2750x_props[] =3D {
>      POWER_SUPPLY_PROP_STATUS,
>      POWER_SUPPLY_PROP_PRESENT,
>      POWER_SUPPLY_PROP_VOLTAGE_NOW,
> @@ -523,7 +522,7 @@ static enum power_supply_property
> bq2750x_battery_props[] =3D {
>      POWER_SUPPLY_PROP_MANUFACTURER,
>  };
>=20
> -static enum power_supply_property bq2751x_battery_props[] =3D {
> +static enum power_supply_property bq2751x_props[] =3D {
>      POWER_SUPPLY_PROP_STATUS,
>      POWER_SUPPLY_PROP_PRESENT,
>      POWER_SUPPLY_PROP_VOLTAGE_NOW,
> @@ -541,7 +540,7 @@ static enum power_supply_property
> bq2751x_battery_props[] =3D {
>      POWER_SUPPLY_PROP_MANUFACTURER,
>  };
>=20
> -static enum power_supply_property bq27500_battery_props[] =3D {
> +static enum power_supply_property bq27500_props[] =3D {
>      POWER_SUPPLY_PROP_STATUS,
>      POWER_SUPPLY_PROP_PRESENT,
>      POWER_SUPPLY_PROP_VOLTAGE_NOW,
> @@ -562,7 +561,7 @@ static enum power_supply_property
> bq27500_battery_props[] =3D {
>      POWER_SUPPLY_PROP_MANUFACTURER,
>  };
>=20
> -static enum power_supply_property bq27510g1_battery_props[] =3D {
> +static enum power_supply_property bq27510g1_props[] =3D {
>      POWER_SUPPLY_PROP_STATUS,
>      POWER_SUPPLY_PROP_PRESENT,
>      POWER_SUPPLY_PROP_VOLTAGE_NOW,
> @@ -583,7 +582,7 @@ static enum power_supply_property
> bq27510g1_battery_props[] =3D {
>      POWER_SUPPLY_PROP_MANUFACTURER,
>  };
>=20
> -static enum power_supply_property bq27510g2_battery_props[] =3D {
> +static enum power_supply_property bq27510g2_props[] =3D {
>      POWER_SUPPLY_PROP_STATUS,
>      POWER_SUPPLY_PROP_PRESENT,
>      POWER_SUPPLY_PROP_VOLTAGE_NOW,
> @@ -604,7 +603,7 @@ static enum power_supply_property
> bq27510g2_battery_props[] =3D {
>      POWER_SUPPLY_PROP_MANUFACTURER,
>  };
>=20
> -static enum power_supply_property bq27510g3_battery_props[] =3D {
> +static enum power_supply_property bq27510g3_props[] =3D {
>      POWER_SUPPLY_PROP_STATUS,
>      POWER_SUPPLY_PROP_PRESENT,
>      POWER_SUPPLY_PROP_VOLTAGE_NOW,
> @@ -622,7 +621,7 @@ static enum power_supply_property
> bq27510g3_battery_props[] =3D {
>      POWER_SUPPLY_PROP_MANUFACTURER,
>  };
>=20
> -static enum power_supply_property bq27520g1_battery_props[] =3D {
> +static enum power_supply_property bq27520g1_props[] =3D {
>      POWER_SUPPLY_PROP_STATUS,
>      POWER_SUPPLY_PROP_PRESENT,
>      POWER_SUPPLY_PROP_VOLTAGE_NOW,
> @@ -642,7 +641,7 @@ static enum power_supply_property
> bq27520g1_battery_props[] =3D {
>      POWER_SUPPLY_PROP_MANUFACTURER,
>  };
>=20
> -static enum power_supply_property bq27520g2_battery_props[] =3D {
> +static enum power_supply_property bq27520g2_props[] =3D {
>      POWER_SUPPLY_PROP_STATUS,
>      POWER_SUPPLY_PROP_PRESENT,
>      POWER_SUPPLY_PROP_VOLTAGE_NOW,
> @@ -663,7 +662,7 @@ static enum power_supply_property
> bq27520g2_battery_props[] =3D {
>      POWER_SUPPLY_PROP_MANUFACTURER,
>  };
>=20
> -static enum power_supply_property bq27520g3_battery_props[] =3D {
> +static enum power_supply_property bq27520g3_props[] =3D {
>      POWER_SUPPLY_PROP_STATUS,
>      POWER_SUPPLY_PROP_PRESENT,
>      POWER_SUPPLY_PROP_VOLTAGE_NOW,
> @@ -683,7 +682,7 @@ static enum power_supply_property
> bq27520g3_battery_props[] =3D {
>      POWER_SUPPLY_PROP_MANUFACTURER,
>  };
>=20
> -static enum power_supply_property bq27520g4_battery_props[] =3D {
> +static enum power_supply_property bq27520g4_props[] =3D {
>      POWER_SUPPLY_PROP_STATUS,
>      POWER_SUPPLY_PROP_PRESENT,
>      POWER_SUPPLY_PROP_VOLTAGE_NOW,
> @@ -700,7 +699,7 @@ static enum power_supply_property
> bq27520g4_battery_props[] =3D {
>      POWER_SUPPLY_PROP_MANUFACTURER,
>  };
>=20
> -static enum power_supply_property bq27530_battery_props[] =3D {
> +static enum power_supply_property bq27530_props[] =3D {
>      POWER_SUPPLY_PROP_STATUS,
>      POWER_SUPPLY_PROP_PRESENT,
>      POWER_SUPPLY_PROP_VOLTAGE_NOW,
> @@ -718,7 +717,7 @@ static enum power_supply_property
> bq27530_battery_props[] =3D {
>      POWER_SUPPLY_PROP_MANUFACTURER,
>  };
>=20
> -static enum power_supply_property bq27541_battery_props[] =3D {
> +static enum power_supply_property bq27541_props[] =3D {
>      POWER_SUPPLY_PROP_STATUS,
>      POWER_SUPPLY_PROP_PRESENT,
>      POWER_SUPPLY_PROP_VOLTAGE_NOW,
> @@ -737,7 +736,7 @@ static enum power_supply_property
> bq27541_battery_props[] =3D {
>      POWER_SUPPLY_PROP_MANUFACTURER,
>  };
>=20
> -static enum power_supply_property bq27545_battery_props[] =3D {
> +static enum power_supply_property bq27545_props[] =3D {
>      POWER_SUPPLY_PROP_STATUS,
>      POWER_SUPPLY_PROP_PRESENT,
>      POWER_SUPPLY_PROP_VOLTAGE_NOW,
> @@ -755,7 +754,7 @@ static enum power_supply_property
> bq27545_battery_props[] =3D {
>      POWER_SUPPLY_PROP_MANUFACTURER,
>  };
>=20
> -static enum power_supply_property bq27421_battery_props[] =3D {
> +static enum power_supply_property bq27421_props[] =3D {
>      POWER_SUPPLY_PROP_STATUS,
>      POWER_SUPPLY_PROP_PRESENT,
>      POWER_SUPPLY_PROP_VOLTAGE_NOW,
> @@ -770,32 +769,32 @@ static enum power_supply_property
> bq27421_battery_props[] =3D {
>      POWER_SUPPLY_PROP_MANUFACTURER,
>  };
>=20
> -#define BQ27XXX_PROP(_id, _prop)        \
> -    [_id] =3D {                \
> -        .props =3D _prop,            \
> -        .size =3D ARRAY_SIZE(_prop),    \
> -    }
> +#define BQ27XXX_DATA(ref) {            \
> +    .regs  =3D ref##_regs,            \
> +    .props =3D ref##_props,            \
> +    .props_size =3D ARRAY_SIZE(ref##_props), }
>=20
>  static struct {
> +    u8 *regs;
>      enum power_supply_property *props;
> -    size_t size;
> -} bq27xxx_battery_props[] =3D {
> -    BQ27XXX_PROP(BQ27000, bq27000_battery_props),
> -    BQ27XXX_PROP(BQ27010, bq27010_battery_props),
> -    BQ27XXX_PROP(BQ2750X, bq2750x_battery_props),
> -    BQ27XXX_PROP(BQ2751X, bq2751x_battery_props),
> -    BQ27XXX_PROP(BQ27500, bq27500_battery_props),
> -    BQ27XXX_PROP(BQ27510G1, bq27510g1_battery_props),
> -    BQ27XXX_PROP(BQ27510G2, bq27510g2_battery_props),
> -    BQ27XXX_PROP(BQ27510G3, bq27510g3_battery_props),
> -    BQ27XXX_PROP(BQ27520G1, bq27520g1_battery_props),
> -    BQ27XXX_PROP(BQ27520G2, bq27520g2_battery_props),
> -    BQ27XXX_PROP(BQ27520G3, bq27520g3_battery_props),
> -    BQ27XXX_PROP(BQ27520G4, bq27520g4_battery_props),
> -    BQ27XXX_PROP(BQ27530, bq27530_battery_props),
> -    BQ27XXX_PROP(BQ27541, bq27541_battery_props),
> -    BQ27XXX_PROP(BQ27545, bq27545_battery_props),
> -    BQ27XXX_PROP(BQ27421, bq27421_battery_props),
> +    size_t props_size;
> +} bq27xxx_battery_data[] =3D {
> +    [BQ27000]   =3D BQ27XXX_DATA(bq27000),
> +    [BQ27010]   =3D BQ27XXX_DATA(bq27010),
> +    [BQ2750X]   =3D BQ27XXX_DATA(bq2750x),
> +    [BQ2751X]   =3D BQ27XXX_DATA(bq2751x),
> +    [BQ27500]   =3D BQ27XXX_DATA(bq27500),
> +    [BQ27510G1] =3D BQ27XXX_DATA(bq27510g1),
> +    [BQ27510G2] =3D BQ27XXX_DATA(bq27510g2),
> +    [BQ27510G3] =3D BQ27XXX_DATA(bq27510g3),
> +    [BQ27520G1] =3D BQ27XXX_DATA(bq27520g1),
> +    [BQ27520G2] =3D BQ27XXX_DATA(bq27520g2),
> +    [BQ27520G3] =3D BQ27XXX_DATA(bq27520g3),
> +    [BQ27520G4] =3D BQ27XXX_DATA(bq27520g4),
> +    [BQ27530]   =3D BQ27XXX_DATA(bq27530),
> +    [BQ27541]   =3D BQ27XXX_DATA(bq27541),
> +    [BQ27545]   =3D BQ27XXX_DATA(bq27545),
> +    [BQ27421]   =3D BQ27XXX_DATA(bq27421),
>  };
>=20
>  static DEFINE_MUTEX(bq27xxx_list_lock);
> @@ -1884,7 +1883,7 @@ int bq27xxx_battery_setup(struct bq27xxx_device_inf=
o *di)
>=20
>      INIT_DELAYED_WORK(&di->work, bq27xxx_battery_poll);
>      mutex_init(&di->lock);
> -    di->regs =3D bq27xxx_regs[di->chip];
> +    di->regs =3D bq27xxx_battery_data[di->chip].regs;
>=20
>      psy_desc =3D devm_kzalloc(di->dev, sizeof(*psy_desc), GFP_KERNEL);
>      if (!psy_desc)
> @@ -1892,8 +1891,8 @@ int bq27xxx_battery_setup(struct bq27xxx_device_inf=
o *di)
>=20
>      psy_desc->name =3D di->name;
>      psy_desc->type =3D POWER_SUPPLY_TYPE_BATTERY;
> -    psy_desc->properties =3D bq27xxx_battery_props[di->chip].props;
> -    psy_desc->num_properties =3D bq27xxx_battery_props[di->chip].size;
> +    psy_desc->properties =3D bq27xxx_battery_data[di->chip].props;
> +    psy_desc->num_properties =3D bq27xxx_battery_data[di->chip].props_si=
ze;
>      psy_desc->get_property =3D bq27xxx_battery_get_property;
>      psy_desc->external_power_changed =3D bq27xxx_external_power_changed;

--lxgd2nh4unmbmov4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAllctbEACgkQ2O7X88g7
+prwqw//WoKlWgPpqjl29kgbpQsx83EM1Pp8ZZ2CnEee3kwHE2eud6fqQxIwaXw/
peMtr7SuxG9wox9fbYUmDXUaEHYITlDc0sUWFO/kfrS0pad/EzUJwNML6jAKwp6m
HQ413+5j8pPHob/Z8X3dFXM2bb9EiBdfy7lH64Vsp3GmwBYrR4KjeXtFruBbZsP2
n1RLZQMWBw0iZ/r3OdkgqrYb4seNxQQetnnRw4k7lh8PwZawzi4uxQi8hnEiYr9v
aE1UeTdXQE5oAssT9GWJSXkdZfcmn1gKVhJ0XoFG8f5OKxEKF4DqR8cjUcbtokiB
gFXIMoBcez1yeJecmEHmE1x2p+82YAYCtuH1AeZADggw6ImH9Rg/4sGXAESfBkeB
6zDACBEAVV5Ee0kIBQe/14Ojd7pUDY6aY0e7ZgC2knfFK9k1iWpdjdtBcJy0IFPX
s6g9nZLpJvyLXnOFkhAFg8sZyIpyKbOxiDBf5FLgS2FvYvDj5p6UDuNcB9eTSZ7V
yiqfMd14queTLczf85se3oQkDCTGhC5sNP2nDjGgY8l7r5ie9S99pGWd0N/1XfMl
1FycEaSo5UKYuaMMcegIGR35S3O2gMO6MSsb/7LG07zL6tP31LWqi8qWxM+D2aa+
xFvtzuKlsfoN79P2piXot/cHaSSzkpsEs5MtBQpo7bEsfFPlgXc=
=D5NX
-----END PGP SIGNATURE-----

--lxgd2nh4unmbmov4--
