From: Daniel Kurtz <djkurtz@chromium.org>
Subject: Re: [PATCH] sbs-battery: fix power status when battery is dry
Date: Thu, 24 Mar 2016 12:01:36 +0800
Message-ID: <CAGS+omDTmJDkJYsf=gDJMrmAos+30enoAa2xfTPyirXUd37=9g@mail.gmail.com>
References: <1458726794-48298-1-git-send-email-yh.huang@mediatek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-vk0-f49.google.com ([209.85.213.49]:36743 "EHLO
	mail-vk0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750756AbcCXEB5 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 24 Mar 2016 00:01:57 -0400
Received: by mail-vk0-f49.google.com with SMTP id z68so44351344vkg.3
        for <linux-pm@vger.kernel.org>; Wed, 23 Mar 2016 21:01:56 -0700 (PDT)
In-Reply-To: <1458726794-48298-1-git-send-email-yh.huang@mediatek.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: YH Huang <yh.huang@mediatek.com>
Cc: Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, Matthias Brugger <matthias.bgg@gmail.com>, linux-pm@vger.kernel.org, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "moderated list:ARM/Mediatek SoC support" <linux-mediatek@lists.infradead.org>

Hi YH,

On Wed, Mar 23, 2016 at 5:53 PM, YH Huang <yh.huang@mediatek.com> wrote:
> When the battery is dry and BATTERY_FULL_DISCHARGED is set,
> we should check BATTERY_DISCHARGING to decide the power status.
> If BATTERY_DISCHARGING is set, the power status is not charging.
> Or the power status should be charging.
>
> Signed-off-by: YH Huang <yh.huang@mediatek.com>
> ---
>  drivers/power/sbs-battery.c |   22 ++++++++++++----------
>  1 file changed, 12 insertions(+), 10 deletions(-)
>
> diff --git a/drivers/power/sbs-battery.c b/drivers/power/sbs-battery.c
> index d6226d6..d86db0e 100644
> --- a/drivers/power/sbs-battery.c
> +++ b/drivers/power/sbs-battery.c
> @@ -382,11 +382,12 @@ static int sbs_get_battery_property(struct i2c_client *client,
>
>                 if (ret & BATTERY_FULL_CHARGED)
>                         val->intval = POWER_SUPPLY_STATUS_FULL;
> -               else if (ret & BATTERY_FULL_DISCHARGED)
> -                       val->intval = POWER_SUPPLY_STATUS_NOT_CHARGING;
> -               else if (ret & BATTERY_DISCHARGING)
> -                       val->intval = POWER_SUPPLY_STATUS_DISCHARGING;
> -               else
> +               else if (ret & BATTERY_DISCHARGING) {
> +                       if (ret & BATTERY_FULL_DISCHARGED)
> +                               val->intval = POWER_SUPPLY_STATUS_NOT_CHARGING;
> +                       else
> +                               val->intval = POWER_SUPPLY_STATUS_DISCHARGING;
> +               } else


I think (BATTERY_DISCHARGING && BATTERY_FULL_DISCHARGED) is still
POWER_SUPPLY_STATUS_DISCHARGING.
So, let's just report what the battery says and do:

               else if (ret & BATTERY_DISCHARGING)
                               val->intval = POWER_SUPPLY_STATUS_DISCHARGING;


>                         val->intval = POWER_SUPPLY_STATUS_CHARGING;
>
>                 if (chip->poll_time == 0)
> @@ -702,11 +703,12 @@ static void sbs_delayed_work(struct work_struct *work)
>
>         if (ret & BATTERY_FULL_CHARGED)
>                 ret = POWER_SUPPLY_STATUS_FULL;
> -       else if (ret & BATTERY_FULL_DISCHARGED)
> -               ret = POWER_SUPPLY_STATUS_NOT_CHARGING;
> -       else if (ret & BATTERY_DISCHARGING)
> -               ret = POWER_SUPPLY_STATUS_DISCHARGING;
> -       else
> +       else if (ret & BATTERY_DISCHARGING) {
> +               if (ret & BATTERY_FULL_DISCHARGED)
> +                       ret = POWER_SUPPLY_STATUS_NOT_CHARGING;
> +               else
> +                       ret = POWER_SUPPLY_STATUS_DISCHARGING;
> +       } else
>                 ret = POWER_SUPPLY_STATUS_CHARGING;
>
>         if (chip->last_state != ret) {
> --
> 1.7.9.5
>
