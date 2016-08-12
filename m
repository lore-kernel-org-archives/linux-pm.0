From: Peter Chen <hzpeterchen@gmail.com>
Subject: Re: [PATCH 3/3] ARM: dts: imx6q-evi: Fix onboard hub reset line
Date: Fri, 12 Aug 2016 11:11:58 +0800
Message-ID: <20160812031158.GH18967@shlinux2>
References: <20160810030254.GD1879@shlinux2>
 <1470933632-22133-1-git-send-email-stillcompiling@gmail.com>
 <1470933632-22133-4-git-send-email-stillcompiling@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1470933632-22133-4-git-send-email-stillcompiling@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Joshua Clayton <stillcompiling@gmail.com>
Cc: Shawn Guo <shawnguo@kernel.org>, gregkh@linuxfoundation.org, stern@rowland.harvard.edu, ulf.hansson@linaro.org, broonie@kernel.org, sre@kernel.org, robh+dt@kernel.org, dbaryshkov@gmail.com, dwmw3@infradead.org, k.kozlowski@samsung.com, linux-arm-kernel@lists.infradead.org, p.zabel@pengutronix.de, devicetree@vger.kernel.org, pawel.moll@arm.com, mark.rutland@arm.com, linux-usb@vger.kernel.org, arnd@arndb.de, s.hauer@pengutronix.de, mail@maciej.szmigiero.name, troy.kisky@boundarydevices.com, festevam@gmail.com, oscar@naiandei.net, stephen.boyd@linaro.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, mka@chromium.org
List-Id: linux-pm@vger.kernel.org

On Thu, Aug 11, 2016 at 09:40:32AM -0700, Joshua Clayton wrote:
> Previously the onboard hub was made to work by treating its
> reset gpio as a regulator enable.
> Get rid of that kludge now that pwseq has added reset gpio support
> Move pin muxing the hub reset pin into the usbh1 group
> 
> Signed-off-by: Joshua Clayton <stillcompiling@gmail.com>
> ---
>  arch/arm/boot/dts/imx6q-evi.dts | 25 +++++++------------------
>  1 file changed, 7 insertions(+), 18 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/imx6q-evi.dts b/arch/arm/boot/dts/imx6q-evi.dts
> index 4fa5601..49c6f61 100644
> --- a/arch/arm/boot/dts/imx6q-evi.dts
> +++ b/arch/arm/boot/dts/imx6q-evi.dts
> @@ -54,18 +54,6 @@
>  		reg = <0x10000000 0x40000000>;
>  	};
>  
> -	reg_usbh1_vbus: regulator-usbhubreset {
> -		compatible = "regulator-fixed";
> -		regulator-name = "usbh1_vbus";
> -		regulator-min-microvolt = <5000000>;
> -		regulator-max-microvolt = <5000000>;
> -		enable-active-high;
> -		startup-delay-us = <2>;
> -		pinctrl-names = "default";
> -		pinctrl-0 = <&pinctrl_usbh1_hubreset>;
> -		gpio = <&gpio7 12 GPIO_ACTIVE_HIGH>;
> -	};
> -
>  	reg_usb_otg_vbus: regulator-usbotgvbus {
>  		compatible = "regulator-fixed";
>  		regulator-name = "usb_otg_vbus";
> @@ -204,12 +192,18 @@
>  };
>  
>  &usbh1 {
> -	vbus-supply = <&reg_usbh1_vbus>;
>  	pinctrl-names = "default";
>  	pinctrl-0 = <&pinctrl_usbh1>;
>  	dr_mode = "host";
>  	disable-over-current;
>  	status = "okay";
> +
> +	usb2415host: hub@1 {
> +		compatible = "usb424,2513";
> +		reg = <1>;
> +		reset-gpios = <&gpio7 12 GPIO_ACTIVE_LOW>;
> +		reset-duration-us = <3000>;
> +	};
>  };
>  
>  &usbotg {
> @@ -467,11 +461,6 @@
>  			MX6QDL_PAD_GPIO_3__USB_H1_OC 0x1b0b0
>  			/* usbh1_b OC */

This comment should be for above pin, do you mind I change it in
this patch?

>  			MX6QDL_PAD_GPIO_0__GPIO1_IO00 0x1b0b0
> -		>;
> -	};
> -
> -	pinctrl_usbh1_hubreset: usbh1hubresetgrp {
> -		fsl,pins = <
>  			MX6QDL_PAD_GPIO_17__GPIO7_IO12 0x1b0b0
>  		>;
>  	};

This changes remind me that I need to change the same thing for udoo
board.

-- 

Best Regards,
Peter Chen
