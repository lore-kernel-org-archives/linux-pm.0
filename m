From: Zhang Rui <rui.zhang@intel.com>
Subject: Re: [PATCH 1/3] Thermal: dove: Convert to devm_ioremap_resource()
Date: Mon, 11 Mar 2013 22:35:10 +0800
Message-ID: <1363012510.2291.75.camel@rzhang1-mobl4>
References: <1362379534-30662-1-git-send-email-sachin.kamat@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:33522 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751665Ab3CKOfP (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Mon, 11 Mar 2013 10:35:15 -0400
In-Reply-To: <1362379534-30662-1-git-send-email-sachin.kamat@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Sachin Kamat <sachin.kamat@linaro.org>
Cc: linux-pm@vger.kernel.org, thierry.reding@avionic-design.de, Andrew Lunn <andrew@lunn.ch>

On Mon, 2013-03-04 at 12:15 +0530, Sachin Kamat wrote:
> Use the newly introduced devm_ioremap_resource() instead of
> devm_request_and_ioremap() which provides more consistent error handling.
> 
> devm_ioremap_resource() provides its own error messages; so all explicit
> error messages can be removed from the failure code paths.
> 
> Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
> Cc: Andrew Lunn <andrew@lunn.ch>

applied to thermal -next tree.

thanks,
rui
> ---
>  drivers/thermal/dove_thermal.c |   16 ++++++----------
>  1 files changed, 6 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/thermal/dove_thermal.c b/drivers/thermal/dove_thermal.c
> index 7b0bfa0..3078c40 100644
> --- a/drivers/thermal/dove_thermal.c
> +++ b/drivers/thermal/dove_thermal.c
> @@ -143,22 +143,18 @@ static int dove_thermal_probe(struct platform_device *pdev)
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
>  	res = platform_get_resource(pdev, IORESOURCE_MEM, 1);
>  	if (!res) {
>  		dev_err(&pdev->dev, "Failed to get platform resource\n");
>  		return -ENODEV;
>  	}
> -	priv->control = devm_request_and_ioremap(&pdev->dev, res);
> -	if (!priv->control) {
> -		dev_err(&pdev->dev, "Failed to request_ioremap memory\n");
> -		return -EADDRNOTAVAIL;
> -	}
> +	priv->control = devm_ioremap_resource(&pdev->dev, res);
> +	if (IS_ERR(priv->control))
> +		return PTR_ERR(priv->control);
>  
>  	ret = dove_init_sensor(priv);
>  	if (ret) {


