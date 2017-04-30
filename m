From: Liam Breck <liam@networkimprov.net>
Subject: Re: [PATCH 5/5] power: supply: bq27xxx: Correct supply status with
 current draw
Date: Sun, 30 Apr 2017 15:35:13 -0700
Message-ID: <CAKvHMgQ+uS=xw+TD_raPECG1psVWF_=M-35cpbDtNUChQYWhnw@mail.gmail.com>
References: <20170430203801.32357-1-contact@paulk.fr> <20170430203801.32357-5-contact@paulk.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-it0-f66.google.com ([209.85.214.66]:33079 "EHLO
        mail-it0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1948039AbdD3WfO (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 30 Apr 2017 18:35:14 -0400
Received: by mail-it0-f66.google.com with SMTP id z67so10969228itb.0
        for <linux-pm@vger.kernel.org>; Sun, 30 Apr 2017 15:35:14 -0700 (PDT)
In-Reply-To: <20170430203801.32357-5-contact@paulk.fr>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Paul Kocialkowski <contact@paulk.fr>
Cc: linux-pm@vger.kernel.org, "Andrew F. Davis" <afd@ti.com>, Sebastian Reichel <sre@kernel.org>

Hi Paul,

On Sun, Apr 30, 2017 at 1:38 PM, Paul Kocialkowski <contact@paulk.fr> wrote:
> The status reported directly by the battery controller is not always
> reliable and should be corrected based on the current draw information.

I have noticed incorrect status on bq27425. On which chip/s did you
find this? It might not be a flaw across the whole family...

> This implements such a correction with a dedicated function, called
> when retrieving the supply status.
>
> Signed-off-by: Paul Kocialkowski <contact@paulk.fr>
> ---
>  drivers/power/supply/bq27xxx_battery.c | 28 ++++++++++++++++++++++++++++
>  1 file changed, 28 insertions(+)
>
> diff --git a/drivers/power/supply/bq27xxx_battery.c b/drivers/power/supply/bq27xxx_battery.c
> index cade00df6162..f7694e775e68 100644
> --- a/drivers/power/supply/bq27xxx_battery.c
> +++ b/drivers/power/supply/bq27xxx_battery.c
> @@ -1171,8 +1171,22 @@ static int bq27xxx_battery_status(struct bq27xxx_device_info *di,
>                                   union power_supply_propval *val)
>  {
>         int status;
> +       int curr;
> +       int flags;
> +
> +       curr = bq27xxx_read(di, BQ27XXX_REG_AI, false);
> +       if (curr < 0) {
> +               dev_err(di->dev, "error reading current\n");
> +               return curr;
> +       }

Maybe read current (then sign-flip, *= 1000) above the status fix?

>         if (di->chip == BQ27000 || di->chip == BQ27010) {
> +               flags = bq27xxx_read(di, BQ27XXX_REG_FLAGS, true);
> +               if (flags & BQ27000_FLAG_CHGS) {
> +                       dev_dbg(di->dev, "negative current!\n");
> +                       curr = -curr;
> +               }
> +
>                 if (di->cache.flags & BQ27000_FLAG_FC)
>                         status = POWER_SUPPLY_STATUS_FULL;
>                 else if (di->cache.flags & BQ27000_FLAG_CHGS)
> @@ -1182,6 +1196,8 @@ static int bq27xxx_battery_status(struct bq27xxx_device_info *di,
>                 else
>                         status = POWER_SUPPLY_STATUS_DISCHARGING;
>         } else {
> +               curr = (int)((s16)curr) * 1000;
> +
>                 if (di->cache.flags & BQ27XXX_FLAG_FC)
>                         status = POWER_SUPPLY_STATUS_FULL;
>                 else if (di->cache.flags & BQ27XXX_FLAG_DSC)
> @@ -1190,6 +1206,18 @@ static int bq27xxx_battery_status(struct bq27xxx_device_info *di,
>                         status = POWER_SUPPLY_STATUS_CHARGING;
>         }
>
> +
> +       if (curr == 0 && status != POWER_SUPPLY_STATUS_NOT_CHARGING)
> +               status = POWER_SUPPLY_STATUS_FULL;
> +
> +       if (status == POWER_SUPPLY_STATUS_FULL) {
> +               /* Drawing or providing current when full */
> +               if (curr > 0)
> +                       status = POWER_SUPPLY_STATUS_CHARGING;
> +               else if (curr < 0)
> +                       status = POWER_SUPPLY_STATUS_DISCHARGING;
> +       }
> +
>         if (di->status_retry == 0 && di->status_change_reference != status) {
>                 di->status_change_reference = status;
>                 power_supply_changed(di->bat);
> --
> 2.12.2
>
