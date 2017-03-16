From: "Andrew F. Davis" <afd@ti.com>
Subject: Re: [PATCH v10 6/8] power: bq27xxx_battery: Keep track of specific
 chip id
Date: Thu, 16 Mar 2017 16:53:16 -0500
Message-ID: <7c8146d1-896c-3652-9fea-ae544acb3d58@ti.com>
References: <20170315192653.26799-1-liam@networkimprov.net>
 <20170315192653.26799-7-liam@networkimprov.net>
 <3c2259be-5f63-1f07-8e4d-1bb059a9447f@ti.com>
 <CAKvHMgQ3HQ8LWj4+ewMPawhpCjzzU=R8We4v-psLZiQjw1PFsQ@mail.gmail.com>
 <840adbba-6251-b565-5f85-611dd840cc39@ti.com>
 <CAKvHMgQ5i9fDmpkePR7BJgHpRpGeOTHY2mrZJ2GvdAqk04gpCg@mail.gmail.com>
 <3e636b53-56df-40f3-16a7-e40901588010@ti.com>
 <CAKvHMgR7PH5gYWWw_iAX=yznzqYvRYum3at5FsYSKSHD0Z=4Eg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from lelnx194.ext.ti.com ([198.47.27.80]:9093 "EHLO
        lelnx194.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752487AbdCPVxW (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 16 Mar 2017 17:53:22 -0400
In-Reply-To: <CAKvHMgR7PH5gYWWw_iAX=yznzqYvRYum3at5FsYSKSHD0Z=4Eg@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Liam Breck <liam@networkimprov.net>
Cc: Sebastian Reichel <sre@kernel.org>, linux-pm@vger.kernel.org, Matt Ranostay <matt@ranostay.consulting>, Liam Breck <kernel@networkimprov.net>

On 03/16/2017 04:47 PM, Liam Breck wrote:
> On Thu, Mar 16, 2017 at 2:30 PM, Andrew F. Davis <afd@ti.com> wrote:
>> On 03/16/2017 04:26 PM, Liam Breck wrote:
>>> On Thu, Mar 16, 2017 at 1:50 PM, Andrew F. Davis <afd@ti.com> wrote:
>>>> On 03/16/2017 03:12 PM, Liam Breck wrote:
>>>>> On Thu, Mar 16, 2017 at 7:44 AM, Andrew F. Davis <afd@ti.com> wrote:
>>>>>> On 03/15/2017 02:26 PM, Liam Breck wrote:
>>>>>>> From: Liam Breck <kernel@networkimprov.net>
>>>>>>>
>>>>>>> Pass actual chip ID into _setup(), which translates it to a group ID,
>>>>>>> to allow support for all chips by the power_supply_battery_info code.
>>>>>>> There are no functional changes to the driver.
>>>>>>>
>>>>>>> Signed-off-by: Liam Breck <kernel@networkimprov.net>
>>>>>>> ---
>>>>>>
>>>>>> What is this patch based on, it doesn't apply to v4.11-rc1 for me.
>>>>>
>>>>> Sorry, I don't have all of Chris' patches here. It wasn't a factor
>>>>> until we attacked the register arrays. Could you send me his patchset
>>>>> with:
>>>>> git format-patch --stdout HEAD~x..HEAD~y > bq27xxx-lapa.mbox
>>>>>
>>>>
>>>> Who are you asking?
>>>
>>> You, if I may impose...
>>>
>>
>> Just rebase on v4.11-rc1...
>>
>>>>>>>  drivers/power/supply/bq27xxx_battery.c     | 19 +++++++++++++++++++
>>>>>>>  drivers/power/supply/bq27xxx_battery_i2c.c | 16 ++++++++--------
>>>>>>>  include/linux/power/bq27xxx_battery.h      | 25 ++++++++++++++++++-------
>>>>>>>  3 files changed, 45 insertions(+), 15 deletions(-)
>>>>>>>
>>>>>>> diff --git a/drivers/power/supply/bq27xxx_battery.c b/drivers/power/supply/bq27xxx_battery.c
>>>>>>> index 7272d1e..d613d3d 100644
>>>>>>> --- a/drivers/power/supply/bq27xxx_battery.c
>>>>>>> +++ b/drivers/power/supply/bq27xxx_battery.c
>>>>>>> @@ -1020,6 +1020,25 @@ int bq27xxx_battery_setup(struct bq27xxx_device_info *di)
>>>>>>>       struct power_supply_desc *psy_desc;
>>>>>>>       struct power_supply_config psy_cfg = { .drv_data = di, };
>>>>>>>
>>>>>>> +     switch(di->chip) {
>>>>>>> +     case BQ27000:
>>>>>>> +     case BQ27010:
>>>>>>> +     case BQ27500:
>>>>>>> +     case BQ27510:
>>>>>>> +     case BQ27530:
>>>>>>> +     case BQ27541:
>>>>>>> +     case BQ27545:
>>>>>>> +     case BQ27421: break;
>>>>>>
>>>>>> Why even have these cases then?
>>>>>
>>>>> You'll get a compiler warning if any are missing. Helps when adding new chips.
>>>>>
>>>>>>> +     case BQ27520: di->chip = BQ27510; break;
>>>>>>> +     case BQ27531: di->chip = BQ27530; break;
>>>>>>> +     case BQ27542: di->chip = BQ27541; break;
>>>>>>> +     case BQ27546: di->chip = BQ27541; break;
>>>>>>> +     case BQ27742: di->chip = BQ27541; break;
>>>>>>> +     case BQ27425: di->chip = BQ27421; break;
>>>>>>> +     case BQ27441: di->chip = BQ27421; break;
>>>>>>> +     case BQ27621: di->chip = BQ27421; break;
>>>>>>
>>>>>> Nope, don't like this at all, make a different variable, ->registers or
>>>>>> something to map to the register table. Plus I think changing the
>>>>>> variable you are switching on can cause undefined behavior.
>>>>>
>>>>> We had a different variable, .dmid, but you rejected a second ID
>>>>> field. I think this is better, as we eliminated the static arrays
>>>>> .dmid indexed. I didn't rename .chip to .category as that would cause
>>>>> trivial changes all over the file. I could do that in a final patch
>>>>> tho.
>>>>>
>>>>> You can modify a variable after switching on it, I promise.
>>>>>
>>>>>>> +     }
>>>>>>> +
>>>>>>>       INIT_DELAYED_WORK(&di->work, bq27xxx_battery_poll);
>>>>>>>       mutex_init(&di->lock);
>>>>>>>       di->regs = bq27xxx_regs[di->chip];
>>>>>>> diff --git a/drivers/power/supply/bq27xxx_battery_i2c.c b/drivers/power/supply/bq27xxx_battery_i2c.c
>>>>>>> index 5c5c3a6..13def59 100644
>>>>>>> --- a/drivers/power/supply/bq27xxx_battery_i2c.c
>>>>>>> +++ b/drivers/power/supply/bq27xxx_battery_i2c.c
>>>>>>> @@ -150,18 +150,18 @@ static const struct i2c_device_id bq27xxx_i2c_id_table[] = {
>>>>>>>       { "bq27210", BQ27010 },
>>>>>>>       { "bq27500", BQ27500 },
>>>>>>>       { "bq27510", BQ27510 },
>>>>>>> -     { "bq27520", BQ27510 },
>>>>>>> +     { "bq27520", BQ27520 },
>>>>>>>       { "bq27530", BQ27530 },
>>>>>>> -     { "bq27531", BQ27530 },
>>>>>>> +     { "bq27531", BQ27531 },
>>>>>>>       { "bq27541", BQ27541 },
>>>>>>> -     { "bq27542", BQ27541 },
>>>>>>> -     { "bq27546", BQ27541 },
>>>>>>> -     { "bq27742", BQ27541 },
>>>>>>> +     { "bq27542", BQ27542 },
>>>>>>> +     { "bq27546", BQ27546 },
>>>>>>> +     { "bq27742", BQ27742 },
>>>>>>>       { "bq27545", BQ27545 },
>>>>>>>       { "bq27421", BQ27421 },
>>>>>>> -     { "bq27425", BQ27421 },
>>>>>>> -     { "bq27441", BQ27421 },
>>>>>>> -     { "bq27621", BQ27421 },
>>>>>>> +     { "bq27425", BQ27425 },
>>>>>>> +     { "bq27441", BQ27441 },
>>>>>>> +     { "bq27621", BQ27621 },
>>>>>>>       {},
>>>>>>>  };
>>>>>>>  MODULE_DEVICE_TABLE(i2c, bq27xxx_i2c_id_table);
>>>>>>> diff --git a/include/linux/power/bq27xxx_battery.h b/include/linux/power/bq27xxx_battery.h
>>>>>>> index 92df553..90db1cf 100644
>>>>>>> --- a/include/linux/power/bq27xxx_battery.h
>>>>>>> +++ b/include/linux/power/bq27xxx_battery.h
>>>>>>> @@ -2,14 +2,25 @@
>>>>>>>  #define __LINUX_BQ27X00_BATTERY_H__
>>>>>>>
>>>>>>>  enum bq27xxx_chip {
>>>>>>> +     /* categories; index for bq27xxx_regs[] */
>>>>>>>       BQ27000 = 1, /* bq27000, bq27200 */
>>>>>>> -     BQ27010, /* bq27010, bq27210 */
>>>>>>> -     BQ27500, /* bq27500 */
>>>>>>> -     BQ27510, /* bq27510, bq27520 */
>>>>>>> -     BQ27530, /* bq27530, bq27531 */
>>>>>>> -     BQ27541, /* bq27541, bq27542, bq27546, bq27742 */
>>>>>>> -     BQ27545, /* bq27545 */
>>>>>>> -     BQ27421, /* bq27421, bq27425, bq27441, bq27621 */
>>>>>>> +     BQ27010 = 2, /* bq27010, bq27210 */
>>>>>>> +     BQ27500 = 3, /* bq27500 */
>>>>>>> +     BQ27510 = 4, /* bq27510, bq27520 */
>>>>>>> +     BQ27530 = 5, /* bq27530, bq27531 */
>>>>>>> +     BQ27541 = 6, /* bq27541, bq27542, bq27546, bq27742 */
>>>>>>> +     BQ27545 = 7, /* bq27545 */
>>>>>>> +     BQ27421 = 8, /* bq27421, bq27425, bq27441, bq27621 */
>>>>>>> +
>>>>>>> +     /* members of categories; translate these to category in _setup() */
>>>>>>> +     BQ27520 = 101,
>>>>>>> +     BQ27531 = 102,
>>>>>>> +     BQ27542 = 103,
>>>>>>> +     BQ27546 = 104,
>>>>>>> +     BQ27742 = 105,
>>>>>>> +     BQ27425 = 106,
>>>>>>> +     BQ27441 = 107,
>>>>>>> +     BQ27621 = 108,
>>>>>>
>>>>>> Get rid of this, just add new chip enum names if you need support for
>>>>>> new chips.
>>>>>
>>>>> How does a non-DT config obtain chip ID? We want explicit enum values
>>>>> if they appear in external platform-data objects. I'll mention that in
>>>>> the next patch description.
>>>>>
>>>>
>>>> platform-data is going away, I'm not sure what you are saying here.
>>>
>>> Don't 1-wire users have a platform-data config? You plan to force them
>>> to replace it with DT? I thought that wasn't kosher.
>>>
>>
>> The 1-wire driver generates this platform-data, 1-wire is a discoverable
>> bus, they never needed to define DT or platform data and still will not.
> 
> How does it map a discovered chip type to a bq27xxx_chip enum?
> 

Right now it just assumes the chip is a BQ27000, see line 45 of
drivers/w1/slaves/w1_bq27000.c

>>>>> The category (original) IDs index bq27xxx_regs[], and you'll probably
>>>>> extend that in time. So I placed the member (new) IDs well above the
>>>>> categories to allow permanent explicit values.
>>>>>
