From: Vincent Guittot <vincent.guittot@linaro.org>
Subject: Re: [PATCH] thermal: Use power efficient workqueue
Date: Wed, 3 Jan 2018 10:43:40 +0100
Message-ID: <CAKfTPtCyMaz4aSTFw4hY+E1Gnb0juxcPdQWR2NVVJW4735d5iQ@mail.gmail.com>
References: <1514971456-2877-1-git-send-email-leo.yan@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-it0-f66.google.com ([209.85.214.66]:38428 "EHLO
        mail-it0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751151AbeACJoC (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 3 Jan 2018 04:44:02 -0500
Received: by mail-it0-f66.google.com with SMTP id r6so1183003itr.3
        for <linux-pm@vger.kernel.org>; Wed, 03 Jan 2018 01:44:01 -0800 (PST)
In-Reply-To: <1514971456-2877-1-git-send-email-leo.yan@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Leo Yan <leo.yan@linaro.org>
Cc: Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>, linux-pm@vger.kernel.org, linux-kernel <linux-kernel@vger.kernel.org>, Daniel Lezcano <daniel.lezcano@linaro.org>

On 3 January 2018 at 10:24, Leo Yan <leo.yan@linaro.org> wrote:
> Thermal core framework uses the system_freezable_wq workqueue as its
> workqueue for polling temperature. Using system_freezable_wq workqueue
> prevents the scheduler to make smart decision about the best place to
> schedule the work.
>
> This commit replaces system_freezable_wq with
> system_freezable_power_efficient_wq. With kernel configuration
> CONFIG_WQ_POWER_EFFICIENT is enabled, the work can be scheduled on the
> best CPU from a power or a performance point of view.
>
> This commit is inspired by Vincent Guittot patch "netfilter: conntrack:
> use power efficient workqueue" and verified on 96boards Hikey960.
>
> Cc: Eduardo Valentin <edubezval@gmail.com>
> Cc: Zhang Rui <rui.zhang@intel.com>
> Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
> Cc: Vincent Guittot <vincent.guittot@linaro.org>
> Signed-off-by: Leo Yan <leo.yan@linaro.org>

Acked-by: Vincent Guittot <vincent.guittot@linaro.org>

> ---
>  drivers/thermal/thermal_core.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
> index 2b1b0ba..ba90f71 100644
> --- a/drivers/thermal/thermal_core.c
> +++ b/drivers/thermal/thermal_core.c
> @@ -293,11 +293,12 @@ static void thermal_zone_device_set_polling(struct thermal_zone_device *tz,
>                                             int delay)
>  {
>         if (delay > 1000)
> -               mod_delayed_work(system_freezable_wq, &tz->poll_queue,
> +               mod_delayed_work(system_freezable_power_efficient_wq,
> +                                &tz->poll_queue,
>                                  round_jiffies(msecs_to_jiffies(delay)));
>         else if (delay)
> -               mod_delayed_work(system_freezable_wq, &tz->poll_queue,
> -                                msecs_to_jiffies(delay));
> +               mod_delayed_work(system_freezable_power_efficient_wq,
> +                                &tz->poll_queue, msecs_to_jiffies(delay));
>         else
>                 cancel_delayed_work(&tz->poll_queue);
>  }
> --
> 2.7.4
>
