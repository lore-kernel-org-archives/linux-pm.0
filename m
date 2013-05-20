From: "Zhang, Rui" <rui.zhang@intel.com>
Subject: RE: [PATCH 2/2] Thermal: don't check resource with
 devm_ioremap_resource
Date: Mon, 20 May 2013 15:39:59 +0000
Message-ID: <744357E9AAD1214791ACBA4B0B909263011023B5@SHSMSX101.ccr.corp.intel.com>
References: <1368670581-4846-1-git-send-email-rui.zhang@intel.com>
 <1368670581-4846-2-git-send-email-rui.zhang@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga14.intel.com ([143.182.124.37]:25630 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752024Ab3ETPkE convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 20 May 2013 11:40:04 -0400
In-Reply-To: <1368670581-4846-2-git-send-email-rui.zhang@intel.com>
Content-Language: en-US
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Zhang, Rui" <rui.zhang@intel.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>
Cc: "eduardo.valentin@ti.com" <eduardo.valentin@ti.com>, Ezequiel Garcia <ezequiel.garcia@free-electrons.com>, Vincenzo Frascino <vincenzo.frascino@st.com>



> -----Original Message-----
> From: Zhang, Rui
> Sent: Thursday, May 16, 2013 10:16 AM
> To: linux-pm@vger.kernel.org
> Cc: eduardo.valentin@ti.com; Zhang, Rui; Ezequiel Garcia; Vincenzo
> Frascino
> Subject: [PATCH 2/2] Thermal: don't check resource with
> devm_ioremap_resource
> Importance: High
> 
> devm_ioremap_resource does sanity checks on the given resource.
> No need to duplicate this in the driver.
> 
> CC: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
> CC: Vincenzo Frascino <vincenzo.frascino@st.com>
> Signed-off-by: Zhang Rui <rui.zhang@intel.com>

Applied to thermal -next.

Thanks,
rui
> ---
>  drivers/thermal/armada_thermal.c |   10 ----------
>  drivers/thermal/spear_thermal.c  |    7 +------
>  2 files changed, 1 insertion(+), 16 deletions(-)
> 
> diff --git a/drivers/thermal/armada_thermal.c
> b/drivers/thermal/armada_thermal.c
> index 0d02d4e..0491465 100644
> --- a/drivers/thermal/armada_thermal.c
> +++ b/drivers/thermal/armada_thermal.c
> @@ -169,21 +169,11 @@ static int armada_thermal_probe(struct
> platform_device *pdev)
>  		return -ENOMEM;
> 
>  	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> -	if (!res) {
> -		dev_err(&pdev->dev, "Failed to get platform resource\n");
> -		return -ENODEV;
> -	}
> -
>  	priv->sensor = devm_ioremap_resource(&pdev->dev, res);
>  	if (IS_ERR(priv->sensor))
>  		return PTR_ERR(priv->sensor);
> 
>  	res = platform_get_resource(pdev, IORESOURCE_MEM, 1);
> -	if (!res) {
> -		dev_err(&pdev->dev, "Failed to get platform resource\n");
> -		return -ENODEV;
> -	}
> -
>  	priv->control = devm_ioremap_resource(&pdev->dev, res);
>  	if (IS_ERR(priv->control))
>  		return PTR_ERR(priv->control);
> diff --git a/drivers/thermal/spear_thermal.c
> b/drivers/thermal/spear_thermal.c index 1b652ab..fa30918 100644
> --- a/drivers/thermal/spear_thermal.c
> +++ b/drivers/thermal/spear_thermal.c
> @@ -118,13 +118,8 @@ static int spear_thermal_probe(struct
> platform_device *pdev)
>  		return -ENOMEM;
>  	}
> 
> -	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> -	if (!res) {
> -		dev_err(&pdev->dev, "memory resource missing\n");
> -		return -ENODEV;
> -	}
> -
>  	/* Enable thermal sensor */
> +	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>  	stdev->thermal_base = devm_ioremap_resource(dev, res);
>  	if (IS_ERR(stdev->thermal_base)) {
>  		dev_err(&pdev->dev, "ioremap failed\n");
> --
> 1.7.9.5

