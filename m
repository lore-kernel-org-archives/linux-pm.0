From: Chander Kashyap <chander.kashyap@linaro.org>
Subject: Re: [RESEND][PATCH] cpuidle: governor: menu: move repeated correction
 factor check to init
Date: Fri, 16 May 2014 13:46:17 +0530
Message-ID: <CANuQgHGLgrbYME7Y8zJQ6ACt7ByviZJMMEk+RbhqwXvnsm+8_g@mail.gmail.com>
References: <CANuQgHFdYhTc8YZ2MbQv0r_CsJGDLwHOqy9NuVDEfVUOTsbRpA@mail.gmail.com>
	<1398170284-7551-1-git-send-email-chander.kashyap@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-ob0-f181.google.com ([209.85.214.181]:47213 "EHLO
	mail-ob0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932161AbaEPIQS (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 16 May 2014 04:16:18 -0400
Received: by mail-ob0-f181.google.com with SMTP id wm4so2519937obc.26
        for <linux-pm@vger.kernel.org>; Fri, 16 May 2014 01:16:17 -0700 (PDT)
In-Reply-To: <1398170284-7551-1-git-send-email-chander.kashyap@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Tuukka Tikkanen <tuukka.tikkanen@linaro.org>, rafael.j.wysocki@intel.com, Daniel Lezcano <daniel.lezcano@linaro.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Chander Kashyap <chander.kashyap@linaro.org>

On 22 April 2014 18:08, Chander Kashyap <chander.kashyap@linaro.org> wrote:
> In menu_select function we check for correction factor every time.
> If it is zero we are initializing to unity. Hence move it to init function
> and initialise by unity, hence avoid repeated comparisons.
>
> Signed-off-by: Chander Kashyap <chander.kashyap@linaro.org>
> Reviewed-by: Tuukka Tikkanen <tuukka.tikkanen@linaro.org>
> ---
>  drivers/cpuidle/governors/menu.c |   15 ++++++++-------
>  1 file changed, 8 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/cpuidle/governors/menu.c b/drivers/cpuidle/governors/menu.c
> index 71b5232..9b7918c 100644
> --- a/drivers/cpuidle/governors/menu.c
> +++ b/drivers/cpuidle/governors/menu.c
> @@ -311,13 +311,6 @@ static int menu_select(struct cpuidle_driver *drv, struct cpuidle_device *dev)
>         data->bucket = which_bucket(data->next_timer_us);
>
>         /*
> -        * if the correction factor is 0 (eg first time init or cpu hotplug
> -        * etc), we actually want to start out with a unity factor.
> -        */
> -       if (data->correction_factor[data->bucket] == 0)
> -               data->correction_factor[data->bucket] = RESOLUTION * DECAY;
> -
> -       /*
>          * Force the result of multiplication to be 64 bits even if both
>          * operands are 32 bits.
>          * Make sure to round up for half microseconds.
> @@ -466,9 +459,17 @@ static int menu_enable_device(struct cpuidle_driver *drv,
>                                 struct cpuidle_device *dev)
>  {
>         struct menu_device *data = &per_cpu(menu_devices, dev->cpu);
> +       int i;
>
>         memset(data, 0, sizeof(struct menu_device));
>
> +       /*
> +        * if the correction factor is 0 (eg first time init or cpu hotplug
> +        * etc), we actually want to start out with a unity factor.
> +        */
> +       for(i = 0; i < BUCKETS; i++)
> +               data->correction_factor[i] = RESOLUTION * DECAY;
> +
>         return 0;
>  }
>

ping.

> --
> 1.7.9.5
>



-- 
with warm regards,
Chander Kashyap
