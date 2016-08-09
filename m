From: Joshua Clayton <stillcompiling@gmail.com>
Subject: Re: [PATCH v5 6/6] ARM: dts: imx6qdl-udoo.dtsi: fix onboard USB HUB
 property
Date: Tue, 9 Aug 2016 16:33:35 -0700
Message-ID: <57AA684F.4020004@gmail.com>
References: <1470646331-23227-1-git-send-email-peter.chen@nxp.com>
 <1470646331-23227-7-git-send-email-peter.chen@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1470646331-23227-7-git-send-email-peter.chen@nxp.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Chen <peter.chen@nxp.com>, gregkh@linuxfoundation.org, stern@rowland.harvard.edu, ulf.hansson@linaro.org, broonie@kernel.org, sre@kernel.org, robh+dt@kernel.org, shawnguo@kernel.org, dbaryshkov@gmail.com, dwmw3@infradead.org
Cc: k.kozlowski@samsung.com, linux-arm-kernel@lists.infradead.org, p.zabel@pengutronix.de, devicetree@vger.kernel.org, pawel.moll@arm.com, mark.rutland@arm.com, linux-usb@vger.kernel.org, arnd@arndb.de, s.hauer@pengutronix.de, mail@maciej.szmigiero.name, troy.kisky@boundarydevices.com, festevam@gmail.com, oscar@naiandei.net, stephen.boyd@linaro.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, mka@chromium.org
List-Id: linux-pm@vger.kernel.org

Hi Peter,

On 08/08/2016 01:52 AM, Peter Chen wrote:
> The current dts describes USB HUB's property at USB controller's
> entry, it is improper. The USB HUB should be the child node
> under USB controller, and power sequence properties are under
> it.
>
> Signed-off-by: Peter Chen <peter.chen@nxp.com>
> ---
>  arch/arm/boot/dts/imx6qdl-udoo.dtsi | 26 +++++++++++++-------------
>  1 file changed, 13 insertions(+), 13 deletions(-)
>
> diff --git a/arch/arm/boot/dts/imx6qdl-udoo.dtsi b/arch/arm/boot/dts/imx6qdl-udoo.dtsi
> index 3bee2f9..f29a72c2f 100644
> --- a/arch/arm/boot/dts/imx6qdl-udoo.dtsi
> +++ b/arch/arm/boot/dts/imx6qdl-udoo.dtsi
> @@ -9,6 +9,8 @@
>   *
>   */
>  
> +#include <dt-bindings/gpio/gpio.h>
> +
>  / {
>  	aliases {
>  		backlight = &backlight;
> @@ -58,17 +60,6 @@
>  		#address-cells = <1>;
>  		#size-cells = <0>;
>  
> -		reg_usb_h1_vbus: regulator@0 {
> -			compatible = "regulator-fixed";
> -			reg = <0>;
> -			regulator-name = "usb_h1_vbus";
> -			regulator-min-microvolt = <5000000>;
> -			regulator-max-microvolt = <5000000>;
> -			enable-active-high;
> -			startup-delay-us = <2>; /* USB2415 requires a POR of 1 us minimum */
> -			gpio = <&gpio7 12 0>;
> -		};
> -
>  		reg_panel: regulator@1 {
>  			compatible = "regulator-fixed";
>  			reg = <1>;
> @@ -259,9 +250,18 @@
>  &usbh1 {
>  	pinctrl-names = "default";
>  	pinctrl-0 = <&pinctrl_usbh>;
> -	vbus-supply = <&reg_usb_h1_vbus>;
> -	clocks = <&clks IMX6QDL_CLK_CKO>;
>  	status = "okay";
> +
> +	#address-cells = <1>;
> +	#size-cells = <0>;
Assuming they are needed,
#address-cells and #size-cells should go in imx6qdl.dtsi,
rather than in board dts files, shouldn't they?
> +	usb2415: hub@1 {
> +		compatible = "usb424,2514";
> +		reg = <1>;
Does <reg>  have any effect?
I couldn't find any reference to it in the patches.
(so apologies if it is in core code)
Does it matter? Would it be possible to connect
more than one hub to the same usb phy?
> +
> +		clocks = <&clks IMX6QDL_CLK_CKO>;
> +		reset-gpios = <&gpio7 12 GPIO_ACTIVE_LOW>;
> +		reset-duration-us = <3000>;
> +	};
>  };
>  
>  &usdhc3 {
