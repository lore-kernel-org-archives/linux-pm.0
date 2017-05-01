From: Hans de Goede <hdegoede@redhat.com>
Subject: Re: [PATCH v2 05/14] power: max17042_battery: Change name in
 power_supply_desc to "main-battery"
Date: Mon, 1 May 2017 17:11:13 +0200
Message-ID: <caf9b434-29bb-e03a-0287-c12de9beec0d@redhat.com>
References: <20170414183259.24382-1-hdegoede@redhat.com>
 <20170414183259.24382-5-hdegoede@redhat.com>
 <20170501122253.e3nrr4dql2nt3cba@earth>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:60410 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752112AbdEAPqd (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 1 May 2017 11:46:33 -0400
In-Reply-To: <20170501122253.e3nrr4dql2nt3cba@earth>
Content-Language: en-US
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
Cc: Krzysztof Kozlowski <krzk@kernel.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, linux-pm@vger.kernel.org

Hi Sebastian,

Thank you for merging all my recent patches.

On 01-05-17 14:22, Sebastian Reichel wrote:
> Hi,
> 
> On Fri, Apr 14, 2017 at 08:32:50PM +0200, Hans de Goede wrote:
>> The max17042 will typically be coupled with some charger IC, almost all
>> charger drivers contain:
>>
>> static char *xxx_charger_supplied_to[] = {
>>          "main-battery",
>> };
>>
>> probe()
>> {
>> 	struct power_supply_config cfg;
>>
>> 	cfg.supplied_to = xxx_charger_supplied_to;
>> 	cfg.num_supplicants = ARRAY_SIZE(xxx_charger_supplied_to);
>> 	xxx->charger = power_supply_register(dev, &x_charger_desc, &_cfg);
>> }
>>
>> Change the name in max17042's power_supply_desc to "main-battery" to
>> match, so that power_supply_am_i_supplied() can be used to implement
>> POWER_SUPPLY_PROP_STATUS.
>>
>> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
>> Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>
> 
> I did not queue this patch and patch 14. First of all: Currently 4/30
> chargers have this, which I wouldn't call "almost all". I think this
> is not the right solution, especially as it will break once a system
> has more than one "main" battery (like some of the newer thinkpads).
> 
> For DT based systems we have generic support to specify the
> dependency as phandle. This obviously won't work for you.
> I suggest to use a device property for supplying the correct name
> to the charger instead.

Ok, fair enough.

So to be clear you are suggesting that we modify the charger driver
(or the power-supply-core) to check for a "supplied-to"
string-array device property which then overrides the power_supply_config.supplied_to
array's default value in the driver?

Or do you want to modify the fuel-gauge driver (or the power-supply-core)
to check for a "supplied-from" string-array device property which then
is used to fill in the power_supply.supplied_from array ?

Looking at how currently the power-supply-core fills in power_supply.supplied_from
from devicetree when #ifdef CONFIG_OF is true, I think the best (and
most consistent) solution would be to change the :

#else
static inline int power_supply_check_supplies(struct power_supply *psy)
{
         return 0;
}
#endif

Code block to check for a "supplied-from" string-array device property
and populate the power_supply.supplied_from string array with its
contents if found.

If you can let me know how exactly you want to solve this I can whip
up (and test) patch for this.

Regards,

Hans



> 
> -- Sebastian
> 
>> ---
>>   drivers/power/supply/max17042_battery.c | 4 ++--
>>   1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/power/supply/max17042_battery.c b/drivers/power/supply/max17042_battery.c
>> index f0ff6e8..3249eb0 100644
>> --- a/drivers/power/supply/max17042_battery.c
>> +++ b/drivers/power/supply/max17042_battery.c
>> @@ -866,7 +866,7 @@ static const struct regmap_config max17042_regmap_config = {
>>   };
>>   
>>   static const struct power_supply_desc max17042_psy_desc = {
>> -	.name		= "max170xx_battery",
>> +	.name		= "main-battery",
>>   	.type		= POWER_SUPPLY_TYPE_BATTERY,
>>   	.get_property	= max17042_get_property,
>>   	.set_property	= max17042_set_property,
>> @@ -876,7 +876,7 @@ static const struct power_supply_desc max17042_psy_desc = {
>>   };
>>   
>>   static const struct power_supply_desc max17042_no_current_sense_psy_desc = {
>> -	.name		= "max170xx_battery",
>> +	.name		= "main-battery",
>>   	.type		= POWER_SUPPLY_TYPE_BATTERY,
>>   	.get_property	= max17042_get_property,
>>   	.set_property	= max17042_set_property,
>> -- 
>> 2.9.3
>>
