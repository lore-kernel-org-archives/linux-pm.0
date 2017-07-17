From: "Bogdan, Dragos" <Dragos.Bogdan-OyLXuOCK7orQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH v6 1/3] power: supply: ltc2941-battery-gauge: Prepare
 for LTC2942 and LTC2944
Date: Mon, 17 Jul 2017 14:52:42 +0000
Message-ID: <6067964B99C6A049AA5840B6F7BB2D0ABDAAD93C@NWD2MBX5.ad.analog.com>
References: <20170716093202.vfea4yylbzfec72v@lenoch>
 <20170716093306.vz4xw7ij7dptzkot@lenoch>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Language: en-US
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Ladislav Michl <ladis-6z/3iImG2C8G8FEW9MqTrA@public.gmane.org>, "linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Cc: Mike Looijmans <mike.looijmans-Oq418RWZeHk@public.gmane.org>, Javier Martinez Canillas <javier-JPH+aEBZ4P+UEJcrhfAQsw@public.gmane.org>, Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

On 07/16/2017 12:33 PM, Ladislav Michl wrote:=0A=
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
> Signed-off-by: Ladislav Michl <ladis-6z/3iImG2C8G8FEW9MqTrA@public.gmane.org>=0A=
=0A=
Acked-by: Dragos Bogdan <dragos.bogdan-OyLXuOCK7orQT0dZR+AlfA@public.gmane.org>=0A=
Tested-by: Dragos Bogdan <dragos.bogdan-OyLXuOCK7orQT0dZR+AlfA@public.gmane.org>=0A=
=0A=
> ---=0A=
>  Changes:=0A=
>  - v2: None=0A=
>  - v3: Extend commit message=0A=
>  - v4: None=0A=
>  - v5: Count on LTC2944 too=0A=
>  - v6: Move LTC2942 and LTC2944 to respective patches=0A=
>=0A=
>  drivers/power/supply/ltc2941-battery-gauge.c | 63 ++++++++++++++--------=
------=0A=
>  1 file changed, 31 insertions(+), 32 deletions(-)=0A=
>=0A=
> diff --git a/drivers/power/supply/ltc2941-battery-gauge.c b/drivers/power=
/supply/ltc2941-battery-gauge.c=0A=
> index 7efb908f4451..b0de448a226b 100644=0A=
> --- a/drivers/power/supply/ltc2941-battery-gauge.c=0A=
> +++ b/drivers/power/supply/ltc2941-battery-gauge.c=0A=
> @@ -34,16 +34,19 @@ enum ltc294x_reg {=0A=
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
> +	LTC2943_ID,=0A=
>  };=0A=
>  =0A=
>  #define LTC2943_REG_CONTROL_MODE_MASK (BIT(7) | BIT(6))=0A=
> @@ -54,15 +57,12 @@ enum ltc294x_reg {=0A=
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
> @@ -146,7 +146,7 @@ static int ltc294x_reset(const struct ltc294x_info *i=
nfo, int prescaler_exp)=0A=
>  	control =3D LTC294X_REG_CONTROL_PRESCALER_SET(prescaler_exp) |=0A=
>  				LTC294X_REG_CONTROL_ALCC_CONFIG_DISABLED;=0A=
>  	/* Put the 2943 into "monitor" mode, so it measures every 10 sec */=0A=
> -	if (info->num_regs =3D=3D LTC2943_NUM_REGS)=0A=
> +	if (info->id =3D=3D LTC2941_ID)=0A=
>  		control |=3D LTC2943_REG_CONTROL_MODE_SCAN;=0A=
>  =0A=
>  	if (value !=3D control) {=0A=
> @@ -263,7 +263,7 @@ static int ltc294x_get_current(const struct ltc294x_i=
nfo *info, int *val)=0A=
>  	s32 value;=0A=
>  =0A=
>  	ret =3D ltc294x_read_regs(info->client,=0A=
> -		LTC294X_REG_CURRENT_MSB, &datar[0], 2);=0A=
> +		LTC2943_REG_CURRENT_MSB, &datar[0], 2);=0A=
>  	value =3D (datar[0] << 8) | datar[1];=0A=
>  	value -=3D 0x7FFF;=0A=
>  	/* Value is in range -32k..+32k, r_sense is usually 10..50 mOhm,=0A=
> @@ -280,7 +280,7 @@ static int ltc294x_get_temperature(const struct ltc29=
4x_info *info, int *val)=0A=
>  	u32 value;=0A=
>  =0A=
>  	ret =3D ltc294x_read_regs(info->client,=0A=
> -		LTC294X_REG_TEMPERATURE_MSB, &datar[0], 2);=0A=
> +		LTC2943_REG_TEMPERATURE_MSB, &datar[0], 2);=0A=
>  	value =3D (datar[0] << 8) | datar[1];=0A=
>  	/* Full-scale is 510 Kelvin, convert to centidegrees  */=0A=
>  	*val =3D (((51000 * value) / 0xFFFF) - 27215);=0A=
> @@ -357,8 +357,8 @@ static enum power_supply_property ltc294x_properties[=
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
> @@ -388,7 +388,7 @@ static int ltc294x_i2c_probe(struct i2c_client *clien=
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
> @@ -409,7 +409,7 @@ static int ltc294x_i2c_probe(struct i2c_client *clien=
t,=0A=
>  		prescaler_exp =3D LTC2941_MAX_PRESCALER_EXP;=0A=
>  	}=0A=
>  =0A=
> -	if (info->num_regs =3D=3D LTC2943_NUM_REGS) {=0A=
> +	if (info->id =3D=3D LTC2943_ID) {=0A=
>  		if (prescaler_exp > LTC2943_MAX_PRESCALER_EXP)=0A=
>  			prescaler_exp =3D LTC2943_MAX_PRESCALER_EXP;=0A=
>  		info->Qlsb =3D ((340 * 50000) / r_sense) /=0A=
> @@ -424,18 +424,17 @@ static int ltc294x_i2c_probe(struct i2c_client *cli=
ent,=0A=
>  	info->client =3D client;=0A=
>  	info->supply_desc.type =3D POWER_SUPPLY_TYPE_BATTERY;=0A=
>  	info->supply_desc.properties =3D ltc294x_properties;=0A=
> -	if (info->num_regs >=3D LTC294X_REG_TEMPERATURE_LSB)=0A=
> +	switch (info->id) {=0A=
> +	case LTC2943_ID:=0A=
>  		info->supply_desc.num_properties =3D=0A=
>  			ARRAY_SIZE(ltc294x_properties);=0A=
> -	else if (info->num_regs >=3D LTC294X_REG_CURRENT_LSB)=0A=
> -		info->supply_desc.num_properties =3D=0A=
> -			ARRAY_SIZE(ltc294x_properties) - 1;=0A=
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
> @@ -492,8 +491,8 @@ static SIMPLE_DEV_PM_OPS(ltc294x_pm_ops, ltc294x_susp=
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
> @@ -501,11 +500,11 @@ MODULE_DEVICE_TABLE(i2c, ltc294x_i2c_id);=0A=
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
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
