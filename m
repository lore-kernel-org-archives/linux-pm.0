From: Liam Breck <liam@networkimprov.net>
Subject: Re: [PATCH v13 09/11] power: supply: bq27xxx_battery: Enable data
 memory update for certain chips
Date: Mon, 8 May 2017 12:02:26 -0700
Message-ID: <CAKvHMgRonN10XZAtFRLo7sxDcoBCiPhJib22YhzLpdMvjAr1TQ@mail.gmail.com>
References: <20170504061811.18107-1-liam@networkimprov.net>
 <20170504061811.18107-10-liam@networkimprov.net> <e11bb744-ac01-8499-18a2-2e9fb3fb5c38@ti.com>
 <CAKvHMgSmMGLXTdeDfu1wP7NxoJP8fJ+YyZvSs7rvOC8uQzk3ng@mail.gmail.com>
 <73f5eb07-dda0-ec1c-2412-e186a42918ba@ti.com> <CAKvHMgTa9rFAdV0QYAAPGskHZo+H58sa-6H0DL-7PosywzhFtw@mail.gmail.com>
 <c6f0b1f8-9e62-995a-0175-f330abf7f6fb@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-io0-f195.google.com ([209.85.223.195]:33956 "EHLO
        mail-io0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755226AbdEHTC2 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 8 May 2017 15:02:28 -0400
Received: by mail-io0-f195.google.com with SMTP id 12so9846653iol.1
        for <linux-pm@vger.kernel.org>; Mon, 08 May 2017 12:02:28 -0700 (PDT)
In-Reply-To: <c6f0b1f8-9e62-995a-0175-f330abf7f6fb@ti.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Andrew F. Davis" <afd@ti.com>
Cc: Sebastian Reichel <sre@kernel.org>, linux-pm@vger.kernel.org, Liam Breck <kernel@networkimprov.net>

On Mon, May 8, 2017 at 8:00 AM, Andrew F. Davis <afd@ti.com> wrote:
> On 05/08/2017 01:40 AM, Liam Breck wrote:
>> On Fri, May 5, 2017 at 12:45 PM, Andrew F. Davis <afd@ti.com> wrote:
>>> On 05/05/2017 02:31 PM, Liam Breck wrote:
>>>> On Thu, May 4, 2017 at 10:00 AM, Andrew F. Davis <afd@ti.com> wrote:
>>>>> On 05/04/2017 01:18 AM, Liam Breck wrote:
>>>>>> From: Liam Breck <kernel@networkimprov.net>
>>>>>>
>>>>>> Support data memory update on BQ27500, 545, 425, 421, 441, 621.
>>>>>>
>>>>>> Create IDs for for previously unID'd chips, to index arrays for unseal keys
>>>>>> and data memory register tables.
>>>>>>
>>>>>> Signed-off-by: Liam Breck <kernel@networkimprov.net>
>>>>>> ---
>>>>>>  drivers/power/supply/bq27xxx_battery.c     | 90 ++++++++++++++++++++++++++++--
>>>>>>  drivers/power/supply/bq27xxx_battery_i2c.c | 16 +++---
>>>>>>  include/linux/power/bq27xxx_battery.h      | 13 +++++
>>>>>>  3 files changed, 107 insertions(+), 12 deletions(-)
>>>>>>
>>>>>> diff --git a/drivers/power/supply/bq27xxx_battery.c b/drivers/power/supply/bq27xxx_battery.c
>>>>>> index 06f15da..0aecd41 100644
>>>>>> --- a/drivers/power/supply/bq27xxx_battery.c
>>>>>> +++ b/drivers/power/supply/bq27xxx_battery.c
>>>>>> @@ -58,7 +58,7 @@
>>>>>>
>>>>>>  #include <linux/power/bq27xxx_battery.h>
>>>>>>
>>>>>> -#define DRIVER_VERSION               "1.2.0"
>>>>>> +#define DRIVER_VERSION               "1.3.0"
>>>>>>
>>>>>>  #define BQ27XXX_MANUFACTURER "Texas Instruments"
>>>>>>
>>>>>> @@ -132,7 +132,7 @@ enum bq27xxx_reg_index {
>>>>>>       [BQ27XXX_DM_CKSUM] = 0x60
>>>>>>
>>>>>>  /* Register mappings */
>>>>>> -static u8 bq27xxx_regs[][BQ27XXX_REG_MAX] = {
>>>>>> +static u8 bq27xxx_regs[BQ27MAX][BQ27XXX_REG_MAX] = {
>>>>>>       [BQ27000] = {
>>>>>>               [BQ27XXX_REG_CTRL] = 0x00,
>>>>>>               [BQ27XXX_REG_TEMP] = 0x06,
>>>>>> @@ -779,7 +779,7 @@ static enum power_supply_property bq27421_battery_props[] = {
>>>>>>  static struct {
>>>>>>       enum power_supply_property *props;
>>>>>>       size_t size;
>>>>>> -} bq27xxx_battery_props[] = {
>>>>>> +} bq27xxx_battery_props[BQ27MAX] = {
>>>>>>       BQ27XXX_PROP(BQ27000, bq27000_battery_props),
>>>>>>       BQ27XXX_PROP(BQ27010, bq27010_battery_props),
>>>>>>       BQ27XXX_PROP(BQ2750X, bq2750x_battery_props),
>>>>>> @@ -798,6 +798,33 @@ static struct {
>>>>>>       BQ27XXX_PROP(BQ27421, bq27421_battery_props),
>>>>>>  };
>>>>>>
>>>>>> +static enum bq27xxx_chip bq27xxx_chips[] = {
>>>>>> +     [BQ27000]   = BQ27000,
>>>>>> +     [BQ27010]   = BQ27010,
>>>>>> +     [BQ2750X]   = BQ2750X,
>>>>>> +     [BQ2751X]   = BQ2751X,
>>>>>> +     [BQ2752X]   = BQ2751X,
>>>>>> +     [BQ27500]   = BQ27500,
>>>>>> +     [BQ27510G1] = BQ27510G1,
>>>>>> +     [BQ27510G2] = BQ27510G2,
>>>>>> +     [BQ27510G3] = BQ27510G3,
>>>>>> +     [BQ27520G1] = BQ27520G1,
>>>>>> +     [BQ27520G2] = BQ27520G2,
>>>>>> +     [BQ27520G3] = BQ27520G3,
>>>>>> +     [BQ27520G4] = BQ27520G4,
>>>>>> +     [BQ27530]   = BQ27530,
>>>>>> +     [BQ27531]   = BQ27530,
>>>>>> +     [BQ27541]   = BQ27541,
>>>>>> +     [BQ27542]   = BQ27541,
>>>>>> +     [BQ27546]   = BQ27541,
>>>>>> +     [BQ27742]   = BQ27541,
>>>>>> +     [BQ27545]   = BQ27545,
>>>>>> +     [BQ27421]   = BQ27421,
>>>>>> +     [BQ27425]   = BQ27421,
>>>>>> +     [BQ27441]   = BQ27421,
>>>>>> +     [BQ27621]   = BQ27421,
>>>>>> +};
>>>>>> +
>>>>>>  static DEFINE_MUTEX(bq27xxx_list_lock);
>>>>>>  static LIST_HEAD(bq27xxx_battery_devices);
>>>>>>
>>>>>> @@ -856,6 +883,54 @@ static const char * const bq27xxx_dm_reg_name[] = {
>>>>>>       [BQ27XXX_DM_TERMINATE_VOLTAGE] = "terminate-voltage",
>>>>>>  };
>>>>>>
>>>>>> +static struct bq27xxx_dm_reg bq27500_dm_regs[] = {
>>>>>> +     [BQ27XXX_DM_DESIGN_CAPACITY]   = { 48, 10, 2,    0, 65535 },
>>>>>> +     [BQ27XXX_DM_DESIGN_ENERGY]     = { }, /* missing on chip */
>>>>>> +     [BQ27XXX_DM_TERMINATE_VOLTAGE] = { 80, 48, 2, 1000, 32767 },
>>>>>> +};
>>>>>> +
>>>>>> +static struct bq27xxx_dm_reg bq27545_dm_regs[] = {
>>>>>> +     [BQ27XXX_DM_DESIGN_CAPACITY]   = { 48, 23, 2,    0, 32767 },
>>>>>> +     [BQ27XXX_DM_DESIGN_ENERGY]     = { 48, 25, 2,    0, 32767 },
>>>>>> +     [BQ27XXX_DM_TERMINATE_VOLTAGE] = { 80, 67, 2, 2800,  3700 },
>>>>>> +};
>>>>>> +
>>>>>> +static struct bq27xxx_dm_reg bq27421_dm_regs[] = {
>>>>>> +     [BQ27XXX_DM_DESIGN_CAPACITY]   = { 82, 10, 2,    0,  8000 },
>>>>>> +     [BQ27XXX_DM_DESIGN_ENERGY]     = { 82, 12, 2,    0, 32767 },
>>>>>> +     [BQ27XXX_DM_TERMINATE_VOLTAGE] = { 82, 16, 2, 2500,  3700 },
>>>>>> +};
>>>>>> +
>>>>>> +static struct bq27xxx_dm_reg bq27425_dm_regs[] = {
>>>>>> +     [BQ27XXX_DM_DESIGN_CAPACITY]   = { 82, 12, 2,    0, 32767 },
>>>>>> +     [BQ27XXX_DM_DESIGN_ENERGY]     = { 82, 14, 2,    0, 32767 },
>>>>>> +     [BQ27XXX_DM_TERMINATE_VOLTAGE] = { 82, 18, 2, 2800,  3700 },
>>>>>> +};
>>>>>> +
>>>>>> +static struct bq27xxx_dm_reg bq27621_dm_regs[] = {
>>>>>> +     [BQ27XXX_DM_DESIGN_CAPACITY]   = { 82, 3, 2,    0,  8000 },
>>>>>> +     [BQ27XXX_DM_DESIGN_ENERGY]     = { 82, 5, 2,    0, 32767 },
>>>>>> +     [BQ27XXX_DM_TERMINATE_VOLTAGE] = { 82, 9, 2, 2500,  3700 },
>>>>>> +};
>>>>>> +
>>>>>> +static struct bq27xxx_dm_reg *bq27xxx_dm_regs[] = {
>>>>>> +     [BQ27500] = bq27500_dm_regs,
>>>>>> +     [BQ27545] = bq27545_dm_regs,
>>>>>> +     [BQ27421] = bq27421_dm_regs,
>>>>>> +     [BQ27425] = bq27425_dm_regs,
>>>>>> +     [BQ27441] = bq27421_dm_regs,
>>>>>> +     [BQ27621] = bq27621_dm_regs,
>>>>>> +};
>>>>>> +
>>>>>> +static u32 bq27xxx_unseal_keys[] = {
>>>>>> +     [BQ27500] = 0x04143672,
>>>>>> +     [BQ27545] = 0x04143672,
>>>>>> +     [BQ27421] = 0x80008000,
>>>>>> +     [BQ27425] = 0x04143672,
>>>>>> +     [BQ27441] = 0x80008000,
>>>>>> +     [BQ27621] = 0x80008000,
>>>>>> +};
>>>>>> +
>>>>>>
>>>>>>  #ifdef CONFIG_BATTERY_BQ27XXX_DT_UPDATES_NVM
>>>>>>  static bool bq27xxx_dt_to_nvm = true;
>>>>>> @@ -1865,9 +1940,16 @@ int bq27xxx_battery_setup(struct bq27xxx_device_info *di)
>>>>>>               .drv_data = di,
>>>>>>       };
>>>>>>
>>>>>> +     di->ram_chip = di->chip == BQ27421 || di->chip == BQ27441 || di->chip == BQ27621;
>>>>>> +
>>>>>> +     di->unseal_key = bq27xxx_unseal_keys[di->chip];
>>>>>> +     di->dm_regs = bq27xxx_dm_regs[di->chip];
>>>>>> +     di->chip = bq27xxx_chips[di->chip];
>>>>>
>>>>> NACK, this is a mess, you should not be using a table to change what
>>>>> chip was passed in, it may be needed later. The chip is still the same,
>>>>> it should have the same one correct ID, use a different index or array
>>>>> if you would like, but this is very hacky.
>>>>
>>>> The only way I see to make the I2C subsystem deliver multiple IDs for
>>>> a device is to treat i2c_device_id.driver_data as a u16[2] instead of
>>>> its normal u32. What do you think of that?
>>>>
>>>
>>> Why would it need multiple IDs for one device? Just pass in the one
>>> correct device ID that it is. No reason to make this so complicated.
>>> From the one ID you can then use tables to lookup any other info about
>>> that device, you don't have to have ever ID populated in every table,
>>> you can even have a table of tables if you would like:
>>>
>>> static const struct chip_lookup lookup_table = {
>>>         [bq27425] = {
>>>                 .regs = &bq27xxx_regs[bq27425],
>>>                 .dm_regs = &bq27xxx_dm_regs[bq274xx],
>>>                 .unseal_key = INVALID_FOR_THIS_DEVICE,
>>>         },
>>>         [bq27343] = {
>>> ...
>>>
>>> Not sure if that is valid C but I think you can get the idea.
>>
>> I considered a master lookup_table, but its ref to
>> bq27xxx_regs[fake-ID] duplicates the mapping of real-ID to di->chip.
>> The latter is still necessary as di->chip is used to select
>> conditional behaviors; we can't change its value in this patch.
>>
>
> Sure we can, in fact you could add the conditional behavior flags to the
> master lookup_table and cleanup all the current switch-case checks we do
> now.

You are proposing a significant change to the ID handling, which is
fine, but I don't wish to code that. Accept this minimal patch to
enable DM update, and then alter the ID logic when you have time in a
future patch.


>> So instead lets amend the I2C table to carry both its original value
>> (fake-ID) and the real-ID. That looks like:
>>
>> static const struct i2c_device_id bq27xxx_i2c_id_table[] = {
>>     /* dest.    di->real_chip       di->chip      */
>>     { "bq27200",   (BQ27000   << 16) |  BQ27000   },
>>     { "bq27210",   (BQ27010   << 16) |  BQ27010   },
>>     ...
>>     { "bq27441",   (BQ27441   << 16) |  BQ27421   },
>>     { "bq27621",   (BQ27621   << 16) |  BQ27421   },
>>     {},
>> };
>>
>> In probe, retrieve two values:
>>
>>     di->real_chip = id->driver_data >> 16;
>>     di->chip = (u16) id->driver_data;
>>
>
> NAK, I'm sure you can see how hacky this is right? This doesn't give us
> anything that the old table didn't. And it fails to correct the issue
> with the tables: We have two chip IDs still!

I'm sorry you don't like the extra ID, but you're the party
responsible for (if not the author of) the fake-ID scheme :-)


> Try the lookup_table again, send be what you have and I can help get
> everything else working if you have any problems with the conditional
> behavior cleanups.
>
>> In setup, use two values:
>>
>>     di->unseal_key = bq27xxx_unseal_keys[di->real_chip];
>>     di->dm_regs = bq27xxx_dm_regs[di->real_chip];
>>     di->regs = bq27xxx_regs[di->chip]; // unchanged from orig src
>>
>> That yields the most compact implementation of this patch, and you get
>> di->real_chip in the bargain :-)
>>
>>
>>>>> Just stop trying to hack around it, add the extra tables, even if they
>>>>> are clones, so we can be done with this series already. I'm sure you
>>>>> want that more than you want this "clever" work-around, right?
>>>>>
>>>>> Also fix all the checkpatch --strict warnings.
>>>>>
