From: "Andrew F. Davis" <afd@ti.com>
Subject: Re: [PATCH v13 09/11] power: supply: bq27xxx_battery: Enable data
 memory update for certain chips
Date: Fri, 5 May 2017 16:29:33 -0500
Message-ID: <735a10ed-3faa-8440-049a-7529a5a56031@ti.com>
References: <20170504061811.18107-1-liam@networkimprov.net>
 <20170504061811.18107-10-liam@networkimprov.net>
 <e11bb744-ac01-8499-18a2-2e9fb3fb5c38@ti.com>
 <CAKvHMgSmMGLXTdeDfu1wP7NxoJP8fJ+YyZvSs7rvOC8uQzk3ng@mail.gmail.com>
 <73f5eb07-dda0-ec1c-2412-e186a42918ba@ti.com>
 <CAKvHMgT25riE8STLnJa1c_dmpbWVa5=Uvxrwb32cxVe2BxFH8g@mail.gmail.com>
 <98bf566e-0fde-9e49-741c-571a5173699c@ti.com>
 <CAKvHMgQP5BQG1yvz+emZjSJLkJk6bXe3gxWf7jDS6o=LZmyLJw@mail.gmail.com>
 <1799a109-ffb3-bf10-d80e-8e47973d85e4@ti.com>
 <CAKvHMgTQ7AQ93PQXGcL7YLXwxjPQn0dMRpGoDaqhdx5buO6-ww@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from lelnx193.ext.ti.com ([198.47.27.77]:21180 "EHLO
        lelnx193.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752260AbdEEV3k (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 5 May 2017 17:29:40 -0400
In-Reply-To: <CAKvHMgTQ7AQ93PQXGcL7YLXwxjPQn0dMRpGoDaqhdx5buO6-ww@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Liam Breck <liam@networkimprov.net>
Cc: Sebastian Reichel <sre@kernel.org>, linux-pm@vger.kernel.org, Liam Breck <kernel@networkimprov.net>

On 05/05/2017 04:27 PM, Liam Breck wrote:
> On Fri, May 5, 2017 at 2:04 PM, Andrew F. Davis <afd@ti.com> wrote:
>> On 05/05/2017 03:55 PM, Liam Breck wrote:
>>> On Fri, May 5, 2017 at 1:44 PM, Andrew F. Davis <afd@ti.com> wrote:
>>>> On 05/05/2017 03:14 PM, Liam Breck wrote:
>>>>> On Fri, May 5, 2017 at 12:45 PM, Andrew F. Davis <afd@ti.com> wrote:
>>>>>> On 05/05/2017 02:31 PM, Liam Breck wrote:
>>>>>>> On Thu, May 4, 2017 at 10:00 AM, Andrew F. Davis <afd@ti.com> wrote:
>>>>>>>> On 05/04/2017 01:18 AM, Liam Breck wrote:
>>>>>>>>> From: Liam Breck <kernel@networkimprov.net>
>>>>>>>>>
>>>>>>>>> Support data memory update on BQ27500, 545, 425, 421, 441, 621.
>>>>>>>>>
>>>>>>>>> Create IDs for for previously unID'd chips, to index arrays for unseal keys
>>>>>>>>> and data memory register tables.
>>>>>>>>>
>>>>>>>>> Signed-off-by: Liam Breck <kernel@networkimprov.net>
>>>>>>>>> ---
>>>>>>>>>  drivers/power/supply/bq27xxx_battery.c     | 90 ++++++++++++++++++++++++++++--
>>>>>>>>>  drivers/power/supply/bq27xxx_battery_i2c.c | 16 +++---
>>>>>>>>>  include/linux/power/bq27xxx_battery.h      | 13 +++++
>>>>>>>>>  3 files changed, 107 insertions(+), 12 deletions(-)
>>>>>>>>>
>>>>>>>>> diff --git a/drivers/power/supply/bq27xxx_battery.c b/drivers/power/supply/bq27xxx_battery.c
>>>>>>>>> index 06f15da..0aecd41 100644
>>>>>>>>> --- a/drivers/power/supply/bq27xxx_battery.c
>>>>>>>>> +++ b/drivers/power/supply/bq27xxx_battery.c
>>>>>>>>> @@ -58,7 +58,7 @@
>>>>>>>>>
>>>>>>>>>  #include <linux/power/bq27xxx_battery.h>
>>>>>>>>>
>>>>>>>>> -#define DRIVER_VERSION               "1.2.0"
>>>>>>>>> +#define DRIVER_VERSION               "1.3.0"
>>>>>>>>>
>>>>>>>>>  #define BQ27XXX_MANUFACTURER "Texas Instruments"
>>>>>>>>>
>>>>>>>>> @@ -132,7 +132,7 @@ enum bq27xxx_reg_index {
>>>>>>>>>       [BQ27XXX_DM_CKSUM] = 0x60
>>>>>>>>>
>>>>>>>>>  /* Register mappings */
>>>>>>>>> -static u8 bq27xxx_regs[][BQ27XXX_REG_MAX] = {
>>>>>>>>> +static u8 bq27xxx_regs[BQ27MAX][BQ27XXX_REG_MAX] = {
>>>>>>>>>       [BQ27000] = {
>>>>>>>>>               [BQ27XXX_REG_CTRL] = 0x00,
>>>>>>>>>               [BQ27XXX_REG_TEMP] = 0x06,
>>>>>>>>> @@ -779,7 +779,7 @@ static enum power_supply_property bq27421_battery_props[] = {
>>>>>>>>>  static struct {
>>>>>>>>>       enum power_supply_property *props;
>>>>>>>>>       size_t size;
>>>>>>>>> -} bq27xxx_battery_props[] = {
>>>>>>>>> +} bq27xxx_battery_props[BQ27MAX] = {
>>>>>>>>>       BQ27XXX_PROP(BQ27000, bq27000_battery_props),
>>>>>>>>>       BQ27XXX_PROP(BQ27010, bq27010_battery_props),
>>>>>>>>>       BQ27XXX_PROP(BQ2750X, bq2750x_battery_props),
>>>>>>>>> @@ -798,6 +798,33 @@ static struct {
>>>>>>>>>       BQ27XXX_PROP(BQ27421, bq27421_battery_props),
>>>>>>>>>  };
>>>>>>>>>
>>>>>>>>> +static enum bq27xxx_chip bq27xxx_chips[] = {
>>>>>>>>> +     [BQ27000]   = BQ27000,
>>>>>>>>> +     [BQ27010]   = BQ27010,
>>>>>>>>> +     [BQ2750X]   = BQ2750X,
>>>>>>>>> +     [BQ2751X]   = BQ2751X,
>>>>>>>>> +     [BQ2752X]   = BQ2751X,
>>>>>>>>> +     [BQ27500]   = BQ27500,
>>>>>>>>> +     [BQ27510G1] = BQ27510G1,
>>>>>>>>> +     [BQ27510G2] = BQ27510G2,
>>>>>>>>> +     [BQ27510G3] = BQ27510G3,
>>>>>>>>> +     [BQ27520G1] = BQ27520G1,
>>>>>>>>> +     [BQ27520G2] = BQ27520G2,
>>>>>>>>> +     [BQ27520G3] = BQ27520G3,
>>>>>>>>> +     [BQ27520G4] = BQ27520G4,
>>>>>>>>> +     [BQ27530]   = BQ27530,
>>>>>>>>> +     [BQ27531]   = BQ27530,
>>>>>>>>> +     [BQ27541]   = BQ27541,
>>>>>>>>> +     [BQ27542]   = BQ27541,
>>>>>>>>> +     [BQ27546]   = BQ27541,
>>>>>>>>> +     [BQ27742]   = BQ27541,
>>>>>>>>> +     [BQ27545]   = BQ27545,
>>>>>>>>> +     [BQ27421]   = BQ27421,
>>>>>>>>> +     [BQ27425]   = BQ27421,
>>>>>>>>> +     [BQ27441]   = BQ27421,
>>>>>>>>> +     [BQ27621]   = BQ27421,
>>>>>>>>> +};
>>>>>>>>> +
>>>>>>>>>  static DEFINE_MUTEX(bq27xxx_list_lock);
>>>>>>>>>  static LIST_HEAD(bq27xxx_battery_devices);
>>>>>>>>>
>>>>>>>>> @@ -856,6 +883,54 @@ static const char * const bq27xxx_dm_reg_name[] = {
>>>>>>>>>       [BQ27XXX_DM_TERMINATE_VOLTAGE] = "terminate-voltage",
>>>>>>>>>  };
>>>>>>>>>
>>>>>>>>> +static struct bq27xxx_dm_reg bq27500_dm_regs[] = {
>>>>>>>>> +     [BQ27XXX_DM_DESIGN_CAPACITY]   = { 48, 10, 2,    0, 65535 },
>>>>>>>>> +     [BQ27XXX_DM_DESIGN_ENERGY]     = { }, /* missing on chip */
>>>>>>>>> +     [BQ27XXX_DM_TERMINATE_VOLTAGE] = { 80, 48, 2, 1000, 32767 },
>>>>>>>>> +};
>>>>>>>>> +
>>>>>>>>> +static struct bq27xxx_dm_reg bq27545_dm_regs[] = {
>>>>>>>>> +     [BQ27XXX_DM_DESIGN_CAPACITY]   = { 48, 23, 2,    0, 32767 },
>>>>>>>>> +     [BQ27XXX_DM_DESIGN_ENERGY]     = { 48, 25, 2,    0, 32767 },
>>>>>>>>> +     [BQ27XXX_DM_TERMINATE_VOLTAGE] = { 80, 67, 2, 2800,  3700 },
>>>>>>>>> +};
>>>>>>>>> +
>>>>>>>>> +static struct bq27xxx_dm_reg bq27421_dm_regs[] = {
>>>>>>>>> +     [BQ27XXX_DM_DESIGN_CAPACITY]   = { 82, 10, 2,    0,  8000 },
>>>>>>>>> +     [BQ27XXX_DM_DESIGN_ENERGY]     = { 82, 12, 2,    0, 32767 },
>>>>>>>>> +     [BQ27XXX_DM_TERMINATE_VOLTAGE] = { 82, 16, 2, 2500,  3700 },
>>>>>>>>> +};
>>>>>>>>> +
>>>>>>>>> +static struct bq27xxx_dm_reg bq27425_dm_regs[] = {
>>>>>>>>> +     [BQ27XXX_DM_DESIGN_CAPACITY]   = { 82, 12, 2,    0, 32767 },
>>>>>>>>> +     [BQ27XXX_DM_DESIGN_ENERGY]     = { 82, 14, 2,    0, 32767 },
>>>>>>>>> +     [BQ27XXX_DM_TERMINATE_VOLTAGE] = { 82, 18, 2, 2800,  3700 },
>>>>>>>>> +};
>>>>>>>>> +
>>>>>>>>> +static struct bq27xxx_dm_reg bq27621_dm_regs[] = {
>>>>>>>>> +     [BQ27XXX_DM_DESIGN_CAPACITY]   = { 82, 3, 2,    0,  8000 },
>>>>>>>>> +     [BQ27XXX_DM_DESIGN_ENERGY]     = { 82, 5, 2,    0, 32767 },
>>>>>>>>> +     [BQ27XXX_DM_TERMINATE_VOLTAGE] = { 82, 9, 2, 2500,  3700 },
>>>>>>>>> +};
>>>>>>>>> +
>>>>>>>>> +static struct bq27xxx_dm_reg *bq27xxx_dm_regs[] = {
>>>>>>>>> +     [BQ27500] = bq27500_dm_regs,
>>>>>>>>> +     [BQ27545] = bq27545_dm_regs,
>>>>>>>>> +     [BQ27421] = bq27421_dm_regs,
>>>>>>>>> +     [BQ27425] = bq27425_dm_regs,
>>>>>>>>> +     [BQ27441] = bq27421_dm_regs,
>>>>>>>>> +     [BQ27621] = bq27621_dm_regs,
>>>>>>>>> +};
>>>>>>>>> +
>>>>>>>>> +static u32 bq27xxx_unseal_keys[] = {
>>>>>>>>> +     [BQ27500] = 0x04143672,
>>>>>>>>> +     [BQ27545] = 0x04143672,
>>>>>>>>> +     [BQ27421] = 0x80008000,
>>>>>>>>> +     [BQ27425] = 0x04143672,
>>>>>>>>> +     [BQ27441] = 0x80008000,
>>>>>>>>> +     [BQ27621] = 0x80008000,
>>>>>>>>> +};
>>>>>>>>> +
>>>>>>>>>
>>>>>>>>>  #ifdef CONFIG_BATTERY_BQ27XXX_DT_UPDATES_NVM
>>>>>>>>>  static bool bq27xxx_dt_to_nvm = true;
>>>>>>>>> @@ -1865,9 +1940,16 @@ int bq27xxx_battery_setup(struct bq27xxx_device_info *di)
>>>>>>>>>               .drv_data = di,
>>>>>>>>>       };
>>>>>>>>>
>>>>>>>>> +     di->ram_chip = di->chip == BQ27421 || di->chip == BQ27441 || di->chip == BQ27621;
>>>>>>>>> +
>>>>>>>>> +     di->unseal_key = bq27xxx_unseal_keys[di->chip];
>>>>>>>>> +     di->dm_regs = bq27xxx_dm_regs[di->chip];
>>>>>>>>> +     di->chip = bq27xxx_chips[di->chip];
>>>>>>>>
>>>>>>>> NACK, this is a mess, you should not be using a table to change what
>>>>>>>> chip was passed in, it may be needed later. The chip is still the same,
>>>>>>>> it should have the same one correct ID, use a different index or array
>>>>>>>> if you would like, but this is very hacky.
>>>>>>>
>>>>>>> The only way I see to make the I2C subsystem deliver multiple IDs for
>>>>>>> a device is to treat i2c_device_id.driver_data as a u16[2] instead of
>>>>>>> its normal u32. What do you think of that?
>>>>>>>
>>>>>>
>>>>>> Why would it need multiple IDs for one device? Just pass in the one
>>>>>> correct device ID that it is. No reason to make this so complicated.
>>>>>
>>>>> Take a look at bq27xxx_i2c_id_table[] here:
>>>>> https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git/tree/drivers/power/supply/bq27xxx_battery_i2c.c?h=linux-4.11.y#n148
>>>>>
>>>>> Notice how this table maps certain chips to the same IDs. I am going
>>>>> to preserve that scheme, as changing it is outside the scope of this
>>>>> series.
>>>>>
>>>>
>>>> You can't just say doing something the right is "outside the scope of
>>>> this series" then hack something together...
>>>>
>>>> Fixing this should be trivial anyway, add the new IDs, pass the real IDs
>>>> in, then add the translation table so you don't have to add any new
>>>> entries to bq27xxx_regs.
>>>
>>> That is *precisely* what I do in v13. Except I don't store real-ID in
>>> a di field because there isn't a use for it. Add that later if you
>>> need it.
>>>
>>
>> The first two yes, but it's the type of translation that doesn't look
>> good, we should go from lookup_table[realID]->whatever_values. With this
>> we are mapping realID -> fakeID then later whatever_values_table[fakeID].
>>
>> So if you barrow the "struct chip_lookup lookup_table" below then we end
>> up with only two mapping types (table_lookup and values tables) and no
>> translations needed.
> 
> If we deliver two values in I2C driver_data, the lookup code will be
> this, and we don't need an extra table:
> 

Sure, but why should the I2C driver have to know anything about how the
core works or what tables it does and does not have index IDs for? It
should only pass in the real ID.

>        di->unseal_key = bq27xxx_unseal_keys[di->real_chip];
>        di->dm_regs = bq27xxx_dm_regs[di->real_chip];
> 
>        di->regs = bq27xxx_regs[di->chip];
> 
> 
>>> bq27xxx_chips[] is the translation table. However we could unify that
>>> with the I2C table by placing two values in its driver_data field, and
>>> I think that's cleaner.
>>>
>>>
>>>>> So the only question is how to deliver the "real" ID to the driver. In
>>>>> v13, I change the I2C table to deliver real-ID, and replicate the
>>>>> mapping of the orig I2C table in bq27xxx_chips[]. Now I propose to
>>>>> make the I2C table carry two values, chip-ID and real-ID. Then we can
>>>>> drop bq27xxx_chips[].
>>>>>
>>>>> Hope that clarifies the issue...
>>>>>
>>>>>> From the one ID you can then use tables to lookup any other info about
>>>>>> that device, you don't have to have ever ID populated in every table,
>>>>>> you can even have a table of tables if you would like:
>>>>>>
>>>>>> static const struct chip_lookup lookup_table = {
>>>>>>         [bq27425] = {
>>>>>>                 .regs = &bq27xxx_regs[bq27425],
>>>>>>                 .dm_regs = &bq27xxx_dm_regs[bq274xx],
>>>>>>                 .unseal_key = INVALID_FOR_THIS_DEVICE,
>>>>>>         },
>>>>>>         [bq27343] = {
>>>>>> ...
>>>>>>
>>>>>> Not sure if that is valid C but I think you can get the idea.
>>>>>>
>>>>>>>
>>>>>>>> Just stop trying to hack around it, add the extra tables, even if they
>>>>>>>> are clones, so we can be done with this series already. I'm sure you
>>>>>>>> want that more than you want this "clever" work-around, right?
>>>>>>>>
>>>>>>>> Also fix all the checkpatch --strict warnings.
>>>>>>>>
>>>>>>>>> +
>>>>>>>>> +     di->regs = bq27xxx_regs[di->chip];
>>>>>>>>> +
>>>>>>>>>       INIT_DELAYED_WORK(&di->work, bq27xxx_battery_poll);
>>>>>>>>>       mutex_init(&di->lock);
>>>>>>>>> -     di->regs = bq27xxx_regs[di->chip];
>>>>>>>>>
>>>>>>>>>       psy_desc = devm_kzalloc(di->dev, sizeof(*psy_desc), GFP_KERNEL);
>>>>>>>>>       if (!psy_desc)
>>>>>>>>> diff --git a/drivers/power/supply/bq27xxx_battery_i2c.c b/drivers/power/supply/bq27xxx_battery_i2c.c
>>>>>>>>> index a597221..0b11ed4 100644
>>>>>>>>> --- a/drivers/power/supply/bq27xxx_battery_i2c.c
>>>>>>>>> +++ b/drivers/power/supply/bq27xxx_battery_i2c.c
>>>>>>>>> @@ -230,7 +230,7 @@ static const struct i2c_device_id bq27xxx_i2c_id_table[] = {
>>>>>>>>>       { "bq27210", BQ27010 },
>>>>>>>>>       { "bq27500", BQ2750X },
>>>>>>>>>       { "bq27510", BQ2751X },
>>>>>>>>> -     { "bq27520", BQ2751X },
>>>>>>>>> +     { "bq27520", BQ2752X },
>>>>>>>>>       { "bq27500-1", BQ27500 },
>>>>>>>>>       { "bq27510g1", BQ27510G1 },
>>>>>>>>>       { "bq27510g2", BQ27510G2 },
>>>>>>>>> @@ -240,16 +240,16 @@ static const struct i2c_device_id bq27xxx_i2c_id_table[] = {
>>>>>>>>>       { "bq27520g3", BQ27520G3 },
>>>>>>>>>       { "bq27520g4", BQ27520G4 },
>>>>>>>>>       { "bq27530", BQ27530 },
>>>>>>>>> -     { "bq27531", BQ27530 },
>>>>>>>>> +     { "bq27531", BQ27531 },
>>>>>>>>>       { "bq27541", BQ27541 },
>>>>>>>>> -     { "bq27542", BQ27541 },
>>>>>>>>> -     { "bq27546", BQ27541 },
>>>>>>>>> -     { "bq27742", BQ27541 },
>>>>>>>>> +     { "bq27542", BQ27542 },
>>>>>>>>> +     { "bq27546", BQ27546 },
>>>>>>>>> +     { "bq27742", BQ27742 },
>>>>>>>>>       { "bq27545", BQ27545 },
>>>>>>>>>       { "bq27421", BQ27421 },
>>>>>>>>> -     { "bq27425", BQ27421 },
>>>>>>>>> -     { "bq27441", BQ27421 },
>>>>>>>>> -     { "bq27621", BQ27421 },
>>>>>>>>> +     { "bq27425", BQ27425 },
>>>>>>>>> +     { "bq27441", BQ27441 },
>>>>>>>>> +     { "bq27621", BQ27621 },
>>>>>>>>>       {},
>>>>>>>>>  };
>>>>>>>>>  MODULE_DEVICE_TABLE(i2c, bq27xxx_i2c_id_table);
>>>>>>>>> diff --git a/include/linux/power/bq27xxx_battery.h b/include/linux/power/bq27xxx_battery.h
>>>>>>>>> index 11e1168..543c10e 100644
>>>>>>>>> --- a/include/linux/power/bq27xxx_battery.h
>>>>>>>>> +++ b/include/linux/power/bq27xxx_battery.h
>>>>>>>>> @@ -2,6 +2,8 @@
>>>>>>>>>  #define __LINUX_BQ27X00_BATTERY_H__
>>>>>>>>>
>>>>>>>>>  enum bq27xxx_chip {
>>>>>>>>> +     /* these index bq27xxx_regs[] & bq27xxx_battery_props[] */
>>>>>>>>> +     /* and map to themselves in bq27xxx_chips[]             */
>>>>>>>>>       BQ27000 = 1, /* bq27000, bq27200 */
>>>>>>>>>       BQ27010, /* bq27010, bq27210 */
>>>>>>>>>       BQ2750X, /* bq27500 deprecated alias */
>>>>>>>>> @@ -18,6 +20,17 @@ enum bq27xxx_chip {
>>>>>>>>>       BQ27541, /* bq27541, bq27542, bq27546, bq27742 */
>>>>>>>>>       BQ27545, /* bq27545 */
>>>>>>>>>       BQ27421, /* bq27421, bq27425, bq27441, bq27621 */
>>>>>>>>> +     BQ27MAX,
>>>>>>>>> +
>>>>>>>>> +     /* these map to above in bq27xxx_chips[] */
>>>>>>>>> +     BQ2752X, /* deprecated alias */
>>>>>>>>> +     BQ27531,
>>>>>>>>> +     BQ27542,
>>>>>>>>> +     BQ27546,
>>>>>>>>> +     BQ27742,
>>>>>>>>> +     BQ27425,
>>>>>>>>> +     BQ27441,
>>>>>>>>> +     BQ27621,
>>>>>>>>>  };
>>>>>>>>>
>>>>>>>>>  /**
>>>>>>>>>
