From: Eduardo Valentin <edubezval@gmail.com>
Subject: Re: [PATCH] thermal: imx: correct thermal driver load sequence
Date: Thu, 11 Sep 2014 08:16:20 -0400
Message-ID: <20140911121618.GA26715@developer>
References: <1410422657-30726-1-git-send-email-b51503@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-qa0-f42.google.com ([209.85.216.42]:48243 "EHLO
	mail-qa0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754377AbaIKMQa (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 11 Sep 2014 08:16:30 -0400
Received: by mail-qa0-f42.google.com with SMTP id j7so192362qaq.15
        for <linux-pm@vger.kernel.org>; Thu, 11 Sep 2014 05:16:29 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1410422657-30726-1-git-send-email-b51503@freescale.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Bai Ping <b51503@freescale.com>
Cc: rui.zhang@intel.com, linux-pm@vger.kernel.org

Hello Bai,

On Thu, Sep 11, 2014 at 04:04:17PM +0800, Bai Ping wrote:
> Thermal driver should be registered after cpufreq driver have
> been registered and probed. Doing so is to make sure that thermal
> driver can get the max cpu cooling states correctly when calling
> get_property.
> 

OK.

> Signed-off-by: Bai Ping <b51503@freescale.com>
> ---
>  drivers/thermal/imx_thermal.c | 11 +++++++++--
>  1 file changed, 9 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/thermal/imx_thermal.c b/drivers/thermal/imx_thermal.c
> index 45af765..d00aaaf 100644
> --- a/drivers/thermal/imx_thermal.c
> +++ b/drivers/thermal/imx_thermal.c
> @@ -1,5 +1,5 @@
>  /*
> - * Copyright 2013 Freescale Semiconductor, Inc.
> + * Copyright 2013-2014 Freescale Semiconductor, Inc.
>   *

The above does not seam to be part of this patch.

>   * This program is free software; you can redistribute it and/or modify
>   * it under the terms of the GNU General Public License version 2 as
> @@ -557,7 +557,14 @@ static struct platform_driver imx_thermal = {
>  	.probe		= imx_thermal_probe,
>  	.remove		= imx_thermal_remove,
>  };
> -module_platform_driver(imx_thermal);
> +
> +static int __init imx_thermal_init(void)
> +{
> +	return platform_driver_register(&imx_thermal);
> +}
> +
> +late_initcall(imx_thermal_init);
> +

Have you considered checking if the cpufreq driver is loaded in your
probe? In case it is not loaded, you may return EPROBE_DEFER.

The problem that I have with the approach above is that it does not have
effect if you are building this driver as a module. Besides, in some
platforms, cpufreq also gets initialized in late phase, when most PM
layers are loaded. Are you sure the cpufreq in your case gets always
loaded before late init calls?

>  MODULE_AUTHOR("Freescale Semiconductor, Inc.");
>  MODULE_DESCRIPTION("Thermal driver for Freescale i.MX SoCs");
> -- 
> 1.9.1
> 
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pm" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
