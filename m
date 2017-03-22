From: Liam Breck <liam@networkimprov.net>
Subject: Re: [PATCH v2 6/7] power: supply: bq24190_charger: Cleanup error-exit
 labels in probe()
Date: Wed, 22 Mar 2017 12:09:34 -0700
Message-ID: <CAKvHMgTVt0T8GGc3kuXF78ck-9o+AJEKtK=5WB_y1yuyO5TDnA@mail.gmail.com>
References: <20170322145536.30570-1-hdegoede@redhat.com> <20170322145536.30570-7-hdegoede@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-io0-f193.google.com ([209.85.223.193]:36574 "EHLO
        mail-io0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S936008AbdCVTJh (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 22 Mar 2017 15:09:37 -0400
Received: by mail-io0-f193.google.com with SMTP id 68so11145471ioh.3
        for <linux-pm@vger.kernel.org>; Wed, 22 Mar 2017 12:09:36 -0700 (PDT)
In-Reply-To: <20170322145536.30570-7-hdegoede@redhat.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Hans de Goede <hdegoede@redhat.com>
Cc: Sebastian Reichel <sre@kernel.org>, Takashi Iwai <tiwai@suse.de>, linux-pm@vger.kernel.org, Liam Breck <kernel@networkimprov.net>, Tony Lindgren <tony@atomide.com>

On Wed, Mar 22, 2017 at 7:55 AM, Hans de Goede <hdegoede@redhat.com> wrote:
> Names like out1, out2, etc. do not make it easier to follow what is
> going on and make it harder (require renaming) if any steps are
> later added / removed. Rename the labels to sane names.

Good idea. But the new labels look like function names, so maybe:
 out_charger, out_battery, out_sysfs, out_pmrt

> This also folds out1 and out2 into one pm_runtime_disable step,
> if pm_runtime_get_sync fails we still need to do the put, it
> failing means that the device failed to resume, but the refcount
> will have been incremented and we need to decrement it.
>
> Cc: Liam Breck <kernel@networkimprov.net>
> Cc: Tony Lindgren <tony@atomide.com>
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> ---
> Changes in v2:
> -This is a new patch in v2 of this patch-set
> ---
>  drivers/power/supply/bq24190_charger.c | 24 +++++++++++-------------
>  1 file changed, 11 insertions(+), 13 deletions(-)
>
> diff --git a/drivers/power/supply/bq24190_charger.c b/drivers/power/supply/bq24190_charger.c
> index 351e020..5e3da66 100644
> --- a/drivers/power/supply/bq24190_charger.c
> +++ b/drivers/power/supply/bq24190_charger.c
> @@ -1408,12 +1408,12 @@ static int bq24190_probe(struct i2c_client *client,
>         pm_runtime_set_autosuspend_delay(dev, 600);
>         ret = pm_runtime_get_sync(dev);
>         if (ret < 0)
> -               goto out1;
> +               goto pm_runtime_disable;
>
>         ret = bq24190_hw_init(bdi);
>         if (ret < 0) {
>                 dev_err(dev, "Hardware init failed\n");
> -               goto out2;
> +               goto pm_runtime_disable;
>         }
>
>         charger_cfg.drv_data = bdi;
> @@ -1424,7 +1424,7 @@ static int bq24190_probe(struct i2c_client *client,
>         if (IS_ERR(bdi->charger)) {
>                 dev_err(dev, "Can't register charger\n");
>                 ret = PTR_ERR(bdi->charger);
> -               goto out2;
> +               goto pm_runtime_disable;
>         }
>
>         battery_cfg.drv_data = bdi;
> @@ -1433,13 +1433,13 @@ static int bq24190_probe(struct i2c_client *client,
>         if (IS_ERR(bdi->battery)) {
>                 dev_err(dev, "Can't register battery\n");
>                 ret = PTR_ERR(bdi->battery);
> -               goto out3;
> +               goto unregister_charger;
>         }
>
>         ret = bq24190_sysfs_create_group(bdi);
>         if (ret) {
>                 dev_err(dev, "Can't create sysfs entries\n");
> -               goto out4;
> +               goto unregister_battery;
>         }
>
>         bdi->initialized = true;
> @@ -1450,7 +1450,7 @@ static int bq24190_probe(struct i2c_client *client,
>                         "bq24190-charger", bdi);
>         if (ret < 0) {
>                 dev_err(dev, "Can't set up irq handler\n");
> -               goto out5;
> +               goto remove_sysfs_group;
>         }
>
>         if (bdi->extcon) {
> @@ -1459,7 +1459,7 @@ static int bq24190_probe(struct i2c_client *client,
>                 ret = devm_extcon_register_notifier(dev, bdi->extcon, -1,
>                                                     &bdi->extcon_nb);
>                 if (ret)
> -                       goto out5;
> +                       goto remove_sysfs_group;
>
>                 /* Sync initial cable state */
>                 queue_delayed_work(system_wq, &bdi->extcon_work, 0);
> @@ -1472,19 +1472,17 @@ static int bq24190_probe(struct i2c_client *client,
>
>         return 0;
>
> -out5:
> +remove_sysfs_group:
>         bq24190_sysfs_remove_group(bdi);
>
> -out4:
> +unregister_battery:
>         power_supply_unregister(bdi->battery);
>
> -out3:
> +unregister_charger:
>         power_supply_unregister(bdi->charger);
>
> -out2:
> +pm_runtime_disable:
>         pm_runtime_put_sync(dev);
> -
> -out1:
>         pm_runtime_dont_use_autosuspend(dev);
>         pm_runtime_disable(dev);
>         return ret;
> --
> 2.9.3
>
