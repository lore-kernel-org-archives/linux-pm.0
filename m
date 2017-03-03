From: "Andrew F. Davis" <afd@ti.com>
Subject: Re: [PATCH v8 7/9] power: bq27xxx_battery: Add
 power_supply_battery_info support
Date: Fri, 3 Mar 2017 16:07:21 -0600
Message-ID: <dcb2a958-6c39-b677-5da0-8c749a9e68dd@ti.com>
References: <20170227071117.18934-1-liam@networkimprov.net>
 <20170227071117.18934-8-liam@networkimprov.net>
 <CAKvHMgQCfVK5k1-HU4UjT4oxOYDXU2LP7UaApNHZ8_NXM94How@mail.gmail.com>
 <3690ab9c-ea76-1b18-b51c-8ed6c165bf43@ti.com>
 <CAKvHMgSz1UAb_ArRs-Ch3EknPj5rSepT0hcjyFgBgVG+KKGy2g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from fllnx209.ext.ti.com ([198.47.19.16]:54498 "EHLO
        fllnx209.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751869AbdCCWIM (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 3 Mar 2017 17:08:12 -0500
In-Reply-To: <CAKvHMgSz1UAb_ArRs-Ch3EknPj5rSepT0hcjyFgBgVG+KKGy2g@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Liam Breck <liam@networkimprov.net>
Cc: Sebastian Reichel <sre@kernel.org>, linux-pm@vger.kernel.org, Matt Ranostay <matt@ranostay.consulting>, Liam Breck <kernel@networkimprov.net>

On 03/03/2017 04:04 PM, Liam Breck wrote:
> On Fri, Mar 3, 2017 at 1:51 PM, Andrew F. Davis <afd@ti.com> wrote:
>> On 03/03/2017 03:36 PM, Liam Breck wrote:
>>> Hi Andrew,
>>>
>>> On Sun, Feb 26, 2017 at 11:11 PM, Liam Breck <liam@networkimprov.net> wrote:
>>>> From: Liam Breck <kernel@networkimprov.net>
>>>>
>>>> Previously there was no way to configure chip registers in the event that the
>>>> defaults didn't match the battery in question.
>>>>
>>>> BQ27xxx driver now calls power_supply_get_battery_info, checks the inputs,
>>>> and writes battery data to chip RAM or non-volatile memory.
>>>>
>>>> Signed-off-by: Matt Ranostay <matt@ranostay.consulting>
>>>> Signed-off-by: Liam Breck <kernel@networkimprov.net>
>>>> ---
>>>>  drivers/power/supply/bq27xxx_battery.c | 458 ++++++++++++++++++++++++++++++++-
>>>>  1 file changed, 456 insertions(+), 2 deletions(-)
>>>>
>>>> diff --git a/drivers/power/supply/bq27xxx_battery.c b/drivers/power/supply/bq27xxx_battery.c
>>>> index 7475a5f..41d4ce7 100644
>>>> --- a/drivers/power/supply/bq27xxx_battery.c
>>>> +++ b/drivers/power/supply/bq27xxx_battery.c
>>>
>>>> @@ -452,6 +508,81 @@ static struct {
>>>>  static DEFINE_MUTEX(bq27xxx_list_lock);
>>>>  static LIST_HEAD(bq27xxx_battery_devices);
>>>>
>>>> +#define BQ27XXX_DM_SZ                  32
>>>> +
>>>> +#define BQ27XXX_MSLEEP(i) usleep_range((i)*1000, (i)*1000+500)
>>>> +
>>>> +struct bq27xxx_dm_reg {
>>>> +       u8 subclass_id;
>>>> +       u8 offset;
>>>> +       u8 bytes;
>>>> +       u16 min, max;
>>>> +};
>>>> +
>>>> +struct bq27xxx_dm_buf {
>>>> +       u8 class;
>>>> +       u8 block;
>>>> +       u8 a[BQ27XXX_DM_SZ];
>>>> +       bool full, updt;
>>>> +};
>>>> +
>>>> +#define BQ27XXX_DM_BUF(di, i) { \
>>>> +       .class = bq27xxx_dm_regs[(di)->chip][i].subclass_id, \
>>>> +       .block = bq27xxx_dm_regs[(di)->chip][i].offset / BQ27XXX_DM_SZ, \
>>>> +}
>>>> +
>>>> +static inline u16* bq27xxx_dm_buf_ptr(struct bq27xxx_dm_buf *buf,
>>>> +                                     struct bq27xxx_dm_reg *reg) {
>>>> +       if (buf->class == reg->subclass_id
>>>> +        && buf->block == reg->offset / BQ27XXX_DM_SZ)
>>>> +               return (u16*) (buf->a + reg->offset % BQ27XXX_DM_SZ);
>>>> +
>>>> +       return NULL;
>>>> +}
>>>> +
>>>> +enum bq27xxx_dm_reg_id {
>>>> +       BQ27XXX_DM_DESIGN_CAPACITY = 0,
>>>> +       BQ27XXX_DM_DESIGN_ENERGY,
>>>> +       BQ27XXX_DM_TERMINATE_VOLTAGE,
>>>> +};
>>>> +
>>>> +static const char* bq27xxx_dm_reg_name[] = {
>>>> +       [BQ27XXX_DM_DESIGN_CAPACITY] = "design-capacity",
>>>> +       [BQ27XXX_DM_DESIGN_ENERGY] = "design-energy",
>>>> +       [BQ27XXX_DM_TERMINATE_VOLTAGE] = "terminate-voltage",
>>>> +};
>>>> +
>>>> +static struct bq27xxx_dm_reg bq27425_dm_regs[] = {
>>>> +       [BQ27XXX_DM_DESIGN_CAPACITY]   = { 82, 12, 2,    0, 32767 },
>>>> +       [BQ27XXX_DM_DESIGN_ENERGY]     = { 82, 14, 2,    0, 32767 },
>>>> +       [BQ27XXX_DM_TERMINATE_VOLTAGE] = { 82, 18, 2, 2800,  3700 },
>>>> +};
>>>> +
>>>> +static struct bq27xxx_dm_reg bq27421_dm_regs[] = { /* not tested */
>>>> +       [BQ27XXX_DM_DESIGN_CAPACITY]   = { 82, 10, 2,    0,  8000 },
>>>> +       [BQ27XXX_DM_DESIGN_ENERGY]     = { 82, 12, 2,    0, 32767 },
>>>> +       [BQ27XXX_DM_TERMINATE_VOLTAGE] = { 82, 16, 2, 2500,  3700 },
>>>> +};
>>>> +
>>>> +//static struct bq27xxx_dm_reg bq27621_dm_regs[] = { /* not tested */
>>>> +//     [BQ27XXX_DM_DESIGN_CAPACITY]   = { 82, 3, 2,    0,  8000 },
>>>> +//     [BQ27XXX_DM_DESIGN_ENERGY]     = { 82, 5, 2,    0, 32767 },
>>>> +//     [BQ27XXX_DM_TERMINATE_VOLTAGE] = { 82, 9, 2, 2500,  3700 },
>>>> +//};
>>>> +
>>>> +static struct bq27xxx_dm_reg *bq27xxx_dm_regs[] = {
>>>> +       [BQ27421] = bq27421_dm_regs, /* and BQ27441 */
>>>> +       [BQ27425] = bq27425_dm_regs,
>>>> +//     [BQ27621] = bq27621_dm_regs,
>>>> +};
>>>> +
>>>> +static u32 bq27xxx_unseal_keys[] = {
>>>> +       [BQ27421] = 0x80008000, /* and BQ27441 */
>>>> +       [BQ27425] = 0x04143672,
>>>> +//     [BQ27621] = 0x80008000,
>>>> +};
>>>
>>> Maybe instead of defining dm_regs_* tables for many chips in this
>>> file, we should land them in a new header, to let the kernel builder
>>> define and/or pick one for his platform by setting a config option,
>>> e.g. config_bq27xxx_dm_type=421
>>>
>>
>> Size isn't really an issue, we build drivers for parts we may not have,
>> you should be able to add a part to a system and only change the DT. So
>> supporting all these chips is okay.
> 
> OK but suppose kernel builders define a dm_regs{} when it's missing.
> Doing that in bq27xxx_battery.c isn't ideal.
> 

Why would it be missing? All this stuff should be left defined always,
if it is unused on a particular board that really cant be avoided.

>>> We could also pull in the dm update code if such an option is defined,
>>> tho it isn't that much code, ~230 lines plus whitespace.
>>>
>>
>> We can have a config option to enable support for DM update, if it can
>> be factored out in such a way. Otherwise if someone uses it, just
>> include it for everyone, if they need it it's there, if they don't then
>> no harm done.
>>
>>> Thoughts?
>>>
