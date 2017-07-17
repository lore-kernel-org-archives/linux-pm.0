From: "Bogdan, Dragos" <Dragos.Bogdan-OyLXuOCK7orQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH v6 3/3] power: supply: ltc2941-battery-gauge: Add
 LTC2944 support
Date: Mon, 17 Jul 2017 14:55:20 +0000
Message-ID: <6067964B99C6A049AA5840B6F7BB2D0ABDAAD96B@NWD2MBX5.ad.analog.com>
References: <20170716093202.vfea4yylbzfec72v@lenoch>
 <20170716093532.w6sqqtadwnbroj3i@lenoch>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Language: en-US
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Ladislav Michl <ladis-6z/3iImG2C8G8FEW9MqTrA@public.gmane.org>, "linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Cc: Mike Looijmans <mike.looijmans-Oq418RWZeHk@public.gmane.org>, Javier Martinez Canillas <javier-JPH+aEBZ4P+UEJcrhfAQsw@public.gmane.org>, Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

On 07/16/2017 12:35 PM, Ladislav Michl wrote:=0A=
> From: Dragos Bogdan <dragos.bogdan-OyLXuOCK7orQT0dZR+AlfA@public.gmane.org>=0A=
>=0A=
> LTC2944 is compatible with LTC2943, but uses different=0A=
> voltage and current computing constants.=0A=
>=0A=
> Signed-off-by: Dragos Bogdan <dragos.bogdan-OyLXuOCK7orQT0dZR+AlfA@public.gmane.org>=0A=
> Signed-off-by: Ladislav Michl <ladis-6z/3iImG2C8G8FEW9MqTrA@public.gmane.org>=0A=
=0A=
Tested-by: Dragos Bogdan <dragos.bogdan-OyLXuOCK7orQT0dZR+AlfA@public.gmane.org>=0A=
=0A=
> ---=0A=
>  Changes:=0A=
>  - v2: fixed voltage and current conversion=0A=
>  - v3: skipped=0A=
>  - v4: skipped=0A=
>  - v5: fixed voltage conversion overflow, rebased on LTC2942 patchset=0A=
>  - v6: fix missing break in the switch statement=0A=
>=0A=
>  .../devicetree/bindings/power/supply/ltc2941.txt   | 12 +++++-----=0A=
>  drivers/power/supply/ltc2941-battery-gauge.c       | 27 ++++++++++++++++=
++----=0A=
>  2 files changed, 28 insertions(+), 11 deletions(-)=0A=
>=0A=
> diff --git a/Documentation/devicetree/bindings/power/supply/ltc2941.txt b=
/Documentation/devicetree/bindings/power/supply/ltc2941.txt=0A=
> index 8ec10366295d..3b9ba147b041 100644=0A=
> --- a/Documentation/devicetree/bindings/power/supply/ltc2941.txt=0A=
> +++ b/Documentation/devicetree/bindings/power/supply/ltc2941.txt=0A=
> @@ -1,14 +1,14 @@=0A=
> -binding for LTC2941, LTC2942 and LTC2943 battery gauges=0A=
> +binding for LTC2941, LTC2942, LTC2943 and LTC2944 battery gauges=0A=
>  =0A=
>  All chips measure battery capacity.=0A=
>  The LTC2942 is pin compatible with the LTC2941, it adds voltage and=0A=
> -temperature monitoring, and is runtime detected. LTC2943 is software=0A=
> -compatible, uses a slightly different conversion formula for the=0A=
> -charge counter and adds voltage, current and temperature monitoring.=0A=
> +temperature monitoring, and is runtime detected. LTC2943 and LTC2944=0A=
> +is software compatible, uses a slightly different conversion formula=0A=
> +for the charge counter and adds voltage, current and temperature monitor=
ing.=0A=
>  =0A=
>  Required properties:=0A=
> -- compatible: Should contain "lltc,ltc2941", "lltc,ltc2942" or "lltc,ltc=
2943"=0A=
> -    which also indicates the type of I2C chip attached.=0A=
> +- compatible: Should contain "lltc,ltc2941", "lltc,ltc2942", "lltc,ltc29=
43"=0A=
> +    or "lltc,ltc2944" which also indicates the type of I2C chip attached=
.=0A=
>  - reg: The 7-bit I2C address.=0A=
>  - lltc,resistor-sense: The sense resistor value in milli-ohms. Can be a =
32-bit=0A=
>      negative value when the battery has been connected to the wrong end =
of the=0A=
> diff --git a/drivers/power/supply/ltc2941-battery-gauge.c b/drivers/power=
/supply/ltc2941-battery-gauge.c=0A=
> index 42ff4e3daf35..08e4fd9ee607 100644=0A=
> --- a/drivers/power/supply/ltc2941-battery-gauge.c=0A=
> +++ b/drivers/power/supply/ltc2941-battery-gauge.c=0A=
> @@ -1,6 +1,6 @@=0A=
>  /*=0A=
> - * I2C client/driver for the Linear Technology LTC2941, LTC2942 and LTC2=
943=0A=
> - * Battery Gas Gauge IC=0A=
> + * I2C client/driver for the Linear Technology LTC2941, LTC2942, LTC2943=
=0A=
> + * and LTC2944 Battery Gas Gauge IC=0A=
>   *=0A=
>   * Copyright (C) 2014 Topic Embedded Systems=0A=
>   *=0A=
> @@ -48,6 +48,7 @@ enum ltc294x_id {=0A=
>  	LTC2941_ID,=0A=
>  	LTC2942_ID,=0A=
>  	LTC2943_ID,=0A=
> +	LTC2944_ID,=0A=
>  };=0A=
>  =0A=
>  #define LTC2941_REG_STATUS_CHIP_ID	BIT(7)=0A=
> @@ -153,7 +154,8 @@ static int ltc294x_reset(const struct ltc294x_info *i=
nfo, int prescaler_exp)=0A=
>  	case LTC2942_ID:	/* 2942 measures every 2 sec */=0A=
>  		control |=3D LTC2942_REG_CONTROL_MODE_SCAN;=0A=
>  		break;=0A=
> -	case LTC2943_ID:	/* 2943 measures every 10 sec */=0A=
> +	case LTC2943_ID:=0A=
> +	case LTC2944_ID:	/* 2943 and 2944 measure every 10 sec */=0A=
>  		control |=3D LTC2943_REG_CONTROL_MODE_SCAN;=0A=
>  		break;=0A=
>  	default:=0A=
> @@ -269,6 +271,11 @@ static int ltc294x_get_voltage(const struct ltc294x_=
info *info, int *val)=0A=
>  		value /=3D 0xFFFF;=0A=
>  		value *=3D 1000 / 2;=0A=
>  		break;=0A=
> +	case LTC2944_ID:=0A=
> +		value *=3D 70800 / 5*4;=0A=
> +		value /=3D 0xFFFF;=0A=
> +		value *=3D 1000 * 5/4;=0A=
> +		break;=0A=
>  	default:=0A=
>  		value *=3D 6000 * 10;=0A=
>  		value /=3D 0xFFFF;=0A=
> @@ -289,10 +296,14 @@ static int ltc294x_get_current(const struct ltc294x=
_info *info, int *val)=0A=
>  		LTC2943_REG_CURRENT_MSB, &datar[0], 2);=0A=
>  	value =3D (datar[0] << 8) | datar[1];=0A=
>  	value -=3D 0x7FFF;=0A=
> +	if (info->id =3D=3D LTC2944_ID)=0A=
> +		value *=3D 64000;=0A=
> +	else=0A=
> +		value *=3D 60000;=0A=
>  	/* Value is in range -32k..+32k, r_sense is usually 10..50 mOhm,=0A=
>  	 * the formula below keeps everything in s32 range while preserving=0A=
>  	 * enough digits */=0A=
> -	*val =3D 1000 * ((60000 * value) / (info->r_sense * 0x7FFF)); /* in uA =
*/=0A=
> +	*val =3D 1000 * (value / (info->r_sense * 0x7FFF)); /* in uA */=0A=
>  	return ret;=0A=
>  }=0A=
>  =0A=
> @@ -470,6 +481,7 @@ static int ltc294x_i2c_probe(struct i2c_client *clien=
t,=0A=
>  	info->supply_desc.type =3D POWER_SUPPLY_TYPE_BATTERY;=0A=
>  	info->supply_desc.properties =3D ltc294x_properties;=0A=
>  	switch (info->id) {=0A=
> +	case LTC2944_ID:=0A=
>  	case LTC2943_ID:=0A=
>  		info->supply_desc.num_properties =3D=0A=
>  			ARRAY_SIZE(ltc294x_properties);=0A=
> @@ -543,6 +555,7 @@ static const struct i2c_device_id ltc294x_i2c_id[] =
=3D {=0A=
>  	{ "ltc2941", LTC2941_ID, },=0A=
>  	{ "ltc2942", LTC2942_ID, },=0A=
>  	{ "ltc2943", LTC2943_ID, },=0A=
> +	{ "ltc2944", LTC2944_ID, },=0A=
>  	{ },=0A=
>  };=0A=
>  MODULE_DEVICE_TABLE(i2c, ltc294x_i2c_id);=0A=
> @@ -560,6 +573,10 @@ static const struct of_device_id ltc294x_i2c_of_matc=
h[] =3D {=0A=
>  		.compatible =3D "lltc,ltc2943",=0A=
>  		.data =3D (void *)LTC2943_ID,=0A=
>  	},=0A=
> +	{=0A=
> +		.compatible =3D "lltc,ltc2944",=0A=
> +		.data =3D (void *)LTC2944_ID,=0A=
> +	},=0A=
>  	{ },=0A=
>  };=0A=
>  MODULE_DEVICE_TABLE(of, ltc294x_i2c_of_match);=0A=
> @@ -578,5 +595,5 @@ module_i2c_driver(ltc294x_driver);=0A=
>  =0A=
>  MODULE_AUTHOR("Auryn Verwegen, Topic Embedded Systems");=0A=
>  MODULE_AUTHOR("Mike Looijmans, Topic Embedded Products");=0A=
> -MODULE_DESCRIPTION("LTC2941/LTC2942/LTC2943 Battery Gas Gauge IC driver"=
);=0A=
> +MODULE_DESCRIPTION("LTC2941/LTC2942/LTC2943/LTC2944 Battery Gas Gauge IC=
 driver");=0A=
>  MODULE_LICENSE("GPL");=0A=
=0A=
=0A=
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
