From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH 1/2] thermal: rcar_thermal: remove redundant operation
Date: Fri, 13 Nov 2015 15:50:04 +0100
Message-ID: <CAPDyKFrpE_v5QXwX+F-xRL7nEtbAo9JCS0UEc+Kv9pWKaRQA5g@mail.gmail.com>
References: <87h9kulkfg.wl%kuninori.morimoto.gx@renesas.com>
	<87fv0elibh.wl%kuninori.morimoto.gx@renesas.com>
	<87egfylia4.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-yk0-f177.google.com ([209.85.160.177]:36068 "EHLO
	mail-yk0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932148AbbKMOuH (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 13 Nov 2015 09:50:07 -0500
Received: by ykdr82 with SMTP id r82so149238046ykd.3
        for <linux-pm@vger.kernel.org>; Fri, 13 Nov 2015 06:50:04 -0800 (PST)
In-Reply-To: <87egfylia4.wl%kuninori.morimoto.gx@renesas.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>, Linux-SH <linux-sh@vger.kernel.org>, Linux-Kernel <linux-kernel@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Cao Minh Hiep <cm-hiep@jinso.co.jp>, =?UTF-8?B?RHVuZ++8muS6uuOCvQ==?= <nv-dung@jinso.co.jp>

On 10 November 2015 at 03:12, Kuninori Morimoto
<kuninori.morimoto.gx@renesas.com> wrote:
> From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
>
> Probe error operation and remove operation are same.

Currently they are, but that's because the error handling in ->probe() is wrong.

In some error cases the pm_runtime_put|disable() should have been
called but they aren't. Perhaps it's better to fix that first.

Kind regards
Uffe

> Let's use same function.
>
> Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> ---
>  drivers/thermal/rcar_thermal.c | 49 ++++++++++++++++++------------------------
>  1 file changed, 21 insertions(+), 28 deletions(-)
>
> diff --git a/drivers/thermal/rcar_thermal.c b/drivers/thermal/rcar_thermal.c
> index 5d4ae7d..13d01ed 100644
> --- a/drivers/thermal/rcar_thermal.c
> +++ b/drivers/thermal/rcar_thermal.c
> @@ -361,6 +361,24 @@ static irqreturn_t rcar_thermal_irq(int irq, void *data)
>  /*
>   *             platform functions
>   */
> +static int rcar_thermal_remove(struct platform_device *pdev)
> +{
> +       struct rcar_thermal_common *common = platform_get_drvdata(pdev);
> +       struct device *dev = &pdev->dev;
> +       struct rcar_thermal_priv *priv;
> +
> +       rcar_thermal_for_each_priv(priv, common) {
> +               if (rcar_has_irq_support(priv))
> +                       rcar_thermal_irq_disable(priv);
> +               thermal_zone_device_unregister(priv->zone);
> +       }
> +
> +       pm_runtime_put(dev);
> +       pm_runtime_disable(dev);
> +
> +       return 0;
> +}
> +
>  static int rcar_thermal_probe(struct platform_device *pdev)
>  {
>         struct rcar_thermal_common *common;
> @@ -377,6 +395,8 @@ static int rcar_thermal_probe(struct platform_device *pdev)
>         if (!common)
>                 return -ENOMEM;
>
> +       platform_set_drvdata(pdev, common);
> +
>         INIT_LIST_HEAD(&common->head);
>         spin_lock_init(&common->lock);
>         common->dev = dev;
> @@ -454,43 +474,16 @@ static int rcar_thermal_probe(struct platform_device *pdev)
>                 rcar_thermal_common_write(common, ENR, enr_bits);
>         }
>
> -       platform_set_drvdata(pdev, common);
> -
>         dev_info(dev, "%d sensor probed\n", i);
>
>         return 0;
>
>  error_unregister:
> -       rcar_thermal_for_each_priv(priv, common) {
> -               if (rcar_has_irq_support(priv))
> -                       rcar_thermal_irq_disable(priv);
> -               thermal_zone_device_unregister(priv->zone);
> -       }
> -
> -       pm_runtime_put(dev);
> -       pm_runtime_disable(dev);
> +       rcar_thermal_remove(pdev);
>
>         return ret;
>  }
>
> -static int rcar_thermal_remove(struct platform_device *pdev)
> -{
> -       struct rcar_thermal_common *common = platform_get_drvdata(pdev);
> -       struct device *dev = &pdev->dev;
> -       struct rcar_thermal_priv *priv;
> -
> -       rcar_thermal_for_each_priv(priv, common) {
> -               if (rcar_has_irq_support(priv))
> -                       rcar_thermal_irq_disable(priv);
> -               thermal_zone_device_unregister(priv->zone);
> -       }
> -
> -       pm_runtime_put(dev);
> -       pm_runtime_disable(dev);
> -
> -       return 0;
> -}
> -
>  static const struct of_device_id rcar_thermal_dt_ids[] = {
>         { .compatible = "renesas,rcar-thermal", },
>         {},
> --
> 1.9.1
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pm" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
