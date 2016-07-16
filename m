From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v2 1/6] binding-doc: power: pwrseq-generic: add binding
 doc for generic power sequence library
Date: Sat, 16 Jul 2016 17:30:57 -0500
Message-ID: <20160716223057.GA8984@rob-hp-laptop>
References: <1468375610-18625-1-git-send-email-peter.chen@nxp.com>
 <1468375610-18625-2-git-send-email-peter.chen@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-oi0-f65.google.com ([209.85.218.65]:33568 "EHLO
	mail-oi0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751698AbcGPWbA (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Sat, 16 Jul 2016 18:31:00 -0400
Content-Disposition: inline
In-Reply-To: <1468375610-18625-2-git-send-email-peter.chen@nxp.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Peter Chen <peter.chen@nxp.com>
Cc: gregkh@linuxfoundation.org, stern@rowland.harvard.edu, ulf.hansson@linaro.org, broonie@kernel.org, sre@kernel.org, shawnguo@kernel.org, mark.rutland@arm.com, devicetree@vger.kernel.org, k.kozlowski@samsung.com, stephen.boyd@linaro.org, oscar@naiandei.net, arnd@arndb.de, pawel.moll@arm.com, linux-pm@vger.kernel.org, s.hauer@pengutronix.de, linux-usb@vger.kernel.org, mail@maciej.szmigiero.name, troy.kisky@boundarydevices.com, stillcompiling@gmail.com, p.zabel@pengutronix.de, festevam@gmail.com, linux-arm-kernel@lists.infradead.org

On Wed, Jul 13, 2016 at 10:06:45AM +0800, Peter Chen wrote:
> Add binding doc for generic power sequence library.

I'd written a review on last version, but forgot to send it out. Anyway, 
I mostly had the same comments as Philipp and Joshua. A couple of things 
they missed...

> 
> Signed-off-by: Peter Chen <peter.chen@nxp.com>
> ---
>  .../bindings/power/pwrseq/pwrseq-generic.txt       | 53 ++++++++++++++++++++++
>  1 file changed, 53 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/power/pwrseq/pwrseq-generic.txt
> 
> diff --git a/Documentation/devicetree/bindings/power/pwrseq/pwrseq-generic.txt b/Documentation/devicetree/bindings/power/pwrseq/pwrseq-generic.txt
> new file mode 100644
> index 0000000..186c58c
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/power/pwrseq/pwrseq-generic.txt
> @@ -0,0 +1,53 @@
> +The generic power sequence library
> +
> +Some hard-wired USB/MMC devices need to do power sequence to let the
> +device work normally, the typical power sequence like: enable USB
> +PHY clock, toggle reset pin, etc. But current Linux USB driver
> +lacks of such code to do it, it may cause some hard-wired USB devices
> +works abnormal or can't be recognized by controller at all. The
> +power sequence will be done before this device can be found at USB
> +bus.
> +
> +The power sequence properties is under the device node.
> +
> +Required properties:
> +- power-sequence: this device needs to do power sequence before enumeration
> +
> +Optional properties:
> +- clocks: the input clock for device.
> +- reset-gpios: Should specify the GPIO for reset.
> +- reset-duration-us: the duration in microsecond for assert reset signal.
> +
> +Below is the example of USB power sequence properties on USB device
> +nodes which have two level USB hubs.
> +
> +&usbotg1 {
> +	vbus-supply = <&reg_usb_otg1_vbus>;
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_usb_otg1_id>;
> +	status = "okay";
> +
> +	#address-cells = <1>;
> +	#size-cells = <0>;
> +	hub: genesys@1 {

genesys: hub@1

> +		compatible = "usb5e3,608";
> +		reg = <1>;
> +
> +		power-sequence;
> +		clocks = <&clks IMX6SX_CLK_CKO>;
> +		reset-gpios = <&gpio4 5 GPIO_ACTIVE_LOW>; /* hub reset pin */
> +		reset-duration-us = <10>;
> +
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +		ethernet: asix@1 {

asix: ethernet@1

> +			compatible = "usbb95,1708";
> +			reg = <1>;
> +
> +			power-sequence;
> +			clocks = <&clks IMX6SX_CLK_IPG>;
> +			reset-gpios = <&gpio4 6 GPIO_ACTIVE_LOW>; /* ethernet_rst */
> +			reset-duration-us = <15>;
> +		};
> +	};
> +};
> -- 
> 1.9.1
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
