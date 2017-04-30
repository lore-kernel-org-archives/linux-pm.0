From: Liam Breck <liam@networkimprov.net>
Subject: Re: [PATCH 1/5] power: supply: bq27xxx: Pass of_node along to allow
 device-tree supply
Date: Sun, 30 Apr 2017 15:03:35 -0700
Message-ID: <CAKvHMgSijN8vQUePoTKRC5nqaW-Shh4_9ZKiKq0Uae3ZLkiDSA@mail.gmail.com>
References: <20170430203801.32357-1-contact@paulk.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-it0-f66.google.com ([209.85.214.66]:36058 "EHLO
        mail-it0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1164133AbdD3WDg (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 30 Apr 2017 18:03:36 -0400
Received: by mail-it0-f66.google.com with SMTP id x188so10897085itb.3
        for <linux-pm@vger.kernel.org>; Sun, 30 Apr 2017 15:03:36 -0700 (PDT)
In-Reply-To: <20170430203801.32357-1-contact@paulk.fr>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Paul Kocialkowski <contact@paulk.fr>
Cc: "Andrew F. Davis" <afd@ti.com>, linux-pm@vger.kernel.org, Sebastian Reichel <sre@kernel.org>

[dropped some CCs]


On Sun, Apr 30, 2017 at 1:37 PM, Paul Kocialkowski <contact@paulk.fr> wrote:
> This passes the of_node from the bq27xxx i2c battery driver to the
> common code, so that it can be registered and provide external supplies
> linked with device-tree.
>
> Signed-off-by: Paul Kocialkowski <contact@paulk.fr>
> ---
>  drivers/power/supply/bq27xxx_battery.c     | 5 ++++-
>  drivers/power/supply/bq27xxx_battery_i2c.c | 1 +
>  include/linux/power/bq27xxx_battery.h      | 1 +
>  3 files changed, 6 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/power/supply/bq27xxx_battery.c b/drivers/power/supply/bq27xxx_battery.c
> index 398801a21b86..6ef95442a918 100644
> --- a/drivers/power/supply/bq27xxx_battery.c
> +++ b/drivers/power/supply/bq27xxx_battery.c
> @@ -1351,7 +1351,10 @@ static void bq27xxx_external_power_changed(struct power_supply *psy)
>  int bq27xxx_battery_setup(struct bq27xxx_device_info *di)
>  {
>         struct power_supply_desc *psy_desc;
> -       struct power_supply_config psy_cfg = { .drv_data = di, };
> +       struct power_supply_config psy_cfg = {};
> +
> +       psy_cfg.drv_data = di;
> +       psy_cfg.of_node = di->of_node;

I don't think you need di->of_node, just the following -- we do this
to obtain data from devicetree via power_supply_get_battery_info()
https://patchwork.kernel.org/patch/9692335/

struct power_supply_config psy_cfg = {
  .drv_data = di,
  .of_node = di->dev->of_node,
};

There is some (gcc?) bug on armv7 or omap which causes separate
assignments to corrupt the stack.

>         INIT_DELAYED_WORK(&di->work, bq27xxx_battery_poll);
>         mutex_init(&di->lock);
> diff --git a/drivers/power/supply/bq27xxx_battery_i2c.c b/drivers/power/supply/bq27xxx_battery_i2c.c
> index c68fbc3fe50a..38a0422a4192 100644
> --- a/drivers/power/supply/bq27xxx_battery_i2c.c
> +++ b/drivers/power/supply/bq27xxx_battery_i2c.c
> @@ -96,6 +96,7 @@ static int bq27xxx_battery_i2c_probe(struct i2c_client *client,
>         di->chip = id->driver_data;
>         di->name = name;
>         di->bus.read = bq27xxx_battery_i2c_read;
> +       di->of_node = client->dev.of_node;
>
>         ret = bq27xxx_battery_setup(di);
>         if (ret)
> diff --git a/include/linux/power/bq27xxx_battery.h b/include/linux/power/bq27xxx_battery.h
> index b312bcef53da..94637b77ecbf 100644
> --- a/include/linux/power/bq27xxx_battery.h
> +++ b/include/linux/power/bq27xxx_battery.h
> @@ -63,6 +63,7 @@ struct bq27xxx_device_info {
>         const char *name;
>         struct bq27xxx_access_methods bus;
>         struct bq27xxx_reg_cache cache;
> +       struct device_node *of_node;
>         int charge_design_full;
>         unsigned long last_update;
>         struct delayed_work work;
> --
> 2.12.2
>
