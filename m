From: Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v9 3/4] doc: bindings: mfd: act8945a: Update the example
Date: Thu, 1 Sep 2016 12:22:51 +0100
Message-ID: <20160901112251.GK4921@dell>
References: <1472722201-31872-1-git-send-email-wenyou.yang@atmel.com>
 <1472722201-31872-4-git-send-email-wenyou.yang@atmel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1472722201-31872-4-git-send-email-wenyou.yang-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wenyou Yang <wenyou.yang-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>
Cc: Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Dmitry Eremin-Solenikov <dbaryshkov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Nicolas Ferre <nicolas.ferre-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>, Alexandre Belloni <alexandre.belloni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Wenyou Yang <wenyou.yang-UWL1GkI3JZL3oGB3hsPCZA@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-pm@vger.kernel.org

On Thu, 01 Sep 2016, Wenyou Yang wrote:

> Since the act8945a-charger is regarded as a sub-device and it using
> "interrupts" property, update the examples section.
> 
> Signed-off-by: Wenyou Yang <wenyou.yang-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>
> ---
> 
> Changes in v9: None
> Changes in v8: None
> Changes in v7: None
> Changes in v6: None
> Changes in v4: None
> 
>  Documentation/devicetree/bindings/mfd/act8945a.txt | 22 +++++++++++++++-------
>  1 file changed, 15 insertions(+), 7 deletions(-)

This is a functional change.  I'll require a DT Ack.

> diff --git a/Documentation/devicetree/bindings/mfd/act8945a.txt b/Documentation/devicetree/bindings/mfd/act8945a.txt
> index f712830..462819a 100644
> --- a/Documentation/devicetree/bindings/mfd/act8945a.txt
> +++ b/Documentation/devicetree/bindings/mfd/act8945a.txt
> @@ -14,13 +14,6 @@ Example:
>  		reg = <0x5b>;
>  		status = "okay";
>  
> -		pinctrl-names = "default";
> -		pinctrl-0 = <&pinctrl_charger_chglev>;
> -		active-semi,chglev-gpio = <&pioA 12 GPIO_ACTIVE_HIGH>;
> -		active-semi,input-voltage-threshold-microvolt = <6600>;
> -		active-semi,precondition-timeout = <40>;
> -		active-semi,total-timeout = <3>;
> -
>  		active-semi,vsel-high;
>  
>  		regulators {
> @@ -73,4 +66,19 @@ Example:
>  				regulator-always-on;
>  			};
>  		};
> +
> +		charger {
> +			compatible = "active-semi,act8945a-charger";
> +			pinctrl-names = "default";
> +			pinctrl-0 = <&pinctrl_charger_chglev &pinctrl_charger_lbo &pinctrl_charger_irq>;
> +			interrupt-parent = <&pioA>;
> +			interrupts = <45 GPIO_ACTIVE_LOW>;
> +
> +			active-semi,chglev-gpios = <&pioA 12 GPIO_ACTIVE_HIGH>;
> +			active-semi,lbo-gpios = <&pioA 72 GPIO_ACTIVE_LOW>;
> +			active-semi,input-voltage-threshold-microvolt = <6600>;
> +			active-semi,precondition-timeout = <40>;
> +			active-semi,total-timeout = <3>;
> +			status = "okay";
> +		};
>  	};

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
