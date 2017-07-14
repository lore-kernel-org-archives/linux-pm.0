From: "Bogdan, Dragos" <Dragos.Bogdan@analog.com>
Subject: Re: [PATCH v5 1/3] power: supply: ltc2941-battery-gauge: Prepare
 for LTC2942 and LTC2944
Date: Fri, 14 Jul 2017 15:05:13 +0000
Message-ID: <6067964B99C6A049AA5840B6F7BB2D0ABDAAD2C7@NWD2MBX5.ad.analog.com>
References: <20170712010758.66jx54qbdjfyt6x6@lenoch>
 <20170712010926.phvueosxw4o3ey44@lenoch>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-bn3nam01on0081.outbound.protection.outlook.com ([104.47.33.81]:51663
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1754120AbdGNPFU (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 14 Jul 2017 11:05:20 -0400
Content-Language: en-US
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Ladislav Michl <ladis@linux-mips.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Cc: Mike Looijmans <mike.looijmans@topic.nl>, Javier Martinez Canillas <javier@osg.samsung.com>, Sebastian Reichel <sre@kernel.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>

On 07/12/2017 04:09 AM, Ladislav Michl wrote:=0A=
> In order to support LTC2942 which has temperature registers=0A=
> at different offsets than LTC2943 use following register naming=0A=
> scheme (prefixes):=0A=
> - LTC294X_ common registers=0A=
> - LTC2942_ chips specific registers=0A=
> - LTC2943_ specific registers=0A=
>=0A=
> LTC2944 is compatible with LTC2943 but uses different constants=0A=
> to compute voltage and current, so replace num_regs misused=0A=
> for device indentification with real device id to discriminate=0A=
> between those two.=0A=
>=0A=
> There are no functional changes.=0A=
>=0A=
> Signed-off-by: Ladislav Michl <ladis@linux-mips.org>=0A=
> ---=0A=
>  Changes:=0A=
>  - v2: None=0A=
>  - v3: Extend commit message=0A=
>  - v4: None=0A=
>  - v5: Count on LTC2944 too=0A=
>=0A=
>  drivers/power/supply/ltc2941-battery-gauge.c | 66 +++++++++++++++-------=
------=0A=
>  1 file changed, 36 insertions(+), 30 deletions(-)=0A=
>=0A=
> diff --git a/drivers/power/supply/ltc2941-battery-gauge.c b/drivers/power=
/supply/ltc2941-battery-gauge.c=0A=
> index 7efb908f4451..7e264e8f28ab 100644=0A=
> --- a/drivers/power/supply/ltc2941-battery-gauge.c=0A=
> +++ b/drivers/power/supply/ltc2941-battery-gauge.c=0A=
> @@ -34,16 +34,21 @@ enum ltc294x_reg {=0A=
>  	LTC294X_REG_CONTROL		=3D 0x01,=0A=
>  	LTC294X_REG_ACC_CHARGE_MSB	=3D 0x02,=0A=
>  	LTC294X_REG_ACC_CHARGE_LSB	=3D 0x03,=0A=
> -	LTC294X_REG_THRESH_HIGH_MSB	=3D 0x04,=0A=
> -	LTC294X_REG_THRESH_HIGH_LSB	=3D 0x05,=0A=
> -	LTC294X_REG_THRESH_LOW_MSB	=3D 0x06,=0A=
> -	LTC294X_REG_THRESH_LOW_LSB	=3D 0x07,=0A=
> -	LTC294X_REG_VOLTAGE_MSB	=3D 0x08,=0A=
> -	LTC294X_REG_VOLTAGE_LSB	=3D 0x09,=0A=
> -	LTC294X_REG_CURRENT_MSB	=3D 0x0E,=0A=
> -	LTC294X_REG_CURRENT_LSB	=3D 0x0F,=0A=
> -	LTC294X_REG_TEMPERATURE_MSB	=3D 0x14,=0A=
> -	LTC294X_REG_TEMPERATURE_LSB	=3D 0x15,=0A=
> +	LTC294X_REG_VOLTAGE_MSB		=3D 0x08,=0A=
> +	LTC294X_REG_VOLTAGE_LSB		=3D 0x09,=0A=
> +	LTC2942_REG_TEMPERATURE_MSB	=3D 0x0C,=0A=
> +	LTC2942_REG_TEMPERATURE_LSB	=3D 0x0D,=0A=
> +	LTC2943_REG_CURRENT_MSB		=3D 0x0E,=0A=
> +	LTC2943_REG_CURRENT_LSB		=3D 0x0F,=0A=
> +	LTC2943_REG_TEMPERATURE_MSB	=3D 0x14,=0A=
> +	LTC2943_REG_TEMPERATURE_LSB	=3D 0x15,=0A=
> +};=0A=
> +=0A=
> +enum ltc294x_id {=0A=
> +	LTC2941_ID,=0A=
> +	LTC2942_ID,=0A=
> +	LTC2943_ID,=0A=
> +	LTC2944_ID,=0A=
>  };=0A=
=0A=
Since v6 is required because of the bug present in [PATCH v5 3/3], I would =
not define here LTC2942_ID=0A=
and LTC2944_ID. They should be defined only when the support for these two =
parts is added (part 2 and=0A=
part 3 of the patch).=0A=
=0A=
>  =0A=
>  #define LTC2943_REG_CONTROL_MODE_MASK (BIT(7) | BIT(6))=0A=
> @@ -54,15 +59,12 @@ enum ltc294x_reg {=0A=
>  	((x << 3) & LTC294X_REG_CONTROL_PRESCALER_MASK)=0A=
>  #define LTC294X_REG_CONTROL_ALCC_CONFIG_DISABLED	0=0A=
>  =0A=
> -#define LTC2941_NUM_REGS	0x08=0A=
> -#define LTC2943_NUM_REGS	0x18=0A=
> -=0A=
>  struct ltc294x_info {=0A=
>  	struct i2c_client *client;	/* I2C Client pointer */=0A=
>  	struct power_supply *supply;	/* Supply pointer */=0A=
>  	struct power_supply_desc supply_desc;	/* Supply description */=0A=
>  	struct delayed_work work;	/* Work scheduler */=0A=
> -	unsigned long num_regs;	/* Number of registers (chip type) */=0A=
> +	enum ltc294x_id id;		/* Chip type */=0A=
>  	int charge;	/* Last charge register content */=0A=
>  	int r_sense;	/* mOhm */=0A=
>  	int Qlsb;	/* nAh */=0A=
> @@ -146,7 +148,7 @@ static int ltc294x_reset(const struct ltc294x_info *i=
nfo, int prescaler_exp)=0A=
>  	control =3D LTC294X_REG_CONTROL_PRESCALER_SET(prescaler_exp) |=0A=
>  				LTC294X_REG_CONTROL_ALCC_CONFIG_DISABLED;=0A=
>  	/* Put the 2943 into "monitor" mode, so it measures every 10 sec */=0A=
> -	if (info->num_regs =3D=3D LTC2943_NUM_REGS)=0A=
> +	if (info->id =3D=3D LTC2941_ID)=0A=
>  		control |=3D LTC2943_REG_CONTROL_MODE_SCAN;=0A=
>  =0A=
>  	if (value !=3D control) {=0A=
> @@ -263,7 +265,7 @@ static int ltc294x_get_current(const struct ltc294x_i=
nfo *info, int *val)=0A=
>  	s32 value;=0A=
>  =0A=
>  	ret =3D ltc294x_read_regs(info->client,=0A=
> -		LTC294X_REG_CURRENT_MSB, &datar[0], 2);=0A=
> +		LTC2943_REG_CURRENT_MSB, &datar[0], 2);=0A=
>  	value =3D (datar[0] << 8) | datar[1];=0A=
>  	value -=3D 0x7FFF;=0A=
>  	/* Value is in range -32k..+32k, r_sense is usually 10..50 mOhm,=0A=
> @@ -280,7 +282,7 @@ static int ltc294x_get_temperature(const struct ltc29=
4x_info *info, int *val)=0A=
>  	u32 value;=0A=
>  =0A=
>  	ret =3D ltc294x_read_regs(info->client,=0A=
> -		LTC294X_REG_TEMPERATURE_MSB, &datar[0], 2);=0A=
> +		LTC2943_REG_TEMPERATURE_MSB, &datar[0], 2);=0A=
>  	value =3D (datar[0] << 8) | datar[1];=0A=
>  	/* Full-scale is 510 Kelvin, convert to centidegrees  */=0A=
>  	*val =3D (((51000 * value) / 0xFFFF) - 27215);=0A=
> @@ -357,8 +359,8 @@ static enum power_supply_property ltc294x_properties[=
] =3D {=0A=
>  	POWER_SUPPLY_PROP_CHARGE_COUNTER,=0A=
>  	POWER_SUPPLY_PROP_CHARGE_NOW,=0A=
>  	POWER_SUPPLY_PROP_VOLTAGE_NOW,=0A=
> -	POWER_SUPPLY_PROP_CURRENT_NOW,=0A=
>  	POWER_SUPPLY_PROP_TEMP,=0A=
> +	POWER_SUPPLY_PROP_CURRENT_NOW,=0A=
>  };=0A=
>  =0A=
>  static int ltc294x_i2c_remove(struct i2c_client *client)=0A=
> @@ -388,7 +390,7 @@ static int ltc294x_i2c_probe(struct i2c_client *clien=
t,=0A=
>  =0A=
>  	np =3D of_node_get(client->dev.of_node);=0A=
>  =0A=
> -	info->num_regs =3D (unsigned long)of_device_get_match_data(&client->dev=
);=0A=
> +	info->id =3D (enum ltc294x_id)of_device_get_match_data(&client->dev);=
=0A=
>  	info->supply_desc.name =3D np->name;=0A=
>  =0A=
>  	/* r_sense can be negative, when sense+ is connected to the battery=0A=
> @@ -409,7 +411,7 @@ static int ltc294x_i2c_probe(struct i2c_client *clien=
t,=0A=
>  		prescaler_exp =3D LTC2941_MAX_PRESCALER_EXP;=0A=
>  	}=0A=
>  =0A=
> -	if (info->num_regs =3D=3D LTC2943_NUM_REGS) {=0A=
> +	if (info->id =3D=3D LTC2943_ID) {=0A=
>  		if (prescaler_exp > LTC2943_MAX_PRESCALER_EXP)=0A=
>  			prescaler_exp =3D LTC2943_MAX_PRESCALER_EXP;=0A=
>  		info->Qlsb =3D ((340 * 50000) / r_sense) /=0A=
> @@ -424,18 +426,22 @@ static int ltc294x_i2c_probe(struct i2c_client *cli=
ent,=0A=
>  	info->client =3D client;=0A=
>  	info->supply_desc.type =3D POWER_SUPPLY_TYPE_BATTERY;=0A=
>  	info->supply_desc.properties =3D ltc294x_properties;=0A=
> -	if (info->num_regs >=3D LTC294X_REG_TEMPERATURE_LSB)=0A=
> +	switch (info->id) {=0A=
> +	case LTC2944_ID:=0A=
=0A=
Same comment as above.=0A=
=0A=
> +	case LTC2943_ID:=0A=
>  		info->supply_desc.num_properties =3D=0A=
>  			ARRAY_SIZE(ltc294x_properties);=0A=
> -	else if (info->num_regs >=3D LTC294X_REG_CURRENT_LSB)=0A=
> +		break;=0A=
> +	case LTC2942_ID:=0A=
=0A=
Same comment as above.=0A=
=0A=
>  		info->supply_desc.num_properties =3D=0A=
>  			ARRAY_SIZE(ltc294x_properties) - 1;=0A=
> -	else if (info->num_regs >=3D LTC294X_REG_VOLTAGE_LSB)=0A=
> -		info->supply_desc.num_properties =3D=0A=
> -			ARRAY_SIZE(ltc294x_properties) - 2;=0A=
> -	else=0A=
> +		break;=0A=
> +	case LTC2941_ID:=0A=
> +	default:=0A=
>  		info->supply_desc.num_properties =3D=0A=
>  			ARRAY_SIZE(ltc294x_properties) - 3;=0A=
> +		break;=0A=
> +	}=0A=
>  	info->supply_desc.get_property =3D ltc294x_get_property;=0A=
>  	info->supply_desc.set_property =3D ltc294x_set_property;=0A=
>  	info->supply_desc.property_is_writeable =3D ltc294x_property_is_writeab=
le;=0A=
> @@ -492,8 +498,8 @@ static SIMPLE_DEV_PM_OPS(ltc294x_pm_ops, ltc294x_susp=
end, ltc294x_resume);=0A=
>  =0A=
>  =0A=
>  static const struct i2c_device_id ltc294x_i2c_id[] =3D {=0A=
> -	{"ltc2941", LTC2941_NUM_REGS},=0A=
> -	{"ltc2943", LTC2943_NUM_REGS},=0A=
> +	{ "ltc2941", LTC2941_ID, },=0A=
> +	{ "ltc2943", LTC2943_ID, },=0A=
>  	{ },=0A=
>  };=0A=
>  MODULE_DEVICE_TABLE(i2c, ltc294x_i2c_id);=0A=
> @@ -501,11 +507,11 @@ MODULE_DEVICE_TABLE(i2c, ltc294x_i2c_id);=0A=
>  static const struct of_device_id ltc294x_i2c_of_match[] =3D {=0A=
>  	{=0A=
>  		.compatible =3D "lltc,ltc2941",=0A=
> -		.data =3D (void *)LTC2941_NUM_REGS=0A=
> +		.data =3D (void *)LTC2941_ID,=0A=
>  	},=0A=
>  	{=0A=
>  		.compatible =3D "lltc,ltc2943",=0A=
> -		.data =3D (void *)LTC2943_NUM_REGS=0A=
> +		.data =3D (void *)LTC2943_ID,=0A=
>  	},=0A=
>  	{ },=0A=
>  };=0A=
=0A=
=0A=
