From: Hongbo Zhang <hongbo.zhang@linaro.org>
Subject: Re: [PATCH 1/2] thermal: db8500: Use of_match_ptr() macro in db8500_thermal.c
Date: Thu, 3 Jan 2013 17:05:18 +0800
Message-ID: <CAJLyvQyk=1BRmvZKLMNZdA4Gj9QyCK3fJ8f0FL_kghc_YfZ7Cw@mail.gmail.com>
References: <1355907059-28720-1-git-send-email-sachin.kamat@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-la0-f51.google.com ([209.85.215.51]:38596 "EHLO
	mail-la0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751422Ab3ACJFU (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 3 Jan 2013 04:05:20 -0500
Received: by mail-la0-f51.google.com with SMTP id fj20so7556289lab.38
        for <linux-pm@vger.kernel.org>; Thu, 03 Jan 2013 01:05:18 -0800 (PST)
In-Reply-To: <1355907059-28720-1-git-send-email-sachin.kamat@linaro.org>
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
>  drivers/thermal/db8500_thermal.c |    4 +---
>  1 files changed, 1 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/thermal/db8500_thermal.c b/drivers/thermal/db8500_thermal.c
> index ec71ade..61ce60a 100644
> --- a/drivers/thermal/db8500_thermal.c
> +++ b/drivers/thermal/db8500_thermal.c
> @@ -508,15 +508,13 @@ static const struct of_device_id db8500_thermal_match[] = {
>         { .compatible = "stericsson,db8500-thermal" },
>         {},
>  };
> -#else
> -#define db8500_thermal_match NULL
>  #endif
>
>  static struct platform_driver db8500_thermal_driver = {
>         .driver = {
>                 .owner = THIS_MODULE,
>                 .name = "db8500-thermal",
> -               .of_match_table = db8500_thermal_match,
> +               .of_match_table = of_match_ptr(db8500_thermal_match),
>         },
>         .probe = db8500_thermal_probe,
>         .suspend = db8500_thermal_suspend,
> --
> 1.7.4.1
>
Good one.
Reviewed-by: hongbo.zhang@linaro.org
