From: Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH 4/8] power: Add an axp20x-usb-power driver
Date: Wed, 10 Jun 2015 11:22:00 +0200
Message-ID: <557801B8.5040804@redhat.com>
References: <1433885881-19809-1-git-send-email-hdegoede@redhat.com> <1433885881-19809-5-git-send-email-hdegoede@redhat.com> <20150610072957.GV2982@x1>
Reply-To: hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-sunxi+bncBDRZXY4CYYORBPMD4CVQKGQEHESSW7A-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
In-Reply-To: <20150610072957.GV2982@x1>
List-Post: <http://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <http://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <http://groups.google.com/group/linux-sunxi
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Subscribe: <http://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>,
 <http://groups.google.com/group/linux-sunxi/subscribe>
To: Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Dmitry Eremin-Solenikov <dbaryshkov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, Kishon Vijay Abraham I <kishon-l0cyMroinI0@public.gmane.org>, Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>, Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, =?UTF-8?B?QnJ1bm8gUHLDqW1vbnQ=?= <bonbons-ud5FBsm0p/xEiooADzr8i9i2O/JbrIOy@public.gmane.org>, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, devicetree <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Id: linux-pm@vger.kernel.org

Hi,

Thanks for the quick review I'll do a v2 addressing your concerns soonish.

On 10-06-15 09:29, Lee Jones wrote:
> On Tue, 09 Jun 2015, Hans de Goede wrote:
>
>> This adds a driver for the usb power_supply bits of the axp20x PMICs.
>>
>> I initially started writing my own driver, before coming aware of
>> Bruno Pr=C3=A9mont's excellent earlier RFC with a driver for this.
>>
>> My driver was lacking CURRENT_MAX and VOLTAGE_MIN support Bruno's
>> drvier has, so I've copied the code for those from his driver.
>>
>> Note that the AC-power-supply and battery charger bits will need separat=
e
>> drivers. Each one needs its own devictree child-node so that other
>> devicetree nodes can reference the right power-supply, and thus each one
>> will get its own mfd-cell / platform_device and platform-driver.
>>
>> Cc: Bruno Pr=C3=A9mont <bonbons-ud5FBsm0p/xEiooADzr8i9i2O/JbrIOy@public.gmane.org>
>> Signed-off-by: Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
>> ---
>>   .../bindings/power_supply/axp20x_usb_power.txt     |  34 +++
>
> This needs to be submitted in a seperate patch.

Ok.

>
>>   drivers/power/Kconfig                              |   7 +
>>   drivers/power/Makefile                             |   1 +
>>   drivers/power/axp20x_usb_power.c                   | 241 +++++++++++++=
++++++++
>>   include/linux/mfd/axp20x.h                         |  24 ++
>>   5 files changed, 307 insertions(+)
>>   create mode 100644 Documentation/devicetree/bindings/power_supply/axp2=
0x_usb_power.txt
>>   create mode 100644 drivers/power/axp20x_usb_power.c
>
> [...]
>
>> diff --git a/include/linux/mfd/axp20x.h b/include/linux/mfd/axp20x.h
>> index f4290ae..d7adb2e 100644
>> --- a/include/linux/mfd/axp20x.h
>> +++ b/include/linux/mfd/axp20x.h
>> @@ -11,6 +11,8 @@
>>   #ifndef __LINUX_MFD_AXP20X_H
>>   #define __LINUX_MFD_AXP20X_H
>>
>> +#include <linux/regmap.h>
>> +
>>   enum {
>>   	AXP202_ID =3D 0,
>>   	AXP209_ID,
>> @@ -366,4 +368,26 @@ struct axp20x_fg_pdata {
>>   	int thermistor_curve[MAX_THERM_CURVE_SIZE][2];
>>   };
>>
>> +/* generic helper function for reading 9-16 bit wide regs */
>> +static inline int axp20x_read_16bit(struct regmap *regmap,
>
> This is only used twice and only in one file.
>
> Do you know of any other uses of this call that will be upstreamed
> shortly?

Yes I plan to write drivers for the other 3 power_supply class
cells (ac-power, battery-charger, rtc-bat-charger) in the axp209,
and most of those need the same helper which I why I put it here.

>
>> +				    unsigned int reg, unsigned int width)
>
> The function name is a bit misleading.

How about: axp20x_read_multibyte_reg ?

>
>> +{
>> +	unsigned int v, raw;
>> +	int r;
>
> 'v' and 'r' are not good variable names.
>
>> +	r =3D regmap_read(regmap, reg, &v);
>> +	if (r)
>> +		return r;
>> +
>> +	raw =3D v << (width - 8);
>
> So 'reg' is expected to be top end loaded?
>
> E.g A value of say 0x0101 (257) in 9 bits will look like this:
>
> reg          reg + 1
> 1000 0000b   0000 0001b

Yes, I guess this was done so that you can get all the 8 msb-s
in a single read if you do not care about the lsb-s.

>
>> +	r =3D regmap_read(regmap, reg + 1, &v);
>> +	if (r)
>> +		return r;
>> +
>> +	raw |=3D v;
>> +
>> +	return raw;
>> +}
>> +
>>   #endif /* __LINUX_MFD_AXP20X_H */
>

Regards,

Hans

--=20
You received this message because you are subscribed to the Google Groups "=
linux-sunxi" group.
To unsubscribe from this group and stop receiving emails from it, send an e=
mail to linux-sunxi+unsubscribe-/JYPxA39Uh5TLH3MbocFF+G/Ez6ZCGd0@public.gmane.org
For more options, visit https://groups.google.com/d/optout.
