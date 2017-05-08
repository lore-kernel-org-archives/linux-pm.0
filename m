From: "Andrew F. Davis" <afd@ti.com>
Subject: Re: [PATCH v13 10/11] power: supply: bq27xxx_battery: Flag identical
 register maps when in debug mode
Date: Mon, 8 May 2017 14:12:46 -0500
Message-ID: <a3139d5f-aa3c-7073-db4f-416c740184f7@ti.com>
References: <20170504061811.18107-1-liam@networkimprov.net>
 <20170504061811.18107-11-liam@networkimprov.net>
 <5bf09742-fb6e-69cf-b4cd-3042656f5985@ti.com>
 <CAKvHMgRW4=uV2Fq-LLxht2wjZ=aKmZavfoi_-gW+dLAwrvgfqA@mail.gmail.com>
 <d7f71378-c667-e8a8-6b9e-d3cfd369d13e@ti.com>
 <CAKvHMgRF4r7e2F6DR-M5zNrOcEROZZDa1ihNQx+BtUfU8dxd_w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from lelnx193.ext.ti.com ([198.47.27.77]:17529 "EHLO
        lelnx193.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752915AbdEHTNB (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 8 May 2017 15:13:01 -0400
In-Reply-To: <CAKvHMgRF4r7e2F6DR-M5zNrOcEROZZDa1ihNQx+BtUfU8dxd_w@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Liam Breck <liam@networkimprov.net>
Cc: Sebastian Reichel <sre@kernel.org>, linux-pm@vger.kernel.org, Liam Breck <kernel@networkimprov.net>

On 05/08/2017 02:07 PM, Liam Breck wrote:
> On Mon, May 8, 2017 at 8:01 AM, Andrew F. Davis <afd@ti.com> wrote:
>> On 05/08/2017 01:18 AM, Liam Breck wrote:
>>> On Thu, May 4, 2017 at 9:38 AM, Andrew F. Davis <afd@ti.com> wrote:
>>>> On 05/04/2017 01:18 AM, Liam Breck wrote:
>>>>> From: Liam Breck <kernel@networkimprov.net>
>>>>>
>>>>> We tie multiple chips to unique register maps. When supporting a new chip,
>>>>> it's easy to add a duplicate map by mistake.
>>>>>
>>>>> In debug mode we now scan the register maps for duplicates.
>>>>>
>>>>
>>>> Debugging stuff doesn't need to go upstream.
>>>
>>> Since we're keeping a dupeless reg table, please ack this so folks
>>> adding chips avoid adding dupes as Chris did.
>>>
>>> I don't have to mention there's tons of debug code upstream :-)
>>>
>>
>> If you want it then make it into a tool that can go into scripts/ or
>> tools/, it doesn't need to be inline cluttering up the source.
> 
> This code needs to read module static data. How would it work in an
> external file?
> 

If you are creating an external checking tool it can just ignore
'static' scope definitions when it is parsing this file.

> 
> 
>>>>> Signed-off-by: Liam Breck <kernel@networkimprov.net>
>>>>> ---
>>>>>  drivers/power/supply/bq27xxx_battery.c | 21 +++++++++++++++++++++
>>>>>  1 file changed, 21 insertions(+)
>>>>>
>>>>> diff --git a/drivers/power/supply/bq27xxx_battery.c b/drivers/power/supply/bq27xxx_battery.c
>>>>> index 0aecd41..97c646c 100644
>>>>> --- a/drivers/power/supply/bq27xxx_battery.c
>>>>> +++ b/drivers/power/supply/bq27xxx_battery.c
>>>>> @@ -1932,6 +1932,25 @@ static void bq27xxx_external_power_changed(struct power_supply *psy)
>>>>>       schedule_delayed_work(&di->work, 0);
>>>>>  }
>>>>>
>>>>> +#ifdef DEBUG
>>>>> +static void bq27xxx_battery_dbg_regs_dupes(struct bq27xxx_device_info *di)
>>>>> +{
>>>>> +     const size_t max = ARRAY_SIZE(bq27xxx_regs);
>>>>> +     int a, b;
>>>>> +
>>>>> +     for (a = 1; a < max-1; a++) {
>>>>> +             for (b = a+1; b < max; b++) {
>>>>> +                     if (!memcmp(bq27xxx_regs[a], bq27xxx_regs[b],
>>>>> +                                 sizeof(bq27xxx_regs[0])))
>>>>> +                             dev_warn(di->dev,
>>>>> +                                     "bq27xxx_regs[%d] & [%d] are identical\n", a, b);
>>>>> +             }
>>>>> +     }
>>>>> +}
>>>>> +#else
>>>>> +static inline void bq27xxx_battery_dbg_regs_dupes(struct bq27xxx_device_info *di) {}
>>>>> +#endif
>>>>> +
>>>>>  int bq27xxx_battery_setup(struct bq27xxx_device_info *di)
>>>>>  {
>>>>>       struct power_supply_desc *psy_desc;
>>>>> @@ -1940,6 +1959,8 @@ int bq27xxx_battery_setup(struct bq27xxx_device_info *di)
>>>>>               .drv_data = di,
>>>>>       };
>>>>>
>>>>> +     bq27xxx_battery_dbg_regs_dupes(di);
>>>>> +
>>>>>       di->ram_chip = di->chip == BQ27421 || di->chip == BQ27441 || di->chip == BQ27621;
>>>>>
>>>>>       di->unseal_key = bq27xxx_unseal_keys[di->chip];
>>>>>
