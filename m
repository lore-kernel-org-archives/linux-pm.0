From: "Bogdan, Dragos" <Dragos.Bogdan-OyLXuOCK7orQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH v6 2/3] power: supply: ltc2941-battery-gauge: Add
 LTC2942 support
Date: Mon, 17 Jul 2017 14:53:57 +0000
Message-ID: <6067964B99C6A049AA5840B6F7BB2D0ABDAAD954@NWD2MBX5.ad.analog.com>
References: <20170716093202.vfea4yylbzfec72v@lenoch>
 <20170716093400.5l52et24ojux5hj4@lenoch>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Language: en-US
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Ladislav Michl <ladis-6z/3iImG2C8G8FEW9MqTrA@public.gmane.org>, "linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Cc: Mike Looijmans <mike.looijmans-Oq418RWZeHk@public.gmane.org>, Javier Martinez Canillas <javier-JPH+aEBZ4P+UEJcrhfAQsw@public.gmane.org>, Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

On 07/16/2017 12:34 PM, Ladislav Michl wrote:=0A=
> LTC2942 is pin compatible with LTC2941 providing additional=0A=
> informations about battery voltage and temperature. It can=0A=
> be runtime detected using bit A7 in the Status register.=0A=
>=0A=
> Signed-off-by: Ladislav Michl <ladis-6z/3iImG2C8G8FEW9MqTrA@public.gmane.org>=0A=
> Acked-by: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>=0A=
=0A=
Acked-by: Dragos Bogdan <dragos.bogdan-OyLXuOCK7orQT0dZR+AlfA@public.gmane.org>=0A=
Tested-by: Dragos Bogdan <dragos.bogdan-OyLXuOCK7orQT0dZR+AlfA@public.gmane.org>=0A=
=0A=
> ---=0A=
>  Changes:=0A=
>  - v2: reworked voltage computing to not overflow and keep presision=0A=
>  - v3: update devicetree binding documentation=0A=
>  - v4: add ltc2942 devicetree compatible=0A=
>  - v5: make use of info->id introduced in previous patch=0A=
>  - v6: collect devicetree ack from Rob=0A=
>=0A=
>  .../devicetree/bindings/power/supply/ltc2941.txt   | 15 ++--=0A=
>  drivers/power/supply/ltc2941-battery-gauge.c       | 80 ++++++++++++++++=
++----=0A=
>  2 files changed, 75 insertions(+), 20 deletions(-)=0A=
>=0A=
> diff --git a/Documentation/devicetree/bindings/power/supply/ltc2941.txt b=
/Documentation/devicetree/bindings/power/supply/ltc2941.txt=0A=
> index a9d7aa60558b..8ec10366295d 100644=0A=
> --- a/Documentation/devicetree/bindings/power/supply/ltc2941.txt=0A=
> +++ b/Documentation/devicetree/bindings/power/supply/ltc2941.txt=0A=
> @@ -1,13 +1,14 @@=0A=
> -binding for LTC2941 and LTC2943 battery gauges=0A=
> +binding for LTC2941, LTC2942 and LTC2943 battery gauges=0A=
>  =0A=
> -Both the LTC2941 and LTC2943 measure battery capacity.=0A=
> -The LTC2943 is compatible with the LTC2941, it adds voltage and=0A=
> -temperature monitoring, and uses a slightly different conversion=0A=
> -formula for the charge counter.=0A=
> +All chips measure battery capacity.=0A=
> +The LTC2942 is pin compatible with the LTC2941, it adds voltage and=0A=
> +temperature monitoring, and is runtime detected. LTC2943 is software=0A=
> +compatible, uses a slightly different conversion formula for the=0A=
> +charge counter and adds voltage, current and temperature monitoring.=0A=
>  =0A=
>  Required properties:=0A=
> -- compatible: Should contain "lltc,ltc2941" or "lltc,ltc2943" which also=
=0A=
> -    indicates the type of I2C chip attached.=0A=
> +- compatible: Should contain "lltc,ltc2941", "lltc,ltc2942" or "lltc,ltc=
2943"=0A=
> +    which also indicates the type of I2C chip attached.=0A=
>  - reg: The 7-bit I2C address.=0A=
>  - lltc,resistor-sense: The sense resistor value in milli-ohms. Can be a =
32-bit=0A=
>      negative value when the battery has been connected to the wrong end =
of the=0A=
> diff --git a/drivers/power/supply/ltc2941-battery-gauge.c b/drivers/power=
/supply/ltc2941-battery-gauge.c=0A=
> index b0de448a226b..42ff4e3daf35 100644=0A=
> --- a/drivers/power/supply/ltc2941-battery-gauge.c=0A=
> +++ b/drivers/power/supply/ltc2941-battery-gauge.c=0A=
> @@ -1,5 +1,5 @@=0A=
>  /*=0A=
> - * I2C client/driver for the Linear Technology LTC2941 and LTC2943=0A=
> + * I2C client/driver for the Linear Technology LTC2941, LTC2942 and LTC2=
943=0A=
>   * Battery Gas Gauge IC=0A=
>   *=0A=
>   * Copyright (C) 2014 Topic Embedded Systems=0A=
> @@ -46,11 +46,14 @@ enum ltc294x_reg {=0A=
>  =0A=
>  enum ltc294x_id {=0A=
>  	LTC2941_ID,=0A=
> +	LTC2942_ID,=0A=
>  	LTC2943_ID,=0A=
>  };=0A=
>  =0A=
> -#define LTC2943_REG_CONTROL_MODE_MASK (BIT(7) | BIT(6))=0A=
> -#define LTC2943_REG_CONTROL_MODE_SCAN BIT(7)=0A=
> +#define LTC2941_REG_STATUS_CHIP_ID	BIT(7)=0A=
> +=0A=
> +#define LTC2942_REG_CONTROL_MODE_SCAN	(BIT(7) | BIT(6))=0A=
> +#define LTC2943_REG_CONTROL_MODE_SCAN	BIT(7)=0A=
>  #define LTC294X_REG_CONTROL_PRESCALER_MASK	(BIT(5) | BIT(4) | BIT(3))=0A=
>  #define LTC294X_REG_CONTROL_SHUTDOWN_MASK	(BIT(0))=0A=
>  #define LTC294X_REG_CONTROL_PRESCALER_SET(x) \=0A=
> @@ -145,9 +148,17 @@ static int ltc294x_reset(const struct ltc294x_info *=
info, int prescaler_exp)=0A=
>  =0A=
>  	control =3D LTC294X_REG_CONTROL_PRESCALER_SET(prescaler_exp) |=0A=
>  				LTC294X_REG_CONTROL_ALCC_CONFIG_DISABLED;=0A=
> -	/* Put the 2943 into "monitor" mode, so it measures every 10 sec */=0A=
> -	if (info->id =3D=3D LTC2941_ID)=0A=
> +	/* Put device into "monitor" mode */=0A=
> +	switch (info->id) {=0A=
> +	case LTC2942_ID:	/* 2942 measures every 2 sec */=0A=
> +		control |=3D LTC2942_REG_CONTROL_MODE_SCAN;=0A=
> +		break;=0A=
> +	case LTC2943_ID:	/* 2943 measures every 10 sec */=0A=
>  		control |=3D LTC2943_REG_CONTROL_MODE_SCAN;=0A=
> +		break;=0A=
> +	default:=0A=
> +		break;=0A=
> +	}=0A=
>  =0A=
>  	if (value !=3D control) {=0A=
>  		ret =3D ltc294x_write_regs(info->client,=0A=
> @@ -252,7 +263,19 @@ static int ltc294x_get_voltage(const struct ltc294x_=
info *info, int *val)=0A=
>  	ret =3D ltc294x_read_regs(info->client,=0A=
>  		LTC294X_REG_VOLTAGE_MSB, &datar[0], 2);=0A=
>  	value =3D (datar[0] << 8) | datar[1];=0A=
> -	*val =3D ((value * 23600) / 0xFFFF) * 1000; /* in uV */=0A=
> +	switch (info->id) {=0A=
> +	case LTC2943_ID:=0A=
> +		value *=3D 23600 * 2;=0A=
> +		value /=3D 0xFFFF;=0A=
> +		value *=3D 1000 / 2;=0A=
> +		break;=0A=
> +	default:=0A=
> +		value *=3D 6000 * 10;=0A=
> +		value /=3D 0xFFFF;=0A=
> +		value *=3D 1000 / 10;=0A=
> +		break;=0A=
> +	}=0A=
> +	*val =3D value;=0A=
>  	return ret;=0A=
>  }=0A=
>  =0A=
> @@ -275,15 +298,22 @@ static int ltc294x_get_current(const struct ltc294x=
_info *info, int *val)=0A=
>  =0A=
>  static int ltc294x_get_temperature(const struct ltc294x_info *info, int =
*val)=0A=
>  {=0A=
> +	enum ltc294x_reg reg;=0A=
>  	int ret;=0A=
>  	u8 datar[2];=0A=
>  	u32 value;=0A=
>  =0A=
> -	ret =3D ltc294x_read_regs(info->client,=0A=
> -		LTC2943_REG_TEMPERATURE_MSB, &datar[0], 2);=0A=
> -	value =3D (datar[0] << 8) | datar[1];=0A=
> -	/* Full-scale is 510 Kelvin, convert to centidegrees  */=0A=
> -	*val =3D (((51000 * value) / 0xFFFF) - 27215);=0A=
> +	if (info->id =3D=3D LTC2942_ID) {=0A=
> +		reg =3D LTC2942_REG_TEMPERATURE_MSB;=0A=
> +		value =3D 60000;	/* Full-scale is 600 Kelvin */=0A=
> +	} else {=0A=
> +		reg =3D LTC2943_REG_TEMPERATURE_MSB;=0A=
> +		value =3D 51000;	/* Full-scale is 510 Kelvin */=0A=
> +	}=0A=
> +	ret =3D ltc294x_read_regs(info->client, reg, &datar[0], 2);=0A=
> +	value *=3D (datar[0] << 8) | datar[1];=0A=
> +	/* Convert to centidegrees  */=0A=
> +	*val =3D value / 0xFFFF - 27215;=0A=
>  	return ret;=0A=
>  }=0A=
>  =0A=
> @@ -375,10 +405,11 @@ static int ltc294x_i2c_probe(struct i2c_client *cli=
ent,=0A=
>  {=0A=
>  	struct power_supply_config psy_cfg =3D {};=0A=
>  	struct ltc294x_info *info;=0A=
> +	struct device_node *np;=0A=
>  	int ret;=0A=
>  	u32 prescaler_exp;=0A=
>  	s32 r_sense;=0A=
> -	struct device_node *np;=0A=
> +	u8 status;=0A=
>  =0A=
>  	info =3D devm_kzalloc(&client->dev, sizeof(*info), GFP_KERNEL);=0A=
>  	if (info =3D=3D NULL)=0A=
> @@ -421,6 +452,20 @@ static int ltc294x_i2c_probe(struct i2c_client *clie=
nt,=0A=
>  				(128 / (1 << prescaler_exp));=0A=
>  	}=0A=
>  =0A=
> +	/* Read status register to check for LTC2942 */=0A=
> +	if (info->id =3D=3D LTC2941_ID || info->id =3D=3D LTC2942_ID) {=0A=
> +		ret =3D ltc294x_read_regs(client, LTC294X_REG_STATUS, &status, 1);=0A=
> +		if (ret < 0) {=0A=
> +			dev_err(&client->dev,=0A=
> +				"Could not read status register\n");=0A=
> +			return ret;=0A=
> +		}=0A=
> +		if (status & LTC2941_REG_STATUS_CHIP_ID)=0A=
> +			info->id =3D LTC2941_ID;=0A=
> +		else=0A=
> +			info->id =3D LTC2942_ID;=0A=
> +	}=0A=
> +=0A=
>  	info->client =3D client;=0A=
>  	info->supply_desc.type =3D POWER_SUPPLY_TYPE_BATTERY;=0A=
>  	info->supply_desc.properties =3D ltc294x_properties;=0A=
> @@ -429,6 +474,10 @@ static int ltc294x_i2c_probe(struct i2c_client *clie=
nt,=0A=
>  		info->supply_desc.num_properties =3D=0A=
>  			ARRAY_SIZE(ltc294x_properties);=0A=
>  		break;=0A=
> +	case LTC2942_ID:=0A=
> +		info->supply_desc.num_properties =3D=0A=
> +			ARRAY_SIZE(ltc294x_properties) - 1;=0A=
> +		break;=0A=
>  	case LTC2941_ID:=0A=
>  	default:=0A=
>  		info->supply_desc.num_properties =3D=0A=
> @@ -492,6 +541,7 @@ static SIMPLE_DEV_PM_OPS(ltc294x_pm_ops, ltc294x_susp=
end, ltc294x_resume);=0A=
>  =0A=
>  static const struct i2c_device_id ltc294x_i2c_id[] =3D {=0A=
>  	{ "ltc2941", LTC2941_ID, },=0A=
> +	{ "ltc2942", LTC2942_ID, },=0A=
>  	{ "ltc2943", LTC2943_ID, },=0A=
>  	{ },=0A=
>  };=0A=
> @@ -503,6 +553,10 @@ static const struct of_device_id ltc294x_i2c_of_matc=
h[] =3D {=0A=
>  		.data =3D (void *)LTC2941_ID,=0A=
>  	},=0A=
>  	{=0A=
> +		.compatible =3D "lltc,ltc2942",=0A=
> +		.data =3D (void *)LTC2942_ID,=0A=
> +	},=0A=
> +	{=0A=
>  		.compatible =3D "lltc,ltc2943",=0A=
>  		.data =3D (void *)LTC2943_ID,=0A=
>  	},=0A=
> @@ -524,5 +578,5 @@ module_i2c_driver(ltc294x_driver);=0A=
>  =0A=
>  MODULE_AUTHOR("Auryn Verwegen, Topic Embedded Systems");=0A=
>  MODULE_AUTHOR("Mike Looijmans, Topic Embedded Products");=0A=
> -MODULE_DESCRIPTION("LTC2941/LTC2943 Battery Gas Gauge IC driver");=0A=
> +MODULE_DESCRIPTION("LTC2941/LTC2942/LTC2943 Battery Gas Gauge IC driver"=
);=0A=
>  MODULE_LICENSE("GPL");=0A=
=0A=
=0A=
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
