From: Shawn Guo <shawn.guo@linaro.org>
Subject: Re: [PATCH 1/1] dt-bindings: thermal: imx: update the binding to new
 method
Date: Mon, 29 Jan 2018 09:48:57 +0800
Message-ID: <20180129014855.GA12957@dragon>
References: <1516862269-25543-1-git-send-email-aisheng.dong@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pf0-f193.google.com ([209.85.192.193]:45955 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752301AbeA2Bt2 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 28 Jan 2018 20:49:28 -0500
Received: by mail-pf0-f193.google.com with SMTP id a88so3509880pfe.12
        for <linux-pm@vger.kernel.org>; Sun, 28 Jan 2018 17:49:28 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1516862269-25543-1-git-send-email-aisheng.dong@nxp.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Dong Aisheng <aisheng.dong@nxp.com>
Cc: linux-pm@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-imx@nxp.com, Leonard Crestez <leonard.crestez@nxp.com>, Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>

On Thu, Jan 25, 2018 at 02:37:49PM +0800, Dong Aisheng wrote:
> Due to the old method has already been marked as deprecated in binding
> doc, so obviously it's better to update the example to new bindings
> as well.
> 
> Cc: Shawn Guo <shawn.guo@linaro.org>

Acked-by: Shawn Guo <shawnguo@kernel.org>

Please use my kernel.org address for kernel patches.

Shawn

> Cc: Leonard Crestez <leonard.crestez@nxp.com>
> Cc: Zhang Rui <rui.zhang@intel.com>
> Cc: Eduardo Valentin <edubezval@gmail.com>
> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>
> ---
>  .../devicetree/bindings/thermal/imx-thermal.txt    | 25 ++++++++++++++++++++++
>  1 file changed, 25 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/thermal/imx-thermal.txt b/Documentation/devicetree/bindings/thermal/imx-thermal.txt
> index 28be51a..379eb76 100644
> --- a/Documentation/devicetree/bindings/thermal/imx-thermal.txt
> +++ b/Documentation/devicetree/bindings/thermal/imx-thermal.txt
> @@ -22,7 +22,32 @@ Optional properties:
>  - clocks : thermal sensor's clock source.
>  
>  Example:
> +ocotp: ocotp@21bc000 {
> +	#address-cells = <1>;
> +	#size-cells = <1>;
> +	compatible = "fsl,imx6sx-ocotp", "syscon";
> +	reg = <0x021bc000 0x4000>;
> +	clocks = <&clks IMX6SX_CLK_OCOTP>;
>  
> +	tempmon_calib: calib@38 {
> +		reg = <0x38 4>;
> +	};
> +
> +	tempmon_temp_grade: temp-grade@20 {
> +		reg = <0x20 4>;
> +	};
> +};
> +
> +tempmon: tempmon {
> +	compatible = "fsl,imx6sx-tempmon", "fsl,imx6q-tempmon";
> +	interrupts = <GIC_SPI 49 IRQ_TYPE_LEVEL_HIGH>;
> +	fsl,tempmon = <&anatop>;
> +	nvmem-cells = <&tempmon_calib>, <&tempmon_temp_grade>;
> +	nvmem-cell-names = "calib", "temp_grade";
> +	clocks = <&clks IMX6SX_CLK_PLL3_USB_OTG>;
> +};
> +
> +Legacy method (Deprecated):
>  tempmon {
>  	compatible = "fsl,imx6q-tempmon";
>  	fsl,tempmon = <&anatop>;
> -- 
> 2.7.4
> 
> --
> To unsubscribe from this list: send the line "unsubscribe devicetree" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
