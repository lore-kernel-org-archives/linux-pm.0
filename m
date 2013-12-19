From: Shawn Guo <shawn.guo@linaro.org>
Subject: Re: [PATCH 3/3] thermal: imx: add clk info for thermal sensor
Date: Thu, 19 Dec 2013 14:57:06 +0800
Message-ID: <20131219065704.GA6691@S2101-09.ap.freescale.net>
References: <1387477045-19037-1-git-send-email-b20788@freescale.com>
 <1387477045-19037-3-git-send-email-b20788@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from tx2ehsobe002.messaging.microsoft.com ([65.55.88.12]:30369 "EHLO
	tx2outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751723Ab3LSG4H (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 19 Dec 2013 01:56:07 -0500
Content-Disposition: inline
In-Reply-To: <1387477045-19037-3-git-send-email-b20788@freescale.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Anson Huang <b20788@freescale.com>
Cc: kernel@pengutronix.de, rui.zhang@intel.com, eduardo.valentin@ti.com, devicetree@vger.kernel.org, linux-doc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org

On Thu, Dec 19, 2013 at 01:17:25PM -0500, Anson Huang wrote:
> thermal sensor needs dedicated clock to work in correct way,
> so we need to add necessary clock info in dts.
> 
> Signed-off-by: Anson Huang <b20788@freescale.com>
> ---
>  .../devicetree/bindings/thermal/imx-thermal.txt    |    2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/thermal/imx-thermal.txt b/Documentation/devicetree/bindings/thermal/imx-thermal.txt
> index 541c25e..e518c6e 100644
> --- a/Documentation/devicetree/bindings/thermal/imx-thermal.txt
> +++ b/Documentation/devicetree/bindings/thermal/imx-thermal.txt
> @@ -7,6 +7,7 @@ Required properties:
>  - fsl,tempmon-data : phandle pointer to fuse controller that contains TEMPMON
>    calibration data, e.g. OCOTP on imx6q.  The details about calibration data
>    can be found in SoC Reference Manual.
> +- clocks : thermal sensor's clock source.

For such binding update, it can just be merged into driver patch.  Also,
it has to be an optional property.  See my reply to the driver patch.

Shawn

>  
>  Example:
>  
> @@ -14,4 +15,5 @@ tempmon {
>  	compatible = "fsl,imx6q-tempmon";
>  	fsl,tempmon = <&anatop>;
>  	fsl,tempmon-data = <&ocotp>;
> +	clocks = <&clks 172>;
>  };
> -- 
> 1.7.9.5
> 
> 

