From: Shawn Guo <shawn.guo@freescale.com>
Subject: Re: [PATCH v2 1/3] ARM: dts: imx6: add pm_power_off support for
 i.mx6 chips
Date: Wed, 17 Sep 2014 10:10:45 +0800
Message-ID: <20140917021044.GD4796@dragon>
References: <1410511739-31122-1-git-send-email-b38343@freescale.com>
 <1410511739-31122-2-git-send-email-b38343@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-bn1on0116.outbound.protection.outlook.com ([157.56.110.116]:32736
	"EHLO na01-bn1-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1753575AbaIQCLD (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Tue, 16 Sep 2014 22:11:03 -0400
Content-Disposition: inline
In-Reply-To: <1410511739-31122-2-git-send-email-b38343@freescale.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Robin Gong <b38343@freescale.com>
Cc: robh+dt@kernel.org, pawel.moll@arm.com, mark.rutland@arm.com, ijc+devicetree@hellion.org.uk, galak@codeaurora.org, kernel@pengutronix.de, sre@kernel.org, dbaryshkov@gmail.com, dwmw2@infradead.org, grant.likely@linaro.org, linux@arm.linux.org.uk, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Fri, Sep 12, 2014 at 04:48:57PM +0800, Robin Gong wrote:
> All chips of i.mx6 can be powered off by programming SNVS.
> For example :
> On i.mx6q-sabresd board, PMIC_ON_REQ connect with external
> pmic ON/OFF pin, that will cause the whole PMIC powered off
> except VSNVS. And system can restart once PMIC_ON_REQ goes
> high by push POWRER key.

What's the behavior for those boards on which PMIC_ON_REQ isn't
connected to anywhere?

BTW, the commit log of the driver patch [[PATCH v2 2/3] ] should be
improved.

Shawn

> 
> Signed-off-by: Robin Gong <b38343@freescale.com>
> ---
>  .../bindings/power_supply/imx-snvs-poweroff.txt     | 21 +++++++++++++++++++++
>  arch/arm/boot/dts/imx6qdl.dtsi                      |  5 +++++
>  arch/arm/boot/dts/imx6sl.dtsi                       |  5 +++++
>  arch/arm/boot/dts/imx6sx.dtsi                       |  5 +++++
>  4 files changed, 36 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/power_supply/imx-snvs-poweroff.txt
> 
> diff --git a/Documentation/devicetree/bindings/power_supply/imx-snvs-poweroff.txt b/Documentation/devicetree/bindings/power_supply/imx-snvs-poweroff.txt
> new file mode 100644
> index 0000000..1a3ab9a
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/power_supply/imx-snvs-poweroff.txt
> @@ -0,0 +1,21 @@
> +i.mx6 Poweroff Driver
> +
> +SNVS_LPCR in SNVS module can power off the whole system by pull
> +PMIC_ON_REQ low.
> +
> +Required Properties:
> +-compatible: "fsl,sec-v4.0-poweroff"
> +-reg: Specifies the physical address of the SNVS_LPCR register
> +
> +Example:
> +	snvs@020cc000 {
> +		compatible = "fsl,sec-v4.0-mon", "simple-bus";
> +		#address-cells = <1>;
> +		#size-cells = <1>;
> +		ranges = <0 0x020cc000 0x4000>;
> +		.....
> +		snvs-poweroff@38 {
> +			compatible = "fsl,sec-v4.0-poweroff";
> +			reg = <0x38 0x4>;
> +		};
> +	}
> diff --git a/arch/arm/boot/dts/imx6qdl.dtsi b/arch/arm/boot/dts/imx6qdl.dtsi
> index 70d7207..d2d7563 100644
> --- a/arch/arm/boot/dts/imx6qdl.dtsi
> +++ b/arch/arm/boot/dts/imx6qdl.dtsi
> @@ -650,6 +650,11 @@
>  					interrupts = <0 19 IRQ_TYPE_LEVEL_HIGH>,
>  						     <0 20 IRQ_TYPE_LEVEL_HIGH>;
>  				};
> +
> +				snvs-poweroff@38 {
> +					compatible = "fsl,sec-v4.0-poweroff";
> +					reg = <0x38 0x4>;
> +				};
>  			};
>  
>  			epit1: epit@020d0000 { /* EPIT1 */
> diff --git a/arch/arm/boot/dts/imx6sl.dtsi b/arch/arm/boot/dts/imx6sl.dtsi
> index ba67714..6e1d8f6 100644
> --- a/arch/arm/boot/dts/imx6sl.dtsi
> +++ b/arch/arm/boot/dts/imx6sl.dtsi
> @@ -568,6 +568,11 @@
>  					interrupts = <0 19 IRQ_TYPE_LEVEL_HIGH>,
>  						     <0 20 IRQ_TYPE_LEVEL_HIGH>;
>  				};
> +
> +				snvs-poweroff@38 {
> +					compatible = "fsl,sec-v4.0-poweroff";
> +					reg = <0x38 0x4>;
> +				};
>  			};
>  
>  			epit1: epit@020d0000 {
> diff --git a/arch/arm/boot/dts/imx6sx.dtsi b/arch/arm/boot/dts/imx6sx.dtsi
> index d137caca..c1f937e 100644
> --- a/arch/arm/boot/dts/imx6sx.dtsi
> +++ b/arch/arm/boot/dts/imx6sx.dtsi
> @@ -671,6 +671,11 @@
>  					reg = <0x34 0x58>;
>  					interrupts = <GIC_SPI 19 IRQ_TYPE_LEVEL_HIGH>, <GIC_SPI 20 IRQ_TYPE_LEVEL_HIGH>;
>  				};
> +
> +				snvs-poweroff@38 {
> +					compatible = "fsl,sec-v4.0-poweroff";
> +					reg = <0x38 0x4>;
> +				};
>  			};
>  
>  			epit1: epit@020d0000 {
> -- 
> 1.9.1
> 
