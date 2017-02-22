From: Liam Breck <liam@networkimprov.net>
Subject: Re: [PATCH v7 7/9] power: bq27xxx_battery: Add power_supply_battery_info
 support
Date: Wed, 22 Feb 2017 13:29:55 -0800
Message-ID: <CAKvHMgTBKiy-+faF_SfNJbQEqyYhk4KVJnYfmrJWTgeL_gxeAQ@mail.gmail.com>
References: <20170221213008.30044-1-liam@networkimprov.net>
 <20170221213008.30044-8-liam@networkimprov.net> <14c63dd0-9784-87e1-74b2-2d3e4026dab7@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-it0-f66.google.com ([209.85.214.66]:35657 "EHLO
        mail-it0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933949AbdBVV35 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 22 Feb 2017 16:29:57 -0500
Received: by mail-it0-f66.google.com with SMTP id 203so2220287ith.2
        for <linux-pm@vger.kernel.org>; Wed, 22 Feb 2017 13:29:56 -0800 (PST)
In-Reply-To: <14c63dd0-9784-87e1-74b2-2d3e4026dab7@ti.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Andrew F. Davis" <afd@ti.com>
Cc: Sebastian Reichel <sre@kernel.org>, linux-pm@vger.kernel.org, Matt Ranostay <matt@ranostay.consulting>

On Wed, Feb 22, 2017 at 12:35 PM, Andrew F. Davis <afd@ti.com> wrote:
> On 02/21/2017 03:30 PM, Liam Breck wrote:
>> From: Liam Breck <kernel@networkimprov.net>
>>
>> Previously there was no way to configure chip registers in the event that the
>> defaults didn't match the battery in question.
>>
>> BQ27xxx driver now calls power_supply_get_battery_info, checks the inputs,
>> and writes battery data to chip RAM or non-volatile memory.
>>
>> Signed-off-by: Matt Ranostay <matt@ranostay.consulting>
>> Signed-off-by: Liam Breck <kernel@networkimprov.net>
>> ---
>>  drivers/power/supply/bq27xxx_battery.c | 399 ++++++++++++++++++++++++++++++++-
>>  1 file changed, 397 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/power/supply/bq27xxx_battery.c b/drivers/power/supply/bq27xxx_battery.c
>> index 7475a5f..8085d4a 100644
>> --- a/drivers/power/supply/bq27xxx_battery.c
>> +++ b/drivers/power/supply/bq27xxx_battery.c
>> @@ -51,7 +51,7 @@
>>
>>  #include <linux/power/bq27xxx_battery.h>
>>
>> -#define DRIVER_VERSION               "1.2.0"
>> +#define DRIVER_VERSION               "1.3.0"
>>
>>  #define BQ27XXX_MANUFACTURER "Texas Instruments"
>>
>> @@ -452,6 +452,99 @@ static struct {
>>  static DEFINE_MUTEX(bq27xxx_list_lock);
>>  static LIST_HEAD(bq27xxx_battery_devices);
>>
>> +/* writable registers */
>> +#define BQ27XXX_CONTROL                      0x00
>> +#define BQ27XXX_DATA_CLASS           0x3E
>> +#define BQ27XXX_DATA_BLOCK           0x3F
>> +#define BQ27XXX_BLOCK_DATA           0x40
>> +#define BQ27XXX_BLOCK_DATA_CHECKSUM  0x60
>> +#define BQ27XXX_BLOCK_DATA_CONTROL   0x61
>> +
>
> These all belong in the bq27xxx_regs array, you can add new register
> types to the bq27xxx_reg_index enum.

They're the same on all chips. Let's dup this code 9+ times when we have cause.

Or make a default array of reg numbers and memcopy it onto each chip
array, then alter as req'd per chip. But that's outside our scope.

>> +/* control register params */
>> +#define BQ27XXX_SEALED                       0x20
>> +#define BQ27XXX_SET_CFGUPDATE                0x13
>> +#define BQ27XXX_SOFT_RESET           0x42
>> +
>> +#define BQ27XXX_MSLEEP(i) usleep_range((i)*1000, (i)*1000+500)
>
> why?

I think this might vary on diff chips. Also I have a pending change
which uses MSLEEP(20)

>> +
>> +struct bq27xxx_dm_reg {
>> +     u8 subclass_id;
>> +     u8 offset;
>> +     u8 bytes;
>> +     u16 min, max;
>> +};
>> +
>> +struct bq27xxx_dm_buf {
>> +     u8 class;
>> +     u8 block;
>> +     u8 a[32];
>> +     bool full, updt;
>> +};
>> +
>> +#define BQ27XXX_DM_BUF_PTR(b, r) \
>> +     ( (u16*) &(b).a[ (r)->offset % sizeof (b).a ] )
>> +
>
> This could compete in the IOCCC, there has to be a more readable way to
> do this..

Hence the macro. It didn't seem to merit a function, but I could write
an inline fn.


>> +#define BQ27XXX_DM_BUF(di, i) { \
>> +     .class = bq27xxx_dm_regs[(di)->chip][i].subclass_id, \
>> +     .block = bq27xxx_dm_regs[(di)->chip][i].offset / sizeof ((struct bq27xxx_dm_buf*)0)->a, \
>> +}
>> +
>> +static inline bool bq27xxx_dm_buf_set(struct bq27xxx_dm_buf *buf,
>> +                                   struct bq27xxx_dm_reg *reg) {
>> +     if (buf->class == reg->subclass_id
>> +      && buf->block == reg->offset / sizeof buf->a
>> +      && buf->full)
>
> Some alignment issues here.
>
>> +             return false;
>> +     buf->class = reg->subclass_id;
>> +     buf->block = reg->offset / sizeof buf->a;
>> +     buf->full = buf->updt = false;
>
> newline before return
>
>> +     return true;
>> +}
>> +
>> +enum bq27xxx_dm_reg_id {
>> +     BQ27XXX_DM_DESIGN_CAPACITY = 0,
>> +     BQ27XXX_DM_DESIGN_ENERGY,
>> +     BQ27XXX_DM_TERMINATE_VOLTAGE,
>> +     BQ27XXX_DM_END,
>> +};
>> +
>> +static const char* bq27xxx_dm_reg_name[] = {
>> +     [BQ27XXX_DM_DESIGN_CAPACITY] = "design-capacity",
>> +     [BQ27XXX_DM_DESIGN_ENERGY] = "design-energy",
>> +     [BQ27XXX_DM_TERMINATE_VOLTAGE] = "terminate-voltage",
>> +};
>> +
>> +static struct bq27xxx_dm_reg bq27425_dm_regs[] = {
>> +     [BQ27XXX_DM_DESIGN_CAPACITY]   = { 82, 12, 2,    0, 32767 },
>> +     [BQ27XXX_DM_DESIGN_ENERGY]     = { 82, 14, 2,    0, 32767 },
>> +     [BQ27XXX_DM_TERMINATE_VOLTAGE] = { 82, 18, 2, 2800,  3700 },
>> +};
>> +
>> +static struct bq27xxx_dm_reg bq27421_dm_regs[] = { /* not tested */
>> +     [BQ27XXX_DM_DESIGN_CAPACITY]   = { 82, 10, 2,    0,  8000 },
>> +     [BQ27XXX_DM_DESIGN_ENERGY]     = { 82, 12, 2,    0, 32767 },
>> +     [BQ27XXX_DM_TERMINATE_VOLTAGE] = { 82, 16, 2, 2500,  3700 },
>> +};
>> +
>> +static struct bq27xxx_dm_reg bq27621_dm_regs[] = { /* not tested */
>> +     [BQ27XXX_DM_DESIGN_CAPACITY]   = { 82, 3, 2,    0,  8000 },
>> +     [BQ27XXX_DM_DESIGN_ENERGY]     = { 82, 5, 2,    0, 32767 },
>> +     [BQ27XXX_DM_TERMINATE_VOLTAGE] = { 82, 9, 2, 2500,  3700 },
>> +};
>> +
>> +static struct bq27xxx_dm_reg *bq27xxx_dm_regs[] = {
>> +     [BQ27421] = bq27421_dm_regs, /* and BQ27441 */
>> +     [BQ27425] = bq27425_dm_regs,
>> +/*   [BQ27621] = */ bq27621_dm_regs,
>> +};
>> +
>> +static u32 bq27xxx_unseal_keys[] = {
>> +     [BQ27421] = 0x80008000, /* and BQ27441 */
>> +     [BQ27425] = 0x04143672,
>> +/*   [BQ27621] = */ 0x80008000,
>
> Why is this commented out.

The 621 id isn't defined yet. I didn't want to enable something I can't test.

>> +};
>> +
>> +
>>  static int poll_interval_param_set(const char *val, const struct kernel_param *kp)
>>  {
>>       struct bq27xxx_device_info *di;
>> @@ -496,6 +589,297 @@ static inline int bq27xxx_read(struct bq27xxx_device_info *di, int reg_index,
>>       return di->bus.read(di, di->regs[reg_index], single);
>>  }
>>
>> +static int bq27xxx_battery_set_seal_state(struct bq27xxx_device_info *di,
>> +                                       bool state)
>> +{
>> +     u32 key = bq27xxx_unseal_keys[di->chip];
>> +     int ret;
>> +
>> +     if (state) {
>> +             ret = di->bus.write(di, BQ27XXX_CONTROL, BQ27XXX_SEALED, false);
>> +             if (ret < 0)
>> +                     goto out;
>> +     } else {
>> +             ret = di->bus.write(di, BQ27XXX_CONTROL, (u16)(key >> 16), false);
>> +             if (ret < 0)
>> +                     goto out;
>> +
>> +             ret = di->bus.write(di, BQ27XXX_CONTROL, (u16)key, false);
>> +             if (ret < 0)
>> +                     goto out;
>> +     }
>> +     return 0;
>> +
>> +out:
>> +     dev_err(di->dev, "bus error in %s: %d\n", __func__, ret);
>
> This is not a debug statement, we don't need the function name, just say
> where it broke.

What's "where" if not fn name?

>> +     return ret;
>> +}
>> +
>> +static u8 bq27xxx_battery_checksum(struct bq27xxx_dm_buf *buf)
>> +{
>> +     u16 sum = 0;
>> +     int i;
>> +
>> +     for (i = 0; i < sizeof buf->a; i++)
>
> Linus would like a word with you:
> https://lkml.org/lkml/2012/7/11/103
>
>> +             sum += buf->a[i];
>> +     sum &= 0xff;
>> +
>> +     return 0xff - sum;
>> +}
>> +
>> +static int bq27xxx_battery_read_dm_block(struct bq27xxx_device_info *di,
>> +                                      struct bq27xxx_dm_buf *buf)
>> +{
>> +     int ret;
>> +
>> +     ret = di->bus.write(di, BQ27XXX_DATA_CLASS, buf->class, true);
>> +     if (ret < 0)
>> +             goto out;
>> +
>> +     ret = di->bus.write(di, BQ27XXX_DATA_BLOCK, buf->block, true);
>> +     if (ret < 0)
>> +             goto out;
>> +
>> +     BQ27XXX_MSLEEP(1);
>> +
>> +     ret = di->bus.read_bulk(di, BQ27XXX_BLOCK_DATA, buf->a, sizeof buf->a);
>> +     if (ret < 0)
>> +             goto out;
>> +
>> +     ret = di->bus.read(di, BQ27XXX_BLOCK_DATA_CHECKSUM, true);
>> +     if (ret < 0)
>> +             goto out;
>> +
>> +     if ((u8)ret != bq27xxx_battery_checksum(buf)) {
>> +             ret = -EINVAL;
>> +             goto out;
>> +     }
>> +
>> +     buf->full = true;
>> +     buf->updt = false;
>> +     return 0;
>> +
>> +out:
>> +     dev_err(di->dev, "bus error in %s: %d\n", __func__, ret);
>> +     return ret;
>> +}
>> +
>> +static void bq27xxx_battery_print_config(struct bq27xxx_device_info *di)
>> +{
>> +     struct bq27xxx_dm_reg *reg = bq27xxx_dm_regs[di->chip];
>> +     struct bq27xxx_dm_buf buf = { .class = 0xFF };
>> +     int i;
>> +
>> +     for (i = 0; i < BQ27XXX_DM_END; i++, reg++) {
>> +             const char* str = bq27xxx_dm_reg_name[i];
>> +
>> +             if (bq27xxx_dm_buf_set(&buf, reg))
>> +                     if (bq27xxx_battery_read_dm_block(di, &buf) < 0)
>> +                             continue;
>> +
>> +             if (reg->bytes == 2)
>> +                     dev_info(di->dev, "config register %s is %d\n", str,
>> +                              be16_to_cpup(BQ27XXX_DM_BUF_PTR(buf, reg)));
>> +             else
>> +                     dev_warn(di->dev, "unsupported config register %s\n", str);
>> +     }
>> +}
>> +
>> +static void bq27xxx_battery_update_dm_block(struct bq27xxx_device_info *di,
>> +                                         struct bq27xxx_dm_buf *buf,
>> +                                         enum bq27xxx_dm_reg_id reg_id,
>> +                                         unsigned int val)
>> +{
>> +     struct bq27xxx_dm_reg *reg = &bq27xxx_dm_regs[di->chip][reg_id];
>> +     u16 *prev;
>> +
>> +     if (reg->bytes != 2)
>> +             return;
>> +
>> +     prev = BQ27XXX_DM_BUF_PTR(*buf, reg);
>> +     if (be16_to_cpup(prev) == val)
>> +             return;
>> +     *prev = cpu_to_be16(val);
>> +
>> +     dev_info(di->dev, "update chip %d, class %u, block %u, offset %u, value %u\n",
>> +              di->chip, buf->class, buf->block, reg->offset, val);
>> +
>
> This should probably be dev_debug, no normal user cares about all this
> detail.

It's only on change to NVM, which a hw developer (like me) wants to
know about. I plan to remove the print_config routine so this is not
redundant.

>> +     buf->updt = true;
>> +     return;
>> +}
>> +
>> +static int bq27xxx_battery_write_dm_block(struct bq27xxx_device_info *di,
>> +                                       struct bq27xxx_dm_buf *buf)
>> +{
>> +     bool cfgup = di->chip == BQ27425 || di->chip == BQ27421; /* || BQ27441 || BQ27621 */
>> +     int ret;
>> +
>> +     if (cfgup) {
>> +             ret = di->bus.write(di, BQ27XXX_CONTROL, BQ27XXX_SET_CFGUPDATE, false);
>> +             if (ret < 0)
>> +                     goto out1;
>> +     }
>> +
>> +     ret = di->bus.write(di, BQ27XXX_BLOCK_DATA_CONTROL, 0, true);
>> +     if (ret < 0)
>> +             goto out2;
>> +
>> +     ret = di->bus.write(di, BQ27XXX_DATA_CLASS, buf->class, true);
>> +     if (ret < 0)
>> +             goto out2;
>> +
>> +     ret = di->bus.write(di, BQ27XXX_DATA_BLOCK, buf->block, true);
>> +     if (ret < 0)
>> +             goto out2;
>> +
>> +     BQ27XXX_MSLEEP(1);
>> +
>> +     ret = di->bus.write_bulk(di, BQ27XXX_BLOCK_DATA, buf->a, sizeof buf->a);
>> +     if (ret < 0)
>> +             goto out2;
>> +
>> +     ret = di->bus.write(di, BQ27XXX_BLOCK_DATA_CHECKSUM,
>> +                         bq27xxx_battery_checksum(buf), true);
>> +     if (ret < 0)
>> +             goto out2;
>> +
>> +     /* THE FOLLOWING CODE IS TOXIC. DO NOT USE!
>
> Then why include it, what is this code supposed to do, and what do we
> lose without it? If it is really needed we can find a way to guarantee
> the delay length.

This triggers a chip bug, and future devs need to know to avoid it. I
was tempted by bqtool into using it for the extra error check, and now
my gauge isn't working, tho I have only reset one NVM block back to
factory defaults. Bqtool is easy to find, if poorly written.

>> +      * If the 350ms delay is insufficient, NVM corruption results
>> +      * on the '425 chip, which could damage the chip.
>> +      * It was suggested in this TI tool:
>> +      *   http://git.ti.com/bms-linux/bqtool/blobs/master/gauge.c#line328
>> +      *
>> +      * BQ27XXX_MSLEEP(350);
>> +      * ret = di->bus.write(di, BQ27XXX_DATA_BLOCK, buf->block, true);
>> +      * BQ27XXX_MSLEEP(1);
>> +      * ret = di->bus.read(di, BQ27XXX_BLOCK_DATA_CHECKSUM, true);
>> +      * if ((u8)ret != bq27xxx_battery_checksum(buf))
>> +      *      ret = -EINVAL;
>> +      */
>> +
>> +     if (cfgup) {
>> +             BQ27XXX_MSLEEP(1);
>> +             ret = di->bus.write(di, BQ27XXX_CONTROL, BQ27XXX_SOFT_RESET, false);
>> +             if (ret < 0)
>> +                     goto out1;
>> +     }
>> +
>> +     buf->updt = false;
>> +     return 0;
>> +
>> +out2:
>> +     if (cfgup)
>> +             di->bus.write(di, BQ27XXX_CONTROL, BQ27XXX_SOFT_RESET, false);
>> +out1:
>> +     dev_err(di->dev, "bus error in %s: %d\n", __func__, ret);
>> +     return ret;
>> +}
>> +
>> +static void bq27xxx_battery_set_config(struct bq27xxx_device_info *di,
>> +                                    struct power_supply_battery_info *info)
>> +{
>> +     struct bq27xxx_dm_buf bd = BQ27XXX_DM_BUF(di, BQ27XXX_DM_DESIGN_ENERGY);
>> +     struct bq27xxx_dm_buf bt = BQ27XXX_DM_BUF(di, BQ27XXX_DM_TERMINATE_VOLTAGE);
>> +
>> +     if (info->charge_full_design_uah != -EINVAL
>> +      && info->energy_full_design_uwh != -EINVAL) {
>> +             bq27xxx_battery_read_dm_block(di, &bd);
>> +             if (bd.full) {
>> +                     /* assume design energy & capacity are in same block */
>> +                     bq27xxx_battery_update_dm_block(di, &bd,
>> +                                     BQ27XXX_DM_DESIGN_CAPACITY,
>> +                                     info->charge_full_design_uah / 1000);
>> +                     bq27xxx_battery_update_dm_block(di, &bd,
>> +                                     BQ27XXX_DM_DESIGN_ENERGY,
>> +                                     info->energy_full_design_uwh / 1000);
>> +             }
>> +     }
>> +
>> +     if (info->voltage_min_design_uv != -EINVAL) {
>> +             bool same = bd.full && bd.class == bt.class && bd.block == bt.block;
>> +             if (!same)
>> +                     bq27xxx_battery_read_dm_block(di, &bt);
>> +             if (same ? bd.full : bt.full)
>> +                     bq27xxx_battery_update_dm_block(di, same ? &bd : &bt,
>> +                                     BQ27XXX_DM_TERMINATE_VOLTAGE,
>> +                                     info->voltage_min_design_uv / 1000);
>> +     }
>> +
>> +     if (bd.updt)
>> +             bq27xxx_battery_write_dm_block(di, &bd);
>> +     if (bt.updt)
>> +             bq27xxx_battery_write_dm_block(di, &bt);
>> +}
>> +
>> +void bq27xxx_battery_settings(struct bq27xxx_device_info *di)
>> +{
>> +     struct power_supply_battery_info info = {};
>> +     unsigned int min, max;
>> +
>> +     /* functions don't exist for writing data so abort */
>> +     if (!di->bus.write || !di->bus.write_bulk)
>> +             return;
>> +
>> +     /* no settings to be set for this chipset so abort */
>> +     if (!bq27xxx_dm_regs[di->chip])
>> +             return;
>> +
>> +     if (bq27xxx_battery_set_seal_state(di, false) < 0)
>> +             return;
>> +
>> +     if (power_supply_get_battery_info(di->bat, &info) < 0)
>> +             goto out;
>> +
>> +     if (info.energy_full_design_uwh != info.charge_full_design_uah) {
>> +             if (info.energy_full_design_uwh == -EINVAL)
>> +                     dev_warn(di->dev,
>> +                             "missing battery:energy-full-design-microwatt-hours\n");
>> +             else if (info.charge_full_design_uah == -EINVAL)
>> +                     dev_warn(di->dev,
>> +                             "missing battery:charge-full-design-microamp-hours\n");
>> +     }
>> +
>> +     /* assume min == 0 */
>> +     max = bq27xxx_dm_regs[di->chip][BQ27XXX_DM_DESIGN_ENERGY].max;
>> +     if (info.energy_full_design_uwh > max * 1000) {
>> +             dev_err(di->dev,
>> +                    "invalid battery:energy-full-design-microwatt-hours %d\n",
>> +                     info.energy_full_design_uwh);
>> +             info.energy_full_design_uwh = -EINVAL;
>> +     }
>> +
>> +     /* assume min == 0 */
>> +     max = bq27xxx_dm_regs[di->chip][BQ27XXX_DM_DESIGN_CAPACITY].max;
>> +     if (info.charge_full_design_uah > max * 1000) {
>> +             dev_err(di->dev,
>> +                    "invalid battery:charge-full-design-microamp-hours %d\n",
>> +                     info.charge_full_design_uah);
>> +             info.charge_full_design_uah = -EINVAL;
>> +     }
>> +
>> +     min = bq27xxx_dm_regs[di->chip][BQ27XXX_DM_TERMINATE_VOLTAGE].min;
>> +     max = bq27xxx_dm_regs[di->chip][BQ27XXX_DM_TERMINATE_VOLTAGE].max;
>> +     if ((info.voltage_min_design_uv < min * 1000
>> +       || info.voltage_min_design_uv > max * 1000)
>> +       && info.voltage_min_design_uv != -EINVAL) {
>> +             dev_err(di->dev,
>> +                    "invalid battery:voltage-min-design-microvolt %d\n",
>> +                     info.voltage_min_design_uv);
>> +             info.voltage_min_design_uv = -EINVAL;
>> +     }
>> +
>> +     if ((info.energy_full_design_uwh == -EINVAL
>> +       || info.charge_full_design_uah == -EINVAL)
>> +       && info.voltage_min_design_uv  == -EINVAL)
>> +             goto out;
>> +
>> +     bq27xxx_battery_set_config(di, &info);
>> +
>> +out:
>> +     bq27xxx_battery_print_config(di);
>> +     bq27xxx_battery_set_seal_state(di, true);
>> +}
>> +
>>  /*
>>   * Return the battery State-of-Charge
>>   * Or < 0 if something fails.
>> @@ -1006,6 +1390,13 @@ static int bq27xxx_battery_get_property(struct power_supply *psy,
>>       case POWER_SUPPLY_PROP_CHARGE_FULL_DESIGN:
>>               ret = bq27xxx_simple_value(di->charge_design_full, val);
>>               break;
>> +     /*
>> +      * TODO: Implement these to make registers set from
>> +      * power_supply_battery_info visible in sysfs.
>> +      */
>> +     case POWER_SUPPLY_PROP_ENERGY_FULL_DESIGN:
>> +     case POWER_SUPPLY_PROP_VOLTAGE_MIN_DESIGN:
>> +             return -EINVAL;
>>       case POWER_SUPPLY_PROP_CYCLE_COUNT:
>>               ret = bq27xxx_simple_value(di->cache.cycle_count, val);
>>               break;
>> @@ -1039,7 +1430,10 @@ static void bq27xxx_external_power_changed(struct power_supply *psy)
>>  int bq27xxx_battery_setup(struct bq27xxx_device_info *di)
>>  {
>>       struct power_supply_desc *psy_desc;
>> -     struct power_supply_config psy_cfg = { .drv_data = di, };
>> +     struct power_supply_config psy_cfg = {
>> +             .of_node = di->dev->of_node,
>> +             .drv_data = di,
>> +     };
>>
>>       INIT_DELAYED_WORK(&di->work, bq27xxx_battery_poll);
>>       mutex_init(&di->lock);
>> @@ -1064,6 +1458,7 @@ int bq27xxx_battery_setup(struct bq27xxx_device_info *di)
>>
>>       dev_info(di->dev, "support ver. %s enabled\n", DRIVER_VERSION);
>>
>> +     bq27xxx_battery_settings(di);
>>       bq27xxx_battery_update(di);
>>
>>       mutex_lock(&bq27xxx_list_lock);
>>
