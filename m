From: Leo Yan <leo.yan@linaro.org>
Subject: Re: [PATCH v5 1/3] dt-bindings: Document the hi6220 thermal sensor
 bindings
Date: Wed, 20 May 2015 09:06:48 +0800
Message-ID: <20150520010648.GA18345@leoy-linaro>
References: <1431933109-22764-1-git-send-email-kong.kongxinwei@hisilicon.com>
 <1431933109-22764-2-git-send-email-kong.kongxinwei@hisilicon.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pd0-f169.google.com ([209.85.192.169]:35621 "EHLO
	mail-pd0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751922AbbETBHI (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 19 May 2015 21:07:08 -0400
Received: by pdea3 with SMTP id a3so47454356pde.2
        for <linux-pm@vger.kernel.org>; Tue, 19 May 2015 18:07:07 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1431933109-22764-2-git-send-email-kong.kongxinwei@hisilicon.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Xinwei Kong <kong.kongxinwei@hisilicon.com>
Cc: edubezval@gmail.com, rui.zhuang@intel.com, amit.kucheria@linaro.org, punit.agrawal@arm.com, Javi.Merino@arm.com, jorge.ramirez-ortiz@linaro.org, haojian.zhuang@linaro.org, linux-pm@vger.kernel.org, dan.zhao@hisilicon.com, devicetree@vger.kernel.org, gongyu@hisilicon.com, guodong.xu@linaro.org, robh@kernel.org, mark.rutland@arm.com, linuxarm@huawei.com, zhenwei.wang@hisilicon.com, mporter@konsulko.com, zhangfei.gao@linaro.org, liguozhu@hisilicon.com

On Mon, May 18, 2015 at 03:11:47PM +0800, Xinwei Kong wrote:
> From: kongxinwei <kong.kongxinwei@hisilicon.com>
> 
> This adds documentation of device tree bindings for the
> thermal sensor controller of hi6220 SoC.
> 
> Signed-off-by: Leo Yan <leo.yan@linaro.org>
> Signed-off-by: kongxinwei <kong.kongxinwei@hisilicon.com>
> ---
>  .../bindings/thermal/hisilicon-thermal.txt         | 23 ++++++++++++++++++++++
>  1 file changed, 23 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/thermal/hisilicon-thermal.txt
> 
> diff --git a/Documentation/devicetree/bindings/thermal/hisilicon-thermal.txt b/Documentation/devicetree/bindings/thermal/hisilicon-thermal.txt
> new file mode 100644
> index 0000000..b2a349f
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/thermal/hisilicon-thermal.txt
> @@ -0,0 +1,23 @@
> +* Temperature Sensor on hisilicon SoCs
> +
> +** Required properties :
> +
> +- compatible: "hisilicon,tsensor".
> +- reg: physical base address of thermal sensor and length of memory mapped
> +  region.
> +- interrupt: The interrupt number to the cpu. Defines the interrupt used
> +  by SOCTHERM.

s/SOCTHERM/tsensor/

> +- clock-names: Input clock name, should be 'thermal_clk'.
> +- clocks: phandles for clock specified in "clock-names" property.
> +- #thermal-sensor-cells: Should be 1. See ./thermal.txt for a description.
> +
> +Example :
> +
> +	tsensor: tsensor@0,f7030700 {
> +		compatible = "hisilicon,tsensor";
> +		reg = <0x0 0xf7030700 0x0 0x1000>;
> +		interrupts = <0 7 0x4>;
> +		clocks = <&clock_sys HI6220_TSENSOR_CLK>;
> +		clock-names = "thermal_clk";
> +		#thermal-sensor-cells = <1>;
> +	}
> -- 
> 1.9.1
> 
> 
