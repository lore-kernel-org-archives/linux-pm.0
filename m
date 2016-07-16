From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v2 3/6] binding-doc: usb: usb-device: add optional
 properties for power sequence
Date: Sat, 16 Jul 2016 17:31:59 -0500
Message-ID: <20160716223158.GB8984@rob-hp-laptop>
References: <1468375610-18625-1-git-send-email-peter.chen@nxp.com>
 <1468375610-18625-4-git-send-email-peter.chen@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-oi0-f66.google.com ([209.85.218.66]:36138 "EHLO
	mail-oi0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751710AbcGPWcB (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Sat, 16 Jul 2016 18:32:01 -0400
Content-Disposition: inline
In-Reply-To: <1468375610-18625-4-git-send-email-peter.chen@nxp.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Peter Chen <peter.chen@nxp.com>
Cc: gregkh@linuxfoundation.org, stern@rowland.harvard.edu, ulf.hansson@linaro.org, broonie@kernel.org, sre@kernel.org, shawnguo@kernel.org, k.kozlowski@samsung.com, linux-arm-kernel@lists.infradead.org, p.zabel@pengutronix.de, devicetree@vger.kernel.org, pawel.moll@arm.com, mark.rutland@arm.com, linux-usb@vger.kernel.org, arnd@arndb.de, s.hauer@pengutronix.de, mail@maciej.szmigiero.name, troy.kisky@boundarydevices.com, festevam@gmail.com, oscar@naiandei.net, stephen.boyd@linaro.org, linux-pm@vger.kernel.org, stillcompiling@gmail.com

On Wed, Jul 13, 2016 at 10:06:47AM +0800, Peter Chen wrote:
> Add optional properties for power sequence.
> 
> Signed-off-by: Peter Chen <peter.chen@nxp.com>
> ---
>  Documentation/devicetree/bindings/usb/usb-device.txt | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/usb/usb-device.txt b/Documentation/devicetree/bindings/usb/usb-device.txt
> index 1c35e7b..0ccaadf 100644
> --- a/Documentation/devicetree/bindings/usb/usb-device.txt
> +++ b/Documentation/devicetree/bindings/usb/usb-device.txt
> @@ -13,6 +13,10 @@ Required properties:
>  - reg: the port number which this device is connecting to, the range
>    is 1-31.
>  
> +Optional properties:
> +power sequence properties, see
> +Documentation/devicetree/bindings/power/pwrseq/pwrseq-generic.txt for detail
> +
>  Example:
>  
>  &usb1 {
> @@ -24,5 +28,10 @@ Example:
>  	hub: genesys@1 {
>  		compatible = "usb5e3,608";
>  		reg = <1>;
> +
> +		power-sequence;
> +		clocks = <&clks IMX6SX_CLK_CKO>;
> +		reset-gpios = <&gpio4 5 GPIO_ACTIVE_LOW>; /* hub reset pin */
> +		reset-duration-us = <10>;

These belong in the binding doc for the hub.

>  	};
>  }
> -- 
> 1.9.1
> 
> --
> To unsubscribe from this list: send the line "unsubscribe devicetree" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
