From: Liam Breck <liam@networkimprov.net>
Subject: Re: [PATCH] power: bq27xxx_battery: Unique chip IDs
Date: Thu, 9 Mar 2017 09:43:18 -0800
Message-ID: <CAKvHMgSDkB6+dt9LXmRv6+U5MHzzdAwxBUQjJ+He7QwQ6kTJxQ@mail.gmail.com>
References: <20170307230536.22886-1-liam@networkimprov.net>
 <0088f5a9-995e-bc57-6fa1-3c8991287a13@ti.com> <CAKvHMgR2g3OftVOfPiunDf25EsCz0f5LXW3ch-TZd8dr0tLBJQ@mail.gmail.com>
 <739da500-67dc-ec2e-f790-e68855c31594@ti.com> <CAKvHMgRM4c=m8UcDWvPu3RQf=vmHag6kTXa6aD8PmMu9yPYuXw@mail.gmail.com>
 <1fc5a7ff-6cb0-a2b1-95b5-8059704c9994@ti.com> <CAKvHMgRHg5Z=++B3Zu57JZHdo2o5gB7bJqKUMDH7zLVbmY2DVw@mail.gmail.com>
 <CAKvHMgTgMZN9AJZGdeJ-4jBGUS1NkiqacJ9YQOf97kRq9SnOJA@mail.gmail.com>
 <2fd3205a-e842-b198-28c4-1bf909856359@ti.com> <fbf98e1a-1181-fa09-e7fc-de25ba476dae@ti.com>
 <CAKvHMgSyizm7UhyaUY5A9vjP0tTjZVbJ10M1a3TBK-F7aZsx_Q@mail.gmail.com> <6c13b7f8-1303-13e5-3bcb-a01e5c6cca0f@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-it0-f68.google.com ([209.85.214.68]:33692 "EHLO
        mail-it0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932472AbdCIRnU (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 9 Mar 2017 12:43:20 -0500
Received: by mail-it0-f68.google.com with SMTP id g138so10737077itb.0
        for <linux-pm@vger.kernel.org>; Thu, 09 Mar 2017 09:43:20 -0800 (PST)
In-Reply-To: <6c13b7f8-1303-13e5-3bcb-a01e5c6cca0f@ti.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Andrew F. Davis" <afd@ti.com>
Cc: linux-pm@vger.kernel.org, Liam Breck <kernel@networkimprov.net>

On Thu, Mar 9, 2017 at 9:33 AM, Andrew F. Davis <afd@ti.com> wrote:
> On 03/09/2017 11:26 AM, Liam Breck wrote:
>> On Thu, Mar 9, 2017 at 7:38 AM, Andrew F. Davis <afd@ti.com> wrote:
>>> On 03/09/2017 09:30 AM, Andrew F. Davis wrote:
>>>> On 03/08/2017 05:49 PM, Liam Breck wrote:
>>>>> On Wed, Mar 8, 2017 at 1:22 PM, Liam Breck <liam@networkimprov.net> wrote:
>>>>>> On Wed, Mar 8, 2017 at 10:23 AM, Andrew F. Davis <afd@ti.com> wrote:
>>>>>>> On 03/08/2017 12:16 PM, Liam Breck wrote:
>>>>>>>> On Wed, Mar 8, 2017 at 9:58 AM, Andrew F. Davis <afd@ti.com> wrote:
>>>>>>>>> On 03/08/2017 11:45 AM, Liam Breck wrote:
>>>>>>>>>> On Wed, Mar 8, 2017 at 9:23 AM, Andrew F. Davis <afd@ti.com> wrote:
>>>>>>>>>>> On 03/07/2017 05:05 PM, Liam Breck wrote:
>>>>>>>>>>>> From: Liam Breck <kernel@networkimprov.net>
>>>>>>>>>>>>
>>>>>>>>>>>> Assign every chip a unique ID, to enable
>>>>>>>>>>>> power_supply_battery_info config for all supported chips.
>>>>>>>>>>>> There are no functional changes to the driver.
>>>>>>>>>>>>
>>>>>>>>>>>> Depends-on: power: bq27xxx_battery: Add power_supply_battery_info support
>>>>>>>>>>>> Signed-off-by: Liam Breck <kernel@networkimprov.net>
>>>>>>>>>>>>
>>>>>>>>>>>> ---
>>>>>>>>>>>> Andrew, let me know if you'd like me to include this in the other patchset.
>>>>>>>>>>>
>>>>>>>>>>> Why do we need this at all? It may be just bit too early for me, but I'm
>>>>>>>>>>> not seeing what this gets us, that couldn't be done before.
>>>>>>>>>>
>>>>>>>>>> Sadly, the chips mostly have different dm_reg tables, so we need the
>>>>>>>>>> real chip ID to give each a table.
>>>>>>>>>>
>>>>>>>>>> My last rev only supported IDs associated with a single chip: 500,
>>>>>>>>>> 545, 421. In the 421 case, we had to split off that ID.
>>>>>>>>>>
>>>>>>>>>
>>>>>>>>> Okay, then if we need a new ID lets add it. Going back to having a table
>>>>>>>>> of pointers is a step back, we used to do it this way, but every-time a
>>>>>>>>> new chip appeared or we found a delta in an existing chip(s) (like you
>>>>>>>>> are finding now) we would have to re-organize the pointer table and
>>>>>>>>> other associated tables, it is much cleaner and easier to review (more
>>>>>>>>> important than code size by orders of magnitude IMHO) to just add a new
>>>>>>>>> entry into the big master table of registers.
>>>>>>>>
>>>>>>>> There were 8 mostly unique reg tables, and you'd need 8 dups to make
>>>>>>>> all the IDs explicit.
>>>>>>>>
>>>>>>>
>>>>>>> Why do all IDs need to be explicit, most have the same register set.
>>>>>>
>>>>>> The DM registers are different. See:
>>>>>>   bq27500_dm_regs[]
>>>>>>   bq27545_dm_regs[]
>>>>>>   bq27421_dm_regs[]
>>>>>>   bq27425_dm_regs[]
>>>>>>   bq27621_dm_regs[]
>>>>>
>>>>> Another way to handle this is using a separate field for the dm_regs[]
>>>>> index, e.g. di->dmid.
>>>>>
>>>>> That's a smaller patch, roughly +20 LoC.
>>>>>
>>>>
>>>> This might work better
>>>>
>>>
>>> Hmmm, looking at the other patch, I think I'll take that back, I guess
>>> I'm not so apposed to this method seeing what would need to be done
>>> otherwise...
>>
>> I'm strongly in favor of the newer, shorter patch, with .chip & .dmid.
>> It's much less work to maintain than the .chip-only approach.
>>
>> I can set .dmid instead of .chip in the probe functions if that makes
>> it clearer.
>>
>> BTW the enum values should be explicit in any case, since they appear
>> in platform_data objects outside the driver.
>>
>
> The only part I didn't like was the duplicate enum values, each chip
> should have one unique ID, I think what ever way you prefer would work
> for the table structure, lets just keep the chip ID enums clean.

It has a group ID (.chip) and a part ID (.dmid). In some cases they
are the same value  but so what.

I didn't want to rename .chip to .group since it appears a lot.

>>>>>>>> You're already using a table of pointers for the property lists.
>>>>>>>>
>>>>>>>> I don't see how adding an entry to a pointer table is worse than
>>>>>>>> adding an entire reg table. Sure, now and then you'd need to add both.
>>>>>>>>
>>>>>>>>>>>>  drivers/power/supply/bq27xxx_battery.c     | 94 +++++++++++++++++-------------
>>>>>>>>>>>>  drivers/power/supply/bq27xxx_battery_i2c.c | 14 ++---
>>>>>>>>>>>>  include/linux/power/bq27xxx_battery.h      | 15 +++--
>>>>>>>>>>>>  3 files changed, 71 insertions(+), 52 deletions(-)
>>>>>>>>>>>>
>>>>>>>>>>>> diff --git a/drivers/power/supply/bq27xxx_battery.c b/drivers/power/supply/bq27xxx_battery.c
>>>>>>>>>>>> index ed976a1..30af0e4 100644
>>>>>>>>>>>> --- a/drivers/power/supply/bq27xxx_battery.c
>>>>>>>>>>>> +++ b/drivers/power/supply/bq27xxx_battery.c
>>>>>>>>>>
>>>>>>>>>>>> +static u8* bq27xxx_regs[] = {
>>>>>>>>>>>> +     [BQ27000] = bq27000_regs, /* really bq27200 */
>>>>>>>>>>>> +     [BQ27010] = bq27010_regs, /* really bq27210 */
>>>>>>>>>>>
>>>>>>>>>>> Not strictly true, the bq270x0 and bq272x0 are different chips, one has
>>>>>>>>>>> an HDQ bus and the other I2C, later chips have both ports on each chip.
>>>>>>>>>>
>>>>>>>>>> Oh, I saw only the 200 & 210 in _i2c.c, and forgot that the driver
>>>>>>>>>> supports another interface. I'll remove those comments.
>>>>>>>>>>
>>>>>>>>>> I won't separate these IDs as none of them support DM update.
>>>>>>>>>>
>>>>>>>>>> Think you could do some testing soon?
>>>>>>>>>>
>>>>>>>>>
>>>>>>>>> Yeah, I could probably fit some testing into my schedule, I'll see what
>>>>>>>>> v9 looks like before I unpack the boards.
