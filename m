From: Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH v4 2/2] mfd: axp20x: Add a cell for the usb
 power_supply part of the axp20x PMICs
Date: Wed, 12 Aug 2015 10:37:01 +0200
Message-ID: <55CB05AD.1030707@redhat.com>
References: <1439049521-30766-1-git-send-email-hdegoede@redhat.com>
 <1439049521-30766-2-git-send-email-hdegoede@redhat.com>
 <20150811141811.GM18282@x1>
Reply-To: hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-sunxi+bncBDRZXY4CYYORBM4LVSXAKGQETIYYQXY-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
In-Reply-To: <20150811141811.GM18282@x1>
List-Post: <http://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <http://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <http://groups.google.com/group/linux-sunxi
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Subscribe: <http://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>,
 <http://groups.google.com/group/linux-sunxi/subscribe>
To: Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, =?UTF-8?Q?Bruno_Pr=c3=a9mont?= <bonbons-ud5FBsm0p/xEiooADzr8i9i2O/JbrIOy@public.gmane.org>, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, devicetree <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Id: linux-pm@vger.kernel.org

Hi,

On 11-08-15 16:18, Lee Jones wrote:
> On Sat, 08 Aug 2015, Hans de Goede wrote:
>
>> Add a cell for the usb power_supply part of the axp20x PMICs.
>>
>> Note that this cell is only for the usb power_supply part and not the
>> ac-power / battery-charger / rtc-backup-bat-charger bits.
>>
>> Depending on the board each of those must be enabled / disabled separate=
ly
>> in devicetree as most boards do not use all 4. So in dt each one needs i=
ts
>> own child-node of the axp20x node. Another reason for using separate chi=
ld
>> nodes for each is so that other devicetree nodes can have a power-supply
>> property with a phandle referencing a node representing a single
>> power-supply.
>>
>> The decision to use a separate devicetree node for each is reflected on
>> the kernel side by each getting its own mfd-cell / platform_device and
>> platform-driver.
>>
>> Note this commit also makes some whitespace changes to the intialization
>> of existing cells in axp20x_cells, these are pure whitespace changes,
>> functionally nothing changes.
>>
>> Cc: Bruno Pr=C3=A9mont <bonbons-ud5FBsm0p/xEiooADzr8i9i2O/JbrIOy@public.gmane.org>
>> Signed-off-by: Bruno Pr=C3=A9mont <bonbons-ud5FBsm0p/xEiooADzr8i9i2O/JbrIOy@public.gmane.org>
>> Signed-off-by: Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
>> Acked-by: Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
>> Acked-by: Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
>> ---
>> Changes in v2:
>> -Use DEFINE_RES_IRQ_NAMED
>> -Change indentation of axp20x_cells initializers to avoid line wrapping
>> Changes in v3:
>> -Improve commit message
>> -Add Bruno's S-o-b
>> ---
>>   drivers/mfd/axp20x.c | 20 ++++++++++++++++----
>>   1 file changed, 16 insertions(+), 4 deletions(-)
>
> Applied, thanks.

Great, but I'm not seeing this in:

https://git.kernel.org/cgit/linux/kernel/git/lee/mfd.git/log/?h=3Dfor-mfd-n=
ext

?

Regards,

Hans


>
>> diff --git a/drivers/mfd/axp20x.c b/drivers/mfd/axp20x.c
>> index d9f2f96..3f576b7 100644
>> --- a/drivers/mfd/axp20x.c
>> +++ b/drivers/mfd/axp20x.c
>> @@ -140,6 +140,13 @@ static struct resource axp20x_pek_resources[] =3D {
>>   	},
>>   };
>>
>> +static struct resource axp20x_usb_power_supply_resources[] =3D {
>> +	DEFINE_RES_IRQ_NAMED(AXP20X_IRQ_VBUS_PLUGIN, "VBUS_PLUGIN"),
>> +	DEFINE_RES_IRQ_NAMED(AXP20X_IRQ_VBUS_REMOVAL, "VBUS_REMOVAL"),
>> +	DEFINE_RES_IRQ_NAMED(AXP20X_IRQ_VBUS_VALID, "VBUS_VALID"),
>> +	DEFINE_RES_IRQ_NAMED(AXP20X_IRQ_VBUS_NOT_VALID, "VBUS_NOT_VALID"),
>> +};
>> +
>>   static struct resource axp22x_pek_resources[] =3D {
>>   	{
>>   		.name   =3D "PEK_DBR",
>> @@ -432,11 +439,16 @@ static const struct regmap_irq_chip axp288_regmap_=
irq_chip =3D {
>>
>>   static struct mfd_cell axp20x_cells[] =3D {
>>   	{
>> -		.name			=3D "axp20x-pek",
>> -		.num_resources		=3D ARRAY_SIZE(axp20x_pek_resources),
>> -		.resources		=3D axp20x_pek_resources,
>> +		.name		=3D "axp20x-pek",
>> +		.num_resources	=3D ARRAY_SIZE(axp20x_pek_resources),
>> +		.resources	=3D axp20x_pek_resources,
>>   	}, {
>> -		.name			=3D "axp20x-regulator",
>> +		.name		=3D "axp20x-regulator",
>> +	}, {
>> +		.name		=3D "axp20x-usb-power-supply",
>> +		.of_compatible	=3D "x-powers,axp202-usb-power-supply",
>> +		.num_resources	=3D ARRAY_SIZE(axp20x_usb_power_supply_resources),
>> +		.resources	=3D axp20x_usb_power_supply_resources,
>>   	},
>>   };
>>
>

--=20
You received this message because you are subscribed to the Google Groups "=
linux-sunxi" group.
To unsubscribe from this group and stop receiving emails from it, send an e=
mail to linux-sunxi+unsubscribe-/JYPxA39Uh5TLH3MbocFF+G/Ez6ZCGd0@public.gmane.org
For more options, visit https://groups.google.com/d/optout.
