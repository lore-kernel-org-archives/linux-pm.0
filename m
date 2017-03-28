From: Liam Breck <liam@networkimprov.net>
Subject: Re: [PATCH v12 7/9] power: bq27xxx_battery: Add power_supply_battery_info
 support
Date: Mon, 27 Mar 2017 23:29:30 -0700
Message-ID: <CAKvHMgTnT0jJKduDU9fmC7u=O5DMfZpE-OyvoL313eGGtXdS6A@mail.gmail.com>
References: <20170327074159.16213-1-liam@networkimprov.net>
 <20170327074159.16213-4-liam@networkimprov.net> <ba7819ad-d357-02fc-c06b-30d9a4e701cc@ti.com>
 <CAKvHMgT_Z6_3YUvp7U-SeKYbFtqwSwxzQuO8o6t0KFyH+0Q8XQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-it0-f66.google.com ([209.85.214.66]:34394 "EHLO
        mail-it0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752766AbdC1G3s (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 28 Mar 2017 02:29:48 -0400
Received: by mail-it0-f66.google.com with SMTP id e75so1565834itd.1
        for <linux-pm@vger.kernel.org>; Mon, 27 Mar 2017 23:29:31 -0700 (PDT)
In-Reply-To: <CAKvHMgT_Z6_3YUvp7U-SeKYbFtqwSwxzQuO8o6t0KFyH+0Q8XQ@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Andrew F. Davis" <afd@ti.com>
Cc: linux-pm@vger.kernel.org, Matt Ranostay <matt@ranostay.consulting>, Liam Breck <kernel@networkimprov.net>

On Mon, Mar 27, 2017 at 1:52 PM, Liam Breck <liam@networkimprov.net> wrote:
> On Mon, Mar 27, 2017 at 8:01 AM, Andrew F. Davis <afd@ti.com> wrote:
>> On 03/27/2017 02:41 AM, Liam Breck wrote:
>>> From: Liam Breck <kernel@networkimprov.net>
>>>
>>> Previously there was no way to configure these chips in the event that the
>>> defaults didn't match the battery in question.
>>>
>>> We now call power_supply_get_battery_info(), check its values, and write
>>> battery data to chip data memory (flash/RAM/NVM).
>>>
>>
>> How do we know if that is the correct thing to do? Maybe the values in
>> NVM are more correct than the DT and the DT values are just for
>> reference when NVM is not present. Updating NVM with DT values needs to
>> be controllable by the user, not automatic every time this driver probes.
>
> We trust the OS package to contain correct config for RAM-only chips,
> but not NVM? A battery config would not be set in mainline dts files,
> unless the battery is non-removable in the device.
>
> If NVM is unexpectedly present, then the entire device is unexpected,
> and you have bigger issues than battery config.
>
> We could prevent a DT referencing a different gauge than is present
> from taking effect by checking device_type via control register. But
> it's not clear that second-guessing the DT is wise.

But the control register device_type values are shared among diff
chips, so that won't work.

I addressed all your other comments. Latest draft at
https://github.com/networkimprov/linux/commits/anvl-v4.9-bq27x-dt-12.1

>>> Signed-off-by: Matt Ranostay <matt@ranostay.consulting>
>>> Signed-off-by: Liam Breck <kernel@networkimprov.net>
>>> ---
>>>  drivers/power/supply/bq27xxx_battery.c | 105 ++++++++++++++++++++++++++++++++-
>>>  1 file changed, 104 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/power/supply/bq27xxx_battery.c b/drivers/power/supply/bq27xxx_battery.c
>>> index ad152cc..d845ade 100644
>>> --- a/drivers/power/supply/bq27xxx_battery.c
>>> +++ b/drivers/power/supply/bq27xxx_battery.c
>>> @@ -1210,6 +1210,98 @@ static int bq27xxx_battery_write_dm_block(struct bq27xxx_device_info *di,
>>>       return ret;
>>>  }
>>>
>>> +static void bq27xxx_battery_set_config(struct bq27xxx_device_info *di,
>>> +                                    struct power_supply_battery_info *info)
>>> +{
>>> +     struct bq27xxx_dm_buf bd = BQ27XXX_DM_BUF(di, BQ27XXX_DM_DESIGN_CAPACITY);
>>> +     struct bq27xxx_dm_buf bt = BQ27XXX_DM_BUF(di, BQ27XXX_DM_TERMINATE_VOLTAGE);
>>> +
>>> +     if (bq27xxx_battery_unseal(di) < 0)
>>> +             return;
>>> +
>>> +     if (info->charge_full_design_uah != -EINVAL &&
>>> +         info->energy_full_design_uwh != -EINVAL) {
>>> +             bq27xxx_battery_read_dm_block(di, &bd);
>>> +             /* assume design energy & capacity are in same block */
>>> +             bq27xxx_battery_update_dm_block(di, &bd,
>>> +                                     BQ27XXX_DM_DESIGN_CAPACITY,
>>> +                                     info->charge_full_design_uah / 1000);
>>> +             bq27xxx_battery_update_dm_block(di, &bd,
>>> +                                     BQ27XXX_DM_DESIGN_ENERGY,
>>> +                                     info->energy_full_design_uwh / 1000);
>>> +     }
>>> +
>>> +     if (info->voltage_min_design_uv != -EINVAL) {
>>> +             bool same = bd.class == bt.class && bd.block == bt.block;
>>> +             if (!same)
>>> +                     bq27xxx_battery_read_dm_block(di, &bt);
>>> +             bq27xxx_battery_update_dm_block(di, same ? &bd : &bt,
>>> +                                     BQ27XXX_DM_TERMINATE_VOLTAGE,
>>> +                                     info->voltage_min_design_uv / 1000);
>>> +     }
>>> +
>>> +     bq27xxx_battery_write_dm_block(di, &bd);
>>> +     bq27xxx_battery_write_dm_block(di, &bt);
>>> +
>>> +     bq27xxx_battery_seal(di);
>>> +
>>> +     if (di->chip != BQ27421) { /* not a cfgupdate chip, so reset */
>>> +             bq27xxx_write(di, BQ27XXX_REG_CTRL, BQ27XXX_RESET, false);
>>> +             BQ27XXX_MSLEEP(300); /* reset time is not documented */
>>> +     }
>>> +     /* assume bq27xxx_battery_update() is called hereafter */
>>> +}
>>> +
>>> +void bq27xxx_battery_settings(struct bq27xxx_device_info *di)
>>> +{
>>> +     struct power_supply_battery_info info = {};
>>> +     unsigned int min, max;
>>> +
>>> +     if (!di->dm_regs)
>>> +             return;
>>> +
>>> +     if (power_supply_get_battery_info(di->bat, &info) < 0)
>>> +             return;
>>> +
>>> +     if (info.energy_full_design_uwh != info.charge_full_design_uah) {
>>> +             if (info.energy_full_design_uwh == -EINVAL)
>>> +                     dev_warn(di->dev, "missing battery:energy-full-design-microwatt-hours\n");
>>> +             else if (info.charge_full_design_uah == -EINVAL)
>>> +                     dev_warn(di->dev, "missing battery:charge-full-design-microamp-hours\n");
>>> +     }
>>> +
>>> +     /* assume min == 0 */
>>> +     max = di->dm_regs[BQ27XXX_DM_DESIGN_ENERGY].max;
>>> +     if (info.energy_full_design_uwh > max * 1000) {
>>> +             dev_err(di->dev, "invalid battery:energy-full-design-microwatt-hours %d\n",
>>> +                     info.energy_full_design_uwh);
>>> +             info.energy_full_design_uwh = -EINVAL;
>>> +     }
>>> +
>>> +     /* assume min == 0 */
>>> +     max = di->dm_regs[BQ27XXX_DM_DESIGN_CAPACITY].max;
>>> +     if (info.charge_full_design_uah > max * 1000) {
>>> +             dev_err(di->dev, "invalid battery:charge-full-design-microamp-hours %d\n",
>>> +                     info.charge_full_design_uah);
>>> +             info.charge_full_design_uah = -EINVAL;
>>> +     }
>>> +
>>> +     min = di->dm_regs[BQ27XXX_DM_TERMINATE_VOLTAGE].min;
>>> +     max = di->dm_regs[BQ27XXX_DM_TERMINATE_VOLTAGE].max;
>>> +     if ((info.voltage_min_design_uv < min * 1000 ||
>>> +          info.voltage_min_design_uv > max * 1000) &&
>>> +          info.voltage_min_design_uv != -EINVAL) {
>>> +             dev_err(di->dev, "invalid battery:voltage-min-design-microvolt %d\n",
>>> +                     info.voltage_min_design_uv);
>>> +             info.voltage_min_design_uv = -EINVAL;
>>> +     }
>>> +
>>> +     if ((info.energy_full_design_uwh != -EINVAL &&
>>> +          info.charge_full_design_uah != -EINVAL) ||
>>> +          info.voltage_min_design_uv  != -EINVAL)
>>> +             bq27xxx_battery_set_config(di, &info);
>>> +}
>>> +
>>>  /*
>>>   * Return the battery State-of-Charge
>>>   * Or < 0 if something fails.
>>> @@ -1727,6 +1819,13 @@ static int bq27xxx_battery_get_property(struct power_supply *psy,
>>>       case POWER_SUPPLY_PROP_CHARGE_FULL_DESIGN:
>>>               ret = bq27xxx_simple_value(di->charge_design_full, val);
>>>               break;
>>> +     /*
>>> +      * TODO: Implement these to make registers set from
>>> +      * power_supply_battery_info visible in sysfs.
>>> +      */
>>> +     case POWER_SUPPLY_PROP_ENERGY_FULL_DESIGN:
>>> +     case POWER_SUPPLY_PROP_VOLTAGE_MIN_DESIGN:
>>> +             return -EINVAL;
>>>       case POWER_SUPPLY_PROP_CYCLE_COUNT:
>>>               ret = bq27xxx_simple_value(di->cache.cycle_count, val);
>>>               break;
>>> @@ -1760,7 +1859,10 @@ static void bq27xxx_external_power_changed(struct power_supply *psy)
>>>  int bq27xxx_battery_setup(struct bq27xxx_device_info *di)
>>>  {
>>>       struct power_supply_desc *psy_desc;
>>> -     struct power_supply_config psy_cfg = { .drv_data = di, };
>>> +     struct power_supply_config psy_cfg = {
>>> +             .of_node = di->dev->of_node,
>>> +             .drv_data = di,
>>> +     };
>>>
>>>       INIT_DELAYED_WORK(&di->work, bq27xxx_battery_poll);
>>>       mutex_init(&di->lock);
>>> @@ -1785,6 +1887,7 @@ int bq27xxx_battery_setup(struct bq27xxx_device_info *di)
>>>
>>>       dev_info(di->dev, "support ver. %s enabled\n", DRIVER_VERSION);
>>>
>>> +     bq27xxx_battery_settings(di);
>>>       bq27xxx_battery_update(di);
>>>
>>>       mutex_lock(&bq27xxx_list_lock);
>>>
