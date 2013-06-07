From: MyungJoo Ham <myungjoo.ham@samsung.com>
Subject: Re: [PATCH 2/3] PM / devfreq: Remove redundant platform_set_drvdata()
 in exynos5_bus.c
Date: Fri, 7 Jun 2013 19:30:06 +0900
Message-ID: <CAJ0PZbQ=Wnpb8PdZOdK_gDswkB=+bptwDoWBdVRbreK2fKxObg@mail.gmail.com>
References: <1370412781-20683-1-git-send-email-sachin.kamat@linaro.org>
	<1370412781-20683-2-git-send-email-sachin.kamat@linaro.org>
Reply-To: myungjoo.ham@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-vb0-f47.google.com ([209.85.212.47]:48747 "EHLO
	mail-vb0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751671Ab3FGKaI (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 7 Jun 2013 06:30:08 -0400
Received: by mail-vb0-f47.google.com with SMTP id x14so2572398vbb.20
        for <linux-pm@vger.kernel.org>; Fri, 07 Jun 2013 03:30:07 -0700 (PDT)
In-Reply-To: <1370412781-20683-2-git-send-email-sachin.kamat@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Sachin Kamat <sachin.kamat@linaro.org>
Cc: Linux PM list <linux-pm@vger.kernel.org>, Kyungmin Park <kyungmin.park@samsung.com>, Abhilash Kesavan <a.kesavan@samsung.com>, "patches@linaro.org" <patches@linaro.org>

On Wed, Jun 5, 2013 at 3:13 PM, Sachin Kamat <sachin.kamat@linaro.org> wrote:
> Commit 0998d06310 (device-core: Ensure drvdata = NULL when no
> driver is bound) removes the need to set driver data field to
> NULL.
>
> Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>

Acked-by: MyungJoo Ham <myungjoo.ham@samsung.com.

Will be applied to the for-next branch soon. Thank you.

> ---
>  drivers/devfreq/exynos/exynos5_bus.c |    2 --
>  1 file changed, 2 deletions(-)
>
> diff --git a/drivers/devfreq/exynos/exynos5_bus.c b/drivers/devfreq/exynos/exynos5_bus.c
> index cd1e630..9a82419 100644
> --- a/drivers/devfreq/exynos/exynos5_bus.c
> +++ b/drivers/devfreq/exynos/exynos5_bus.c
> @@ -419,7 +419,6 @@ static int exynos5_busfreq_int_probe(struct platform_device *pdev)
>
>  err_devfreq_add:
>         devfreq_remove_device(data->devfreq);
> -       platform_set_drvdata(pdev, NULL);
>  err_opp_add:
>         clk_put(data->int_clk);
>  err_clock:
> @@ -437,7 +436,6 @@ static int exynos5_busfreq_int_remove(struct platform_device *pdev)
>         devfreq_remove_device(data->devfreq);
>         regulator_put(data->vdd_int);
>         clk_put(data->int_clk);
> -       platform_set_drvdata(pdev, NULL);
>
>         return 0;
>  }
> --
> 1.7.9.5
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pm" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



--
MyungJoo Ham, Ph.D.
Mobile Software Platform Lab, DMC Business, Samsung Electronics
