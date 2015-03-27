From: amit daniel kachhap <amit.daniel@samsung.com>
Subject: Re: [PATCH 04/13] thermal: Fix not emulating critical temperatures
Date: Fri, 27 Mar 2015 08:35:50 +0530
Message-ID: <CADGdYn5vaPu4+yhjs5c3QuCnz-LtL2Z2qRENjsizpO6D1gVOSg@mail.gmail.com>
References: <1427385240-6086-1-git-send-email-s.hauer@pengutronix.de>
	<1427385240-6086-5-git-send-email-s.hauer@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wi0-f182.google.com ([209.85.212.182]:34977 "EHLO
	mail-wi0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751644AbbC0DFw (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 26 Mar 2015 23:05:52 -0400
In-Reply-To: <1427385240-6086-5-git-send-email-s.hauer@pengutronix.de>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Sascha Hauer <s.hauer@pengutronix.de>
Cc: "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Stephen Warren <swarren@wwwdotorg.org>, Mikko Perttunen <mikko.perttunen@kapsi.fi>, kernel@pengutronix.de, linux-mediatek@lists.infradead.org, LAK <linux-arm-kernel@lists.infradead.org>

Hi Sascha,

On Thu, Mar 26, 2015 at 9:23 PM, Sascha Hauer <s.hauer@pengutronix.de> wrote:
> commit e6e238c38 (thermal: sysfs: Add a new sysfs node emul_temp for
> thermal emulation)  promised not to emulate critical temperatures,
> but the check for critical temperatures is broken in multiple ways:
>
> - The code should only accept an emulated temperature when the emulated
>   temperature is lower than the critical temperature. Instead the code
>   accepts an emulated temperature whenever the real temperature is lower
>   than the critical temperature. This makes no sense and trying to
>   emulate a temperature higher than the critical temperature halts the
>   system.
Even higher than critical temperature should be accepted. see my
further comments below.
> - When trying to emulate a higher-than-critical temperature we should either
>   limit the emulated temperature to the maximum non critical temperature
>   or refuse to emulate this temperature. Instead the code just silently
>   ignores the emulated temperature and continues with the real temperature.
>
> This patch moves the test for illegal emulated temperature to the sysfs
> write function so that we can properly refuse illegal temperatures here.
> Trying to write illegal temperatures results in an error message. While
> at it use IS_ENABLED() instead of #ifdefs.
>
> Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
> ---
>  drivers/thermal/thermal_core.c | 46 ++++++++++++++++++++++--------------------
>  1 file changed, 24 insertions(+), 22 deletions(-)
>
> diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
> index dcea909..ebca854 100644
> --- a/drivers/thermal/thermal_core.c
> +++ b/drivers/thermal/thermal_core.c
> @@ -414,11 +414,6 @@ static void handle_thermal_trip(struct thermal_zone_device *tz, int trip)
>  int thermal_zone_get_temp(struct thermal_zone_device *tz, unsigned long *temp)
>  {
>         int ret = -EINVAL;
> -#ifdef CONFIG_THERMAL_EMULATION
> -       int count;
> -       unsigned long crit_temp = -1UL;
> -       enum thermal_trip_type type;
> -#endif
>
>         if (!tz || IS_ERR(tz) || !tz->ops->get_temp)
>                 goto exit;
> @@ -426,25 +421,10 @@ int thermal_zone_get_temp(struct thermal_zone_device *tz, unsigned long *temp)
>         mutex_lock(&tz->lock);
>
>         ret = tz->ops->get_temp(tz, temp);
> -#ifdef CONFIG_THERMAL_EMULATION
> -       if (!tz->emul_temperature)
> -               goto skip_emul;
> -
> -       for (count = 0; count < tz->trips; count++) {
> -               ret = tz->ops->get_trip_type(tz, count, &type);
> -               if (!ret && type == THERMAL_TRIP_CRITICAL) {
> -                       ret = tz->ops->get_trip_temp(tz, count, &crit_temp);
> -                       break;
> -               }
> -       }
> -
> -       if (ret)
> -               goto skip_emul;
>
> -       if (*temp < crit_temp)
I guess this check is confusing. Actually instead of returning
emulating temperature it is returning actual temperature. But the
important thing to look here is that actual temperature is higher than
critical temperature. So this check prevents the user from suppressing
the critical temperature and hence prevents from burning up the chip.
> +       if (IS_ENABLED(CONFIG_THERMAL_EMULATION) && tz->emul_temperature)
>                 *temp = tz->emul_temperature;
> -skip_emul:
> -#endif
> +
>         mutex_unlock(&tz->lock);
>  exit:
>         return ret;
> @@ -788,10 +768,32 @@ emul_temp_store(struct device *dev, struct device_attribute *attr,
>         struct thermal_zone_device *tz = to_thermal_zone(dev);
>         int ret = 0;
>         unsigned long temperature;
> +       int trip;
> +       unsigned long crit_temp;
> +       enum thermal_trip_type type;
>
>         if (kstrtoul(buf, 10, &temperature))
>                 return -EINVAL;
>
> +       for (trip = 0; trip < tz->trips; trip++) {
> +               ret = tz->ops->get_trip_type(tz, trip, &type);
> +               if (ret)
> +                       return ret;
> +
> +               if (type != THERMAL_TRIP_CRITICAL)
> +                       continue;
> +
> +               ret = tz->ops->get_trip_temp(tz, trip, &crit_temp);
> +               if (ret)
> +                       return ret;
> +
> +               if (temperature >= crit_temp) {
> +                       dev_err(&tz->device, "Will not emulate critical temperature %luC (tcrit=%luC)\n",
> +                                       temperature / 1000, crit_temp / 1000);
> +                       return -EINVAL;
> +               }
Emulating critical temperature is very much needed.
> +       }
> +
>         if (!tz->ops->set_emul_temp) {
>                 mutex_lock(&tz->lock);
>                 tz->emul_temperature = temperature;
> --
> 2.1.4
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pm" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
