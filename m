From: Dong Aisheng <dongas86@gmail.com>
Subject: Re: [PATCH 1/2] ARM: dts: imx7s: add temperature monitor support
Date: Thu, 25 Jan 2018 23:32:30 +0800
Message-ID: <20180125153230.GD24622@b29396-OptiPlex-7040>
References: <1516605949-14663-1-git-send-email-Anson.Huang@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pg0-f66.google.com ([74.125.83.66]:38498 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751105AbeAYPcm (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 25 Jan 2018 10:32:42 -0500
Content-Disposition: inline
In-Reply-To: <1516605949-14663-1-git-send-email-Anson.Huang@nxp.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Anson Huang <Anson.Huang@nxp.com>
Cc: rui.zhang@intel.com, edubezval@gmail.com, robh+dt@kernel.org, mark.rutland@arm.com, shawnguo@kernel.org, kernel@pengutronix.de, fabio.estevam@nxp.com, linux@armlinux.org.uk, ping.bai@nxp.com, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, aisheng.dong@nxp.com, Linux-imx@nxp.com

On Mon, Jan 22, 2018 at 03:25:48PM +0800, Anson Huang wrote:
> Add i.MX7 temperature monitor support.
> 
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
> ---
>  .../devicetree/bindings/thermal/imx-thermal.txt      |  5 +++--
>  arch/arm/boot/dts/imx7s.dtsi                         | 20 ++++++++++++++++++++
>  2 files changed, 23 insertions(+), 2 deletions(-)
> 

Acked-by: Dong Aisheng <aisheng.dong@nxp.com>

Regards
Dong Aisheng

> diff --git a/Documentation/devicetree/bindings/thermal/imx-thermal.txt b/Documentation/devicetree/bindings/thermal/imx-thermal.txt
> index 28be51a..9575d45 100644
> --- a/Documentation/devicetree/bindings/thermal/imx-thermal.txt
> +++ b/Documentation/devicetree/bindings/thermal/imx-thermal.txt
> @@ -1,8 +1,9 @@
>  * Temperature Monitor (TEMPMON) on Freescale i.MX SoCs
>  
>  Required properties:
> -- compatible : "fsl,imx6q-tempmon" for i.MX6Q, "fsl,imx6sx-tempmon" for i.MX6SX.
> -  i.MX6SX has two more IRQs than i.MX6Q, one is IRQ_LOW and the other is IRQ_PANIC,
> +- compatible : "fsl,imx6q-tempmon" for i.MX6Q, "fsl,imx6sx-tempmon" for i.MX6SX,
> +  "fsl,imx7-tempmon" for i.MX7S/D.
> +  i.MX6SX and i.MX7S/D have two more IRQs than i.MX6Q, one is IRQ_LOW and the other is IRQ_PANIC,
>    when temperature is below than low threshold, IRQ_LOW will be triggered, when temperature
>    is higher than panic threshold, system will auto reboot by SRC module.
>  - fsl,tempmon : phandle pointer to system controller that contains TEMPMON
> diff --git a/arch/arm/boot/dts/imx7s.dtsi b/arch/arm/boot/dts/imx7s.dtsi
> index 82ad26e..2e2eda53 100644
> --- a/arch/arm/boot/dts/imx7s.dtsi
> +++ b/arch/arm/boot/dts/imx7s.dtsi
> @@ -497,9 +497,29 @@
>  			};
>  
>  			ocotp: ocotp-ctrl@30350000 {
> +				#address-cells = <1>;
> +				#size-cells = <1>;
>  				compatible = "fsl,imx7d-ocotp", "syscon";
>  				reg = <0x30350000 0x10000>;
>  				clocks = <&clks IMX7D_OCOTP_CLK>;
> +
> +				tempmon_calib: calib@3c {
> +					reg = <0x3c 0x4>;
> +				};
> +
> +				tempmon_temp_grade: temp-grade@10 {
> +					reg = <0x10 0x4>;
> +				};
> +			};
> +
> +			tempmon: tempmon {
> +				compatible = "fsl,imx7-tempmon";
> +				interrupts = <GIC_SPI 49 IRQ_TYPE_LEVEL_HIGH>;
> +				fsl,tempmon =<&anatop>;
> +				nvmem-cells = <&tempmon_calib>,
> +					<&tempmon_temp_grade>;
> +				nvmem-cell-names = "calib", "temp_grade";
> +				clocks = <&clks IMX7D_PLL_SYS_MAIN_CLK>;
>  			};
>  
>  			anatop: anatop@30360000 {
> -- 
> 2.7.4
> 
