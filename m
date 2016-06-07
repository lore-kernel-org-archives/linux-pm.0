From: Rhyland Klein <rklein@nvidia.com>
Subject: Re: [RESEND PATCH v2] power_supply: power_supply_read_temp only if
 use_cnt > 0
Date: Tue, 7 Jun 2016 12:45:49 -0400
Message-ID: <409802ee-74bb-b068-d5ac-85a86e0b9310@nvidia.com>
References: <1465232216-12625-1-git-send-email-rklein@nvidia.com>
 <57567654.5060503@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <57567654.5060503@samsung.com>
Sender: stable-owner@vger.kernel.org
To: Krzysztof Kozlowski <k.kozlowski@samsung.com>, Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Jon Hunter <jonathanh@nvidia.com>, stable@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On 6/7/2016 3:23 AM, Krzysztof Kozlowski wrote:
> On 06/06/2016 06:56 PM, Rhyland Klein wrote:
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
>>
>> Cc: stable@vger.kernel.org
>> Signed-off-by: Rhyland Klein <rklein@nvidia.com>
> 
> And maybe:
> Fixes: 297d716f6260 ("power_supply: Change ownership from driver to core")

Sure, I wasn't sure which commit this should *fix*, but that makes sense.

> 
> 
>> ---
>> v2:
>>  - Added cc stable
>>  - changed return to -EAGAIN in case of use_cnt < 1
>>  - Removed WARNING
>>  - return value check added in additional patch:
>>   "thermal: helpers: Check return value of get_temp"
>>
>>  drivers/power/power_supply_core.c | 8 ++++++--
>>  1 file changed, 6 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/power/power_supply_core.c b/drivers/power/power_supply_core.c
>> index 456987c88baa..bbd80631f31e 100644
>> --- a/drivers/power/power_supply_core.c
>> +++ b/drivers/power/power_supply_core.c
>> @@ -561,11 +561,15 @@ static int power_supply_read_temp(struct thermal_zone_device *tzd,
>>  {
>>  	struct power_supply *psy;
>>  	union power_supply_propval val;
>> -	int ret;
>> +	int ret = -EAGAIN;
>>  
>>  	WARN_ON(tzd == NULL);
>> +
>>  	psy = tzd->devdata;
>> -	ret = psy->desc->get_property(psy, POWER_SUPPLY_PROP_TEMP, &val);
>> +
>> +	if (atomic_read(&psy->use_cnt) > 0)
>> +		ret = psy->desc->get_property(psy, POWER_SUPPLY_PROP_TEMP,
>> +					      &val);
> 
> How about using just power_supply_get_property() and convert return
> value to EAGAIN?

I like that. I'll swap it over to use that.

> 
> Anyway probably such check should be present also on other
> get_property() calls, like thermal cooling path.

I'll look around and see what else I can find.

> 
> Best regards,
> Krzysztof
> 

-rhyland

-- 
nvpublic
