From: Hongbo Zhang <hongbo.zhang@linaro.org>
Subject: Re: [PATCH 2/2] thermal: db8500: Fix missing mutex_unlock() in probe
 error paths
Date: Wed, 13 Mar 2013 16:13:06 +0800
Message-ID: <CAJLyvQxJ05HGtz79F-JKB0K9gdh5cwz3vjVbhn2vHnTWz54iMQ@mail.gmail.com>
References: <1363102940.3160.2.camel@phoenix>
	<1363103009.3160.3.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-ea0-f182.google.com ([209.85.215.182]:61744 "EHLO
	mail-ea0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754125Ab3CMINI (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 13 Mar 2013 04:13:08 -0400
Received: by mail-ea0-f182.google.com with SMTP id q15so270425ead.13
        for <linux-pm@vger.kernel.org>; Wed, 13 Mar 2013 01:13:06 -0700 (PDT)
In-Reply-To: <1363103009.3160.3.camel@phoenix>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Axel Lin <axel.lin@ingics.com>
Cc: Zhang Rui <rui.zhang@intel.com>, Hongbo Zhang <hongbo.zhang@stericsson.com>, Viresh Kumar <viresh.kumar@linaro.org>, Francesco Lavra <francescolavra.fl@gmail.com>, linux-pm@vger.kernel.org

On 12 March 2013 23:43, Axel Lin <axel.lin@ingics.com> wrote:

It is better to say some commit message here I think.

> Signed-off-by: Axel Lin <axel.lin@ingics.com>
> ---
>  drivers/thermal/db8500_thermal.c |   17 +++++++++++------
>  1 file changed, 11 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/thermal/db8500_thermal.c b/drivers/thermal/db8500_thermal.c
> index 6bdcec4..1e3b3bf 100644
> --- a/drivers/thermal/db8500_thermal.c
> +++ b/drivers/thermal/db8500_thermal.c
> @@ -419,7 +419,8 @@ static int db8500_thermal_probe(struct platform_device *pdev)
>         low_irq = platform_get_irq_byname(pdev, "IRQ_HOTMON_LOW");
>         if (low_irq < 0) {
>                 dev_err(&pdev->dev, "Get IRQ_HOTMON_LOW failed.\n");
> -               return low_irq;
> +               ret = low_irq;
> +               goto out_unlock;
>         }
>
>         ret = devm_request_threaded_irq(&pdev->dev, low_irq, NULL,
> @@ -427,13 +428,14 @@ static int db8500_thermal_probe(struct platform_device *pdev)
>                 "dbx500_temp_low", pzone);
>         if (ret < 0) {
>                 dev_err(&pdev->dev, "Failed to allocate temp low irq.\n");
> -               return ret;
> +               goto out_unlock;
>         }
>
>         high_irq = platform_get_irq_byname(pdev, "IRQ_HOTMON_HIGH");
>         if (high_irq < 0) {
>                 dev_err(&pdev->dev, "Get IRQ_HOTMON_HIGH failed.\n");
> -               return high_irq;
> +               ret = high_irq;
> +               goto out_unlock;
>         }
>
>         ret = devm_request_threaded_irq(&pdev->dev, high_irq, NULL,
> @@ -441,7 +443,7 @@ static int db8500_thermal_probe(struct platform_device *pdev)
>                 "dbx500_temp_high", pzone);
>         if (ret < 0) {
>                 dev_err(&pdev->dev, "Failed to allocate temp high irq.\n");
> -               return ret;
> +               goto out_unlock;
>         }
>
>         pzone->therm_dev = thermal_zone_device_register("db8500_thermal_zone",
> @@ -449,7 +451,8 @@ static int db8500_thermal_probe(struct platform_device *pdev)
>
>         if (IS_ERR(pzone->therm_dev)) {
>                 dev_err(&pdev->dev, "Register thermal zone device failed.\n");
> -               return PTR_ERR(pzone->therm_dev);
> +               ret = PTR_ERR(pzone->therm_dev);
> +               goto out_unlock;
>         }
>         dev_info(&pdev->dev, "Thermal zone device registered.\n");
>
> @@ -461,9 +464,11 @@ static int db8500_thermal_probe(struct platform_device *pdev)
>
>         platform_set_drvdata(pdev, pzone);
>         pzone->mode = THERMAL_DEVICE_ENABLED;
> +
> +out_unlock:

This was my carelessness really, thanks.

>         mutex_unlock(&pzone->th_lock);
>
> -       return 0;
> +       return ret;
>  }
>
>  static int db8500_thermal_remove(struct platform_device *pdev)
> --
> 1.7.9.5
>
>
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pm" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
