From: Zhang Rui <rui.zhang@intel.com>
Subject: Re: [PATCH 3/3] Thermal: kirkwood: Convert to
 devm_ioremap_resource()
Date: Mon, 11 Mar 2013 22:35:50 +0800
Message-ID: <1363012550.2291.77.camel@rzhang1-mobl4>
References: <1362379534-30662-1-git-send-email-sachin.kamat@linaro.org>
	 <1362379534-30662-3-git-send-email-sachin.kamat@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga03.intel.com ([143.182.124.21]:57978 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752686Ab3CKOf4 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Mon, 11 Mar 2013 10:35:56 -0400
In-Reply-To: <1362379534-30662-3-git-send-email-sachin.kamat@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Sachin Kamat <sachin.kamat@linaro.org>
Cc: linux-pm@vger.kernel.org, thierry.reding@avionic-design.de, Nobuhiro Iwamatsu <iwamatsu@nigauri.org>

On Mon, 2013-03-04 at 12:15 +0530, Sachin Kamat wrote:
> Use the newly introduced devm_ioremap_resource() instead of
> devm_request_and_ioremap() which provides more consistent error handling.
> 
> devm_ioremap_resource() provides its own error messages; so all explicit
> error messages can be removed from the failure code paths.
> 
> Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
> Cc: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>

applied to thermal -next tree.

thanks,
rui
> ---
>  drivers/thermal/kirkwood_thermal.c |    8 +++-----
>  1 files changed, 3 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/thermal/kirkwood_thermal.c b/drivers/thermal/kirkwood_thermal.c
> index 65cb4f0..e5500ed 100644
> --- a/drivers/thermal/kirkwood_thermal.c
> +++ b/drivers/thermal/kirkwood_thermal.c
> @@ -85,11 +85,9 @@ static int kirkwood_thermal_probe(struct platform_device *pdev)
>  	if (!priv)
>  		return -ENOMEM;
>  
> -	priv->sensor = devm_request_and_ioremap(&pdev->dev, res);
> -	if (!priv->sensor) {
> -		dev_err(&pdev->dev, "Failed to request_ioremap memory\n");
> -		return -EADDRNOTAVAIL;
> -	}
> +	priv->sensor = devm_ioremap_resource(&pdev->dev, res);
> +	if (IS_ERR(priv->sensor))
> +		return PTR_ERR(priv->sensor);
>  
>  	thermal = thermal_zone_device_register("kirkwood_thermal", 0, 0,
>  					       priv, &ops, NULL, 0, 0);


