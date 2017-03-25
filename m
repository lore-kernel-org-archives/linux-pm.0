From: Liam Breck <liam@networkimprov.net>
Subject: Re: [PATCH v2 7/7] power: supply: bq24190_charger: Remove battery
 power_supply device
Date: Fri, 24 Mar 2017 17:19:10 -0700
Message-ID: <CAKvHMgTuYwb5Rdn5nODXdNE3ra=REnF_GL_0PdJrc9nVPaEV+w@mail.gmail.com>
References: <20170322145536.30570-1-hdegoede@redhat.com> <20170322145536.30570-8-hdegoede@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-it0-f67.google.com ([209.85.214.67]:35559 "EHLO
        mail-it0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932134AbdCYATM (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 24 Mar 2017 20:19:12 -0400
Received: by mail-it0-f67.google.com with SMTP id y18so1052032itc.2
        for <linux-pm@vger.kernel.org>; Fri, 24 Mar 2017 17:19:11 -0700 (PDT)
In-Reply-To: <20170322145536.30570-8-hdegoede@redhat.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Hans de Goede <hdegoede@redhat.com>
Cc: Sebastian Reichel <sre@kernel.org>, Takashi Iwai <tiwai@suse.de>, linux-pm@vger.kernel.org, Liam Breck <kernel@networkimprov.net>, Tony Lindgren <tony@atomide.com>

On Wed, Mar 22, 2017 at 7:55 AM, Hans de Goede <hdegoede@redhat.com> wrote:
> The TI bq24190 chip is purely a charger chip, as such it has very
> little battery info to export to userspace and in practice it is almost
> always used together with a separate fuel-gauge chip which does have
> interesting info to export.
>
> Since the userspace ABI requires there to be only 1 power_supply device
> registered per physical battery, the limited battery power_supply device
> the bq24190_charger driver is registering is actually getting in the way
> of a fuel-gauge driver exporting more useful info, therefor this commit
> removes the battery power_supply device.

As discussed on the thread for my bq24190 patchset, this is not what's required.

I have a specific plan to move -battery properties to -charger, which
I will post when I get a chance.

Meanwhile...

> Cc: Liam Breck <kernel@networkimprov.net>
> Cc: Tony Lindgren <tony@atomide.com>
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> ---
> Changes in v2:
> -This is a new patch in v2 of this patch-set
> ---
>  drivers/power/supply/bq24190_charger.c | 290 +--------------------------------
>  1 file changed, 5 insertions(+), 285 deletions(-)
>
> diff --git a/drivers/power/supply/bq24190_charger.c b/drivers/power/supply/bq24190_charger.c
> index 5e3da66..52d8756 100644
> --- a/drivers/power/supply/bq24190_charger.c
> +++ b/drivers/power/supply/bq24190_charger.c
> @@ -151,7 +151,6 @@ struct bq24190_dev_info {
>         struct i2c_client               *client;
>         struct device                   *dev;
>         struct power_supply             *charger;
> -       struct power_supply             *battery;
>         struct extcon_dev               *extcon;
>         struct notifier_block           extcon_nb;
>         struct delayed_work             extcon_work;
> @@ -910,266 +909,9 @@ static const struct power_supply_desc bq24190_charger_desc = {
>         .property_is_writeable  = bq24190_charger_property_is_writeable,
>  };
>
> -/* Battery power supply property routines */
> -
> -static int bq24190_battery_get_status(struct bq24190_dev_info *bdi,
> -               union power_supply_propval *val)
> -{
> -       u8 ss_reg, chrg_fault;
> -       int status, ret;
> -
> -       mutex_lock(&bdi->f_reg_lock);
> -       chrg_fault = bdi->f_reg;
> -       mutex_unlock(&bdi->f_reg_lock);
> -
> -       chrg_fault &= BQ24190_REG_F_CHRG_FAULT_MASK;
> -       chrg_fault >>= BQ24190_REG_F_CHRG_FAULT_SHIFT;
> -
> -       ret = bq24190_read(bdi, BQ24190_REG_SS, &ss_reg);
> -       if (ret < 0)
> -               return ret;
> -
> -       /*
> -        * The battery must be discharging when any of these are true:
> -        * - there is no good power source;
> -        * - there is a charge fault.
> -        * Could also be discharging when in "supplement mode" but
> -        * there is no way to tell when its in that mode.
> -        */
> -       if (!(ss_reg & BQ24190_REG_SS_PG_STAT_MASK) || chrg_fault) {
> -               status = POWER_SUPPLY_STATUS_DISCHARGING;
> -       } else {
> -               ss_reg &= BQ24190_REG_SS_CHRG_STAT_MASK;
> -               ss_reg >>= BQ24190_REG_SS_CHRG_STAT_SHIFT;
> -
> -               switch (ss_reg) {
> -               case 0x0: /* Not Charging */
> -                       status = POWER_SUPPLY_STATUS_NOT_CHARGING;
> -                       break;
> -               case 0x1: /* Pre-charge */
> -               case 0x2: /* Fast Charging */
> -                       status = POWER_SUPPLY_STATUS_CHARGING;
> -                       break;
> -               case 0x3: /* Charge Termination Done */
> -                       status = POWER_SUPPLY_STATUS_FULL;
> -                       break;
> -               default:
> -                       ret = -EIO;
> -               }
> -       }
> -
> -       if (!ret)
> -               val->intval = status;
> -
> -       return ret;
> -}
> -
> -static int bq24190_battery_get_health(struct bq24190_dev_info *bdi,
> -               union power_supply_propval *val)
> -{
> -       u8 v;
> -       int health;
> -
> -       mutex_lock(&bdi->f_reg_lock);
> -       v = bdi->f_reg;
> -       mutex_unlock(&bdi->f_reg_lock);
> -
> -       if (v & BQ24190_REG_F_BAT_FAULT_MASK) {
> -               health = POWER_SUPPLY_HEALTH_OVERVOLTAGE;
> -       } else {
> -               v &= BQ24190_REG_F_NTC_FAULT_MASK;
> -               v >>= BQ24190_REG_F_NTC_FAULT_SHIFT;
> -
> -               switch (v) {
> -               case 0x0: /* Normal */
> -                       health = POWER_SUPPLY_HEALTH_GOOD;
> -                       break;
> -               case 0x1: /* TS1 Cold */
> -               case 0x3: /* TS2 Cold */
> -               case 0x5: /* Both Cold */
> -                       health = POWER_SUPPLY_HEALTH_COLD;
> -                       break;
> -               case 0x2: /* TS1 Hot */
> -               case 0x4: /* TS2 Hot */
> -               case 0x6: /* Both Hot */
> -                       health = POWER_SUPPLY_HEALTH_OVERHEAT;
> -                       break;
> -               default:
> -                       health = POWER_SUPPLY_HEALTH_UNKNOWN;
> -               }
> -       }
> -
> -       val->intval = health;
> -       return 0;
> -}
> -
> -static int bq24190_battery_get_online(struct bq24190_dev_info *bdi,
> -               union power_supply_propval *val)
> -{
> -       u8 batfet_disable;
> -       int ret;
> -
> -       ret = bq24190_read_mask(bdi, BQ24190_REG_MOC,
> -                       BQ24190_REG_MOC_BATFET_DISABLE_MASK,
> -                       BQ24190_REG_MOC_BATFET_DISABLE_SHIFT, &batfet_disable);
> -       if (ret < 0)
> -               return ret;
> -
> -       val->intval = !batfet_disable;
> -       return 0;
> -}
> -
> -static int bq24190_battery_set_online(struct bq24190_dev_info *bdi,
> -               const union power_supply_propval *val)
> -{
> -       return bq24190_write_mask(bdi, BQ24190_REG_MOC,
> -                       BQ24190_REG_MOC_BATFET_DISABLE_MASK,
> -                       BQ24190_REG_MOC_BATFET_DISABLE_SHIFT, !val->intval);
> -}
> -
> -static int bq24190_battery_get_temp_alert_max(struct bq24190_dev_info *bdi,
> -               union power_supply_propval *val)
> -{
> -       int temp, ret;
> -
> -       ret = bq24190_get_field_val(bdi, BQ24190_REG_ICTRC,
> -                       BQ24190_REG_ICTRC_TREG_MASK,
> -                       BQ24190_REG_ICTRC_TREG_SHIFT,
> -                       bq24190_ictrc_treg_values,
> -                       ARRAY_SIZE(bq24190_ictrc_treg_values), &temp);
> -       if (ret < 0)
> -               return ret;
> -
> -       val->intval = temp;
> -       return 0;
> -}
> -
> -static int bq24190_battery_set_temp_alert_max(struct bq24190_dev_info *bdi,
> -               const union power_supply_propval *val)
> -{
> -       return bq24190_set_field_val(bdi, BQ24190_REG_ICTRC,
> -                       BQ24190_REG_ICTRC_TREG_MASK,
> -                       BQ24190_REG_ICTRC_TREG_SHIFT,
> -                       bq24190_ictrc_treg_values,
> -                       ARRAY_SIZE(bq24190_ictrc_treg_values), val->intval);
> -}
> -
> -static int bq24190_battery_get_property(struct power_supply *psy,
> -               enum power_supply_property psp, union power_supply_propval *val)
> -{
> -       struct bq24190_dev_info *bdi = power_supply_get_drvdata(psy);
> -       int ret;
> -
> -       dev_dbg(bdi->dev, "prop: %d\n", psp);
> -
> -       ret = pm_runtime_get_sync(bdi->dev);
> -       if (ret < 0)
> -               return ret;
> -
> -       switch (psp) {
> -       case POWER_SUPPLY_PROP_STATUS:
> -               ret = bq24190_battery_get_status(bdi, val);
> -               break;
> -       case POWER_SUPPLY_PROP_HEALTH:
> -               ret = bq24190_battery_get_health(bdi, val);
> -               break;
> -       case POWER_SUPPLY_PROP_ONLINE:
> -               ret = bq24190_battery_get_online(bdi, val);
> -               break;
> -       case POWER_SUPPLY_PROP_TECHNOLOGY:
> -               /* Could be Li-on or Li-polymer but no way to tell which */
> -               val->intval = POWER_SUPPLY_TECHNOLOGY_UNKNOWN;
> -               ret = 0;
> -               break;
> -       case POWER_SUPPLY_PROP_TEMP_ALERT_MAX:
> -               ret = bq24190_battery_get_temp_alert_max(bdi, val);
> -               break;
> -       case POWER_SUPPLY_PROP_SCOPE:
> -               val->intval = POWER_SUPPLY_SCOPE_SYSTEM;
> -               ret = 0;
> -               break;
> -       default:
> -               ret = -ENODATA;
> -       }
> -
> -       pm_runtime_mark_last_busy(bdi->dev);
> -       pm_runtime_put_autosuspend(bdi->dev);
> -
> -       return ret;
> -}
> -
> -static int bq24190_battery_set_property(struct power_supply *psy,
> -               enum power_supply_property psp,
> -               const union power_supply_propval *val)
> -{
> -       struct bq24190_dev_info *bdi = power_supply_get_drvdata(psy);
> -       int ret;
> -
> -       dev_dbg(bdi->dev, "prop: %d\n", psp);
> -
> -       ret = pm_runtime_get_sync(bdi->dev);
> -       if (ret < 0)
> -               return ret;
> -
> -       switch (psp) {
> -       case POWER_SUPPLY_PROP_ONLINE:
> -               ret = bq24190_battery_set_online(bdi, val);
> -               break;
> -       case POWER_SUPPLY_PROP_TEMP_ALERT_MAX:
> -               ret = bq24190_battery_set_temp_alert_max(bdi, val);
> -               break;
> -       default:
> -               ret = -EINVAL;
> -       }
> -
> -       pm_runtime_mark_last_busy(bdi->dev);
> -       pm_runtime_put_autosuspend(bdi->dev);
> -
> -       return ret;
> -}
> -
> -static int bq24190_battery_property_is_writeable(struct power_supply *psy,
> -               enum power_supply_property psp)
> -{
> -       int ret;
> -
> -       switch (psp) {
> -       case POWER_SUPPLY_PROP_ONLINE:
> -       case POWER_SUPPLY_PROP_TEMP_ALERT_MAX:
> -               ret = 1;
> -               break;
> -       default:
> -               ret = 0;
> -       }
> -
> -       return ret;
> -}
> -
> -static enum power_supply_property bq24190_battery_properties[] = {
> -       POWER_SUPPLY_PROP_STATUS,
> -       POWER_SUPPLY_PROP_HEALTH,
> -       POWER_SUPPLY_PROP_ONLINE,
> -       POWER_SUPPLY_PROP_TECHNOLOGY,
> -       POWER_SUPPLY_PROP_TEMP_ALERT_MAX,
> -       POWER_SUPPLY_PROP_SCOPE,
> -};
> -
> -static const struct power_supply_desc bq24190_battery_desc = {
> -       .name                   = "bq24190-battery",
> -       .type                   = POWER_SUPPLY_TYPE_BATTERY,

...use _TYPE_UNKNOWN above in your fuel gauge branch so that this
sysfs device doesn't conflict with the gauge's _TYPE_BATTERY sysfs
device.


> -       .properties             = bq24190_battery_properties,
> -       .num_properties         = ARRAY_SIZE(bq24190_battery_properties),
> -       .get_property           = bq24190_battery_get_property,
> -       .set_property           = bq24190_battery_set_property,
> -       .property_is_writeable  = bq24190_battery_property_is_writeable,
> -};
> -
>  static void bq24190_check_status(struct bq24190_dev_info *bdi)
>  {
> -       const u8 battery_mask_ss = BQ24190_REG_SS_CHRG_STAT_MASK;
> -       const u8 battery_mask_f = BQ24190_REG_F_BAT_FAULT_MASK
> -                               | BQ24190_REG_F_NTC_FAULT_MASK;
> -       bool alert_charger = false, alert_battery = false;
> +       bool alert_charger = false;
>         u8 ss_reg = 0, f_reg = 0;
>         int i, ret;
>
> @@ -1202,12 +944,9 @@ static void bq24190_check_status(struct bq24190_dev_info *bdi)
>                                 !!(f_reg & BQ24190_REG_F_NTC_FAULT_MASK));
>
>                 mutex_lock(&bdi->f_reg_lock);
> -               if ((bdi->f_reg & battery_mask_f) != (f_reg & battery_mask_f))
> -                       alert_battery = true;
> -               if ((bdi->f_reg & ~battery_mask_f) != (f_reg & ~battery_mask_f))
> -                       alert_charger = true;
>                 bdi->f_reg = f_reg;
>                 mutex_unlock(&bdi->f_reg_lock);
> +               alert_charger = true;
>         }
>
>         if (ss_reg != bdi->ss_reg) {
> @@ -1226,17 +965,12 @@ static void bq24190_check_status(struct bq24190_dev_info *bdi)
>                                         ret);
>                 }
>
> -               if ((bdi->ss_reg & battery_mask_ss) != (ss_reg & battery_mask_ss))
> -                       alert_battery = true;
> -               if ((bdi->ss_reg & ~battery_mask_ss) != (ss_reg & ~battery_mask_ss))
> -                       alert_charger = true;
>                 bdi->ss_reg = ss_reg;
> +               alert_charger = true;
>         }
>
>         if (alert_charger)
>                 power_supply_changed(bdi->charger);
> -       if (alert_battery)
> -               power_supply_changed(bdi->battery);
>
>         dev_dbg(bdi->dev, "ss_reg: 0x%02x, f_reg: 0x%02x\n", ss_reg, f_reg);
>  }
> @@ -1363,7 +1097,7 @@ static int bq24190_probe(struct i2c_client *client,
>  {
>         struct i2c_adapter *adapter = to_i2c_adapter(client->dev.parent);
>         struct device *dev = &client->dev;
> -       struct power_supply_config charger_cfg = {}, battery_cfg = {};
> +       struct power_supply_config charger_cfg = {};
>         struct bq24190_dev_info *bdi;
>         const char *name;
>         int ret;
> @@ -1427,19 +1161,10 @@ static int bq24190_probe(struct i2c_client *client,
>                 goto pm_runtime_disable;
>         }
>
> -       battery_cfg.drv_data = bdi;
> -       bdi->battery = power_supply_register(dev, &bq24190_battery_desc,
> -                                               &battery_cfg);
> -       if (IS_ERR(bdi->battery)) {
> -               dev_err(dev, "Can't register battery\n");
> -               ret = PTR_ERR(bdi->battery);
> -               goto unregister_charger;
> -       }
> -
>         ret = bq24190_sysfs_create_group(bdi);
>         if (ret) {
>                 dev_err(dev, "Can't create sysfs entries\n");
> -               goto unregister_battery;
> +               goto unregister_charger;
>         }
>
>         bdi->initialized = true;
> @@ -1475,9 +1200,6 @@ static int bq24190_probe(struct i2c_client *client,
>  remove_sysfs_group:
>         bq24190_sysfs_remove_group(bdi);
>
> -unregister_battery:
> -       power_supply_unregister(bdi->battery);
> -
>  unregister_charger:
>         power_supply_unregister(bdi->charger);
>
> @@ -1500,7 +1222,6 @@ static int bq24190_remove(struct i2c_client *client)
>         }
>
>         bq24190_sysfs_remove_group(bdi);
> -       power_supply_unregister(bdi->battery);
>         power_supply_unregister(bdi->charger);
>         if (error >= 0)
>                 pm_runtime_put_sync(bdi->dev);
> @@ -1568,7 +1289,6 @@ static __maybe_unused int bq24190_pm_resume(struct device *dev)
>
>         /* Things may have changed while suspended so alert upper layer */
>         power_supply_changed(bdi->charger);
> -       power_supply_changed(bdi->battery);
>
>         return 0;
>  }
> --
> 2.9.3
>
