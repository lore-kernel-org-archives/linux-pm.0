From: Matt Ranostay <mranostay@gmail.com>
Subject: Re: [PATCH v2 2/2] power: bq27xxx_battery: add poll interval property query
Date: Mon, 24 Oct 2016 12:58:25 -0700
Message-ID: <CAKzfze9uvMvrF=gWph_HKFk_cH0qzRz6Wa2VJafK+H+wdnP0rg@mail.gmail.com>
References: <1475092512-30555-1-git-send-email-matt@ranostay.consulting> <1475092512-30555-3-git-send-email-matt@ranostay.consulting>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1475092512-30555-3-git-send-email-matt@ranostay.consulting>
Sender: linux-kernel-owner@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>, Pavel Machek <pavel@ucw.cz>
Cc: linux-pm@vger.kernel.org, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Matt Ranostay <matt@ranostay.consulting>, Tony Lindgren <tony@atomide.com>
List-Id: linux-pm@vger.kernel.org

Pavel + Sebastian this is the patchset that need I some input on :)

Thanks,

Matt

On Wed, Sep 28, 2016 at 12:55 PM, Matt Ranostay <mranostay@gmail.com> wrote:
> Add POWER_SUPPLY_PROP_POLL_INTERVAL property to query and set the
> polling interval of the fuel gauge.
>
> Cc: Sebastian Reichel <sre@kernel.org>
> Cc: Tony Lindgren <tony@atomide.com
> Signed-off-by: Matt Ranostay <matt@ranostay.consulting>
> ---
>  drivers/power/supply/bq27xxx_battery.c | 40 ++++++++++++++++++++++++++++++++++
>  1 file changed, 40 insertions(+)
>
> diff --git a/drivers/power/supply/bq27xxx_battery.c b/drivers/power/supply/bq27xxx_battery.c
> index 3b0dbc689d72..d18802ca3327 100644
> --- a/drivers/power/supply/bq27xxx_battery.c
> +++ b/drivers/power/supply/bq27xxx_battery.c
> @@ -262,6 +262,7 @@ static enum power_supply_property bq27000_battery_props[] = {
>         POWER_SUPPLY_PROP_POWER_AVG,
>         POWER_SUPPLY_PROP_HEALTH,
>         POWER_SUPPLY_PROP_MANUFACTURER,
> +       POWER_SUPPLY_PROP_POLL_INTERVAL,
>  };
>
>  static enum power_supply_property bq27010_battery_props[] = {
> @@ -282,6 +283,7 @@ static enum power_supply_property bq27010_battery_props[] = {
>         POWER_SUPPLY_PROP_CYCLE_COUNT,
>         POWER_SUPPLY_PROP_HEALTH,
>         POWER_SUPPLY_PROP_MANUFACTURER,
> +       POWER_SUPPLY_PROP_POLL_INTERVAL,
>  };
>
>  static enum power_supply_property bq27500_battery_props[] = {
> @@ -300,6 +302,7 @@ static enum power_supply_property bq27500_battery_props[] = {
>         POWER_SUPPLY_PROP_CYCLE_COUNT,
>         POWER_SUPPLY_PROP_HEALTH,
>         POWER_SUPPLY_PROP_MANUFACTURER,
> +       POWER_SUPPLY_PROP_POLL_INTERVAL,
>  };
>
>  static enum power_supply_property bq27530_battery_props[] = {
> @@ -318,6 +321,7 @@ static enum power_supply_property bq27530_battery_props[] = {
>         POWER_SUPPLY_PROP_HEALTH,
>         POWER_SUPPLY_PROP_CYCLE_COUNT,
>         POWER_SUPPLY_PROP_MANUFACTURER,
> +       POWER_SUPPLY_PROP_POLL_INTERVAL,
>  };
>
>  static enum power_supply_property bq27541_battery_props[] = {
> @@ -337,6 +341,7 @@ static enum power_supply_property bq27541_battery_props[] = {
>         POWER_SUPPLY_PROP_POWER_AVG,
>         POWER_SUPPLY_PROP_HEALTH,
>         POWER_SUPPLY_PROP_MANUFACTURER,
> +       POWER_SUPPLY_PROP_POLL_INTERVAL,
>  };
>
>  static enum power_supply_property bq27545_battery_props[] = {
> @@ -355,6 +360,7 @@ static enum power_supply_property bq27545_battery_props[] = {
>         POWER_SUPPLY_PROP_CYCLE_COUNT,
>         POWER_SUPPLY_PROP_POWER_AVG,
>         POWER_SUPPLY_PROP_MANUFACTURER,
> +       POWER_SUPPLY_PROP_POLL_INTERVAL,
>  };
>
>  static enum power_supply_property bq27421_battery_props[] = {
> @@ -370,6 +376,7 @@ static enum power_supply_property bq27421_battery_props[] = {
>         POWER_SUPPLY_PROP_CHARGE_NOW,
>         POWER_SUPPLY_PROP_CHARGE_FULL_DESIGN,
>         POWER_SUPPLY_PROP_MANUFACTURER,
> +       POWER_SUPPLY_PROP_POLL_INTERVAL,
>  };
>
>  #define BQ27XXX_PROP(_id, _prop)               \
> @@ -955,6 +962,9 @@ static int bq27xxx_battery_get_property(struct power_supply *psy,
>         case POWER_SUPPLY_PROP_MANUFACTURER:
>                 val->strval = BQ27XXX_MANUFACTURER;
>                 break;
> +       case POWER_SUPPLY_PROP_POLL_INTERVAL:
> +               val->intval = poll_interval;
> +               break;
>         default:
>                 return -EINVAL;
>         }
> @@ -962,6 +972,34 @@ static int bq27xxx_battery_get_property(struct power_supply *psy,
>         return ret;
>  }
>
> +static int bq27xxx_battery_set_property(struct power_supply *psy,
> +                                       enum power_supply_property psp,
> +                                       const union power_supply_propval *val)
> +{
> +       struct bq27xxx_device_info *di = power_supply_get_drvdata(psy);
> +
> +       if (psp != POWER_SUPPLY_PROP_POLL_INTERVAL)
> +               return -EINVAL;
> +
> +       if (poll_interval == val->intval)
> +               return 0;
> +
> +       poll_interval = val->intval;
> +       cancel_delayed_work_sync(&di->work);
> +       schedule_delayed_work(&di->work, 0);
> +
> +       return 0;
> +}
> +
> +static int bq27xxx_property_is_writeable(struct power_supply *psy,
> +                                        enum power_supply_property psp)
> +{
> +       if (psp == POWER_SUPPLY_PROP_POLL_INTERVAL)
> +               return 1;
> +
> +       return 0;
> +}
> +
>  static void bq27xxx_external_power_changed(struct power_supply *psy)
>  {
>         struct bq27xxx_device_info *di = power_supply_get_drvdata(psy);
> @@ -988,6 +1026,8 @@ int bq27xxx_battery_setup(struct bq27xxx_device_info *di)
>         psy_desc->properties = bq27xxx_battery_props[di->chip].props;
>         psy_desc->num_properties = bq27xxx_battery_props[di->chip].size;
>         psy_desc->get_property = bq27xxx_battery_get_property;
> +       psy_desc->set_property = bq27xxx_battery_set_property;
> +       psy_desc->property_is_writeable = bq27xxx_property_is_writeable;
>         psy_desc->external_power_changed = bq27xxx_external_power_changed;
>
>         di->bat = power_supply_register_no_ws(di->dev, psy_desc, &psy_cfg);
> --
> 2.7.4
>
