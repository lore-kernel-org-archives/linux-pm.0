From: Shawn Guo <shawn.guo@linaro.org>
Subject: Re: [PATCH] thermal: imx_thermal: add module device table
Date: Tue, 17 Dec 2013 10:57:39 +0800
Message-ID: <20131217025737.GD6691@S2101-09.ap.freescale.net>
References: <E1Vsg3A-0008Q1-9O@rmk-PC.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from tx2ehsobe003.messaging.microsoft.com ([65.55.88.13]:41006 "EHLO
	tx2outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751169Ab3LQC5D (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 16 Dec 2013 21:57:03 -0500
Content-Disposition: inline
In-Reply-To: <E1Vsg3A-0008Q1-9O@rmk-PC.arm.linux.org.uk>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Russell King <rmk+kernel@arm.linux.org.uk>
Cc: Sascha Hauer <kernel@pengutronix.de>, linux-arm-kernel@lists.infradead.org, Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <eduardo.valentin@ti.com>, linux-pm@vger.kernel.org

On Mon, Dec 16, 2013 at 09:50:04PM +0000, Russell King wrote:
> Add the module device table declaration so the module can be loaded
> automatically at boot time.
> 
> Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>

Acked-by: Shawn Guo <shawn.guo@linaro.org>

> ---
>  drivers/thermal/imx_thermal.c |    1 +
>  1 files changed, 1 insertions(+), 0 deletions(-)
> 
> diff --git a/drivers/thermal/imx_thermal.c b/drivers/thermal/imx_thermal.c
> index 1d6c801c1eb9..230864886775 100644
> --- a/drivers/thermal/imx_thermal.c
> +++ b/drivers/thermal/imx_thermal.c
> @@ -522,6 +522,7 @@ static const struct of_device_id of_imx_thermal_match[] = {
>  	{ .compatible = "fsl,imx6q-tempmon", },
>  	{ /* end */ }
>  };
> +MODULE_DEVICE_TABLE(of, of_imx_thermal_match);
>  
>  static struct platform_driver imx_thermal = {
>  	.driver = {
> -- 
> 1.7.4.4
> 

