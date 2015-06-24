From: Hans de Goede <hdegoede@redhat.com>
Subject: Re: [linux-sunxi] Re: [PATCH v2 3/4] mfd: axp20x: Add a cell for the
 usb power_supply part of the axp20x PMICs
Date: Wed, 24 Jun 2015 17:04:28 +0200
Message-ID: <558AC6FC.1050603@redhat.com>
References: <1434211748-25572-1-git-send-email-hdegoede@redhat.com>
 <1434211748-25572-4-git-send-email-hdegoede@redhat.com>
 <20150624112333.GH15013@x1>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:37514 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752937AbbFXPEc (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Wed, 24 Jun 2015 11:04:32 -0400
In-Reply-To: <20150624112333.GH15013@x1>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Lee Jones <lee.jones@linaro.org>
Cc: Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, Maxime Ripard <maxime.ripard@free-electrons.com>, =?UTF-8?Q?Bruno_Pr=c3=a9mont?= <bonbons@linux-vserver.org>, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree <devicetree@vger.kernel.org>, linux-sunxi@googlegroups.com

Hi,

On 24-06-15 13:23, Lee Jones wrote:
>> Add a cell for the usb power_supply part of the axp20x PMICs.
>
> Why are you duplicating the subject line?

Heh, because some maintainers insist that the main-body part of the
commit message must stand by itself, without needing the subject to be
understandable...

>> Note that this cell is only for the usb power_supply part and not th=
e
>> ac-power / battery-charger / rtc-backup-bat-charger bits.
>>
>> Depending on the board each of those must be enabled / disabled sepa=
rately
>> in devicetree as most boards do not use all 4. So in dt each one nee=
ds its
>> own child-node of the axp20x node. Another reason for using separate=
 child
>> nodes for each is so that other devicetree nodes can have a power-su=
pply
>> property with a phandle referencing a node representing a single
>> power-supply.
>>
>> The decision to use a separate devicetree node for each is reflected=
 on
>> the kernel side by each getting its own mfd-cell / platform_device a=
nd
>> platform-driver.
>
> You don't really need to say any of this, as this is the 'norm'.

I agree it should be the norm, but I'm not sure if it actually is, whil=
e
working on this I've seen several drivers which instantiate multiple
power-supply class devices from a single mfd-cell. And this is what
Bruno's original patches did, so I would prefer to keep this

> What you didn't mention however, is that you're taking the opportunit=
y
> to fix some formatting issues and that there are no functional change=
s
> in these lines.

That is the end result of your request to change the indentation to
avoid line-wrapping :)

>
>> Cc: Bruno Pr=C3=A9mont <bonbons@linux-vserver.org>
>> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
>> ---
>> Changes in v2:
>> -Use DEFINE_RES_IRQ_NAMED
>> -Change indentation of axp20x_cells initializers to avoid line wrapp=
ing
>> ---
>>   drivers/mfd/axp20x.c | 20 ++++++++++++++++----
>>   1 file changed, 16 insertions(+), 4 deletions(-)
>
> Patch looks okay however:
>
> Acked-by: Lee Jones <lee.jones@linaro.org>

Thanks.

Regards,

Hans


>
>> diff --git a/drivers/mfd/axp20x.c b/drivers/mfd/axp20x.c
>> index f9a3c2d..ca4a604 100644
>> --- a/drivers/mfd/axp20x.c
>> +++ b/drivers/mfd/axp20x.c
>> @@ -113,6 +113,13 @@ static struct resource axp20x_pek_resources[] =3D=
 {
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
>> @@ -363,11 +370,16 @@ static const struct regmap_irq_chip axp288_reg=
map_irq_chip =3D {
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
