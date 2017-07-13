From: "Bogdan, Dragos" <Dragos.Bogdan-OyLXuOCK7orQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH v2] power: supply: ltc2941-battery-gauge: Add LTC2944
 support
Date: Thu, 13 Jul 2017 15:24:39 +0000
Message-ID: <6067964B99C6A049AA5840B6F7BB2D0ABDAACEA4@NWD2MBX5.ad.analog.com>
References: <20170711160732.16170-1-dragos.bogdan@analog.com>
 <20170711205911.w6pp2kdaeo5iv2yo@lenoch>
 <20170711231156.mavruc6xsiv4gvla@lenoch>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Language: en-US
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Ladislav Michl <ladis-6z/3iImG2C8G8FEW9MqTrA@public.gmane.org>
Cc: Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Mike Looijmans <mike.looijmans-Oq418RWZeHk@public.gmane.org>, "linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

On 07/12/2017 02:12 AM, Ladislav Michl wrote:=0A=
> On Tue, Jul 11, 2017 at 10:59:11PM +0200, Ladislav Michl wrote:=0A=
>> On Tue, Jul 11, 2017 at 07:07:32PM +0300, Dragos Bogdan wrote:=0A=
>>> The only difference between the already supported LTC2943 and LTC2944 i=
s the operating range (3.6V - 20V compared to 3.6V - 60V).=0A=
>> Please wrap commit message correctly.=0A=
>>=0A=
>>> Signed-off-by: Dragos Bogdan <dragos.bogdan-OyLXuOCK7orQT0dZR+AlfA@public.gmane.org>=0A=
>>> ---=0A=
>>> Changes in v2:=0A=
>>> - Fix the voltage and current conversion.=0A=
>> That's better :-) However it conflicts with LTC2942 patch. I can fix=0A=
> Well, still not good enough. You overlooked different temperature=0A=
> computing formula. For a bug, see bellow.=0A=
=0A=
The Full-Scale Temperature is 510 K (as it is displayed in the Electrical=
=0A=
Characteristics section) for both LTC2943 and LTC2944 parts, so the same=0A=
computing formula is valid.=0A=
=0A=
For LTC2944, the 500 K value used in the Applications Information section=
=0A=
is an error that will be fixed in the next version of the datasheet.=0A=
=0A=
>=0A=
>> this and extend LTC2942 patch serie to add LTC2944. Okay to proceed=0A=
>> or do you want to take care about this yourself? Also it is nice to=0A=
> I'll provide patchset myself, it is mostly done now. I'd appreciate=0A=
> if you could test it on your device.=0A=
>=0A=
>> Cc driver author (done now).=0A=
>>=0A=
>> 	ladis=0A=
>>=0A=
>>>  .../devicetree/bindings/power/supply/ltc2941.txt   | 10 ++---=0A=
>>>  drivers/power/supply/ltc2941-battery-gauge.c       | 46 ++++++++++++++=
+++-----=0A=
>>>  2 files changed, 41 insertions(+), 15 deletions(-)=0A=
>>>=0A=
>>> diff --git a/Documentation/devicetree/bindings/power/supply/ltc2941.txt=
 b/Documentation/devicetree/bindings/power/supply/ltc2941.txt=0A=
