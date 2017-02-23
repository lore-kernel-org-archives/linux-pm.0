From: Liam Breck <liam@networkimprov.net>
Subject: Re: [PATCH v7 7/9] power: bq27xxx_battery: Add power_supply_battery_info
 support
Date: Thu, 23 Feb 2017 09:36:27 -0800
Message-ID: <CAKvHMgQx+Yb1hmTRovhZ7weoy1+D0j7HpveL2K9b_U79iFUK0w@mail.gmail.com>
References: <20170221213008.30044-1-liam@networkimprov.net>
 <20170221213008.30044-8-liam@networkimprov.net> <14c63dd0-9784-87e1-74b2-2d3e4026dab7@ti.com>
 <CAKvHMgTBKiy-+faF_SfNJbQEqyYhk4KVJnYfmrJWTgeL_gxeAQ@mail.gmail.com>
 <10fde05e-d5d7-c973-2882-3578235f5a41@ti.com> <CAKvHMgQUgh6_HOK613vhvkAoQU3y+AOxn6emQsuwr2HLTmZOYA@mail.gmail.com>
 <8bfb1289-f388-e835-1e11-228e6b971be1@ti.com> <CAKvHMgRu07MiT7sH-eRQEMXK8qraofEceOru7AT-rkuXS5zzTQ@mail.gmail.com>
 <3e407e80-3c35-5a16-5e0c-503cec5fe70f@ti.com> <CAKvHMgTfWJCW2vDsGf3anW2Day_nGDOaR0PyC3OAk=ZR_LFS9A@mail.gmail.com>
 <237fd0ee-6bd0-f3ff-9c8c-bc3629f10f67@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-it0-f65.google.com ([209.85.214.65]:33850 "EHLO
        mail-it0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751049AbdBWRhE (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 23 Feb 2017 12:37:04 -0500
Received: by mail-it0-f65.google.com with SMTP id r141so1203953ita.1
        for <linux-pm@vger.kernel.org>; Thu, 23 Feb 2017 09:36:28 -0800 (PST)
In-Reply-To: <237fd0ee-6bd0-f3ff-9c8c-bc3629f10f67@ti.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Andrew F. Davis" <afd@ti.com>
Cc: Sebastian Reichel <sre@kernel.org>, linux-pm@vger.kernel.org, Matt Ranostay <matt@ranostay.consulting>

On Thu, Feb 23, 2017 at 8:53 AM, Andrew F. Davis <afd@ti.com> wrote:
> On 02/23/2017 10:38 AM, Liam Breck wrote:
>> On Thu, Feb 23, 2017 at 8:08 AM, Andrew F. Davis <afd@ti.com> wrote:
>>> On 02/23/2017 09:49 AM, Liam Breck wrote:
>>>> On Thu, Feb 23, 2017 at 7:17 AM, Andrew F. Davis <afd@ti.com> wrote:
>>>>> On 02/22/2017 06:54 PM, Liam Breck wrote:
>>>>>> On Wed, Feb 22, 2017 at 4:30 PM, Andrew F. Davis <afd@ti.com> wrote:
>>>>>>> On 02/22/2017 03:29 PM, Liam Breck wrote:
>>>>>>>> On Wed, Feb 22, 2017 at 12:35 PM, Andrew F. Davis <afd@ti.com> wrote:
>>>>>>>>> On 02/21/2017 03:30 PM, Liam Breck wrote:
>>>>>>>>>> From: Liam Breck <kernel@networkimprov.net>
>>>>>>>>>>
>>>>>>>>>> Previously there was no way to configure chip registers in the event that the
>>>>>>>>>> defaults didn't match the battery in question.
>>>>>>>>>>
>>>>>>>>>> BQ27xxx driver now calls power_supply_get_battery_info, checks the inputs,
>>>>>>>>>> and writes battery data to chip RAM or non-volatile memory.
>>>>>>>>>>
>>>>>>>>>> Signed-off-by: Matt Ranostay <matt@ranostay.consulting>
>>>>>>>>>> Signed-off-by: Liam Breck <kernel@networkimprov.net>
>>>>>>>>>> ---
>>>>>>>>>>  drivers/power/supply/bq27xxx_battery.c | 399 ++++++++++++++++++++++++++++++++-
>>>>>>>>>>  1 file changed, 397 insertions(+), 2 deletions(-)
>>>>>>>>>>
>>>>>>>>>> diff --git a/drivers/power/supply/bq27xxx_battery.c b/drivers/power/supply/bq27xxx_battery.c
>>>>>>>>>> index 7475a5f..8085d4a 100644
>>>>>>>>>> --- a/drivers/power/supply/bq27xxx_battery.c
>>>>>>>>>> +++ b/drivers/power/supply/bq27xxx_battery.c
>>>>>>>>>> @@ -51,7 +51,7 @@
>>>>>>>>>>
>>>>>>>>>>  #include <linux/power/bq27xxx_battery.h>
>>>>>>>>>>
>>>>>>>>>> -#define DRIVER_VERSION               "1.2.0"
>>>>>>>>>> +#define DRIVER_VERSION               "1.3.0"
>>>>>>>>>>
>>>>>>>>>>  #define BQ27XXX_MANUFACTURER "Texas Instruments"
>>>>>>>>>>
>>>>>>>>>> @@ -452,6 +452,99 @@ static struct {
>>>>>>>>>>  static DEFINE_MUTEX(bq27xxx_list_lock);
>>>>>>>>>>  static LIST_HEAD(bq27xxx_battery_devices);
>>>>>>>>>>
>>>>>>>>>> +/* writable registers */
>>>>>>>>>> +#define BQ27XXX_CONTROL                      0x00
>>>>>>>>>> +#define BQ27XXX_DATA_CLASS           0x3E
>>>>>>>>>> +#define BQ27XXX_DATA_BLOCK           0x3F
>>>>>>>>>> +#define BQ27XXX_BLOCK_DATA           0x40
>>>>>>>>>> +#define BQ27XXX_BLOCK_DATA_CHECKSUM  0x60
>>>>>>>>>> +#define BQ27XXX_BLOCK_DATA_CONTROL   0x61
>>>>>>>>>> +
>>>>>>>>>
>>>>>>>>> These all belong in the bq27xxx_regs array, you can add new register
>>>>>>>>> types to the bq27xxx_reg_index enum.
>>>>>>>>
>>>>>>>> They're the same on all chips. Let's dup this code 9+ times when we have cause.
>>>>>>>>
>>>>>>>
>>>>>>> They are not the same on all chips, some chips don't have these
>>>>>>> registers at all. Plus, BQ27XXX_CONTROL is the same for all chips, and
>>>>>>> we already have it in all the chips bq27xxx_regs.
>>>>>>
>>>>>> Datasheets? Do those chips even support this feature set? Bqtool
>>>>>> doesn't appear to support any other memory update scheme.
>>>>>>
>>>>>
>>>>> Many chips don't, which is why we don't want these registers being
>>>>> global defines, you can have the chips without these registers as
>>>>> INVALID_REG_ADDR
>>>>
>>>> Chips that don't support memory update won't have a bq27xxx_dm_regs
>>>> list; we look for that at the start of this code path and do nothing
>>>> if it's null for di->chip. All chips that do support memory update use
>>>> the same command registers, so there's no reason to dup those.
>>>>
>>>
>>> Someday they might use a different value, we don't lose anything by
>>> putting these device registers in the table with the other device
>>> registers. I would rather duplicate some lines if it makes the code more
>>> uniform and easier to follow, again this is not a contest, we write code
>>> for ourselves, let the compiler organize/optimize things.
>>
>> I prefer the principle that every line you write must have a purpose
>> in the current codebase, vs a future one. But if you are adamant, I
>> capitulate.
>>
>
> Normally I would agree, but for listing registers on a device we would
> have a register map that looks like swiss cheese.

Was that adamant? Keep the readable registers in tables; make the
writable ones universal since they're all the same.

>>>> Also you can delete REG_CTRL as it's not used by the existing code  :-)
>>>>
>>>
>>> True, but as before, I just like having the complete register set in a
>>> nice simple table, as opposed to having to add and change things all
>>> over if/when we may need that register.
>>>
>>> Being a static table, I wonder if a sufficiently smart compiler could
>>> see that it is not used and optimize the value out for us...
>>
>> No :-p All the compiler can do for unused data is issue a warning. And
>> it can't do so for array elements.
>>
>
> I said "sufficiently smart compiler", it could find that no code within
> the tables context accesses it outside of the set indexes, it could then
> even remove the tables altogether and replace accesses with immediate
> values. Not practical, but not impossible, I think.. :)

I'm not so interested in hypothetical compilers and chips. There are
reasons why compilers don't optimize away data.

>> You really should define those tables in a function which memcpy's the
>> right one onto di.regs.
>
> What would that do for us? We still need to store the tables, it just
> removes one level of pointers.

It would store 1 table for the life of the kernel, vs 9+
