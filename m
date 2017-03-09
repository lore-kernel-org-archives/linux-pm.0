From: "Andrew F. Davis" <afd@ti.com>
Subject: Re: [PATCH] power: bq27xxx_battery: Keep track of specific chip id
Date: Thu, 9 Mar 2017 16:45:50 -0600
Message-ID: <b6a92484-20b0-ad6f-4003-9956817b6d82@ti.com>
References: <20170309070019.11892-1-liam@networkimprov.net>
 <CAKvHMgQB4pZTM-+Ubt19ZvJ4fVoZBrnYGQx3popJSKA6RmSfeQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from lelnx194.ext.ti.com ([198.47.27.80]:44737 "EHLO
        lelnx194.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752797AbdCIXCQ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 9 Mar 2017 18:02:16 -0500
In-Reply-To: <CAKvHMgQB4pZTM-+Ubt19ZvJ4fVoZBrnYGQx3popJSKA6RmSfeQ@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Liam Breck <liam@networkimprov.net>, linux-pm@vger.kernel.org

On 03/09/2017 04:42 PM, Liam Breck wrote:
> On Wed, Mar 8, 2017 at 11:00 PM, Liam Breck <liam@networkimprov.net> wrote:
>> From: Liam Breck <kernel@networkimprov.net>
>>
>> Keep actual chip ID in di->dmid, to allow support for all chips
>> by the power_supply_battery_info code.
>> There are no functional changes to the driver.
>>
>> Signed-off-by: Matt Ranostay <matt@ranostay.consulting>
>> Signed-off-by: Liam Breck <kernel@networkimprov.net>
>> ---
>> Andrew, here is the alternate method I referred to.
>> I made the enum values explicit in case they are referenced externally.
>>
>>  drivers/power/supply/bq27xxx_battery.c     | 13 +++++++++++++
>>  drivers/power/supply/bq27xxx_battery_i2c.c | 16 ++++++++--------
>>  include/linux/power/bq27xxx_battery.h      | 26 +++++++++++++++++++-------
>>  3 files changed, 40 insertions(+), 15 deletions(-)
>>
>> diff --git a/drivers/power/supply/bq27xxx_battery.c b/drivers/power/supply/bq27xxx_battery.c
>> index 7272d1e..0e6653f 100644
>> --- a/drivers/power/supply/bq27xxx_battery.c
>> +++ b/drivers/power/supply/bq27xxx_battery.c
>> @@ -1020,6 +1020,19 @@ int bq27xxx_battery_setup(struct bq27xxx_device_info *di)
>>         struct power_supply_desc *psy_desc;
>>         struct power_supply_config psy_cfg = { .drv_data = di, };
>>
>> +       di->dmid = di->chip;
>> +       switch(di->dmid) {
>> +       case BQ27520: di->chip = BQ27510; break;
>> +       case BQ27531: di->chip = BQ27530; break;
>> +       case BQ27542: di->chip = BQ27541; break;
>> +       case BQ27546: di->chip = BQ27541; break;
>> +       case BQ27742: di->chip = BQ27541; break;
>> +       case BQ27425: di->chip = BQ27421; break;
>> +       case BQ27441: di->chip = BQ27421; break;
>> +       case BQ27621: di->chip = BQ27421; break;
>> +       default: break;
>> +       }
> 
> To avoid .chip + .dmid we can add .dm_regs & .unseal_key and init them
> in the above switch. That eliminates two static arrays as well.
> 
> How soon could you test a v10?
> 

Lets just see how the code looks first, and for the most part you should
test all new parts yourself before submitting patches for them, I'll do
some sanity tests before this all gets merged on parts you don't have,
but I'm not a test farm, I do have a day job :)

>>         INIT_DELAYED_WORK(&di->work, bq27xxx_battery_poll);
>>         mutex_init(&di->lock);
>>         di->regs = bq27xxx_regs[di->chip];
>> diff --git a/drivers/power/supply/bq27xxx_battery_i2c.c b/drivers/power/supply/bq27xxx_battery_i2c.c
>> index 5c5c3a6..13def59 100644
>> --- a/drivers/power/supply/bq27xxx_battery_i2c.c
>> +++ b/drivers/power/supply/bq27xxx_battery_i2c.c
>> @@ -150,18 +150,18 @@ static const struct i2c_device_id bq27xxx_i2c_id_table[] = {
>>         { "bq27210", BQ27010 },
>>         { "bq27500", BQ27500 },
>>         { "bq27510", BQ27510 },
>> -       { "bq27520", BQ27510 },
>> +       { "bq27520", BQ27520 },
>>         { "bq27530", BQ27530 },
>> -       { "bq27531", BQ27530 },
>> +       { "bq27531", BQ27531 },
>>         { "bq27541", BQ27541 },
>> -       { "bq27542", BQ27541 },
>> -       { "bq27546", BQ27541 },
>> -       { "bq27742", BQ27541 },
>> +       { "bq27542", BQ27542 },
>> +       { "bq27546", BQ27546 },
>> +       { "bq27742", BQ27742 },
>>         { "bq27545", BQ27545 },
>>         { "bq27421", BQ27421 },
>> -       { "bq27425", BQ27421 },
>> -       { "bq27441", BQ27421 },
>> -       { "bq27621", BQ27421 },
>> +       { "bq27425", BQ27425 },
>> +       { "bq27441", BQ27441 },
>> +       { "bq27621", BQ27621 },
>>         {},
>>  };
>>  MODULE_DEVICE_TABLE(i2c, bq27xxx_i2c_id_table);
>> diff --git a/include/linux/power/bq27xxx_battery.h b/include/linux/power/bq27xxx_battery.h
>> index 92df553..969f99f 100644
>> --- a/include/linux/power/bq27xxx_battery.h
>> +++ b/include/linux/power/bq27xxx_battery.h
>> @@ -3,13 +3,24 @@
>>
>>  enum bq27xxx_chip {
>>         BQ27000 = 1, /* bq27000, bq27200 */
>> -       BQ27010, /* bq27010, bq27210 */
>> -       BQ27500, /* bq27500 */
>> -       BQ27510, /* bq27510, bq27520 */
>> -       BQ27530, /* bq27530, bq27531 */
>> -       BQ27541, /* bq27541, bq27542, bq27546, bq27742 */
>> -       BQ27545, /* bq27545 */
>> -       BQ27421, /* bq27421, bq27425, bq27441, bq27621 */
>> +       BQ27010 = 2, /* bq27010, bq27210 */
>> +       BQ27500 = 3, /* bq27500 */
>> +       BQ27510 = 4, /* bq27510, bq27520 */
>> +       BQ27530 = 5, /* bq27530, bq27531 */
>> +       BQ27541 = 6, /* bq27541, bq27542, bq27546, bq27742 */
>> +       BQ27545 = 7, /* bq27545 */
>> +       BQ27421 = 8, /* bq27421, bq27425, bq27441, bq27621 */
>> +
>> +       /* members of above groups, for use in .dmid */
>> +       /* translate these in _setup() for .chip */
>> +       BQ27520 = 101,
>> +       BQ27531 = 102,
>> +       BQ27542 = 103,
>> +       BQ27546 = 104,
>> +       BQ27742 = 105,
>> +       BQ27425 = 106,
>> +       BQ27441 = 107,
>> +       BQ27621 = 108,
>>  };
>>
>>  /**
>> @@ -55,6 +66,7 @@ struct bq27xxx_device_info {
>>         struct device *dev;
>>         int id;
>>         enum bq27xxx_chip chip;
>> +       enum bq27xxx_chip dmid;
>>         const char *name;
>>         struct bq27xxx_access_methods bus;
>>         struct bq27xxx_reg_cache cache;
>> --
>> 2.9.3
>>
