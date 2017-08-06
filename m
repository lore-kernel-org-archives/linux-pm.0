From: Hans de Goede <hdegoede@redhat.com>
Subject: Re: [PATCH 11/18] power: supply: Fix power_supply_am_i_supplied to
 return -ENODEV when apropriate
Date: Sun, 6 Aug 2017 16:54:25 +0200
Message-ID: <d5040aaa-0204-41c0-e7db-f129742f904e@redhat.com>
References: <20170806123555.5124-1-hdegoede@redhat.com>
 <20170806123555.5124-12-hdegoede@redhat.com>
 <31e2a928-61f8-4706-9981-0d2e9ab2bc10@roeck-us.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <platform-driver-x86-owner@vger.kernel.org>
In-Reply-To: <31e2a928-61f8-4706-9981-0d2e9ab2bc10@roeck-us.net>
Content-Language: en-US
Sender: platform-driver-x86-owner@vger.kernel.org
To: Guenter Roeck <linux@roeck-us.net>, Darren Hart <dvhart@infradead.org>, Andy Shevchenko <andy@infradead.org>, Wolfram Sang <wsa@the-dreams.de>, Sebastian Reichel <sre@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc: platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org, Liam Breck <liam@networkimprov.net>, Tony Lindgren <tony@atomide.com>, linux-pm@vger.kernel.org, devel@driverdev.osuosl.org
List-Id: linux-pm@vger.kernel.org

Hi,

On 06-08-17 16:31, Guenter Roeck wrote:
> On 08/06/2017 05:35 AM, Hans de Goede wrote:
>> Commit 2848e039c562 ("power: supply: Make power_supply_am_i_supplied return
>> -ENODEV if there are no suppliers") was supposed to make
>> power_supply_am_i_supplied() return -ENODEV when there are no supplies
>> which supply the supply passed to it.
>>
>> But instead it will only return -ENODEV when there are no supplies at
>> all as data->count++; is incremented on every call of the iterator, rather
>> then only when __power_supply_is_supplied_by returns true. This commit
>> fixes this.
>>
>> Fixes: 2848e039c562 ("power: supply: Make power_supply_am_i_supplied ...")
>> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> 
> Independent of this series ?

Correct, in hindsight I should have send it out as a standalone patch, I will
do so for v2.

Regards,

Hans





> 
>> ---
>>   drivers/power/supply/power_supply_core.c | 5 +++--
>>   1 file changed, 3 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/power/supply/power_supply_core.c b/drivers/power/supply/power_supply_core.c
>> index 540d3e0aa011..0741fcef3b44 100644
>> --- a/drivers/power/supply/power_supply_core.c
>> +++ b/drivers/power/supply/power_supply_core.c
>> @@ -314,11 +314,12 @@ static int __power_supply_am_i_supplied(struct device *dev, void *_data)
>>       struct power_supply *epsy = dev_get_drvdata(dev);
>>       struct psy_am_i_supplied_data *data = _data;
>> -    data->count++;
>> -    if (__power_supply_is_supplied_by(epsy, data->psy))
>> +    if (__power_supply_is_supplied_by(epsy, data->psy)) {
>> +        data->count++;
>>           if (!epsy->desc->get_property(epsy, POWER_SUPPLY_PROP_ONLINE,
>>                       &ret))
>>               return ret.intval;
>> +    }
>>       return 0;
>>   }
>>
> 
