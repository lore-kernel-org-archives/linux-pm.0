From: Rhyland Klein <rklein@nvidia.com>
Subject: Re: [PATCH] power_supply: power_supply_read_temp only if use_cnt > 0
Date: Mon, 6 Jun 2016 11:39:45 -0400
Message-ID: <c307bdcc-5744-e966-e551-578b5c16fa8c@nvidia.com>
References: <1464985850-12365-1-git-send-email-rklein@nvidia.com>
 <20160604133022.GA31801@earth>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from hqemgate14.nvidia.com ([216.228.121.143]:5578 "EHLO
	hqemgate14.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751147AbcFFPjw (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 6 Jun 2016 11:39:52 -0400
In-Reply-To: <20160604133022.GA31801@earth>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>
Cc: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Jon Hunter <jonathanh@nvidia.com>, Krzysztof Kozlowski <k.kozlowski@samsung.com>

On 6/4/2016 9:30 AM, Sebastian Reichel wrote:
> * PGP Signed by an unknown key
> 
> Hi Rhyland,
> 
> Thanks for the patch.
> 
> On Fri, Jun 03, 2016 at 04:30:50PM -0400, Rhyland Klein wrote:
>> Add check to power_supply_read_temp() to only use the power_supply
>> get_property() callback if the use_cnt is > 0. The use_cnt will
>> be incremented at the end of __power_supply_register, so this will
>> block to case where get_property can be called before the supply
>> is fully registered. This fixes the issue show in the stack below:
>>
>> [    1.452598] power_supply_read_temp+0x78/0x80
>> [    1.458680] thermal_zone_get_temp+0x5c/0x11c
>> [    1.464765] thermal_zone_device_update+0x34/0xb4
>> [    1.471195] thermal_zone_device_register+0x87c/0x8cc
>> [    1.477974] __power_supply_register+0x364/0x424
>> [    1.484317] power_supply_register_no_ws+0x10/0x18
>> [    1.490833] bq27xxx_battery_setup+0x10c/0x164
>> [    1.497003] bq27xxx_battery_i2c_probe+0xd0/0x1b0
>> [    1.503435] i2c_device_probe+0x174/0x240
>> [    1.509172] driver_probe_device+0x1fc/0x29c
>> [    1.515167] __driver_attach+0xa4/0xa8
>> [    1.520643] bus_for_each_dev+0x58/0x98
>> [    1.526204] driver_attach+0x20/0x28
>> [    1.531505] bus_add_driver+0x1c8/0x22c
>> [    1.537067] driver_register+0x68/0x108
>> [    1.542630] i2c_register_driver+0x38/0x7c
>> [    1.548457] bq27xxx_battery_i2c_driver_init+0x18/0x20
>> [    1.555321] do_one_initcall+0x38/0x12c
>> [    1.560886] kernel_init_freeable+0x148/0x1ec
>> [    1.566972] kernel_init+0x10/0xfc
>> [    1.572101] ret_from_fork+0x10/0x40
> 
> So I guess this should be backported to stable kernels.

That it would probably make sense.

> 
>> Signed-off-by: Rhyland Klein <rklein@nvidia.com>
>> ---
>>  drivers/power/power_supply_core.c | 9 +++++++--
>>  1 file changed, 7 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/power/power_supply_core.c b/drivers/power/power_supply_core.c
>> index 456987c88baa..070fec621d66 100644
>> --- a/drivers/power/power_supply_core.c
>> +++ b/drivers/power/power_supply_core.c
>> @@ -561,11 +561,16 @@ static int power_supply_read_temp(struct thermal_zone_device *tzd,
>>  {
>>  	struct power_supply *psy;
>>  	union power_supply_propval val;
>> -	int ret;
>> +	int ret = 0;
> 
> ret should probably be initialized to -EAGAIN to avoid val being
> interpreted without get_property() having been called at all?

Sure, that makes more sense than a 0 temp which could be misinterpreted.

> 
>>  	WARN_ON(tzd == NULL);
>> +
>>  	psy = tzd->devdata;
>> -	ret = psy->desc->get_property(psy, POWER_SUPPLY_PROP_TEMP, &val);
>> +	WARN_ON(atomic_read(&psy->use_cnt) == 0);
> 
> I guess the warning can be dropped if error code is properly reported?

It looks like the thermal might not, but I will make a patch for that
too, since it is setup to handle it, but doesn't actually check it.

> 
>> +	if (atomic_read(&psy->use_cnt) > 0)
>> +		ret = psy->desc->get_property(psy, POWER_SUPPLY_PROP_TEMP,
>> +					      &val);
>>  
>>  	/* Convert tenths of degree Celsius to milli degree Celsius. */
>>  	if (!ret)
> 
> -- Sebastian
> 
-rhyland


-- 
nvpublic
