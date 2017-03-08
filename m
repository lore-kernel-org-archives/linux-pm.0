From: "Andrew F. Davis" <afd@ti.com>
Subject: Re: [PATCH] power: bq27xxx_battery: Unique chip IDs
Date: Wed, 8 Mar 2017 12:23:56 -0600
Message-ID: <1fc5a7ff-6cb0-a2b1-95b5-8059704c9994@ti.com>
References: <20170307230536.22886-1-liam@networkimprov.net>
 <0088f5a9-995e-bc57-6fa1-3c8991287a13@ti.com>
 <CAKvHMgR2g3OftVOfPiunDf25EsCz0f5LXW3ch-TZd8dr0tLBJQ@mail.gmail.com>
 <739da500-67dc-ec2e-f790-e68855c31594@ti.com>
 <CAKvHMgRM4c=m8UcDWvPu3RQf=vmHag6kTXa6aD8PmMu9yPYuXw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from fllnx209.ext.ti.com ([198.47.19.16]:42661 "EHLO
        fllnx209.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754298AbdCHVSz (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 8 Mar 2017 16:18:55 -0500
In-Reply-To: <CAKvHMgRM4c=m8UcDWvPu3RQf=vmHag6kTXa6aD8PmMu9yPYuXw@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Liam Breck <liam@networkimprov.net>
Cc: linux-pm@vger.kernel.org, Liam Breck <kernel@networkimprov.net>

On 03/08/2017 12:16 PM, Liam Breck wrote:
> On Wed, Mar 8, 2017 at 9:58 AM, Andrew F. Davis <afd@ti.com> wrote:
>> On 03/08/2017 11:45 AM, Liam Breck wrote:
>>> On Wed, Mar 8, 2017 at 9:23 AM, Andrew F. Davis <afd@ti.com> wrote:
>>>> On 03/07/2017 05:05 PM, Liam Breck wrote:
>>>>> From: Liam Breck <kernel@networkimprov.net>
>>>>>
>>>>> Assign every chip a unique ID, to enable
>>>>> power_supply_battery_info config for all supported chips.
>>>>> There are no functional changes to the driver.
>>>>>
>>>>> Depends-on: power: bq27xxx_battery: Add power_supply_battery_info support
>>>>> Signed-off-by: Liam Breck <kernel@networkimprov.net>
>>>>>
>>>>> ---
>>>>> Andrew, let me know if you'd like me to include this in the other patchset.
>>>>
>>>> Why do we need this at all? It may be just bit too early for me, but I'm
>>>> not seeing what this gets us, that couldn't be done before.
>>>
>>> Sadly, the chips mostly have different dm_reg tables, so we need the
>>> real chip ID to give each a table.
>>>
>>> My last rev only supported IDs associated with a single chip: 500,
>>> 545, 421. In the 421 case, we had to split off that ID.
>>>
>>
>> Okay, then if we need a new ID lets add it. Going back to having a table
>> of pointers is a step back, we used to do it this way, but every-time a
>> new chip appeared or we found a delta in an existing chip(s) (like you
>> are finding now) we would have to re-organize the pointer table and
>> other associated tables, it is much cleaner and easier to review (more
>> important than code size by orders of magnitude IMHO) to just add a new
>> entry into the big master table of registers.
> 
> There were 8 mostly unique reg tables, and you'd need 8 dups to make
> all the IDs explicit.
> 

Why do all IDs need to be explicit, most have the same register set.

> You're already using a table of pointers for the property lists.
> 
> I don't see how adding an entry to a pointer table is worse than
> adding an entire reg table. Sure, now and then you'd need to add both.
> 
>>>>>  drivers/power/supply/bq27xxx_battery.c     | 94 +++++++++++++++++-------------
>>>>>  drivers/power/supply/bq27xxx_battery_i2c.c | 14 ++---
>>>>>  include/linux/power/bq27xxx_battery.h      | 15 +++--
>>>>>  3 files changed, 71 insertions(+), 52 deletions(-)
>>>>>
>>>>> diff --git a/drivers/power/supply/bq27xxx_battery.c b/drivers/power/supply/bq27xxx_battery.c
>>>>> index ed976a1..30af0e4 100644
>>>>> --- a/drivers/power/supply/bq27xxx_battery.c
>>>>> +++ b/drivers/power/supply/bq27xxx_battery.c
>>>
>>>>> +static u8* bq27xxx_regs[] = {
>>>>> +     [BQ27000] = bq27000_regs, /* really bq27200 */
>>>>> +     [BQ27010] = bq27010_regs, /* really bq27210 */
>>>>
>>>> Not strictly true, the bq270x0 and bq272x0 are different chips, one has
>>>> an HDQ bus and the other I2C, later chips have both ports on each chip.
>>>
>>> Oh, I saw only the 200 & 210 in _i2c.c, and forgot that the driver
>>> supports another interface. I'll remove those comments.
>>>
>>> I won't separate these IDs as none of them support DM update.
>>>
>>> Think you could do some testing soon?
>>>
>>
>> Yeah, I could probably fit some testing into my schedule, I'll see what
>> v9 looks like before I unpack the boards.
