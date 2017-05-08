From: "Andrew F. Davis" <afd@ti.com>
Subject: Re: [PATCH v13 08/11] power: supply: bq27xxx_battery: Add
 power_supply_battery_info support
Date: Mon, 8 May 2017 09:54:36 -0500
Message-ID: <d1d93ce1-5c6c-ada8-2917-a9d592a9e1cd@ti.com>
References: <20170504061811.18107-1-liam@networkimprov.net>
 <20170504061811.18107-9-liam@networkimprov.net>
 <f0121e38-9159-2bb4-26ca-1a4a72ba6ace@ti.com>
 <CAKvHMgSWCW5g3L2PtEa6Yg_LWRU_ByDDO_NVJqQqzvoHgXO=GQ@mail.gmail.com>
 <CAKvHMgS6XtrJDWgq=J_dnOBYUXLWG-zwBOaa3FHybEfkCDicvA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from lelnx193.ext.ti.com ([198.47.27.77]:63773 "EHLO
        lelnx193.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754152AbdEHOyq (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 8 May 2017 10:54:46 -0400
In-Reply-To: <CAKvHMgS6XtrJDWgq=J_dnOBYUXLWG-zwBOaa3FHybEfkCDicvA@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Liam Breck <liam@networkimprov.net>
Cc: Sebastian Reichel <sre@kernel.org>, linux-pm@vger.kernel.org, Matt Ranostay <matt@ranostay.consulting>, Liam Breck <kernel@networkimprov.net>

On 05/08/2017 01:16 AM, Liam Breck wrote:
> On Thu, May 4, 2017 at 11:40 AM, Liam Breck <liam@networkimprov.net> wrote:
>> On Thu, May 4, 2017 at 9:52 AM, Andrew F. Davis <afd@ti.com> wrote:
>>> On 05/04/2017 01:18 AM, Liam Breck wrote:
>>>> From: Liam Breck <kernel@networkimprov.net>
>>>>
>>>> Previously there was no way to configure these chips in the event that the
>>>> defaults didn't match the battery in question.
>>>>
>>>> For chips with RAM data memory (and also those with flash/NVM data memory
>>>> if CONFIG_BATTERY_BQ27XXX_DT_UPDATES_NVM is defined and the user has not
>>>> set module param dt_monitored_battery_updates_nvm=0) we now call
>>>> power_supply_get_battery_info(), check its values, and write battery
>>>> properties to chip data memory if there is a dm_regs table for the chip.
>>>>
>>>> Signed-off-by: Matt Ranostay <matt@ranostay.consulting>
>>>> Signed-off-by: Liam Breck <kernel@networkimprov.net>
>>>> ---
>>>>  drivers/power/supply/Kconfig           |   9 ++
>>>>  drivers/power/supply/bq27xxx_battery.c | 199 ++++++++++++++++++++++++++++++++-
>>>>  include/linux/power/bq27xxx_battery.h  |   2 +
>>>>  3 files changed, 209 insertions(+), 1 deletion(-)
>>>>
>>>> diff --git a/drivers/power/supply/Kconfig b/drivers/power/supply/Kconfig
>>>> index 76806a0..85e2fb2 100644
>>>> --- a/drivers/power/supply/Kconfig
>>>> +++ b/drivers/power/supply/Kconfig
>>>> @@ -178,6 +178,15 @@ config BATTERY_BQ27XXX_I2C
>>>>         Say Y here to enable support for batteries with BQ27xxx chips
>>>>         connected over an I2C bus.
>>>>
>>>> +config BATTERY_BQ27XXX_DT_UPDATES_NVM
>>>> +     bool "BQ27xxx support for update of NVM/flash data memory"
>>>> +     depends on BATTERY_BQ27XXX_I2C
>>>> +     help
>>>> +       Say Y here to enable devicetree monitored-battery config to update
>>>> +       NVM/flash data memory. Only enable this option for devices with a
>>>> +       fuel gauge mounted on the circuit board, and a battery that cannot
>>>> +       be replaced with one of a different type.
>>>> +
>>>>  config BATTERY_DA9030
>>>>       tristate "DA9030 battery driver"
>>>>       depends on PMIC_DA903X
>>>> diff --git a/drivers/power/supply/bq27xxx_battery.c b/drivers/power/supply/bq27xxx_battery.c
>>>> index 8ab184c..06f15da 100644
>>>> --- a/drivers/power/supply/bq27xxx_battery.c
>>>> +++ b/drivers/power/supply/bq27xxx_battery.c
>>>> @@ -805,6 +805,13 @@ static LIST_HEAD(bq27xxx_battery_devices);
>>>>
>>>>  #define BQ27XXX_DM_SZ        32
>>>>
>>>> +struct bq27xxx_dm_reg {
>>>> +     u8 subclass_id;
>>>> +     u8 offset;
>>>> +     u8 bytes;
>>>> +     u16 min, max;
>>>> +};
>>>> +
>>>>  /**
>>>>   * struct bq27xxx_dm_buf - chip data memory buffer
>>>>   * @class: data memory subclass_id
>>>> @@ -822,6 +829,43 @@ struct bq27xxx_dm_buf {
>>>>       bool has_data, dirty;
>>>>  };
>>>>
>>>> +#define BQ27XXX_DM_BUF(di, i) { \
>>>> +     .class = (di)->dm_regs[i].subclass_id, \
>>>> +     .block = (di)->dm_regs[i].offset / BQ27XXX_DM_SZ, \
>>>> +}
>>>> +
>>>> +static inline u16 *bq27xxx_dm_reg_ptr(struct bq27xxx_dm_buf *buf,
>>>> +                                   struct bq27xxx_dm_reg *reg)
>>>> +{
>>>> +     if (buf->class == reg->subclass_id &&
>>>> +         buf->block == reg->offset / BQ27XXX_DM_SZ)
>>>> +             return (u16 *) (buf->data + reg->offset % BQ27XXX_DM_SZ);
>>>> +
>>>> +     return NULL;
>>>> +}
>>>> +
>>>> +enum bq27xxx_dm_reg_id {
>>>> +     BQ27XXX_DM_DESIGN_CAPACITY = 0,
>>>> +     BQ27XXX_DM_DESIGN_ENERGY,
>>>> +     BQ27XXX_DM_TERMINATE_VOLTAGE,
>>>> +};
>>>> +
>>>> +static const char * const bq27xxx_dm_reg_name[] = {
>>>> +     [BQ27XXX_DM_DESIGN_CAPACITY] = "design-capacity",
>>>> +     [BQ27XXX_DM_DESIGN_ENERGY] = "design-energy",
>>>> +     [BQ27XXX_DM_TERMINATE_VOLTAGE] = "terminate-voltage",
>>>> +};
>>>> +
>>>> +
>>>> +#ifdef CONFIG_BATTERY_BQ27XXX_DT_UPDATES_NVM
>>>> +static bool bq27xxx_dt_to_nvm = true;
>>>> +
>>>> +module_param_named(dt_monitored_battery_updates_nvm, bq27xxx_dt_to_nvm, bool, 0444);
>>>> +MODULE_PARM_DESC(dt_monitored_battery_updates_nvm,
>>>> +     "Devicetree monitored-battery config updates NVM/flash data memory, if present. Default is 1/y.");
>>>
>>> As before, the default should not be y, this is a rare case and I can't
>>> see it being useful or wanted by anyone but device manufacturers. I
>>> don't want everyones chip's factory programmed NVM overwritten by
>>> accident when someone compiles and ships a kernel with
>>> BATTERY_BQ27XXX_DT_UPDATES_NVM=y
>>
>> Right, the point of the config option is to let a device vendor ship a
>> kernel + dtb which can field-upgrade NVM. (Setting the option does
>> nothing absent the necessary dtb.)
>>
>> Module params are for end-user config; we can't require a device
>> vendor to ship /etc/modprobe.d/xyz. And we certainly don't want a
>> kernel package update to defeat the end-user config of
>> dt_monitored_battery_updates_nvm=0 !!
>>
>> I believe Sebastian agrees, given that he queued this patch :-)
> 
> I clarified the rationale for module param default =1 above; could you ack?
> 
> That prevents this scenario:
> 1) user changes battery type, sets dt_monitored_battery_updates_nvm=0
> 2) vendor ships kernel package with dtb update and
> dt_monitored_battery_updates_nvm=1
> 3) gauge stops working correctly
> 

Leaving it =1 will encourage this situation, not prevent it. Updating
NVM is a non-standard operation for these parts. It should only be done
once ideally. It is nice being able to update the NVM, and we have
user-space tools for this, but this is a dangerous operation, improperly
programming can brick the chip, as you have found out.

If you want to add this function into the kernel driver that is fine,
but you *cannot* have this be the default, it needs to be a hidden away
option for people who know what they are doing, else you will end up
accidentally causing damage to countless users' hardware.

> 
>>>> +#else
>>>> +static bool bq27xxx_dt_to_nvm = false;
>>>> +#endif
>>>>
>>>>  static int poll_interval_param_set(const char *val, const struct kernel_param *kp)
>>>>  {
>>>> @@ -1019,6 +1063,51 @@ static int bq27xxx_battery_read_dm_block(struct bq27xxx_device_info *di,
>>>>       return ret;
>>>>  }
>>>>
>>>> +static void bq27xxx_battery_update_dm_block(struct bq27xxx_device_info *di,
>>>> +                                         struct bq27xxx_dm_buf *buf,
>>>> +                                         enum bq27xxx_dm_reg_id reg_id,
>>>> +                                         unsigned int val)
>>>> +{
>>>> +     struct bq27xxx_dm_reg *reg = &di->dm_regs[reg_id];
>>>> +     const char *str = bq27xxx_dm_reg_name[reg_id];
>>>> +     u16 *prev = bq27xxx_dm_reg_ptr(buf, reg);
>>>> +
>>>> +     if (prev == NULL) {
>>>> +             dev_warn(di->dev, "buffer does not match %s dm spec\n", str);
>>>> +             return;
>>>> +     }
>>>> +
>>>> +     if (reg->bytes != 2) {
>>>> +             dev_warn(di->dev, "%s dm spec has unsupported byte size\n", str);
>>>> +             return;
>>>> +     }
>>>> +
>>>> +     if (!buf->has_data)
>>>> +             return;
>>>> +
>>>> +     if (be16_to_cpup(prev) == val) {
>>>> +             dev_info(di->dev, "%s has %u\n", str, val);
>>>> +             return;
>>>> +     }
>>>> +
>>>> +     if (!di->ram_chip && !bq27xxx_dt_to_nvm) {
>>>> +             /* devicetree and NVM differ; defer to NVM */
>>>> +             dev_warn(di->dev, "%s has %u; update to %u disallowed "
>>>> +#ifdef CONFIG_BATTERY_BQ27XXX_DT_UPDATES_NVM
>>>> +                      "by dt_monitored_battery_updates_nvm=0"
>>>> +#else
>>>> +                      "for flash/NVM data memory"
>>>> +#endif
>>>> +                      "\n", str, be16_to_cpup(prev), val);
>>>> +             return;
>>>> +     }
>>>> +
>>>> +     dev_info(di->dev, "update %s to %u\n", str, val);
>>>> +
>>>> +     *prev = cpu_to_be16(val);
>>>> +     buf->dirty = true;
>>>> +}
>>>> +
>>>>  static int bq27xxx_battery_set_cfgupdate(struct bq27xxx_device_info *di, u16 state)
>>>>  {
>>>>       const int limit = 100;
>>>> @@ -1117,6 +1206,103 @@ static int bq27xxx_battery_write_dm_block(struct bq27xxx_device_info *di,
>>>>       return ret;
>>>>  }
>>>>
>>>> +static void bq27xxx_battery_set_config(struct bq27xxx_device_info *di,
>>>> +                                    struct power_supply_battery_info *info)
>>>> +{
>>>> +     struct bq27xxx_dm_buf bd = BQ27XXX_DM_BUF(di, BQ27XXX_DM_DESIGN_CAPACITY);
>>>> +     struct bq27xxx_dm_buf bt = BQ27XXX_DM_BUF(di, BQ27XXX_DM_TERMINATE_VOLTAGE);
>>>> +     bool updated;
>>>> +
>>>> +     if (bq27xxx_battery_unseal(di) < 0)
>>>> +             return;
>>>> +
>>>> +     if (info->charge_full_design_uah != -EINVAL &&
>>>> +         info->energy_full_design_uwh != -EINVAL) {
>>>> +             bq27xxx_battery_read_dm_block(di, &bd);
>>>> +             /* assume design energy & capacity are in same block */
>>>> +             bq27xxx_battery_update_dm_block(di, &bd,
>>>> +                                     BQ27XXX_DM_DESIGN_CAPACITY,
>>>> +                                     info->charge_full_design_uah / 1000);
>>>> +             bq27xxx_battery_update_dm_block(di, &bd,
>>>> +                                     BQ27XXX_DM_DESIGN_ENERGY,
>>>> +                                     info->energy_full_design_uwh / 1000);
>>>> +     }
>>>> +
>>>> +     if (info->voltage_min_design_uv != -EINVAL) {
>>>> +             bool same = bd.class == bt.class && bd.block == bt.block;
>>>> +             if (!same)
>>>> +                     bq27xxx_battery_read_dm_block(di, &bt);
>>>> +             bq27xxx_battery_update_dm_block(di, same ? &bd : &bt,
>>>> +                                     BQ27XXX_DM_TERMINATE_VOLTAGE,
>>>> +                                     info->voltage_min_design_uv / 1000);
>>>> +     }
>>>> +
>>>> +     updated = bd.dirty || bt.dirty;
>>>> +
>>>> +     bq27xxx_battery_write_dm_block(di, &bd);
>>>> +     bq27xxx_battery_write_dm_block(di, &bt);
>>>> +
>>>> +     bq27xxx_battery_seal(di);
>>>> +
>>>> +     if (updated && di->chip != BQ27421) { /* not a cfgupdate chip, so reset */
>>>> +             bq27xxx_write(di, BQ27XXX_REG_CTRL, BQ27XXX_RESET, false);
>>>> +             BQ27XXX_MSLEEP(300); /* reset time is not documented */
>>>> +     }
>>>> +     /* assume bq27xxx_battery_update() is called hereafter */
>>>> +}
>>>> +
>>>> +static void bq27xxx_battery_settings(struct bq27xxx_device_info *di)
>>>> +{
>>>> +     struct power_supply_battery_info info = {};
>>>> +     unsigned int min, max;
>>>> +
>>>> +     if (power_supply_get_battery_info(di->bat, &info) < 0)
>>>> +             return;
>>>> +
>>>> +     if (!di->dm_regs) {
>>>> +             dev_warn(di->dev, "data memory update not supported for chip\n");
>>>> +             return;
>>>> +     }
>>>> +
>>>> +     if (info.energy_full_design_uwh != info.charge_full_design_uah) {
>>>> +             if (info.energy_full_design_uwh == -EINVAL)
>>>> +                     dev_warn(di->dev, "missing battery:energy-full-design-microwatt-hours\n");
>>>> +             else if (info.charge_full_design_uah == -EINVAL)
>>>> +                     dev_warn(di->dev, "missing battery:charge-full-design-microamp-hours\n");
>>>> +     }
>>>> +
>>>> +     /* assume min == 0 */
>>>> +     max = di->dm_regs[BQ27XXX_DM_DESIGN_ENERGY].max;
>>>> +     if (info.energy_full_design_uwh > max * 1000) {
>>>> +             dev_err(di->dev, "invalid battery:energy-full-design-microwatt-hours %d\n",
>>>> +                     info.energy_full_design_uwh);
>>>> +             info.energy_full_design_uwh = -EINVAL;
>>>> +     }
>>>> +
>>>> +     /* assume min == 0 */
>>>> +     max = di->dm_regs[BQ27XXX_DM_DESIGN_CAPACITY].max;
>>>> +     if (info.charge_full_design_uah > max * 1000) {
>>>> +             dev_err(di->dev, "invalid battery:charge-full-design-microamp-hours %d\n",
>>>> +                     info.charge_full_design_uah);
>>>> +             info.charge_full_design_uah = -EINVAL;
>>>> +     }
>>>> +
>>>> +     min = di->dm_regs[BQ27XXX_DM_TERMINATE_VOLTAGE].min;
>>>> +     max = di->dm_regs[BQ27XXX_DM_TERMINATE_VOLTAGE].max;
>>>> +     if ((info.voltage_min_design_uv < min * 1000 ||
>>>> +          info.voltage_min_design_uv > max * 1000) &&
>>>> +          info.voltage_min_design_uv != -EINVAL) {
>>>> +             dev_err(di->dev, "invalid battery:voltage-min-design-microvolt %d\n",
>>>> +                     info.voltage_min_design_uv);
>>>> +             info.voltage_min_design_uv = -EINVAL;
>>>> +     }
>>>> +
>>>> +     if ((info.energy_full_design_uwh != -EINVAL &&
>>>> +          info.charge_full_design_uah != -EINVAL) ||
>>>> +          info.voltage_min_design_uv  != -EINVAL)
>>>> +             bq27xxx_battery_set_config(di, &info);
>>>> +}
>>>> +
>>>>  /*
>>>>   * Return the battery State-of-Charge
>>>>   * Or < 0 if something fails.
>>>> @@ -1634,6 +1820,13 @@ static int bq27xxx_battery_get_property(struct power_supply *psy,
>>>>       case POWER_SUPPLY_PROP_CHARGE_FULL_DESIGN:
>>>>               ret = bq27xxx_simple_value(di->charge_design_full, val);
>>>>               break;
>>>> +     /*
>>>> +      * TODO: Implement these to make registers set from
>>>> +      * power_supply_battery_info visible in sysfs.
>>>> +      */
>>>> +     case POWER_SUPPLY_PROP_ENERGY_FULL_DESIGN:
>>>> +     case POWER_SUPPLY_PROP_VOLTAGE_MIN_DESIGN:
>>>> +             return -EINVAL;
>>>>       case POWER_SUPPLY_PROP_CYCLE_COUNT:
>>>>               ret = bq27xxx_simple_value(di->cache.cycle_count, val);
>>>>               break;
>>>> @@ -1667,7 +1860,10 @@ static void bq27xxx_external_power_changed(struct power_supply *psy)
>>>>  int bq27xxx_battery_setup(struct bq27xxx_device_info *di)
>>>>  {
>>>>       struct power_supply_desc *psy_desc;
>>>> -     struct power_supply_config psy_cfg = { .drv_data = di, };
>>>> +     struct power_supply_config psy_cfg = {
>>>> +             .of_node = di->dev->of_node,
>>>> +             .drv_data = di,
>>>> +     };
>>>>
>>>>       INIT_DELAYED_WORK(&di->work, bq27xxx_battery_poll);
>>>>       mutex_init(&di->lock);
>>>> @@ -1692,6 +1888,7 @@ int bq27xxx_battery_setup(struct bq27xxx_device_info *di)
>>>>
>>>>       dev_info(di->dev, "support ver. %s enabled\n", DRIVER_VERSION);
>>>>
>>>> +     bq27xxx_battery_settings(di);
>>>>       bq27xxx_battery_update(di);
>>>>
>>>>       mutex_lock(&bq27xxx_list_lock);
>>>> diff --git a/include/linux/power/bq27xxx_battery.h b/include/linux/power/bq27xxx_battery.h
>>>> index b1defb8..11e1168 100644
>>>> --- a/include/linux/power/bq27xxx_battery.h
>>>> +++ b/include/linux/power/bq27xxx_battery.h
>>>> @@ -63,7 +63,9 @@ struct bq27xxx_device_info {
>>>>       struct device *dev;
>>>>       int id;
>>>>       enum bq27xxx_chip chip;
>>>> +     bool ram_chip;
>>>>       const char *name;
>>>> +     struct bq27xxx_dm_reg *dm_regs;
>>>>       u32 unseal_key;
>>>>       struct bq27xxx_access_methods bus;
>>>>       struct bq27xxx_reg_cache cache;
>>>>
