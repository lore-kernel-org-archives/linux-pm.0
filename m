From: Vaibhav Hiremath <vaibhav.hiremath-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v6 1/8] binding-doc: power: pwrseq-generic: add binding
 doc for generic power sequence library
Date: Thu, 1 Sep 2016 13:33:22 +0530
Message-ID: <6832cc55-831a-1188-4878-bbbf0b3c3be8@linaro.org>
References: <1471252398-957-1-git-send-email-peter.chen@nxp.com>
 <1471252398-957-2-git-send-email-peter.chen@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1471252398-957-2-git-send-email-peter.chen-3arQi8VN3Tc@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Peter Chen <peter.chen-3arQi8VN3Tc@public.gmane.org>, gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org, stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org, ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, shawnguo-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, dbaryshkov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, dwmw3-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org
Cc: k.kozlowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, p.zabel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, pawel.moll-5wv7dgnIgG8@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, arnd-r2nGTMty4D4@public.gmane.org, s.hauer-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, mail-APzI5cXaD1zVlRWJc41N0YvC60bnQu0Y@public.gmane.org, troy.kisky-Q5RJGjKts06CY9SHAMCTRUEOCMrvLtNR@public.gmane.org, festevam-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, oscar-Bdbr4918Nnnk1uMJSBkQmQ@public.gmane.org, stephen.boyd-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, stillcompiling-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, mka-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org
List-Id: linux-pm@vger.kernel.org



On Monday 15 August 2016 02:43 PM, Peter Chen wrote:
> Add binding doc for generic power sequence library.
>
> Signed-off-by: Peter Chen <peter.chen-3arQi8VN3Tc@public.gmane.org>
> Acked-by: Philipp Zabel <p.zabel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
> Acked-by: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
> ---
>   .../bindings/power/pwrseq/pwrseq-generic.txt       | 48 ++++++++++++++++++++++
>   1 file changed, 48 insertions(+)
>   create mode 100644 Documentation/devicetree/bindings/power/pwrseq/pwrseq-generic.txt
>
> diff --git a/Documentation/devicetree/bindings/power/pwrseq/pwrseq-generic.txt b/Documentation/devicetree/bindings/power/pwrseq/pwrseq-generic.txt
> new file mode 100644
> index 0000000..ebf0d47
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/power/pwrseq/pwrseq-generic.txt
> @@ -0,0 +1,48 @@
> +The generic power sequence library
> +
> +Some hard-wired devices (eg USB/MMC) need to do power sequence before
> +the device can be enumerated on the bus, the typical power sequence
> +like: enable USB PHY clock, toggle reset pin, etc. But current
> +Linux device driver lacks of such code to do it, it may cause some
> +hard-wired devices works abnormal or can't be recognized by
> +controller at all. The power sequence will be done before this device
> +can be found at the bus.
> +
> +The power sequence properties is under the device node.
> +
> +Optional properties:
> +- clocks: the input clocks for device.
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
> +	genesys: hub@1 {
> +		compatible = "usb5e3,608";
> +		reg = <1>;
> +
> +		clocks = <&clks IMX6SX_CLK_CKO>;
> +		reset-gpios = <&gpio4 5 GPIO_ACTIVE_LOW>; /* hub reset pin */
> +		reset-duration-us = <10>;
> +
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +		asix: ethernet@1 {
> +			compatible = "usbb95,1708";

So I assume, with our recent discussion and the change
we are proposing, the library would have some knowledge
about this compatible string, right?

what I was asking on other email was, how are you connecting
multiple power sequence libraries to their respective consumers ?

Thanks,
Vaibhav

> +			reg = <1>;
> +
> +			clocks = <&clks IMX6SX_CLK_IPG>;
> +			reset-gpios = <&gpio4 6 GPIO_ACTIVE_LOW>; /* ethernet_rst */
> +			reset-duration-us = <15>;
> +		};
> +	};
> +};

-- 
Thanks,
Vaibhav

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
