From: Shawn Guo <shawn.guo@linaro.org>
Subject: Re: [PATCH] thermal: imx_thermal: add module device table
Date: Thu, 31 Oct 2013 16:03:30 +0800
Message-ID: <20131031080328.GJ23549@S2101-09.ap.freescale.net>
References: <E1VbfcJ-0003g5-SK@rmk-PC.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from co9ehsobe004.messaging.microsoft.com ([207.46.163.27]:56154
	"EHLO co9outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751668Ab3JaIDW (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 31 Oct 2013 04:03:22 -0400
Content-Disposition: inline
In-Reply-To: <E1VbfcJ-0003g5-SK@rmk-PC.arm.linux.org.uk>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Russell King <rmk+kernel@arm.linux.org.uk>
Cc: linux-arm-kernel@lists.infradead.org, Sascha Hauer <kernel@pengutronix.de>, Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <eduardo.valentin@ti.com>, linux-pm@vger.kernel.org

On Wed, Oct 30, 2013 at 11:56:03PM +0000, Russell King wrote:
> Add the module device table declaration so the module can be loaded
> automatically at boot time.
> 
> Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
> ---
>  drivers/thermal/imx_thermal.c |    1 +
>  1 files changed, 1 insertions(+), 0 deletions(-)
> 
> diff --git a/drivers/thermal/imx_thermal.c b/drivers/thermal/imx_thermal.c
> index 1d6c801c1eb9..ab31552f0360 100644
> --- a/drivers/thermal/imx_thermal.c
> +++ b/drivers/thermal/imx_thermal.c
> @@ -539,3 +539,4 @@ MODULE_AUTHOR("Freescale Semiconductor, Inc.");
>  MODULE_DESCRIPTION("Thermal driver for Freescale i.MX SoCs");
>  MODULE_LICENSE("GPL v2");
>  MODULE_ALIAS("platform:imx-thermal");
> +MODULE_DEVICE_TABLE(of, of_imx_thermal_match);

Can you move it right below of_imx_thermal_match definition?  Otherwise,

Acked-by: Shawn Guo <shawn.guo@linaro.org>

> -- 
> 1.7.4.4
> 

