From: Shawn Guo <shawnguo@kernel.org>
Subject: Re: [PATCH v1 1/3] dt: bindings: add thermal device driver for zx2967
Date: Mon, 9 Jan 2017 10:41:37 +0800
Message-ID: <20170109024136.GJ20956@dragon>
References: <1483767488-19778-1-git-send-email-baoyou.xie@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:42752 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751305AbdAICmO (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Sun, 8 Jan 2017 21:42:14 -0500
Content-Disposition: inline
In-Reply-To: <1483767488-19778-1-git-send-email-baoyou.xie@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Baoyou Xie <baoyou.xie@linaro.org>
Cc: rui.zhang@intel.com, edubezval@gmail.com, robh+dt@kernel.org, mark.rutland@arm.com, jun.nie@linaro.org, gregkh@linuxfoundation.org, davem@davemloft.net, geert+renesas@glider.be, akpm@linux-foundation.org, mchehab@kernel.org, linux@roeck-us.net, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, xie.baoyou@zte.com.cn, chen.chaokai@zte.com.cn, wang.qiang01@zte.com.cn

On Sat, Jan 07, 2017 at 01:38:06PM +0800, Baoyou Xie wrote:
> This patch adds dt-binding documentation for zx2967 family thermal sensor.
> 
> Signed-off-by: Baoyou Xie <baoyou.xie@linaro.org>

The patch subject is inappropriate.  The patch adds a bindings not
device driver.

> ---
>  .../devicetree/bindings/thermal/zx2967-thermal.txt | 22 ++++++++++++++++++++++
>  1 file changed, 22 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/thermal/zx2967-thermal.txt
> 
> diff --git a/Documentation/devicetree/bindings/thermal/zx2967-thermal.txt b/Documentation/devicetree/bindings/thermal/zx2967-thermal.txt
> new file mode 100644
> index 0000000..2633964
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/thermal/zx2967-thermal.txt
> @@ -0,0 +1,22 @@
> +* ZTE zx2967 family Thermal
> +
> +Required Properties:
> +- compatible: should be one of the following.
> +    * zte,zx2967-thermal
> +    * zte,zx296718-thermal

We usually use specific SoC name in compatible string to specify the
programming model for the hardware.  That said, I do not think we need
"zte,zx2967-thermal".

> +- reg: physical base address of the controller and length of memory mapped
> +    region.
> +- clocks : Pairs of phandle and specifier referencing the controller's clocks.
> +- clock-names: "tempsensor_gate" for the topcrm clock.
> +	       "tempsensor_pclk" for the apb clock.

In the context of tempsensor device, the "tempsensor_" in the clock
names are not really necessary.

> +- #thermal-sensor-cells: must be 0.
> +
> +Example:
> +
> +	tempsensor: tempsensor@148a000 {
> +		compatible = "zte,zx2967-thermal";

"zte,zx296718-thermal"

Shawn

> +		reg = <0x0148a000 0x20>;
> +		clocks = <&topcrm TEMPSENSOR_GATE>, <&audiocrm AUDIO_TS_PCLK>;
> +		clock-names = "tempsensor_gate", "tempsensor_pclk";
> +		#thermal-sensor-cells = <0>;
> +	};
> -- 
> 2.7.4
> 
