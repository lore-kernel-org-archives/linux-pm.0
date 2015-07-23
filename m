From: Pali =?utf-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>
Subject: Re: [PATCH 7/8] power: bq27xxx_battery: Add support for additional
 bq27xxx family devices
Date: Thu, 23 Jul 2015 18:20:17 +0200
Message-ID: <20150723162017.GH29125@pali>
References: <1437601920-13045-1-git-send-email-afd@ti.com>
 <1437601920-13045-8-git-send-email-afd@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wi0-f171.google.com ([209.85.212.171]:34780 "EHLO
	mail-wi0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752255AbbGWQUV (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 23 Jul 2015 12:20:21 -0400
Content-Disposition: inline
In-Reply-To: <1437601920-13045-8-git-send-email-afd@ti.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Andrew F. Davis" <afd@ti.com>
Cc: Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, Dan Murphy <dmurphy@ti.com>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org

On Wednesday 22 July 2015 16:51:59 Andrew F. Davis wrote:
> Add support for additional devices and register equivalent family dev=
ices
> including the bq27010, bq27210, bq272500, bq27510, bq27520, bq27530,
> bq27531, bq27541, bq27542, bq27546, bq27545, bq27441, bq27421, and th=
e
> bq27641.
>=20
> To facilitate this process the register mapings have been moved to ta=
bles
> and other small cleanups have been made.
>=20
> Signed-off-by: Andrew F. Davis <afd@ti.com>
> ---
>  drivers/power/bq27xxx_battery.c | 618 ++++++++++++++++++++++++++----=
----------
>  1 file changed, 409 insertions(+), 209 deletions(-)
>=20
> diff --git a/drivers/power/bq27xxx_battery.c b/drivers/power/bq27xxx_=
battery.c
> index 5686da6..f148222 100644
> --- a/drivers/power/bq27xxx_battery.c
> +++ b/drivers/power/bq27xxx_battery.c
> @@ -17,11 +17,15 @@
>   * WARRANTIES OF MERCHANTIBILITY AND FITNESS FOR A PARTICULAR PURPOS=
E.
>   *
>   * Datasheets:
> - * http://focus.ti.com/docs/prod/folders/print/bq27000.html
> - * http://focus.ti.com/docs/prod/folders/print/bq27500.html
> + * http://www.ti.com/product/bq27000
> + * http://www.ti.com/product/bq27010
> + * http://www.ti.com/product/bq27510-g3
> + * http://www.ti.com/product/bq27520-g4
> + * http://www.ti.com/product/bq27411-g1
> + * http://www.ti.com/product/bq27421-g1
>   * http://www.ti.com/product/bq27425-g1
> - * http://www.ti.com/product/BQ27742-G1
> - * http://www.ti.com/product/BQ27510-G3
> + * http://www.ti.com/product/bq27742-g1
> + * http://www.ti.com/product/bq27621-g1
>   */

Now, when you touching list of links to documentation, you can add also
one for bq27200: http://www.ti.com/product/bq27200

> =20
>  #include <linux/device.h>
> @@ -43,55 +47,66 @@
> =20
>  #define BQ27XXX_MANUFACTURER	"Texas Instruments"
> =20
> -#define BQ27x00_REG_TEMP	0x06
> -#define BQ27x00_REG_VOLT	0x08
> -#define BQ27x00_REG_AI		0x14
> -#define BQ27x00_REG_FLAGS	0x0A
> -#define BQ27x00_REG_TTE		0x16
> -#define BQ27x00_REG_TTF		0x18
> -#define BQ27x00_REG_TTECP	0x26
> -#define BQ27x00_REG_NAC		0x0C /* Nominal available capacity */
> -#define BQ27x00_REG_LMD		0x12 /* Last measured discharge */
> -#define BQ27x00_REG_CYCT	0x2A /* Cycle count total */
> -#define BQ27x00_REG_AE		0x22 /* Available energy */
> -#define BQ27x00_POWER_AVG	0x24
> -
> -#define BQ27000_REG_RSOC	0x0B /* Relative State-of-Charge */
> -#define BQ27000_REG_ILMD	0x76 /* Initial last measured discharge */
> +/* BQ27XXX Flags */
> +#define BQ27XXX_FLAG_DSC	BIT(0)
> +#define BQ27XXX_FLAG_SOCF	BIT(1) /* State-of-Charge threshold final =
*/
> +#define BQ27XXX_FLAG_SOC1	BIT(2) /* State-of-Charge threshold 1 */
> +#define BQ27XXX_FLAG_FC		BIT(9)
> +#define BQ27XXX_FLAG_OTD	BIT(14)
> +#define BQ27XXX_FLAG_OTC	BIT(15)
> +
> +/* BQ27000 has different layout for Flags register */
>  #define BQ27000_FLAG_EDVF	BIT(0) /* Final End-of-Discharge-Voltage f=
lag */
>  #define BQ27000_FLAG_EDV1	BIT(1) /* First End-of-Discharge-Voltage f=
lag */
>  #define BQ27000_FLAG_CI		BIT(4) /* Capacity Inaccurate flag */
>  #define BQ27000_FLAG_FC		BIT(5)
>  #define BQ27000_FLAG_CHGS	BIT(7) /* Charge state flag */
> =20
> -#define BQ27500_REG_SOC		0x2C
> -#define BQ27500_REG_DCAP	0x3C /* Design capacity */
> -#define BQ27500_FLAG_DSC	BIT(0)
> -#define BQ27500_FLAG_SOCF	BIT(1) /* State-of-Charge threshold final =
*/
> -#define BQ27500_FLAG_SOC1	BIT(2) /* State-of-Charge threshold 1 */
> -#define BQ27500_FLAG_FC		BIT(9)
> -#define BQ27500_FLAG_OTC	BIT(15)
> -
> -#define BQ27742_POWER_AVG	0x76
> -
> -#define BQ27510_REG_SOC		0x20
> -#define BQ27510_REG_DCAP	0x2E /* Design capacity */
> -#define BQ27510_REG_CYCT	0x1E /* Cycle count total */
> -
> -/* bq27425 register addresses are same as bq27x00 addresses minus 4 =
*/
> -#define BQ27425_REG_OFFSET	0x04
> -#define BQ27425_REG_SOC		(0x1C + BQ27425_REG_OFFSET)
> -#define BQ27425_REG_DCAP	(0x3C + BQ27425_REG_OFFSET)
> -
> -#define BQ27XXX_RS			20 /* Resistor sense */
> -#define BQ27XXX_POWER_CONSTANT		(256 * 29200 / 1000)
> +#define BQ27XXX_RS			(20) /* Resistor sense mOhm */
> +#define BQ27XXX_POWER_CONSTANT		(29200) /* 29.2 =C2=B5V^2 * 1000 */
> +#define BQ27XXX_CURRENT_CONSTANT	(3570) /* 3.57 =C2=B5V * 1000 */
> =20
>  struct bq27xxx_device_info;
>  struct bq27xxx_access_methods {
>  	int (*read)(struct bq27xxx_device_info *di, u8 reg, bool single);
>  };
> =20
> -enum bq27xxx_chip { BQ27000, BQ27500, BQ27425, BQ27742, BQ27510};
> +#define INVALID_REG_ADDR	0xff
> +
> +enum bq27xxx_chip {
> +	BQ27000, /* bq27000, bq27200 */
> +	BQ27010, /* bq27010, bq27210 */
> +	BQ27500, /* bq27500, bq27510, bq27520 */
> +	BQ27530, /* bq27530, bq27531 */
> +	BQ27541, /* bq27541, bq27542, bq27546, bq27742 */
> +	BQ27545, /* bq27545 */
> +	BQ27421, /* bq27421, bq27425, bq27441, bq27621 */
> +};
> +
> +/*
> + * bq27xxx_reg_index - Register names
> + *
> + * These are indexes into a device's register mapping array.
> + */
> +enum bq27xxx_reg_index {
> +	BQ27XXX_REG_CTRL =3D 0,	/* Control */
> +	BQ27XXX_REG_TEMP,	/* Temperature */
> +	BQ27XXX_REG_INT_TEMP,	/* Internal Temperature */
> +	BQ27XXX_REG_VOLT,	/* Voltage */
> +	BQ27XXX_REG_AI,		/* Average Current */
> +	BQ27XXX_REG_FLAGS,	/* Flags */
> +	BQ27XXX_REG_TTE,	/* Time-to-Empty */
> +	BQ27XXX_REG_TTF,	/* Time-to-Full */
> +	BQ27XXX_REG_TTES,	/* Time-to-Empty Standby */
> +	BQ27XXX_REG_TTECP,	/* Time-to-Empty at Constant Power */
> +	BQ27XXX_REG_NAC,	/* Nominal Available Capacity */
> +	BQ27XXX_REG_FCC,	/* Full Charge Capacity */
> +	BQ27XXX_REG_CYCT,	/* Cycle Count */
> +	BQ27XXX_REG_AE,		/* Available Energy */
> +	BQ27XXX_REG_SOC,	/* State-of-Charge */
> +	BQ27XXX_REG_DCAP,	/* Design Capacity */
> +	BQ27XXX_REG_AP,		/* Average Power */
> +};
> =20
>  struct bq27xxx_reg_cache {
>  	int temperature;
> @@ -123,9 +138,152 @@ struct bq27xxx_device_info {
>  	struct bq27xxx_access_methods bus;
> =20
>  	struct mutex lock;
> +
> +	u8 *regs;
>  };
> =20
> -static enum power_supply_property bq27x00_battery_props[] =3D {
> +/* Register mappings */
> +static u8 bq27000_regs[] =3D {
> +	0x00,	/* CONTROL	*/
> +	0x06,	/* TEMP		*/
> +	0xff,	/* INT TEMP - NA*/
> +	0x08,	/* VOLT		*/
> +	0x14,	/* AVG CURR	*/
> +	0x0a,	/* FLAGS	*/
> +	0x16,	/* TTE		*/
> +	0x18,	/* TTF		*/
> +	0x1c,	/* TTES		*/
> +	0x26,	/* TTECP	*/
> +	0x0c,	/* NAC		*/
> +	0x12,	/* LMD(FCC)	*/
> +	0x2a,	/* CYCT		*/
> +	0x22,	/* AE		*/
> +	0x0b,	/* SOC(RSOC)	*/
> +	0x76,	/* DCAP(ILMD)	*/
> +	0x24,	/* AP		*/
> +};
> +
> +static u8 bq27010_regs[] =3D {
> +	0x00,	/* CONTROL	*/
> +	0x06,	/* TEMP		*/
> +	0xff,	/* INT TEMP - NA*/
> +	0x08,	/* VOLT		*/
> +	0x14,	/* AVG CURR	*/
> +	0x0a,	/* FLAGS	*/
> +	0x16,	/* TTE		*/
> +	0x18,	/* TTF		*/
> +	0x1c,	/* TTES		*/
> +	0x26,	/* TTECP	*/
> +	0x0c,	/* NAC		*/
> +	0x12,	/* LMD(FCC)	*/
> +	0x2a,	/* CYCT		*/
> +	0xff,	/* AE - NA	*/
> +	0x0b,	/* SOC(RSOC)	*/
> +	0x76,	/* DCAP(ILMD)	*/
> +	0xff,	/* AP - NA	*/
> +};
> +
> +static u8 bq27500_regs[] =3D {
> +	0x00,	/* CONTROL	*/
> +	0x06,	/* TEMP		*/
> +	0x28,	/* INT TEMP	*/
> +	0x08,	/* VOLT		*/
> +	0x14,	/* AVG CURR	*/
> +	0x0a,	/* FLAGS	*/
> +	0x16,	/* TTE		*/
> +	0xff,	/* TTF - NA	*/
> +	0x1a,	/* TTES		*/
> +	0xff,	/* TTECP - NA	*/
> +	0x0c,	/* NAC		*/
> +	0x12,	/* LMD(FCC)	*/
> +	0x1e,	/* CYCT		*/
> +	0xff,	/* AE - NA	*/
> +	0x20,	/* SOC(RSOC)	*/
> +	0x2e,	/* DCAP(ILMD)	*/
> +	0xff,	/* AP - NA	*/
> +};
> +
> +static u8 bq27530_regs[] =3D {
> +	0x00,	/* CONTROL	*/
> +	0x06,	/* TEMP		*/
> +	0x32,	/* INT TEMP	*/
> +	0x08,	/* VOLT		*/
> +	0x14,	/* AVG CURR	*/
> +	0x0a,	/* FLAGS	*/
> +	0x16,	/* TTE		*/
> +	0xff,	/* TTF - NA	*/
> +	0xff,	/* TTES - NA	*/
> +	0xff,	/* TTECP - NA	*/
> +	0x0c,	/* NAC		*/
> +	0x12,	/* LMD(FCC)	*/
> +	0x2a,	/* CYCT		*/
> +	0xff,	/* AE - NA	*/
> +	0x2c,	/* SOC(RSOC)	*/
> +	0xff,	/* DCAP - NA	*/
> +	0x24,	/* AP		*/
> +};
> +
> +static u8 bq27541_regs[] =3D {
> +	0x00,	/* CONTROL	*/
> +	0x06,	/* TEMP		*/
> +	0x28,	/* INT TEMP	*/
> +	0x08,	/* VOLT		*/
> +	0x14,	/* AVG CURR	*/
> +	0x0a,	/* FLAGS	*/
> +	0x16,	/* TTE		*/
> +	0xff,	/* TTF - NA	*/
> +	0xff,	/* TTES - NA	*/
> +	0xff,	/* TTECP - NA	*/
> +	0x0c,	/* NAC		*/
> +	0x12,	/* LMD(FCC)	*/
> +	0x2a,	/* CYCT		*/
> +	0xff,	/* AE - NA	*/
> +	0x2c,	/* SOC(RSOC)	*/
> +	0x3c,	/* DCAP		*/
> +	0x76,	/* AP		*/
> +};
> +
> +static u8 bq27545_regs[] =3D {
> +	0x00,	/* CONTROL	*/
> +	0x06,	/* TEMP		*/
> +	0x28,	/* INT TEMP	*/
> +	0x08,	/* VOLT		*/
> +	0x14,	/* AVG CURR	*/
> +	0x0a,	/* FLAGS	*/
> +	0x16,	/* TTE		*/
> +	0xff,	/* TTF - NA	*/
> +	0xff,	/* TTES - NA	*/
> +	0xff,	/* TTECP - NA	*/
> +	0x0c,	/* NAC		*/
> +	0x12,	/* LMD(FCC)	*/
> +	0x2a,	/* CYCT		*/
> +	0xff,	/* AE - NA	*/
> +	0x2c,	/* SOC(RSOC)	*/
> +	0xff,	/* DCAP - NA */
> +	0x24,	/* AP		*/
> +};
> +
> +static u8 bq27421_regs[] =3D {
> +	0x00,	/* CONTROL	*/
> +	0x02,	/* TEMP		*/
> +	0x1e,	/* INT TEMP	*/
> +	0x04,	/* VOLT		*/
> +	0x10,	/* AVG CURR	*/
> +	0x06,	/* FLAGS	*/
> +	0xff,	/* TTE - NA	*/
> +	0xff,	/* TTF - NA	*/
> +	0xff,	/* TTES - NA	*/
> +	0xff,	/* TTECP - NA	*/
> +	0x08,	/* NAC		*/
> +	0x0e,	/* FCC		*/
> +	0xff,	/* CYCT - NA	*/
> +	0xff,	/* AE - NA	*/
> +	0x1c,	/* SOC		*/
> +	0x3c,	/* DCAP		*/
> +	0x18,	/* AP		*/
> +};
> +
> +static enum power_supply_property bq27000_battery_props[] =3D {
>  	POWER_SUPPLY_PROP_STATUS,
>  	POWER_SUPPLY_PROP_PRESENT,
>  	POWER_SUPPLY_PROP_VOLTAGE_NOW,
> @@ -147,7 +305,7 @@ static enum power_supply_property bq27x00_battery=
_props[] =3D {
>  	POWER_SUPPLY_PROP_MANUFACTURER,
>  };
> =20
> -static enum power_supply_property bq27425_battery_props[] =3D {
> +static enum power_supply_property bq27010_battery_props[] =3D {
>  	POWER_SUPPLY_PROP_STATUS,
>  	POWER_SUPPLY_PROP_PRESENT,
>  	POWER_SUPPLY_PROP_VOLTAGE_NOW,
> @@ -155,14 +313,19 @@ static enum power_supply_property bq27425_batte=
ry_props[] =3D {
>  	POWER_SUPPLY_PROP_CAPACITY,
>  	POWER_SUPPLY_PROP_CAPACITY_LEVEL,
>  	POWER_SUPPLY_PROP_TEMP,
> +	POWER_SUPPLY_PROP_TIME_TO_EMPTY_NOW,
> +	POWER_SUPPLY_PROP_TIME_TO_EMPTY_AVG,
> +	POWER_SUPPLY_PROP_TIME_TO_FULL_NOW,
>  	POWER_SUPPLY_PROP_TECHNOLOGY,
>  	POWER_SUPPLY_PROP_CHARGE_FULL,
>  	POWER_SUPPLY_PROP_CHARGE_NOW,
>  	POWER_SUPPLY_PROP_CHARGE_FULL_DESIGN,
> +	POWER_SUPPLY_PROP_CYCLE_COUNT,
> +	POWER_SUPPLY_PROP_HEALTH,
>  	POWER_SUPPLY_PROP_MANUFACTURER,
>  };
> =20
> -static enum power_supply_property bq27742_battery_props[] =3D {
> +static enum power_supply_property bq27500_battery_props[] =3D {
>  	POWER_SUPPLY_PROP_STATUS,
>  	POWER_SUPPLY_PROP_PRESENT,
>  	POWER_SUPPLY_PROP_VOLTAGE_NOW,
> @@ -176,12 +339,29 @@ static enum power_supply_property bq27742_batte=
ry_props[] =3D {
>  	POWER_SUPPLY_PROP_CHARGE_NOW,
>  	POWER_SUPPLY_PROP_CHARGE_FULL_DESIGN,
>  	POWER_SUPPLY_PROP_CYCLE_COUNT,
> +	POWER_SUPPLY_PROP_HEALTH,
> +	POWER_SUPPLY_PROP_MANUFACTURER,
> +};
> +
> +static enum power_supply_property bq27530_battery_props[] =3D {
> +	POWER_SUPPLY_PROP_STATUS,
> +	POWER_SUPPLY_PROP_PRESENT,
> +	POWER_SUPPLY_PROP_VOLTAGE_NOW,
> +	POWER_SUPPLY_PROP_CURRENT_NOW,
> +	POWER_SUPPLY_PROP_CAPACITY,
> +	POWER_SUPPLY_PROP_CAPACITY_LEVEL,
> +	POWER_SUPPLY_PROP_TEMP,
> +	POWER_SUPPLY_PROP_TIME_TO_EMPTY_NOW,
> +	POWER_SUPPLY_PROP_TECHNOLOGY,
> +	POWER_SUPPLY_PROP_CHARGE_FULL,
> +	POWER_SUPPLY_PROP_CHARGE_NOW,
>  	POWER_SUPPLY_PROP_POWER_AVG,
>  	POWER_SUPPLY_PROP_HEALTH,
> +	POWER_SUPPLY_PROP_CYCLE_COUNT,
>  	POWER_SUPPLY_PROP_MANUFACTURER,
>  };
> =20
> -static enum power_supply_property bq27510_battery_props[] =3D {
> +static enum power_supply_property bq27541_battery_props[] =3D {
>  	POWER_SUPPLY_PROP_STATUS,
>  	POWER_SUPPLY_PROP_PRESENT,
>  	POWER_SUPPLY_PROP_VOLTAGE_NOW,
> @@ -200,6 +380,39 @@ static enum power_supply_property bq27510_batter=
y_props[] =3D {
>  	POWER_SUPPLY_PROP_MANUFACTURER,
>  };
> =20
> +static enum power_supply_property bq27545_battery_props[] =3D {
> +	POWER_SUPPLY_PROP_STATUS,
> +	POWER_SUPPLY_PROP_PRESENT,
> +	POWER_SUPPLY_PROP_VOLTAGE_NOW,
> +	POWER_SUPPLY_PROP_CURRENT_NOW,
> +	POWER_SUPPLY_PROP_CAPACITY,
> +	POWER_SUPPLY_PROP_CAPACITY_LEVEL,
> +	POWER_SUPPLY_PROP_TEMP,
> +	POWER_SUPPLY_PROP_TIME_TO_EMPTY_NOW,
> +	POWER_SUPPLY_PROP_TECHNOLOGY,
> +	POWER_SUPPLY_PROP_CHARGE_FULL,
> +	POWER_SUPPLY_PROP_CHARGE_NOW,
> +	POWER_SUPPLY_PROP_HEALTH,
> +	POWER_SUPPLY_PROP_CYCLE_COUNT,
> +	POWER_SUPPLY_PROP_POWER_AVG,
> +	POWER_SUPPLY_PROP_MANUFACTURER,
> +};
> +
> +static enum power_supply_property bq27421_battery_props[] =3D {
> +	POWER_SUPPLY_PROP_STATUS,
> +	POWER_SUPPLY_PROP_PRESENT,
> +	POWER_SUPPLY_PROP_VOLTAGE_NOW,
> +	POWER_SUPPLY_PROP_CURRENT_NOW,
> +	POWER_SUPPLY_PROP_CAPACITY,
> +	POWER_SUPPLY_PROP_CAPACITY_LEVEL,
> +	POWER_SUPPLY_PROP_TEMP,
> +	POWER_SUPPLY_PROP_TECHNOLOGY,
> +	POWER_SUPPLY_PROP_CHARGE_FULL,
> +	POWER_SUPPLY_PROP_CHARGE_NOW,
> +	POWER_SUPPLY_PROP_CHARGE_FULL_DESIGN,
> +	POWER_SUPPLY_PROP_MANUFACTURER,
> +};
> +
>  static unsigned int poll_interval =3D 360;
>  module_param(poll_interval, uint, 0644);
>  MODULE_PARM_DESC(poll_interval,
> @@ -209,25 +422,14 @@ MODULE_PARM_DESC(poll_interval,
>   * Common code for BQ27xxx devices
>   */
> =20
> -static inline int bq27xxx_read(struct bq27xxx_device_info *di, u8 re=
g,
> +static inline int bq27xxx_read(struct bq27xxx_device_info *di, int r=
eg_index,
>  			       bool single)
>  {
> -	if (di->chip =3D=3D BQ27425)
> -		return di->bus.read(di, reg - BQ27425_REG_OFFSET, single);
> -	return di->bus.read(di, reg, single);
> -}
> +	/* Reports EINVAL for invalid/missing registers */
> +	if (!di || di->regs[reg_index] =3D=3D INVALID_REG_ADDR)
> +		return -EINVAL;
> =20
> -/*
> - * Higher versions of the chip like BQ27425 and BQ27500
> - * differ from BQ27000 and BQ27200 in calculation of certain
> - * parameters. Hence we need to check for the chip type.
> - */
> -static bool bq27xxx_is_chip_version_higher(struct bq27xxx_device_inf=
o *di)
> -{
> -	if (di->chip =3D=3D BQ27425 || di->chip =3D=3D BQ27500 || di->chip =
=3D=3D BQ27742
> -	    || di->chip =3D=3D BQ27510)
> -		return true;
> -	return false;
> +	return di->bus.read(di, di->regs[reg_index], single);
>  }
> =20
>  /*
> @@ -238,14 +440,7 @@ static int bq27xxx_battery_read_soc(struct bq27x=
xx_device_info *di)
>  {
>  	int soc;
> =20
> -	if (di->chip =3D=3D BQ27500 || di->chip =3D=3D BQ27742)
> -		soc =3D bq27xxx_read(di, BQ27500_REG_SOC, false);
> -	else if (di->chip =3D=3D BQ27510)
> -		soc =3D bq27xxx_read(di, BQ27510_REG_SOC, false);
> -	else if (di->chip =3D=3D BQ27425)
> -		soc =3D bq27xxx_read(di, BQ27425_REG_SOC, false);
> -	else
> -		soc =3D bq27xxx_read(di, BQ27000_REG_RSOC, true);
> +	soc =3D bq27xxx_read(di, BQ27XXX_REG_SOC, false);
> =20
>  	if (soc < 0)
>  		dev_dbg(di->dev, "error reading State-of-Charge\n");
> @@ -268,10 +463,10 @@ static int bq27xxx_battery_read_charge(struct b=
q27xxx_device_info *di, u8 reg)
>  		return charge;
>  	}
> =20
> -	if (bq27xxx_is_chip_version_higher(di))
> -		charge *=3D 1000;
> +	if (di->chip =3D=3D BQ27000 || di->chip =3D=3D BQ27010)
> +		charge *=3D BQ27XXX_CURRENT_CONSTANT / BQ27XXX_RS;
>  	else
> -		charge =3D charge * 3570 / BQ27XXX_RS;
> +		charge *=3D 1000;
> =20
>  	return charge;
>  }
> @@ -283,57 +478,46 @@ static int bq27xxx_battery_read_charge(struct b=
q27xxx_device_info *di, u8 reg)
>  static inline int bq27xxx_battery_read_nac(struct bq27xxx_device_inf=
o *di)
>  {
>  	int flags;
> -	bool is_bq27500 =3D di->chip =3D=3D BQ27500;
> -	bool is_bq27742 =3D di->chip =3D=3D BQ27742;
> -	bool is_higher =3D bq27xxx_is_chip_version_higher(di);
> -	bool flags_1b =3D !(is_bq27500 || is_bq27742);
> =20
> -	flags =3D bq27xxx_read(di, BQ27x00_REG_FLAGS, flags_1b);
> -	if (flags >=3D 0 && !is_higher && (flags & BQ27000_FLAG_CI))
> -		return -ENODATA;
> +	if (di->chip =3D=3D BQ27000 || di->chip =3D=3D BQ27010) {
> +		flags =3D bq27xxx_read(di, BQ27XXX_REG_FLAGS, true);
> +		if (flags >=3D 0 && (flags & BQ27000_FLAG_CI))
> +			return -ENODATA;
> +	}
> =20
> -	return bq27xxx_battery_read_charge(di, BQ27x00_REG_NAC);
> +	return bq27xxx_battery_read_charge(di, BQ27XXX_REG_NAC);
>  }
> =20
>  /*
> - * Return the battery Last measured discharge in =C2=B5Ah
> + * Return the battery Full Charge Capacity in =C2=B5Ah
>   * Or < 0 if something fails.
>   */
> -static inline int bq27xxx_battery_read_lmd(struct bq27xxx_device_inf=
o *di)
> +static inline int bq27xxx_battery_read_fcc(struct bq27xxx_device_inf=
o *di)
>  {
> -	return bq27xxx_battery_read_charge(di, BQ27x00_REG_LMD);
> +	return bq27xxx_battery_read_charge(di, BQ27XXX_REG_FCC);
>  }
> =20
>  /*
> - * Return the battery Initial last measured discharge in =C2=B5Ah
> + * Return the Design Capacity in =C2=B5Ah
>   * Or < 0 if something fails.
>   */
> -static int bq27xxx_battery_read_ilmd(struct bq27xxx_device_info *di)
> +static int bq27xxx_battery_read_dcap(struct bq27xxx_device_info *di)
>  {
> -	int ilmd;
> +	int dcap;
> =20
> -	if (bq27xxx_is_chip_version_higher(di)) {
> -		if (di->chip =3D=3D BQ27425)
> -			ilmd =3D bq27xxx_read(di, BQ27425_REG_DCAP, false);
> -		else if (di->chip =3D=3D BQ27510)
> -			ilmd =3D bq27xxx_read(di, BQ27510_REG_DCAP, false);
> -		else
> -			ilmd =3D bq27xxx_read(di, BQ27500_REG_DCAP, false);
> -	} else {
> -		ilmd =3D bq27xxx_read(di, BQ27000_REG_ILMD, true);
> -	}
> +	dcap =3D bq27xxx_read(di, BQ27XXX_REG_DCAP, false);
> =20
> -	if (ilmd < 0) {
> +	if (dcap < 0) {
>  		dev_dbg(di->dev, "error reading initial last measured discharge\n"=
);
> -		return ilmd;
> +		return dcap;
>  	}
> =20
> -	if (bq27xxx_is_chip_version_higher(di))
> -		ilmd *=3D 1000;
> +	if (di->chip =3D=3D BQ27000 || di->chip =3D=3D BQ27010)
> +		dcap *=3D BQ27XXX_CURRENT_CONSTANT / BQ27XXX_RS;
>  	else
> -		ilmd =3D ilmd * 256 * 3570 / BQ27XXX_RS;
> +		dcap *=3D 1000;
> =20
> -	return ilmd;
> +	return dcap;
>  }
> =20
>  /*
> @@ -344,16 +528,16 @@ static int bq27xxx_battery_read_energy(struct b=
q27xxx_device_info *di)
>  {
>  	int ae;
> =20
> -	ae =3D bq27xxx_read(di, BQ27x00_REG_AE, false);
> +	ae =3D bq27xxx_read(di, BQ27XXX_REG_AE, false);
>  	if (ae < 0) {
>  		dev_dbg(di->dev, "error reading available energy\n");
>  		return ae;
>  	}
> =20
> -	if (di->chip =3D=3D BQ27500)
> -		ae *=3D 1000;
> +	if (di->chip =3D=3D BQ27000 || di->chip =3D=3D BQ27010)
> +		ae *=3D BQ27XXX_POWER_CONSTANT / BQ27XXX_RS;
>  	else
> -		ae =3D ae * 29200 / BQ27XXX_RS;
> +		ae *=3D 1000;
> =20
>  	return ae;
>  }
> @@ -366,13 +550,13 @@ static int bq27xxx_battery_read_temperature(str=
uct bq27xxx_device_info *di)
>  {
>  	int temp;
> =20
> -	temp =3D bq27xxx_read(di, BQ27x00_REG_TEMP, false);
> +	temp =3D bq27xxx_read(di, BQ27XXX_REG_TEMP, false);
>  	if (temp < 0) {
>  		dev_err(di->dev, "error reading temperature\n");
>  		return temp;
>  	}
> =20
> -	if (!bq27xxx_is_chip_version_higher(di))
> +	if (di->chip =3D=3D BQ27000 || di->chip =3D=3D BQ27010)
>  		temp =3D 5 * temp / 2;
> =20
>  	return temp;
> @@ -386,10 +570,7 @@ static int bq27xxx_battery_read_cyct(struct bq27=
xxx_device_info *di)
>  {
>  	int cyct;
> =20
> -	if (di->chip =3D=3D BQ27510)
> -		cyct =3D bq27xxx_read(di, BQ27510_REG_CYCT, false);
> -	else
> -		cyct =3D bq27xxx_read(di, BQ27x00_REG_CYCT, false);
> +	cyct =3D bq27xxx_read(di, BQ27XXX_REG_CYCT, false);
>  	if (cyct < 0)
>  		dev_err(di->dev, "error reading cycle count total\n");
> =20
> @@ -421,21 +602,32 @@ static int bq27xxx_battery_read_time(struct bq2=
7xxx_device_info *di, u8 reg)
>   * Read an average power register.
>   * Return < 0 if something fails.
>   */
> -static int bq27xxx_battery_read_pwr_avg(struct bq27xxx_device_info *=
di, u8 reg)
> +static int bq27xxx_battery_read_pwr_avg(struct bq27xxx_device_info *=
di)
>  {
>  	int tval;
> =20
> -	tval =3D bq27xxx_read(di, reg, false);
> +	tval =3D bq27xxx_read(di, BQ27XXX_REG_AP, false);
>  	if (tval < 0) {
> -		dev_err(di->dev, "error reading power avg rgister  %02x: %d\n",
> -			reg, tval);
> +		dev_err(di->dev, "error reading average power register  %02x: %d\n=
",
> +			BQ27XXX_REG_AP, tval);
>  		return tval;
>  	}
> =20
> -	if (di->chip =3D=3D BQ27500)
> +	if (di->chip =3D=3D BQ27000 || di->chip =3D=3D BQ27010)
> +		return (tval * BQ27XXX_POWER_CONSTANT) / BQ27XXX_RS;
> +	else
>  		return tval;
> +}
> +
> +/*
> + * Returns true if a battery over temperature condition is detected
> + */
> +static int bq27xxx_battery_overtemp(struct bq27xxx_device_info *di, =
u16 flags)
> +{
> +	if (di->chip =3D=3D BQ27500 || di->chip =3D=3D BQ27541)
> +		return flags & (BQ27XXX_FLAG_OTC | BQ27XXX_FLAG_OTD);
>  	else
> -		return (tval * BQ27XXX_POWER_CONSTANT) / BQ27XXX_RS;
> +		return flags & BQ27XXX_FLAG_OTC;
>  }
> =20
>  /*
> @@ -444,53 +636,43 @@ static int bq27xxx_battery_read_pwr_avg(struct =
bq27xxx_device_info *di, u8 reg)
>   */
>  static int bq27xxx_battery_read_health(struct bq27xxx_device_info *d=
i)
>  {
> -	int tval;
> +	u16 tval;
> =20
> -	tval =3D bq27xxx_read(di, BQ27x00_REG_FLAGS, false);
> +	tval =3D bq27xxx_read(di, BQ27XXX_REG_FLAGS, false);
>  	if (tval < 0) {
>  		dev_err(di->dev, "error reading flag register:%d\n", tval);
>  		return tval;
>  	}
> =20
> -	if (di->chip =3D=3D BQ27500) {
> -		if (tval & BQ27500_FLAG_SOCF)
> +	if (di->chip =3D=3D BQ27000 || di->chip =3D=3D BQ27010) {
> +		if (tval & BQ27000_FLAG_EDV1)
>  			tval =3D POWER_SUPPLY_HEALTH_DEAD;
> -		else if (tval & BQ27500_FLAG_OTC)
> -			tval =3D POWER_SUPPLY_HEALTH_OVERHEAT;
>  		else
>  			tval =3D POWER_SUPPLY_HEALTH_GOOD;
> -		return tval;
> -	} else if (di->chip =3D=3D BQ27510) {
> -		if (tval & BQ27500_FLAG_OTC)
> -			return POWER_SUPPLY_HEALTH_OVERHEAT;
> -		return POWER_SUPPLY_HEALTH_GOOD;
>  	} else {
> -		if (tval & BQ27000_FLAG_EDV1)
> +		if (tval & BQ27XXX_FLAG_SOCF)
>  			tval =3D POWER_SUPPLY_HEALTH_DEAD;
> +		else if (bq27xxx_battery_overtemp(di, tval))
> +			tval =3D POWER_SUPPLY_HEALTH_OVERHEAT;
>  		else
>  			tval =3D POWER_SUPPLY_HEALTH_GOOD;
> -		return tval;
>  	}
> =20
> -	return -1;
> +	return tval;
>  }
> =20
>  static void bq27xxx_battery_update(struct bq27xxx_device_info *di)
>  {
>  	struct bq27xxx_reg_cache cache =3D {0, };
> -	bool is_bq27500 =3D di->chip =3D=3D BQ27500;
> -	bool is_bq27510 =3D di->chip =3D=3D BQ27510;
> -	bool is_bq27425 =3D di->chip =3D=3D BQ27425;
> -	bool is_bq27742 =3D di->chip =3D=3D BQ27742;
> -	bool flags_1b =3D !(is_bq27500 || is_bq27742);
> +	bool has_ci_flag =3D di->chip =3D=3D BQ27000 || di->chip =3D=3D BQ2=
7010;
> +	bool has_singe_flag =3D di->chip =3D=3D BQ27000 || di->chip =3D=3D =
BQ27010;
> =20
> -	cache.flags =3D bq27xxx_read(di, BQ27x00_REG_FLAGS, flags_1b);
> +	cache.flags =3D bq27xxx_read(di, BQ27XXX_REG_FLAGS, has_singe_flag)=
;
>  	if ((cache.flags & 0xff) =3D=3D 0xff)
> -		/* read error */
> -		cache.flags =3D -1;
> +		cache.flags =3D -1; /* read error */
>  	if (cache.flags >=3D 0) {
> -		if (!is_bq27500 && !is_bq27425 && !is_bq27742 && !is_bq27510
> -				&& (cache.flags & BQ27000_FLAG_CI)) {
> +		cache.temperature =3D bq27xxx_battery_read_temperature(di);
> +		if (has_ci_flag && (cache.flags & BQ27000_FLAG_CI)) {
>  			dev_info(di->dev, "battery is not calibrated! ignoring capacity v=
alues\n");
>  			cache.capacity =3D -ENODATA;
>  			cache.energy =3D -ENODATA;
> @@ -500,41 +682,25 @@ static void bq27xxx_battery_update(struct bq27x=
xx_device_info *di)
>  			cache.charge_full =3D -ENODATA;
>  			cache.health =3D -ENODATA;
>  		} else {
> +			if (di->regs[BQ27XXX_REG_TTE] !=3D INVALID_REG_ADDR)
> +				cache.time_to_empty =3D bq27xxx_battery_read_time(di, BQ27XXX_RE=
G_TTE);
> +			if (di->regs[BQ27XXX_REG_TTECP] !=3D INVALID_REG_ADDR)
> +				cache.time_to_empty_avg =3D bq27xxx_battery_read_time(di, BQ27XX=
X_REG_TTECP);
> +			if (di->regs[BQ27XXX_REG_TTF] !=3D INVALID_REG_ADDR)
> +				cache.time_to_full =3D bq27xxx_battery_read_time(di, BQ27XXX_REG=
_TTF);
> +			cache.charge_full =3D bq27xxx_battery_read_fcc(di);
>  			cache.capacity =3D bq27xxx_battery_read_soc(di);
> -			if (is_bq27742 || is_bq27510)
> -				cache.time_to_empty =3D
> -					bq27xxx_battery_read_time(di,
> -							BQ27x00_REG_TTE);
> -			else if (!is_bq27425) {
> +			if (di->regs[BQ27XXX_REG_AE] !=3D INVALID_REG_ADDR)
>  				cache.energy =3D bq27xxx_battery_read_energy(di);
> -				cache.time_to_empty =3D
> -					bq27xxx_battery_read_time(di,
> -							BQ27x00_REG_TTE);
> -				cache.time_to_empty_avg =3D
> -					bq27xxx_battery_read_time(di,
> -							BQ27x00_REG_TTECP);
> -				cache.time_to_full =3D
> -					bq27xxx_battery_read_time(di,
> -							BQ27x00_REG_TTF);
> -			}
> -			cache.charge_full =3D bq27xxx_battery_read_lmd(di);
>  			cache.health =3D bq27xxx_battery_read_health(di);
>  		}
> -		cache.temperature =3D bq27xxx_battery_read_temperature(di);
> -		if (!is_bq27425)
> +		if (di->regs[BQ27XXX_REG_CYCT] !=3D INVALID_REG_ADDR)
>  			cache.cycle_count =3D bq27xxx_battery_read_cyct(di);
> -		if (is_bq27742)
> -			cache.power_avg =3D
> -				bq27xxx_battery_read_pwr_avg(di,
> -						BQ27742_POWER_AVG);
> -		else
> -			cache.power_avg =3D
> -				bq27xxx_battery_read_pwr_avg(di,
> -						BQ27x00_POWER_AVG);
> +		cache.power_avg =3D bq27xxx_battery_read_pwr_avg(di);
> =20
>  		/* We only have to read charge design full once */
>  		if (di->charge_design_full <=3D 0)
> -			di->charge_design_full =3D bq27xxx_battery_read_ilmd(di);
> +			di->charge_design_full =3D bq27xxx_battery_read_dcap(di);
>  	}
> =20
>  	if (di->cache.capacity !=3D cache.capacity)
> @@ -549,7 +715,8 @@ static void bq27xxx_battery_update(struct bq27xxx=
_device_info *di)
>  static void bq27xxx_battery_poll(struct work_struct *work)
>  {
>  	struct bq27xxx_device_info *di =3D
> -		container_of(work, struct bq27xxx_device_info, work.work);
> +			container_of(work, struct bq27xxx_device_info,
> +				     work.work);
> =20
>  	bq27xxx_battery_update(di);
> =20
> @@ -571,23 +738,23 @@ static int bq27xxx_battery_current(struct bq27x=
xx_device_info *di,
>  	int curr;
>  	int flags;
> =20
> -	curr =3D bq27xxx_read(di, BQ27x00_REG_AI, false);
> +	curr =3D bq27xxx_read(di, BQ27XXX_REG_AI, false);
>  	if (curr < 0) {
>  		dev_err(di->dev, "error reading current\n");
>  		return curr;
>  	}
> =20
> -	if (bq27xxx_is_chip_version_higher(di)) {
> -		/* bq27500 returns signed value */
> -		val->intval =3D (int)((s16)curr) * 1000;
> -	} else {
> -		flags =3D bq27xxx_read(di, BQ27x00_REG_FLAGS, false);
> +	if (di->chip =3D=3D BQ27000 || di->chip =3D=3D BQ27010) {
> +		flags =3D bq27xxx_read(di, BQ27XXX_REG_FLAGS, false);
>  		if (flags & BQ27000_FLAG_CHGS) {
>  			dev_dbg(di->dev, "negative current!\n");
>  			curr =3D -curr;
>  		}
> =20
> -		val->intval =3D curr * 3570 / BQ27XXX_RS;
> +		val->intval =3D curr * BQ27XXX_CURRENT_CONSTANT / BQ27XXX_RS;
> +	} else {
> +		/* Other gauges return signed value */
> +		val->intval =3D (int)((s16)curr) * 1000;
>  	}
> =20
>  	return 0;
> @@ -598,14 +765,7 @@ static int bq27xxx_battery_status(struct bq27xxx=
_device_info *di,
>  {
>  	int status;
> =20
> -	if (bq27xxx_is_chip_version_higher(di)) {
> -		if (di->cache.flags & BQ27500_FLAG_FC)
> -			status =3D POWER_SUPPLY_STATUS_FULL;
> -		else if (di->cache.flags & BQ27500_FLAG_DSC)
> -			status =3D POWER_SUPPLY_STATUS_DISCHARGING;
> -		else
> -			status =3D POWER_SUPPLY_STATUS_CHARGING;
> -	} else {
> +	if (di->chip =3D=3D BQ27000 || di->chip =3D=3D BQ27010) {
>  		if (di->cache.flags & BQ27000_FLAG_FC)
>  			status =3D POWER_SUPPLY_STATUS_FULL;
>  		else if (di->cache.flags & BQ27000_FLAG_CHGS)
> @@ -614,6 +774,13 @@ static int bq27xxx_battery_status(struct bq27xxx=
_device_info *di,
>  			status =3D POWER_SUPPLY_STATUS_NOT_CHARGING;
>  		else
>  			status =3D POWER_SUPPLY_STATUS_DISCHARGING;
> +	} else {
> +		if (di->cache.flags & BQ27XXX_FLAG_FC)
> +			status =3D POWER_SUPPLY_STATUS_FULL;
> +		else if (di->cache.flags & BQ27XXX_FLAG_DSC)
> +			status =3D POWER_SUPPLY_STATUS_DISCHARGING;
> +		else
> +			status =3D POWER_SUPPLY_STATUS_CHARGING;
>  	}
> =20
>  	val->intval =3D status;
> @@ -626,21 +793,21 @@ static int bq27xxx_battery_capacity_level(struc=
t bq27xxx_device_info *di,
>  {
>  	int level;
> =20
> -	if (bq27xxx_is_chip_version_higher(di)) {
> -		if (di->cache.flags & BQ27500_FLAG_FC)
> +	if (di->chip =3D=3D BQ27000 || di->chip =3D=3D BQ27010) {
> +		if (di->cache.flags & BQ27000_FLAG_FC)
>  			level =3D POWER_SUPPLY_CAPACITY_LEVEL_FULL;
> -		else if (di->cache.flags & BQ27500_FLAG_SOC1)
> +		else if (di->cache.flags & BQ27000_FLAG_EDV1)
>  			level =3D POWER_SUPPLY_CAPACITY_LEVEL_LOW;
> -		else if (di->cache.flags & BQ27500_FLAG_SOCF)
> +		else if (di->cache.flags & BQ27000_FLAG_EDVF)
>  			level =3D POWER_SUPPLY_CAPACITY_LEVEL_CRITICAL;
>  		else
>  			level =3D POWER_SUPPLY_CAPACITY_LEVEL_NORMAL;
>  	} else {
> -		if (di->cache.flags & BQ27000_FLAG_FC)
> +		if (di->cache.flags & BQ27XXX_FLAG_FC)
>  			level =3D POWER_SUPPLY_CAPACITY_LEVEL_FULL;
> -		else if (di->cache.flags & BQ27000_FLAG_EDV1)
> +		else if (di->cache.flags & BQ27XXX_FLAG_SOC1)
>  			level =3D POWER_SUPPLY_CAPACITY_LEVEL_LOW;
> -		else if (di->cache.flags & BQ27000_FLAG_EDVF)
> +		else if (di->cache.flags & BQ27XXX_FLAG_SOCF)
>  			level =3D POWER_SUPPLY_CAPACITY_LEVEL_CRITICAL;
>  		else
>  			level =3D POWER_SUPPLY_CAPACITY_LEVEL_NORMAL;
> @@ -660,7 +827,7 @@ static int bq27xxx_battery_voltage(struct bq27xxx=
_device_info *di,
>  {
>  	int volt;
> =20
> -	volt =3D bq27xxx_read(di, BQ27x00_REG_VOLT, false);
> +	volt =3D bq27xxx_read(di, BQ27XXX_REG_VOLT, false);
>  	if (volt < 0) {
>  		dev_err(di->dev, "error reading voltage\n");
>  		return volt;
> @@ -721,7 +888,7 @@ static int bq27xxx_battery_get_property(struct po=
wer_supply *psy,
>  	case POWER_SUPPLY_PROP_TEMP:
>  		ret =3D bq27xxx_simple_value(di->cache.temperature, val);
>  		if (ret =3D=3D 0)
> -			val->intval -=3D 2731;
> +			val->intval -=3D 2731; /* convert decidegree k to c */
>  		break;
>  	case POWER_SUPPLY_PROP_TIME_TO_EMPTY_NOW:
>  		ret =3D bq27xxx_simple_value(di->cache.time_to_empty, val);
> @@ -787,18 +954,27 @@ static int bq27xxx_powersupply_init(struct bq27=
xxx_device_info *di,
> =20
>  	psy_desc->name =3D name;
>  	psy_desc->type =3D POWER_SUPPLY_TYPE_BATTERY;
> -	if (di->chip =3D=3D BQ27425) {
> -		psy_desc->properties =3D bq27425_battery_props;
> -		psy_desc->num_properties =3D ARRAY_SIZE(bq27425_battery_props);
> -	} else if (di->chip =3D=3D BQ27742) {
> -		psy_desc->properties =3D bq27742_battery_props;
> -		psy_desc->num_properties =3D ARRAY_SIZE(bq27742_battery_props);
> -	} else if (di->chip =3D=3D BQ27510) {
> -		psy_desc->properties =3D bq27510_battery_props;
> -		psy_desc->num_properties =3D ARRAY_SIZE(bq27510_battery_props);
> +	if (di->chip =3D=3D BQ27000) {
> +		psy_desc->properties =3D bq27000_battery_props;
> +		psy_desc->num_properties =3D ARRAY_SIZE(bq27000_battery_props);
> +	} else if (di->chip =3D=3D BQ27010) {
> +		psy_desc->properties =3D bq27010_battery_props;
> +		psy_desc->num_properties =3D ARRAY_SIZE(bq27010_battery_props);
> +	} else if (di->chip =3D=3D BQ27500) {
> +		psy_desc->properties =3D bq27500_battery_props;
> +		psy_desc->num_properties =3D ARRAY_SIZE(bq27500_battery_props);
> +	} else if (di->chip =3D=3D BQ27530) {
> +		psy_desc->properties =3D bq27530_battery_props;
> +		psy_desc->num_properties =3D ARRAY_SIZE(bq27530_battery_props);
> +	} else if (di->chip =3D=3D BQ27541) {
> +		psy_desc->properties =3D bq27541_battery_props;
> +		psy_desc->num_properties =3D ARRAY_SIZE(bq27541_battery_props);
> +	} else if (di->chip =3D=3D BQ27545) {
> +		psy_desc->properties =3D bq27545_battery_props;
> +		psy_desc->num_properties =3D ARRAY_SIZE(bq27545_battery_props);
>  	} else {
> -		psy_desc->properties =3D bq27x00_battery_props;
> -		psy_desc->num_properties =3D ARRAY_SIZE(bq27x00_battery_props);
> +		psy_desc->properties =3D bq27421_battery_props;
> +		psy_desc->num_properties =3D ARRAY_SIZE(bq27421_battery_props);
>  	}
>  	psy_desc->get_property =3D bq27xxx_battery_get_property;
>  	psy_desc->external_power_changed =3D bq27xxx_external_power_changed=
;
> @@ -913,10 +1089,32 @@ static int bq27xxx_battery_i2c_probe(struct i2=
c_client *client,
>  	di->chip =3D id->driver_data;
>  	di->bus.read =3D &bq27xxx_battery_i2c_read;
> =20
> +	if (di->chip =3D=3D BQ27000) {
> +		di->regs =3D bq27000_regs;
> +	} else if (di->chip =3D=3D BQ27010) {
> +		di->regs =3D bq27010_regs;
> +	} else if (di->chip =3D=3D BQ27500) {
> +		di->regs =3D bq27500_regs;
> +	} else if (di->chip =3D=3D BQ27530) {
> +		di->regs =3D bq27530_regs;
> +	} else if (di->chip =3D=3D BQ27541) {
> +		di->regs =3D bq27541_regs;
> +	} else if (di->chip =3D=3D BQ27545) {
> +		di->regs =3D bq27545_regs;
> +	} else if (di->chip =3D=3D BQ27421) {
> +		di->regs =3D bq27421_regs;
> +	} else {
> +		dev_err(&client->dev, "Unexpected gas gauge: %d\n", di->chip);
> +		di->regs =3D bq27000_regs;
> +	}
> +
>  	retval =3D bq27xxx_powersupply_init(di, name);
>  	if (retval)
>  		goto batt_failed;
> =20
> +	/* Schedule a polling after about 1 min */
> +	schedule_delayed_work(&di->work, 60 * HZ);
> +
>  	i2c_set_clientdata(client, di);
> =20
>  	return 0;
> @@ -943,11 +1141,13 @@ static int bq27xxx_battery_i2c_remove(struct i=
2c_client *client)
>  }
> =20
>  static const struct i2c_device_id bq27xxx_id[] =3D {
> -	{ "bq27200", BQ27000 },	/* bq27200 is same as bq27000, but with i2c=
 */
> +	{ "bq27000", BQ27000 },

I2C version is bq27200, HDQ is bq27000. So here in struct i2c_device_id
is needed bq27200.

Also existing kernel code depends on it (git grep bq27200).

> +	{ "bq27010", BQ27010 },
>  	{ "bq27500", BQ27500 },
> -	{ "bq27425", BQ27425 },
> -	{ "bq27742", BQ27742 },
> -	{ "bq27510", BQ27510 },
> +	{ "bq27530", BQ27530 },
> +	{ "bq27541", BQ27541 },
> +	{ "bq27545", BQ27545 },
> +	{ "bq27421", BQ27421 },

Why you removed support for bq27425, bq27742 and bq27510?

>  	{},
>  };
>  MODULE_DEVICE_TABLE(i2c, bq27xxx_id);

--=20
Pali Roh=C3=A1r
pali.rohar@gmail.com
