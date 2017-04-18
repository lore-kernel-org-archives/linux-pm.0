From: Hans de Goede <hdegoede@redhat.com>
Subject: Re: [PATCH v1 1/1] power: bq24190_charger: Deprecate battery class
 and replicate its features in charger
Date: Tue, 18 Apr 2017 12:05:03 +0200
Message-ID: <c02691e1-cbcc-078b-5e12-bcef0e19d98a@redhat.com>
References: <20170416230626.30022-1-liam@networkimprov.net>
 <aaf8c54b-aac8-9ccd-cd17-4b318f4520c2@redhat.com>
 <CAKvHMgQGWur8JgYjJ1uh12_JHPTSRAPo8EcwBPgvygWBFjceNw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:34632 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754819AbdDRKFH (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 18 Apr 2017 06:05:07 -0400
In-Reply-To: <CAKvHMgQGWur8JgYjJ1uh12_JHPTSRAPo8EcwBPgvygWBFjceNw@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Liam Breck <liam@networkimprov.net>
Cc: Sebastian Reichel <sre@kernel.org>, linux-pm@vger.kernel.org, Tony Lindgren <tony@atomide.com>, Liam Breck <kernel@networkimprov.net>

Hi,

On 18-04-17 11:42, Liam Breck wrote:
> Hi Hans,
>
> On Tue, Apr 18, 2017 at 1:05 AM, Hans de Goede <hdegoede@redhat.com> wrote:
>> Hi Liam,
>>
>> On 17-04-17 01:06, Liam Breck wrote:
>>>
>>> From: Liam Breck <kernel@networkimprov.net>
>>>
>>> The driver was registering two classes, bq24190-battery & -charger.
>>> Because the power supply framework cannot surface features from multiple
>>> drivers in a single class, a fuel gauge driver would create a third class,
>>> which some power management utilities cannot see.
>>>
>>> Deprecate the -battery class for future removal and replicate its features
>>> in -charger. Set /sys/class...-charger/online = pg_stat &&
>>> !batfet_disable.
>>> If device_property "omit-battery-class" is set, don't register -battery.
>>>
>>> Cc: Tony Lindgren <tony@atomide.com>
>>> Cc: Hans de Goede <hdegoede@redhat.com>
>>> Signed-off-by: Liam Breck <kernel@networkimprov.net>
>>
>>
>> Thank you for writing this patch.
>
> Glad to help!
>
>> The patch looks good to me:
>
> Darn, I was hoping you'd see *something* amiss in all that clutter :-)

Wel, I did not find the forward declaration of bq24190_battery_set_online
and friends pretty, but I can understand why you did this and we can
clean that up when we remove the battery interface altogether later.

> Do you think charger-powered and battery-connected is the right
> definition of power_supply_prop_online?

Now that you specifically ask I've been thinking a bit more this,
but I still can't find anything wrong with that as definition :)

> Sebastian had suggested surfacing the batfet as a regulator, but altho
> user settable, it's a binary widget.

Turning off the batfet typically will turn off the entire system,
I believe it is more of an emergency break style switch which gets
thrown by the charger under certain (very bad) conditions then
something which we would actually ever want to use / control from
within the kernel.

Regards,

Hans



>
>> Reviewed-by: Hans de Goede <hdegoede@redhat.com>
>>
>> Regards,
>>
>> Hans
>>
>> p.s.
>>
>> Any chance you can find some time to review:
>>
>> "[PATCH v6] power: supply: bq24190_charger: Add disable-reset
>> device-property" ?
>>
>>
>>
>>
>>
>>> ---
>>>  drivers/power/supply/bq24190_charger.c | 146
>>> +++++++++++++++++++++++++--------
>>>  1 file changed, 111 insertions(+), 35 deletions(-)
>>>
>>> diff --git a/drivers/power/supply/bq24190_charger.c
>>> b/drivers/power/supply/bq24190_charger.c
>>> index f581042..4197fdb 100644
>>> --- a/drivers/power/supply/bq24190_charger.c
>>> +++ b/drivers/power/supply/bq24190_charger.c
>>> @@ -658,22 +658,25 @@ static int bq24190_charger_get_health(struct
>>> bq24190_dev_info *bdi,
>>>         v = bdi->f_reg;
>>>         mutex_unlock(&bdi->f_reg_lock);
>>>
>>> -       if (v & BQ24190_REG_F_BOOST_FAULT_MASK) {
>>> -               /*
>>> -                * This could be over-current or over-voltage but there's
>>> -                * no way to tell which.  Return 'OVERVOLTAGE' since there
>>> -                * isn't an 'OVERCURRENT' value defined that we can return
>>> -                * even if it was over-current.
>>> -                */
>>> -               health = POWER_SUPPLY_HEALTH_OVERVOLTAGE;
>>> -       } else {
>>> -               v &= BQ24190_REG_F_CHRG_FAULT_MASK;
>>> -               v >>= BQ24190_REG_F_CHRG_FAULT_SHIFT;
>>> -
>>> -               switch (v) {
>>> -               case 0x0: /* Normal */
>>> -                       health = POWER_SUPPLY_HEALTH_GOOD;
>>> +       if (v & BQ24190_REG_F_NTC_FAULT_MASK) {
>>> +               switch (v >> BQ24190_REG_F_NTC_FAULT_SHIFT & 0x7) {
>>> +               case 0x1: /* TS1  Cold */
>>> +               case 0x3: /* TS2  Cold */
>>> +               case 0x5: /* Both Cold */
>>> +                       health = POWER_SUPPLY_HEALTH_COLD;
>>>                         break;
>>> +               case 0x2: /* TS1  Hot */
>>> +               case 0x4: /* TS2  Hot */
>>> +               case 0x6: /* Both Hot */
>>> +                       health = POWER_SUPPLY_HEALTH_OVERHEAT;
>>> +                       break;
>>> +               default:
>>> +                       health = POWER_SUPPLY_HEALTH_UNKNOWN;
>>> +               }
>>> +       } else if (v & BQ24190_REG_F_BAT_FAULT_MASK) {
>>> +               health = POWER_SUPPLY_HEALTH_OVERVOLTAGE;
>>> +       } else if (v & BQ24190_REG_F_CHRG_FAULT_MASK) {
>>> +               switch (v >> BQ24190_REG_F_CHRG_FAULT_SHIFT & 0x3) {
>>>                 case 0x1: /* Input Fault (VBUS OVP or VBAT<VBUS<3.8V) */
>>>                         /*
>>>                          * This could be over-voltage or under-voltage
>>> @@ -690,9 +693,19 @@ static int bq24190_charger_get_health(struct
>>> bq24190_dev_info *bdi,
>>>                 case 0x3: /* Charge Safety Timer Expiration */
>>>                         health = POWER_SUPPLY_HEALTH_SAFETY_TIMER_EXPIRE;
>>>                         break;
>>> -               default:
>>> -                       health = POWER_SUPPLY_HEALTH_UNKNOWN;
>>> +               default:  /* prevent compiler warning */
>>> +                       health = -1;
>>>                 }
>>> +       } else if (v & BQ24190_REG_F_BOOST_FAULT_MASK) {
>>> +               /*
>>> +                * This could be over-current or over-voltage but there's
>>> +                * no way to tell which.  Return 'OVERVOLTAGE' since there
>>> +                * isn't an 'OVERCURRENT' value defined that we can return
>>> +                * even if it was over-current.
>>> +                */
>>> +               health = POWER_SUPPLY_HEALTH_OVERVOLTAGE;
>>> +       } else {
>>> +               health = POWER_SUPPLY_HEALTH_GOOD;
>>>         }
>>>
>>>         val->intval = health;
>>> @@ -703,19 +716,59 @@ static int bq24190_charger_get_health(struct
>>> bq24190_dev_info *bdi,
>>>  static int bq24190_charger_get_online(struct bq24190_dev_info *bdi,
>>>                 union power_supply_propval *val)
>>>  {
>>> -       u8 v;
>>> +       u8 pg_stat, batfet_disable;
>>>         int ret;
>>>
>>>         ret = bq24190_read_mask(bdi, BQ24190_REG_SS,
>>>                         BQ24190_REG_SS_PG_STAT_MASK,
>>> -                       BQ24190_REG_SS_PG_STAT_SHIFT, &v);
>>> +                       BQ24190_REG_SS_PG_STAT_SHIFT, &pg_stat);
>>>         if (ret < 0)
>>>                 return ret;
>>>
>>> -       val->intval = v;
>>> +       ret = bq24190_read_mask(bdi, BQ24190_REG_MOC,
>>> +                       BQ24190_REG_MOC_BATFET_DISABLE_MASK,
>>> +                       BQ24190_REG_MOC_BATFET_DISABLE_SHIFT,
>>> &batfet_disable);
>>> +       if (ret < 0)
>>> +               return ret;
>>> +
>>> +       val->intval = pg_stat && !batfet_disable;
>>> +
>>>         return 0;
>>>  }
>>>
>>> +static int bq24190_battery_set_online(struct bq24190_dev_info *bdi,
>>> +                                     const union power_supply_propval
>>> *val);
>>> +static int bq24190_battery_get_status(struct bq24190_dev_info *bdi,
>>> +                                     union power_supply_propval *val);
>>> +static int bq24190_battery_get_temp_alert_max(struct bq24190_dev_info
>>> *bdi,
>>> +                                             union power_supply_propval
>>> *val);
>>> +static int bq24190_battery_set_temp_alert_max(struct bq24190_dev_info
>>> *bdi,
>>> +                                             const union
>>> power_supply_propval *val);
>>> +
>>> +static int bq24190_charger_set_online(struct bq24190_dev_info *bdi,
>>> +                                     const union power_supply_propval
>>> *val)
>>> +{
>>> +       return bq24190_battery_set_online(bdi, val);
>>> +}
>>> +
>>> +static int bq24190_charger_get_status(struct bq24190_dev_info *bdi,
>>> +                                     union power_supply_propval *val)
>>> +{
>>> +       return bq24190_battery_get_status(bdi, val);
>>> +}
>>> +
>>> +static int bq24190_charger_get_temp_alert_max(struct bq24190_dev_info
>>> *bdi,
>>> +                                             union power_supply_propval
>>> *val)
>>> +{
>>> +       return bq24190_battery_get_temp_alert_max(bdi, val);
>>> +}
>>> +
>>> +static int bq24190_charger_set_temp_alert_max(struct bq24190_dev_info
>>> *bdi,
>>> +                                             const union
>>> power_supply_propval *val)
>>> +{
>>> +       return bq24190_battery_set_temp_alert_max(bdi, val);
>>> +}
>>> +
>>>  static int bq24190_charger_get_current(struct bq24190_dev_info *bdi,
>>>                 union power_supply_propval *val)
>>>  {
>>> @@ -830,6 +883,12 @@ static int bq24190_charger_get_property(struct
>>> power_supply *psy,
>>>         case POWER_SUPPLY_PROP_ONLINE:
>>>                 ret = bq24190_charger_get_online(bdi, val);
>>>                 break;
>>> +       case POWER_SUPPLY_PROP_STATUS:
>>> +               ret = bq24190_charger_get_status(bdi, val);
>>> +               break;
>>> +       case POWER_SUPPLY_PROP_TEMP_ALERT_MAX:
>>> +               ret =  bq24190_charger_get_temp_alert_max(bdi, val);
>>> +               break;
>>>         case POWER_SUPPLY_PROP_CONSTANT_CHARGE_CURRENT:
>>>                 ret = bq24190_charger_get_current(bdi, val);
>>>                 break;
>>> @@ -878,6 +937,12 @@ static int bq24190_charger_set_property(struct
>>> power_supply *psy,
>>>                 return ret;
>>>
>>>         switch (psp) {
>>> +       case POWER_SUPPLY_PROP_ONLINE:
>>> +               ret = bq24190_charger_set_online(bdi, val);
>>> +               break;
>>> +       case POWER_SUPPLY_PROP_TEMP_ALERT_MAX:
>>> +               ret = bq24190_charger_set_temp_alert_max(bdi, val);
>>> +               break;
>>>         case POWER_SUPPLY_PROP_CHARGE_TYPE:
>>>                 ret = bq24190_charger_set_charge_type(bdi, val);
>>>                 break;
>>> @@ -903,6 +968,8 @@ static int
>>> bq24190_charger_property_is_writeable(struct power_supply *psy,
>>>         int ret;
>>>
>>>         switch (psp) {
>>> +       case POWER_SUPPLY_PROP_ONLINE:
>>> +       case POWER_SUPPLY_PROP_TEMP_ALERT_MAX:
>>>         case POWER_SUPPLY_PROP_CHARGE_TYPE:
>>>         case POWER_SUPPLY_PROP_CONSTANT_CHARGE_CURRENT:
>>>         case POWER_SUPPLY_PROP_CONSTANT_CHARGE_VOLTAGE:
>>> @@ -919,6 +986,8 @@ static enum power_supply_property
>>> bq24190_charger_properties[] = {
>>>         POWER_SUPPLY_PROP_CHARGE_TYPE,
>>>         POWER_SUPPLY_PROP_HEALTH,
>>>         POWER_SUPPLY_PROP_ONLINE,
>>> +       POWER_SUPPLY_PROP_STATUS,
>>> +       POWER_SUPPLY_PROP_TEMP_ALERT_MAX,
>>>         POWER_SUPPLY_PROP_CONSTANT_CHARGE_CURRENT,
>>>         POWER_SUPPLY_PROP_CONSTANT_CHARGE_CURRENT_MAX,
>>>         POWER_SUPPLY_PROP_CONSTANT_CHARGE_VOLTAGE,
>>> @@ -1092,6 +1161,7 @@ static int bq24190_battery_get_property(struct
>>> power_supply *psy,
>>>         struct bq24190_dev_info *bdi = power_supply_get_drvdata(psy);
>>>         int ret;
>>>
>>> +       dev_warn(bdi->dev, "warning:
>>> /sys/class/power_supply/bq24190-battery is deprecated\n");
>>>         dev_dbg(bdi->dev, "prop: %d\n", psp);
>>>
>>>         ret = pm_runtime_get_sync(bdi->dev);
>>> @@ -1137,6 +1207,7 @@ static int bq24190_battery_set_property(struct
>>> power_supply *psy,
>>>         struct bq24190_dev_info *bdi = power_supply_get_drvdata(psy);
>>>         int ret;
>>>
>>> +       dev_warn(bdi->dev, "warning:
>>> /sys/class/power_supply/bq24190-battery is deprecated\n");
>>>         dev_dbg(bdi->dev, "prop: %d\n", psp);
>>>
>>>         ret = pm_runtime_get_sync(bdi->dev);
>>> @@ -1265,9 +1336,9 @@ static void bq24190_check_status(struct
>>> bq24190_dev_info *bdi)
>>>                 bdi->ss_reg = ss_reg;
>>>         }
>>>
>>> -       if (alert_charger)
>>> +       if (alert_charger || alert_battery)
>>>                 power_supply_changed(bdi->charger);
>>> -       if (alert_battery)
>>> +       if (alert_battery && bdi->battery)
>>>                 power_supply_changed(bdi->battery);
>>>
>>>         dev_dbg(bdi->dev, "ss_reg: 0x%02x, f_reg: 0x%02x\n", ss_reg,
>>> f_reg);
>>> @@ -1472,19 +1543,23 @@ static int bq24190_probe(struct i2c_client
>>> *client,
>>>                 goto out_pmrt;
>>>         }
>>>
>>> -       battery_cfg.drv_data = bdi;
>>> -       bdi->battery = power_supply_register(dev, &bq24190_battery_desc,
>>> -                                               &battery_cfg);
>>> -       if (IS_ERR(bdi->battery)) {
>>> -               dev_err(dev, "Can't register battery\n");
>>> -               ret = PTR_ERR(bdi->battery);
>>> -               goto out_charger;
>>> +       /* the battery class is deprecated and will be removed. */
>>> +       /* in the interim, this property hides it.              */
>>> +       if (!device_property_read_bool(dev, "omit-battery-class")) {
>>> +               battery_cfg.drv_data = bdi;
>>> +               bdi->battery = power_supply_register(dev,
>>> &bq24190_battery_desc,
>>> +                                                    &battery_cfg);
>>> +               if (IS_ERR(bdi->battery)) {
>>> +                       dev_err(dev, "Can't register battery\n");
>>> +                       ret = PTR_ERR(bdi->battery);
>>> +                       goto out_charger;
>>> +               }
>>>         }
>>>
>>>         ret = bq24190_sysfs_create_group(bdi);
>>>         if (ret) {
>>>                 dev_err(dev, "Can't create sysfs entries\n");
>>> -               goto out_battery;
>>> +               goto out_charger;
>>>         }
>>>
>>>         bdi->initialized = true;
>>> @@ -1522,10 +1597,9 @@ static int bq24190_probe(struct i2c_client *client,
>>>  out_sysfs:
>>>         bq24190_sysfs_remove_group(bdi);
>>>
>>> -out_battery:
>>> -       power_supply_unregister(bdi->battery);
>>> -
>>>  out_charger:
>>> +       if (!IS_ERR_OR_NULL(bdi->battery))
>>> +               power_supply_unregister(bdi->battery);
>>>         power_supply_unregister(bdi->charger);
>>>
>>>  out_pmrt:
>>> @@ -1548,7 +1622,8 @@ static int bq24190_remove(struct i2c_client *client)
>>>
>>>         bq24190_register_reset(bdi);
>>>         bq24190_sysfs_remove_group(bdi);
>>> -       power_supply_unregister(bdi->battery);
>>> +       if (bdi->battery)
>>> +               power_supply_unregister(bdi->battery);
>>>         power_supply_unregister(bdi->charger);
>>>         if (error >= 0)
>>>                 pm_runtime_put_sync(bdi->dev);
>>> @@ -1635,7 +1710,8 @@ static __maybe_unused int bq24190_pm_resume(struct
>>> device *dev)
>>>
>>>         /* Things may have changed while suspended so alert upper layer */
>>>         power_supply_changed(bdi->charger);
>>> -       power_supply_changed(bdi->battery);
>>> +       if (bdi->battery)
>>> +               power_supply_changed(bdi->battery);
>>>
>>>         return 0;
>>>  }
>>>
>>
