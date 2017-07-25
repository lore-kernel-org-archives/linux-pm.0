From: Shawn Guo <shawnguo@kernel.org>
Subject: Re: [PATCH v2 4/5] ARM: dts: imx6sx: Use nvmem-cells for tempmon
Date: Tue, 25 Jul 2017 16:11:33 +0800
Message-ID: <20170725081131.GE20064@dragon>
References: <cover.1500041281.git.leonard.crestez@nxp.com>
 <3cda26e557510055f05cea92b81678743e0ea9e3.1500041281.git.leonard.crestez@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:41844 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750757AbdGYIMU (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 25 Jul 2017 04:12:20 -0400
Content-Disposition: inline
In-Reply-To: <3cda26e557510055f05cea92b81678743e0ea9e3.1500041281.git.leonard.crestez@nxp.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Leonard Crestez <leonard.crestez@nxp.com>
Cc: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, Rob Herring <robh+dt@kernel.org>, Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>, Mark Rutland <mark.rutland@arm.com>, Lothar =?iso-8859-1?Q?Wa=DFmann?= <LW@KARO-electronics.de>, Dong Aisheng <aisheng.dong@nxp.com>, Bai Ping <ping.bai@nxp.com>, Anson Huang <Anson.Huang@nxp.com>, Octavian Purdila <octavian.purdila@nxp.com>, Fabio Estevam <fabio.estevam@nxp.com>, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org

On Fri, Jul 14, 2017 at 05:11:09PM +0300, Leonard Crestez wrote:
> On imx6sx accessing OCOTP directly is wrong because the ocotp clock
> needs to be enabled first. Use the nvmem-cells binding instead.
> 
> This requirement does not apply to older imx6qdl chips because there the
> ocotp access clock (clk_ipg_s) is always enabled.
> 
> This is visible by comparing the "System Clocks, Gating, and Override"
> tables (OCOTP rows) in the 6DQ and 6SX manuals:
> http://www.nxp.com/assets/documents/data/en/reference-manuals/IMX6SXRM.pdf
> http://www.nxp.com/assets/documents/data/en/reference-manuals/IMX6DQRM.pdf
> 
> This happens to work right now because the ocotp clock might be enabled
> for some other reason. In particular the it might be enabled from the
> bootloader and it only gets disabled late during boot in
> clk_disable_unused, after imx-thermal has completed probing.
> 
> If imx-thermal is compiled as a module then the system can hang on
> probe.
> 
> Reported-by: Lothar Waﬂmann <LW@KARO-electronics.de>
> Signed-off-by: Leonard Crestez <leonard.crestez@nxp.com>

I cannot apply dts changes until the driver part gets landed on
mainline.  Please remind me when dts patches can be applied.

Shawn

> ---
>  arch/arm/boot/dts/imx6sx.dtsi | 13 ++++++++++++-
>  1 file changed, 12 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm/boot/dts/imx6sx.dtsi b/arch/arm/boot/dts/imx6sx.dtsi
> index f16b9df..580af30 100644
> --- a/arch/arm/boot/dts/imx6sx.dtsi
> +++ b/arch/arm/boot/dts/imx6sx.dtsi
> @@ -675,7 +675,8 @@
>  				compatible = "fsl,imx6sx-tempmon", "fsl,imx6q-tempmon";
>  				interrupts = <GIC_SPI 49 IRQ_TYPE_LEVEL_HIGH>;
>  				fsl,tempmon = <&anatop>;
> -				fsl,tempmon-data = <&ocotp>;
> +				nvmem-cells = <&tempmon_calib>, <&tempmon_temp_grade>;
> +				nvmem-cell-names = "calib", "temp_grade";
>  				clocks = <&clks IMX6SX_CLK_PLL3_USB_OTG>;
>  			};
>  
> @@ -993,9 +994,19 @@
>  			};
>  
>  			ocotp: ocotp@021bc000 {
> +				#address-cells = <1>;
> +				#size-cells = <1>;
>  				compatible = "fsl,imx6sx-ocotp", "syscon";
>  				reg = <0x021bc000 0x4000>;
>  				clocks = <&clks IMX6SX_CLK_OCOTP>;
> +
> +				tempmon_calib: calib@38 {
> +					reg = <0x38 4>;
> +				};
> +
> +				tempmon_temp_grade: temp-grade@20 {
> +					reg = <0x20 4>;
> +				};
>  			};
>  
>  			sai1: sai@021d4000 {
> -- 
> 2.7.4
> 
