From: Daniel Kurtz <djkurtz@chromium.org>
Subject: Re: [PATCH] sbs-battery: fix power status when battery charging near dry
Date: Sat, 9 Apr 2016 20:38:30 +1000
Message-ID: <CAGS+omA7YgCvEJNTU2VB2xOu52nkowTuhBpykk=wOnjDAYFQWA@mail.gmail.com>
References: <1459909945-36541-1-git-send-email-yh.huang@mediatek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-vk0-f46.google.com ([209.85.213.46]:35929 "EHLO
	mail-vk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751723AbcDIKiv (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Sat, 9 Apr 2016 06:38:51 -0400
Received: by mail-vk0-f46.google.com with SMTP id c4so164657575vkb.3
        for <linux-pm@vger.kernel.org>; Sat, 09 Apr 2016 03:38:50 -0700 (PDT)
In-Reply-To: <1459909945-36541-1-git-send-email-yh.huang@mediatek.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: YH Huang <yh.huang@mediatek.com>
Cc: Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, Matthias Brugger <matthias.bgg@gmail.com>, linux-pm@vger.kernel.org, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "moderated list:ARM/Mediatek SoC support" <linux-mediatek@lists.infradead.org>

On Wed, Apr 6, 2016 at 12:32 PM, YH Huang <yh.huang@mediatek.com> wrote:
> POWER_SUPPLY_STATUS_NOT_CHARGING is used for AC connected, but
> battery not charging (e.g. because battery temperature is out
> of acceptable range).
>
> When battery is charging near dry and BATTERY_FULL_DISCHARGED is set,
> it is wrong to set as POWER_SUPPLY_STATUS_NOT_CHARGING.
> Just use BATTERY_DISCHARGING to decide the power supply status is
> discharging or charging.
>
> Signed-off-by: YH Huang <yh.huang@mediatek.com>

Reviewed-by: Daniel Kurtz <djkurtz@chromium.org>

> ---
>  drivers/power/sbs-battery.c |    4 ----
>  1 file changed, 4 deletions(-)
>
> diff --git a/drivers/power/sbs-battery.c b/drivers/power/sbs-battery.c
> index d6226d6..768b9fc 100644
> --- a/drivers/power/sbs-battery.c
> +++ b/drivers/power/sbs-battery.c
> @@ -382,8 +382,6 @@ static int sbs_get_battery_property(struct i2c_client *client,
>
>                 if (ret & BATTERY_FULL_CHARGED)
>                         val->intval = POWER_SUPPLY_STATUS_FULL;
> -               else if (ret & BATTERY_FULL_DISCHARGED)
> -                       val->intval = POWER_SUPPLY_STATUS_NOT_CHARGING;
>                 else if (ret & BATTERY_DISCHARGING)
>                         val->intval = POWER_SUPPLY_STATUS_DISCHARGING;
>                 else
> @@ -702,8 +700,6 @@ static void sbs_delayed_work(struct work_struct *work)
>
>         if (ret & BATTERY_FULL_CHARGED)
>                 ret = POWER_SUPPLY_STATUS_FULL;
> -       else if (ret & BATTERY_FULL_DISCHARGED)
> -               ret = POWER_SUPPLY_STATUS_NOT_CHARGING;
>         else if (ret & BATTERY_DISCHARGING)
>                 ret = POWER_SUPPLY_STATUS_DISCHARGING;
>         else
> --
> 1.7.9.5
>
