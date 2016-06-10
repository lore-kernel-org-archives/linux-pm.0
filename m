From: Hans de Goede <hdegoede@redhat.com>
Subject: Re: [PATCH v2 3/4] mfd: axp20x: Add axp20x-usb-power-supply for
 axp22x pmics
Date: Fri, 10 Jun 2016 20:47:16 +0200
Message-ID: <162fe714-9f40-a6c6-d94b-d82d88689b7c@redhat.com>
References: <1464887936-17020-1-git-send-email-hdegoede@redhat.com>
 <1464887936-17020-3-git-send-email-hdegoede@redhat.com>
 <20160610145622.GB7351@dell>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:45560 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751724AbcFJSrY (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Fri, 10 Jun 2016 14:47:24 -0400
In-Reply-To: <20160610145622.GB7351@dell>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Lee Jones <lee.jones@linaro.org>
Cc: Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, Maxime Ripard <maxime.ripard@free-electrons.com>, Chen-Yu Tsai <wens@csie.org>, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree <devicetree@vger.kernel.org>

Hi,

On 10-06-16 16:56, Lee Jones wrote:
> On Thu, 02 Jun 2016, Hans de Goede wrote:
>
>> Add axp20x-usb-power-supply for axp22x pmics.
>>
>> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
>> ---
>> Changes in v2:
>> -Change compatible string for axp22x usb-power-supply cell to match v2 of:
>>  "power: axp20x_usb: Add support for usb power-supply on axp22x pmics"
>> ---
>>  drivers/mfd/axp20x.c | 10 ++++++++++
>>  1 file changed, 10 insertions(+)
>
> Applied, thanks.

Thanks, any chance we can see this show up soonish in :

https://git.kernel.org/cgit/linux/kernel/git/lee/mfd.git/log/?h=for-mfd-next

?

We keep a branch with all the foo-for-next branches relevant for
sunxi merged in for testing and it would be good to get these in there.

Regards,

Hans



>
>> diff --git a/drivers/mfd/axp20x.c b/drivers/mfd/axp20x.c
>> index ca04361..6364dab 100644
>> --- a/drivers/mfd/axp20x.c
>> +++ b/drivers/mfd/axp20x.c
>> @@ -160,6 +160,11 @@ static struct resource axp20x_usb_power_supply_resources[] = {
>>  	DEFINE_RES_IRQ_NAMED(AXP20X_IRQ_VBUS_NOT_VALID, "VBUS_NOT_VALID"),
>>  };
>>
>> +static struct resource axp22x_usb_power_supply_resources[] = {
>> +	DEFINE_RES_IRQ_NAMED(AXP22X_IRQ_VBUS_PLUGIN, "VBUS_PLUGIN"),
>> +	DEFINE_RES_IRQ_NAMED(AXP22X_IRQ_VBUS_REMOVAL, "VBUS_REMOVAL"),
>> +};
>> +
>>  static struct resource axp22x_pek_resources[] = {
>>  	{
>>  		.name   = "PEK_DBR",
>> @@ -527,6 +532,11 @@ static struct mfd_cell axp22x_cells[] = {
>>  		.resources		= axp22x_pek_resources,
>>  	}, {
>>  		.name			= "axp20x-regulator",
>> +	}, {
>> +		.name		= "axp20x-usb-power-supply",
>> +		.of_compatible	= "x-powers,axp221-usb-power-supply",
>> +		.num_resources	= ARRAY_SIZE(axp22x_usb_power_supply_resources),
>> +		.resources	= axp22x_usb_power_supply_resources,
>>  	},
>>  };
>>
>