>>> index a9d7aa60558b..ed0f02846d10 100644=0A=
>>> --- a/Documentation/devicetree/bindings/power/supply/ltc2941.txt=0A=
>>> +++ b/Documentation/devicetree/bindings/power/supply/ltc2941.txt=0A=
>>> @@ -1,9 +1,9 @@=0A=
>>> -binding for LTC2941 and LTC2943 battery gauges=0A=
>>> +binding for LTC2941, LTC2943 and LTC2944 battery gauges=0A=
>>>  =0A=
>>> -Both the LTC2941 and LTC2943 measure battery capacity.=0A=
>>> -The LTC2943 is compatible with the LTC2941, it adds voltage and=0A=
>>> -temperature monitoring, and uses a slightly different conversion=0A=
>>> -formula for the charge counter.=0A=
>>> +All the LTC2941, LTC2943 and LTC2944 measure battery capacity.=0A=
>>> +The LTC2943 and LTC2944 are compatible with the LTC2941, they add volt=
age and=0A=
>>> +temperature monitoring, and use a slightly different conversion formul=
a for the=0A=
>>> +charge counter.=0A=
>>>  =0A=
>>>  Required properties:=0A=
>>>  - compatible: Should contain "lltc,ltc2941" or "lltc,ltc2943" which al=
so=0A=
>>> diff --git a/drivers/power/supply/ltc2941-battery-gauge.c b/drivers/pow=
er/supply/ltc2941-battery-gauge.c=0A=
>>> index 7efb908f4451..4c979b1a022b 100644=0A=
>>> --- a/drivers/power/supply/ltc2941-battery-gauge.c=0A=
>>> +++ b/drivers/power/supply/ltc2941-battery-gauge.c=0A=
>>> @@ -1,5 +1,5 @@=0A=
>>>  /*=0A=
>>> - * I2C client/driver for the Linear Technology LTC2941 and LTC2943=0A=
>>> + * I2C client/driver for the Linear Technology LTC2941, LTC2943 and LT=
C2944=0A=
>>>   * Battery Gas Gauge IC=0A=
>>>   *=0A=
>>>   * Copyright (C) 2014 Topic Embedded Systems=0A=
>>> @@ -57,6 +57,12 @@ enum ltc294x_reg {=0A=
>>>  #define LTC2941_NUM_REGS	0x08=0A=
>>>  #define LTC2943_NUM_REGS	0x18=0A=
>>>  =0A=
>>> +enum ltc294x_id {=0A=
>>> +	LTC2941_ID,=0A=
>>> +	LTC2943_ID,=0A=
>>> +	LTC2944_ID,=0A=
>>> +};=0A=
>>> +=0A=
>>>  struct ltc294x_info {=0A=
>>>  	struct i2c_client *client;	/* I2C Client pointer */=0A=
>>>  	struct power_supply *supply;	/* Supply pointer */=0A=
>>> @@ -66,6 +72,7 @@ struct ltc294x_info {=0A=
>>>  	int charge;	/* Last charge register content */=0A=
>>>  	int r_sense;	/* mOhm */=0A=
>>>  	int Qlsb;	/* nAh */=0A=
>>> +	enum ltc294x_id id;=0A=
>>>  };=0A=
>>>  =0A=
>>>  static inline int convert_bin_to_uAh(=0A=
>>> @@ -145,7 +152,7 @@ static int ltc294x_reset(const struct ltc294x_info =
*info, int prescaler_exp)=0A=
>>>  =0A=
>>>  	control =3D LTC294X_REG_CONTROL_PRESCALER_SET(prescaler_exp) |=0A=
>>>  				LTC294X_REG_CONTROL_ALCC_CONFIG_DISABLED;=0A=
>>> -	/* Put the 2943 into "monitor" mode, so it measures every 10 sec */=
=0A=
>>> +	/* Put the 2943/4 into "monitor" mode, so it measures every 10 sec */=
=0A=
>>>  	if (info->num_regs =3D=3D LTC2943_NUM_REGS)=0A=
>>>  		control |=3D LTC2943_REG_CONTROL_MODE_SCAN;=0A=
>>>  =0A=
>>> @@ -248,11 +255,16 @@ static int ltc294x_get_voltage(const struct ltc29=
4x_info *info, int *val)=0A=
>>>  	int ret;=0A=
>>>  	u8 datar[2];=0A=
>>>  	u32 value;=0A=
>>> +	u32 full_scale;=0A=
>>>  =0A=
>>>  	ret =3D ltc294x_read_regs(info->client,=0A=
>>>  		LTC294X_REG_VOLTAGE_MSB, &datar[0], 2);=0A=
>>>  	value =3D (datar[0] << 8) | datar[1];=0A=
>>> -	*val =3D ((value * 23600) / 0xFFFF) * 1000; /* in uV */=0A=
>>> +	if (info->id =3D=3D LTC2944_ID)=0A=
>>> +		full_scale =3D 70800;=0A=
>>> +	else=0A=
>>> +		full_scale =3D 23600;=0A=
>>> +	*val =3D ((value * full_scale) / 0xFFFF) * 1000; /* in uV */=0A=
> Here result of 14bit ADC conversion is stored in 16bit register with=0A=
> lowest two bits being zero. Multiplying that with 70800 will overflow=0A=
> 32bit unsigned integer.=0A=
>=0A=
>>>  	return ret;=0A=
>>>  }=0A=
>>>  =0A=
>>> @@ -261,15 +273,20 @@ static int ltc294x_get_current(const struct ltc29=
4x_info *info, int *val)=0A=
>>>  	int ret;=0A=
>>>  	u8 datar[2];=0A=
>>>  	s32 value;=0A=
>>> +	u32 full_scale;=0A=
>>>  =0A=
>>>  	ret =3D ltc294x_read_regs(info->client,=0A=
>>>  		LTC294X_REG_CURRENT_MSB, &datar[0], 2);=0A=
>>>  	value =3D (datar[0] << 8) | datar[1];=0A=
>>>  	value -=3D 0x7FFF;=0A=
>>> +	if (info->id =3D=3D LTC2944_ID)=0A=
>>> +		full_scale =3D 64000;=0A=
>>> +	else=0A=
>>> +		full_scale =3D 60000;=0A=
>>>  	/* Value is in range -32k..+32k, r_sense is usually 10..50 mOhm,=0A=
>>>  	 * the formula below keeps everything in s32 range while preserving=
=0A=
>>>  	 * enough digits */=0A=
>>> -	*val =3D 1000 * ((60000 * value) / (info->r_sense * 0x7FFF)); /* in u=
A */=0A=
>>> +	*val =3D 1000 * ((full_scale * value) / (info->r_sense * 0x7FFF)); /*=
 in uA */=0A=
