From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v3 7/7] doc: bindings: act8945a-charger: Update properties
Date: Fri, 29 Jul 2016 16:40:20 -0500
Message-ID: <20160729214020.GA18140@rob-hp-laptop>
References: <1469755528-8413-1-git-send-email-wenyou.yang@atmel.com>
 <1469755528-8413-8-git-send-email-wenyou.yang@atmel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-oi0-f67.google.com ([209.85.218.67]:36773 "EHLO
	mail-oi0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751640AbcG2VkW (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 29 Jul 2016 17:40:22 -0400
Content-Disposition: inline
In-Reply-To: <1469755528-8413-8-git-send-email-wenyou.yang@atmel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Wenyou Yang <wenyou.yang@atmel.com>
Cc: Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, Pawel Moll <pawel.moll@arm.com>, Mark Brown <broonie@kernel.org>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Nicolas Ferre <nicolas.ferre@atmel.com>, linux-pm@vger.kernel.org

On Fri, Jul 29, 2016 at 09:25:28AM +0800, Wenyou Yang wrote:
> Due the driver improvements, update the properties,
>  - Remove "active-semi,check-battery-temperature" property.
>  - Add the properties, "active-semi,irq_gpio"
>    and "active-semi,lbo-gpios".
> 
> Signed-off-by: Wenyou Yang <wenyou.yang@atmel.com>
> ---
> 
> Changes in v3: None
> Changes in v2: None
> 
>  Documentation/devicetree/bindings/power/act8945a-charger.txt | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/power/act8945a-charger.txt b/Documentation/devicetree/bindings/power/act8945a-charger.txt
> index bea254c..d7cf05b 100644
> --- a/Documentation/devicetree/bindings/power/act8945a-charger.txt
> +++ b/Documentation/devicetree/bindings/power/act8945a-charger.txt
> @@ -4,10 +4,12 @@ Required properties:
>   - compatible: "active-semi,act8945a", please refer to ../mfd/act8945a.txt.
>   - active-semi,chglev-gpios: charge current level phandle with args
>     as described in ../gpio/gpio.txt.
> + - active-semi,irq_gpios: specify the charger interrupt input phanle
> +   with args as as described in ../gpio/gpio.txt.

As I said in v2, this should be an interrupt property instead.

> + - active-semi,lbo-gpios: specify the low battery voltage detect phandle
> +   with args as as described in ../gpio/gpio.txt.

Maybe this one too.

>  
>  Optional properties:
> - - active-semi,check-battery-temperature: boolean to check the battery
> -   temperature or not.
>   - active-semi,input-voltage-threshold-microvolt: unit: mV;
>     Specifies the charger's input over-voltage threshold value;
>     The value can be: 6600, 7000, 7500, 8000; default: 6600
> -- 
> 2.7.4
> 
