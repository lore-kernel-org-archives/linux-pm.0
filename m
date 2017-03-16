From: Liam Breck <liam@networkimprov.net>
Subject: Re: [PATCH v10 6/8] power: bq27xxx_battery: Keep track of specific
 chip id
Date: Thu, 16 Mar 2017 13:12:37 -0700
Message-ID: <CAKvHMgQ3HQ8LWj4+ewMPawhpCjzzU=R8We4v-psLZiQjw1PFsQ@mail.gmail.com>
References: <20170315192653.26799-1-liam@networkimprov.net>
 <20170315192653.26799-7-liam@networkimprov.net> <3c2259be-5f63-1f07-8e4d-1bb059a9447f@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-it0-f66.google.com ([209.85.214.66]:33441 "EHLO
        mail-it0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752249AbdCPUMq (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 16 Mar 2017 16:12:46 -0400
Received: by mail-it0-f66.google.com with SMTP id g138so246896itb.0
        for <linux-pm@vger.kernel.org>; Thu, 16 Mar 2017 13:12:38 -0700 (PDT)
In-Reply-To: <3c2259be-5f63-1f07-8e4d-1bb059a9447f@ti.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Andrew F. Davis" <afd@ti.com>
Cc: Sebastian Reichel <sre@kernel.org>, linux-pm@vger.kernel.org, Matt Ranostay <matt@ranostay.consulting>, Liam Breck <kernel@networkimprov.net>

On Thu, Mar 16, 2017 at 7:44 AM, Andrew F. Davis <afd@ti.com> wrote:
> On 03/15/2017 02:26 PM, Liam Breck wrote:
>> From: Liam Breck <kernel@networkimprov.net>
>>
>> Pass actual chip ID into _setup(), which translates it to a group ID,
>> to allow support for all chips by the power_supply_battery_info code.
>> There are no functional changes to the driver.
>>
>> Signed-off-by: Liam Breck <kernel@networkimprov.net>
>> ---
>
> What is this patch based on, it doesn't apply to v4.11-rc1 for me.

Sorry, I don't have all of Chris' patches here. It wasn't a factor
until we attacked the register arrays. Could you send me his patchset
with:
git format-patch --stdout HEAD~x..HEAD~y > bq27xxx-lapa.mbox

>>  drivers/power/supply/bq27xxx_battery.c     | 19 +++++++++++++++++++
>>  drivers/power/supply/bq27xxx_battery_i2c.c | 16 ++++++++--------
>>  include/linux/power/bq27xxx_battery.h      | 25 ++++++++++++++++++-------
>>  3 files changed, 45 insertions(+), 15 deletions(-)
>>
>> diff --git a/drivers/power/supply/bq27xxx_battery.c b/drivers/power/supply/bq27xxx_battery.c
>> index 7272d1e..d613d3d 100644
>> --- a/drivers/power/supply/bq27xxx_battery.c
>> +++ b/drivers/power/supply/bq27xxx_battery.c
>> @@ -1020,6 +1020,25 @@ int bq27xxx_battery_setup(struct bq27xxx_device_info *di)
>>       struct power_supply_desc *psy_desc;
>>       struct power_supply_config psy_cfg = { .drv_data = di, };
>>
>> +     switch(di->chip) {
>> +     case BQ27000:
>> +     case BQ27010:
>> +     case BQ27500:
>> +     case BQ27510:
>> +     case BQ27530:
>> +     case BQ27541:
>> +     case BQ27545:
>> +     case BQ27421: break;
>
> Why even have these cases then?

You'll get a compiler warning if any are missing. Helps when adding new chips.

>> +     case BQ27520: di->chip = BQ27510; break;
>> +     case BQ27531: di->chip = BQ27530; break;
>> +     case BQ27542: di->chip = BQ27541; break;
>> +     case BQ27546: di->chip = BQ27541; break;
>> +     case BQ27742: di->chip = BQ27541; break;
>> +     case BQ27425: di->chip = BQ27421; break;
>> +     case BQ27441: di->chip = BQ27421; break;
>> +     case BQ27621: di->chip = BQ27421; break;
>
> Nope, don't like this at all, make a different variable, ->registers or
> something to map to the register table. Plus I think changing the
> variable you are switching on can cause undefined behavior.

We had a different variable, .dmid, but you rejected a second ID
field. I think this is better, as we eliminated the static arrays
.dmid indexed. I didn't rename .chip to .category as that would cause
trivial changes all over the file. I could do that in a final patch
tho.

You can modify a variable after switching on it, I promise.

>> +     }
>> +
>>       INIT_DELAYED_WORK(&di->work, bq27xxx_battery_poll);
>>       mutex_init(&di->lock);
>>       di->regs = bq27xxx_regs[di->chip];
>> diff --git a/drivers/power/supply/bq27xxx_battery_i2c.c b/drivers/power/supply/bq27xxx_battery_i2c.c
>> index 5c5c3a6..13def59 100644
>> --- a/drivers/power/supply/bq27xxx_battery_i2c.c
>> +++ b/drivers/power/supply/bq27xxx_battery_i2c.c
>> @@ -150,18 +150,18 @@ static const struct i2c_device_id bq27xxx_i2c_id_table[] = {
>>       { "bq27210", BQ27010 },
>>       { "bq27500", BQ27500 },
>>       { "bq27510", BQ27510 },
>> -     { "bq27520", BQ27510 },
>> +     { "bq27520", BQ27520 },
>>       { "bq27530", BQ27530 },
>> -     { "bq27531", BQ27530 },
>> +     { "bq27531", BQ27531 },
>>       { "bq27541", BQ27541 },
>> -     { "bq27542", BQ27541 },
>> -     { "bq27546", BQ27541 },
>> -     { "bq27742", BQ27541 },
>> +     { "bq27542", BQ27542 },
>> +     { "bq27546", BQ27546 },
>> +     { "bq27742", BQ27742 },
>>       { "bq27545", BQ27545 },
>>       { "bq27421", BQ27421 },
>> -     { "bq27425", BQ27421 },
>> -     { "bq27441", BQ27421 },
>> -     { "bq27621", BQ27421 },
>> +     { "bq27425", BQ27425 },
>> +     { "bq27441", BQ27441 },
>> +     { "bq27621", BQ27621 },
>>       {},
>>  };
>>  MODULE_DEVICE_TABLE(i2c, bq27xxx_i2c_id_table);
>> diff --git a/include/linux/power/bq27xxx_battery.h b/include/linux/power/bq27xxx_battery.h
>> index 92df553..90db1cf 100644
>> --- a/include/linux/power/bq27xxx_battery.h
>> +++ b/include/linux/power/bq27xxx_battery.h
>> @@ -2,14 +2,25 @@
>>  #define __LINUX_BQ27X00_BATTERY_H__
>>
>>  enum bq27xxx_chip {
>> +     /* categories; index for bq27xxx_regs[] */
>>       BQ27000 = 1, /* bq27000, bq27200 */
>> -     BQ27010, /* bq27010, bq27210 */
>> -     BQ27500, /* bq27500 */
>> -     BQ27510, /* bq27510, bq27520 */
>> -     BQ27530, /* bq27530, bq27531 */
>> -     BQ27541, /* bq27541, bq27542, bq27546, bq27742 */
>> -     BQ27545, /* bq27545 */
>> -     BQ27421, /* bq27421, bq27425, bq27441, bq27621 */
>> +     BQ27010 = 2, /* bq27010, bq27210 */
>> +     BQ27500 = 3, /* bq27500 */
>> +     BQ27510 = 4, /* bq27510, bq27520 */
>> +     BQ27530 = 5, /* bq27530, bq27531 */
>> +     BQ27541 = 6, /* bq27541, bq27542, bq27546, bq27742 */
>> +     BQ27545 = 7, /* bq27545 */
>> +     BQ27421 = 8, /* bq27421, bq27425, bq27441, bq27621 */
>> +
>> +     /* members of categories; translate these to category in _setup() */
>> +     BQ27520 = 101,
>> +     BQ27531 = 102,
>> +     BQ27542 = 103,
>> +     BQ27546 = 104,
>> +     BQ27742 = 105,
>> +     BQ27425 = 106,
>> +     BQ27441 = 107,
>> +     BQ27621 = 108,
>
> Get rid of this, just add new chip enum names if you need support for
> new chips.

How does a non-DT config obtain chip ID? We want explicit enum values
if they appear in external platform-data objects. I'll mention that in
the next patch description.

The category (original) IDs index bq27xxx_regs[], and you'll probably
extend that in time. So I placed the member (new) IDs well above the
categories to allow permanent explicit values.