>>>  	return ret;=0A=
>>>  }=0A=
>>>  =0A=
>>> @@ -388,7 +405,11 @@ static int ltc294x_i2c_probe(struct i2c_client *cl=
ient,=0A=
>>>  =0A=
>>>  	np =3D of_node_get(client->dev.of_node);=0A=
>>>  =0A=
>>> -	info->num_regs =3D (unsigned long)of_device_get_match_data(&client->d=
ev);=0A=
>>> +	info->id =3D (enum ltc294x_id)of_device_get_match_data(&client->dev);=
=0A=
>>> +	if (info->id =3D=3D LTC2941_ID)=0A=
>>> +		info->num_regs =3D LTC2941_NUM_REGS;=0A=
>>> +	else=0A=
>>> +		info->num_regs =3D LTC2943_NUM_REGS;=0A=
>>>  	info->supply_desc.name =3D np->name;=0A=
>>>  =0A=
>>>  	/* r_sense can be negative, when sense+ is connected to the battery=
=0A=
>>> @@ -492,8 +513,9 @@ static SIMPLE_DEV_PM_OPS(ltc294x_pm_ops, ltc294x_su=
spend, ltc294x_resume);=0A=
>>>  =0A=
>>>  =0A=
>>>  static const struct i2c_device_id ltc294x_i2c_id[] =3D {=0A=
>>> -	{"ltc2941", LTC2941_NUM_REGS},=0A=
>>> -	{"ltc2943", LTC2943_NUM_REGS},=0A=
>>> +	{"ltc2941", LTC2941_ID},=0A=
>>> +	{"ltc2943", LTC2943_ID},=0A=
>>> +	{"ltc2944", LTC2944_ID},=0A=
>>>  	{ },=0A=
>>>  };=0A=
>>>  MODULE_DEVICE_TABLE(i2c, ltc294x_i2c_id);=0A=
>>> @@ -501,11 +523,15 @@ MODULE_DEVICE_TABLE(i2c, ltc294x_i2c_id);=0A=
>>>  static const struct of_device_id ltc294x_i2c_of_match[] =3D {=0A=
>>>  	{=0A=
>>>  		.compatible =3D "lltc,ltc2941",=0A=
>>> -		.data =3D (void *)LTC2941_NUM_REGS=0A=
>>> +		.data =3D (void *)LTC2941_ID=0A=
>>>  	},=0A=
>>>  	{=0A=
>>>  		.compatible =3D "lltc,ltc2943",=0A=
>>> -		.data =3D (void *)LTC2943_NUM_REGS=0A=
>>> +		.data =3D (void *)LTC2943_ID=0A=
>>> +	},=0A=
>>> +	{=0A=
>>> +		.compatible =3D "lltc,ltc2944",=0A=
>>> +		.data =3D (void *)LTC2944_ID=0A=
>>>  	},=0A=
>>>  	{ },=0A=
>>>  };=0A=
>>> @@ -525,5 +551,5 @@ module_i2c_driver(ltc294x_driver);=0A=
>>>  =0A=
>>>  MODULE_AUTHOR("Auryn Verwegen, Topic Embedded Systems");=0A=
>>>  MODULE_AUTHOR("Mike Looijmans, Topic Embedded Products");=0A=
>>> -MODULE_DESCRIPTION("LTC2941/LTC2943 Battery Gas Gauge IC driver");=0A=
>>> +MODULE_DESCRIPTION("LTC2941/LTC2943/LTC2944 Battery Gas Gauge IC drive=
r");=0A=
>>>  MODULE_LICENSE("GPL");=0A=
>>> -- =0A=
>>> 2.11.0=0A=
>=0A=
=0A=
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
