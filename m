From: Daniel Kurtz <djkurtz@chromium.org>
Subject: Re: [PATCH v4 4/5] thermal: power_allocator: don't require tzp to be
 present for the thermal zone
Date: Fri, 28 Aug 2015 10:18:20 +0800
Message-ID: <CAGS+omBzLQnbT13k2pGa_g+TQg1v0+k=nb+1QUNY5KaNvq2pfQ@mail.gmail.com>
References: <1439833008-26440-1-git-send-email-javi.merino@arm.com>
 <1440595604-27197-1-git-send-email-javi.merino@arm.com> <1440595604-27197-5-git-send-email-javi.merino@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wi0-f179.google.com ([209.85.212.179]:36804 "EHLO
	mail-wi0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751268AbbH1CSl (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 27 Aug 2015 22:18:41 -0400
Received: by wicgk12 with SMTP id gk12so7999182wic.1
        for <linux-pm@vger.kernel.org>; Thu, 27 Aug 2015 19:18:40 -0700 (PDT)
In-Reply-To: <1440595604-27197-5-git-send-email-javi.merino@arm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Javi Merino <javi.merino@arm.com>
Cc: linux-pm@vger.kernel.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Chung-yih Wang <cywang@chromium.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Punit Agrawal <punit.agrawal@arm.com>, Eduardo Valentin <edubezval@gmail.com>, Zhang Rui <rui.zhang@intel.com>

On Wed, Aug 26, 2015 at 9:26 PM, Javi Merino <javi.merino@arm.com> wrote:
> Thermal zones created using thermal_zone_device_create() may not have
> tzp.  As the governor gets its parameters from there, allocate it while
> the governor is bound to the thermal zone so that it can operate in it.
> In this case, tzp is freed when the thermal zone switches to another
> governor.
>
> Cc: Zhang Rui <rui.zhang@intel.com>
> Cc: Eduardo Valentin <edubezval@gmail.com>
> Signed-off-by: Javi Merino <javi.merino@arm.com>
> ---
>
> While this would be easier to do by just ignoring the thermal zone if
> there was no tzp, I think the approach in this patch provides a better
> behavior.

Why?
Just ignoring the thermal zone seems reasonable and simpler.

>
>  drivers/thermal/power_allocator.c | 32 +++++++++++++++++++++++++++-----
>  1 file changed, 27 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/thermal/power_allocator.c b/drivers/thermal/power_allocator.c
> index 2dfb8ade4d1b..85ce0aac9a41 100644
> --- a/drivers/thermal/power_allocator.c
> +++ b/drivers/thermal/power_allocator.c
> @@ -58,6 +58,8 @@ static inline s64 div_frac(s64 x, s64 y)
>
>  /**
>   * struct power_allocator_params - parameters for the power allocator governor
> + * @allocated_tzp:     whether we have allocated tzp for this thermal zone and
> + *                     it needs to be freed on unbind
>   * @err_integral:      accumulated error in the PID controller.
>   * @prev_err:  error in the previous iteration of the PID controller.
>   *             Used to calculate the derivative term.
> @@ -70,6 +72,7 @@ static inline s64 div_frac(s64 x, s64 y)
>   *                                     controlling for.
>   */
>  struct power_allocator_params {
> +       bool allocated_tzp;
>         s64 err_integral;
>         s32 prev_err;
>         int trip_switch_on;
> @@ -530,8 +533,7 @@ static void allow_maximum_power(struct thermal_zone_device *tz)
>   * Initialize the PID controller parameters and bind it to the thermal
>   * zone.
>   *
> - * Return: 0 on success, -EINVAL if the thermal zone doesn't have tzp or -ENOMEM
> - * if we ran out of memory.
> + * Return: 0 on success, or -ENOMEM if we ran out of memory.
>   */
>  static int power_allocator_bind(struct thermal_zone_device *tz)
>  {
> @@ -539,13 +541,20 @@ static int power_allocator_bind(struct thermal_zone_device *tz)
>         struct power_allocator_params *params;
>         unsigned long control_temp;
>
> -       if (!tz->tzp)
> -               return -EINVAL;
> -
>         params = kzalloc(sizeof(*params), GFP_KERNEL);
>         if (!params)
>                 return -ENOMEM;
>
> +       if (!tz->tzp) {
> +               tz->tzp = kzalloc(sizeof(*tz->tzp), GFP_KERNEL);

Why bother to allocate this dummy struct?
Can't we just leave tz->tzp as NULL, and do a NULL check where needed?

> +               if (!tz->tzp) {
> +                       ret = -ENOMEM;
> +                       goto free_params;
> +               }
> +
> +               params->allocated_tzp = true;
> +       }
> +
>         if (!tz->tzp->sustainable_power)
>                 dev_warn(&tz->device, "power_allocator: sustainable_power will be estimated\n");
>
> @@ -562,11 +571,24 @@ static int power_allocator_bind(struct thermal_zone_device *tz)
>         tz->governor_data = params;
>
>         return 0;
> +
> +free_params:
> +       kfree(params);
> +
> +       return ret;
>  }
>
>  static void power_allocator_unbind(struct thermal_zone_device *tz)
>  {
> +       struct power_allocator_params *params = tz->governor_data;
> +
>         dev_dbg(&tz->device, "Unbinding from thermal zone %d\n", tz->id);
> +
> +       if (params->allocated_tzp) {
> +               kfree(tz->tzp);
> +               tz->tzp = NULL;
> +       }
> +
>         kfree(tz->governor_data);
>         tz->governor_data = NULL;
>  }
> --
> 1.9.1
>
