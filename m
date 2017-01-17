From: Eduardo Valentin <edubezval@gmail.com>
Subject: Re: [PATCH v4 1/3] dt: bindings: add documentation for zx2967 family
 thermal sensor
Date: Mon, 16 Jan 2017 21:27:00 -0800
Message-ID: <20170117052658.GA3246@localhost.localdomain>
References: <1484304418-17489-1-git-send-email-baoyou.xie@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pg0-f65.google.com ([74.125.83.65]:34905 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750880AbdAQF1I (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 17 Jan 2017 00:27:08 -0500
Content-Disposition: inline
In-Reply-To: <1484304418-17489-1-git-send-email-baoyou.xie@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Baoyou Xie <baoyou.xie@linaro.org>
Cc: rui.zhang@intel.com, jun.nie@linaro.org, gregkh@linuxfoundation.org, davem@davemloft.net, geert+renesas@glider.be, akpm@linux-foundation.org, mchehab@kernel.org, linux@roeck-us.net, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, shawnguo@kernel.org, xie.baoyou@zte.com.cn, chen.chaokai@zte.com.cn, wang.qiang01@zte.com.cn

Hey,

On Fri, Jan 13, 2017 at 06:46:56PM +0800, Baoyou Xie wrote:
> This patch adds dt-binding documentation for zx2967 family thermal sensor.
> 
> Signed-off-by: Baoyou Xie <baoyou.xie@linaro.org>
> Acked-by: Rob Herring <robh@kernel.org>
> Reviewed-by: Shawn Guo <shawnguo@kernel.org>
> ---
>  .../devicetree/bindings/thermal/zx2967-thermal.txt  | 21 +++++++++++++++++++++
>  1 file changed, 21 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/thermal/zx2967-thermal.txt
> 
> diff --git a/Documentation/devicetree/bindings/thermal/zx2967-thermal.txt b/Documentation/devicetree/bindings/thermal/zx2967-thermal.txt
> new file mode 100644
> index 0000000..86f941c
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/thermal/zx2967-thermal.txt
> @@ -0,0 +1,21 @@
> +* ZTE zx2967 family Thermal
> +
> +Required Properties:
> +- compatible: should be one of the following.
> +    * zte,zx296718-thermal
> +- reg: physical base address of the controller and length of memory mapped
> +    region.
> +- clocks : Pairs of phandle and specifier referencing the controller's clocks.
> +- clock-names: "gate" for the topcrm clock.
> +	       "pclk" for the apb clock.
> +- #thermal-sensor-cells: must be 0.
> +
> +Example:
> +
> +	tempsensor: tempsensor@148a000 {
> +		compatible = "zte,zx296718-thermal";
> +		reg = <0x0148a000 0x20>;
> +		clocks = <&topcrm TEMPSENSOR_GATE>, <&audiocrm AUDIO_TS_PCLK>;
> +		clock-names = "gate", "pclk";
> +		#thermal-sensor-cells = <0>;
> +	};

Given that you are using of-thermal, would be welcome if you include an
example on how to deploy a thermal zone with your tempsensor entry.

> -- 
> 2.7.4
> 
