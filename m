From: Kevin Hilman <khilman@baylibre.com>
Subject: Re: [PATCH v4] thermal: tango: add resume support
Date: Fri, 02 Sep 2016 13:54:56 -0700
Message-ID: <7hpoom10pr.fsf@baylibre.com>
References: <57726196.5060909@free.fr> <57C97BDD.4030101@sigmadesigns.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f48.google.com ([209.85.220.48]:35378 "EHLO
        mail-pa0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752142AbcIBUy7 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 2 Sep 2016 16:54:59 -0400
Received: by mail-pa0-f48.google.com with SMTP id hb8so43476118pac.2
        for <linux-pm@vger.kernel.org>; Fri, 02 Sep 2016 13:54:58 -0700 (PDT)
In-Reply-To: <57C97BDD.4030101@sigmadesigns.com> (Marc Gonzalez's message of
        "Fri, 2 Sep 2016 15:17:17 +0200")
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Marc Gonzalez <marc_gonzalez@sigmadesigns.com>
Cc: Eduardo Valentin <edubezval@gmail.com>, Zhang Rui <rui.zhang@intel.com>, linux-pm <linux-pm@vger.kernel.org>, Linux ARM <linux-arm-kernel@lists.infradead.org>, Sebastian Frias <sf84@laposte.net>, Thierry Reding <thierry.reding@gmail.com>, Arnd Bergmann <arnd@arndb.de>, Mason <slash.tmp@free.fr>

Marc Gonzalez <marc_gonzalez@sigmadesigns.com> writes:

> When this platform is suspended, firmware powers the entire SoC down,
> except a few hardware blocks waiting for wakeup events. There is no
> context to save for this particular block.
>
> Therefore, there is nothing useful for the driver to do on suspend;
> so we define a NULL suspend hook. On resume, the driver initializes
> the block exactly as is done in the probe callback.
>
> Signed-off-by: Marc Gonzalez <marc_gonzalez@sigmadesigns.com>

Reviewed-by: Kevin Hilman <khilman@baylibre.com>

> ---
> Earlier versions of this patch were reviewed by Kevin and Thierry.
> The current form is preferred by Arnd.
> ---
>  drivers/thermal/tango_thermal.c | 19 +++++++++++++++++--
>  1 file changed, 17 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/thermal/tango_thermal.c b/drivers/thermal/tango_thermal.c
> index 70e0d9f406e9..201304aeafeb 100644
> --- a/drivers/thermal/tango_thermal.c
> +++ b/drivers/thermal/tango_thermal.c
> @@ -64,6 +64,12 @@ static const struct thermal_zone_of_device_ops ops = {
>  	.get_temp	= tango_get_temp,
>  };
>  
> +static void tango_thermal_init(struct tango_thermal_priv *priv)
> +{
> +	writel(0, priv->base + TEMPSI_CFG);
> +	writel(CMD_ON, priv->base + TEMPSI_CMD);
> +}
> +
>  static int tango_thermal_probe(struct platform_device *pdev)
>  {
>  	struct resource *res;
> @@ -79,14 +85,22 @@ static int tango_thermal_probe(struct platform_device *pdev)
>  	if (IS_ERR(priv->base))
>  		return PTR_ERR(priv->base);
>  
> +	platform_set_drvdata(pdev, priv);
>  	priv->thresh_idx = IDX_MIN;
> -	writel(0, priv->base + TEMPSI_CFG);
> -	writel(CMD_ON, priv->base + TEMPSI_CMD);
> +	tango_thermal_init(priv);
>  
>  	tzdev = devm_thermal_zone_of_sensor_register(&pdev->dev, 0, priv, &ops);
>  	return PTR_ERR_OR_ZERO(tzdev);
>  }
>  
> +static int __maybe_unused tango_thermal_resume(struct device *dev)
> +{
> +	tango_thermal_init(dev_get_drvdata(dev));
> +	return 0;
> +}
> +
> +static SIMPLE_DEV_PM_OPS(tango_thermal_pm, NULL, tango_thermal_resume);
> +
>  static const struct of_device_id tango_sensor_ids[] = {
>  	{
>  		.compatible = "sigma,smp8758-thermal",
> @@ -99,6 +113,7 @@ static struct platform_driver tango_thermal_driver = {
>  	.driver	= {
>  		.name		= "tango-thermal",
>  		.of_match_table	= tango_sensor_ids,
> +		.pm		= &tango_thermal_pm,
>  	},
>  };
