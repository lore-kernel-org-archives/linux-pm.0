From: Hongbo Zhang <hongbo.zhang@linaro.org>
Subject: Re: [PATCH 2/2] thermal: db8500: Use of_match_ptr() macro in db8500_cpufreq_cooling.c
Date: Thu, 3 Jan 2013 17:07:13 +0800
Message-ID: <CAJLyvQxEiWmc7fG_F7brbpKHg5Tt9=yDywtRY+sQWZJ77_L4+w@mail.gmail.com>
References: <1355907059-28720-1-git-send-email-sachin.kamat@linaro.org>
	<1355907059-28720-2-git-send-email-sachin.kamat@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-la0-f51.google.com ([209.85.215.51]:42463 "EHLO
	mail-la0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752867Ab3ACJHP (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 3 Jan 2013 04:07:15 -0500
Received: by mail-la0-f51.google.com with SMTP id fj20so7355245lab.24
        for <linux-pm@vger.kernel.org>; Thu, 03 Jan 2013 01:07:14 -0800 (PST)
In-Reply-To: <1355907059-28720-2-git-send-email-sachin.kamat@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Sachin Kamat <sachin.kamat@linaro.org>
Cc: linux-pm@vger.kernel.org, rui.zhang@intel.com, patches@linaro.org, Hongbo Zhang <hongbo.zhang@stericsson.com>

On 19 December 2012 16:50, Sachin Kamat <sachin.kamat@linaro.org> wrote:
> This eliminates having an #ifdef returning NULL for the case
> when OF is disabled.
>
> Cc: Hongbo Zhang <hongbo.zhang@stericsson.com>
> Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
> ---
> Compile tested on linux-next.
> ---
>  drivers/thermal/db8500_cpufreq_cooling.c |    5 ++---
>  1 files changed, 2 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/thermal/db8500_cpufreq_cooling.c b/drivers/thermal/db8500_cpufreq_cooling.c
> index 4cf8e72..2141985 100644
> --- a/drivers/thermal/db8500_cpufreq_cooling.c
> +++ b/drivers/thermal/db8500_cpufreq_cooling.c
> @@ -21,6 +21,7 @@
>  #include <linux/cpufreq.h>
>  #include <linux/err.h>
>  #include <linux/module.h>
> +#include <linux/of.h>
>  #include <linux/platform_device.h>
>  #include <linux/slab.h>
>
> @@ -73,15 +74,13 @@ static const struct of_device_id db8500_cpufreq_cooling_match[] = {
>         { .compatible = "stericsson,db8500-cpufreq-cooling" },
>         {},
>  };
> -#else
> -#define db8500_cpufreq_cooling_match NULL
>  #endif
>
>  static struct platform_driver db8500_cpufreq_cooling_driver = {
>         .driver = {
>                 .owner = THIS_MODULE,
>                 .name = "db8500-cpufreq-cooling",
> -               .of_match_table = db8500_cpufreq_cooling_match,
> +               .of_match_table = of_match_ptr(db8500_cpufreq_cooling_match),
>         },
>         .probe = db8500_cpufreq_cooling_probe,
>         .suspend = db8500_cpufreq_cooling_suspend,
> --
> 1.7.4.1
>
Good one.
Reviewed-by: hongbo.zhang@linaro.org

Thanks.
