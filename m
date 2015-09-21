From: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v4 resend 1/2] ARM: dts: Add binding
 documentation for AXP20x pmic usb power supply
Date: Mon, 21 Sep 2015 10:10:28 -0500
Message-ID: <56001DE4.6060901@kernel.org>
References: <1442752773-22635-1-git-send-email-hdegoede@redhat.com>
 <1442752773-22635-2-git-send-email-hdegoede@redhat.com>
Reply-To: robherring2-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-sunxi+bncBD62P6P6EQIM7J4BWACRUBAU7TTZI-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
In-Reply-To: <1442752773-22635-2-git-send-email-hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
List-Post: <http://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <http://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <http://groups.google.com/group/linux-sunxi
List-Subscribe: <http://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>,
 <http://groups.google.com/group/linux-sunxi/subscribe>
To: Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Dmitry Eremin-Solenikov <dbaryshkov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>, Kishon Vijay Abraham I <kishon-l0cyMroinI0@public.gmane.org>, Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, =?UTF-8?Q?Bruno_Pr=c3=a9mont?= <bonbons-ud5FBsm0p/xEiooADzr8i9i2O/JbrIOy@public.gmane.org>, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, devicetree <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-usb <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Id: linux-pm@vger.kernel.org

On 09/20/2015 07:39 AM, Hans de Goede wrote:
> Add binding documentation for the usb power supply part of the AXP20x pmic.
> 
> Signed-off-by: Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>

Acked-by: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>

> ---
> Changes in v2:
> -Split out into a separate patch from the actual driver commit
> Changes in v4:
> -s/usb_power_supply/usb-power-supply/ in the dts example code
> ---
>  .../bindings/power_supply/axp20x_usb_power.txt     | 34 ++++++++++++++++++++++
>  1 file changed, 34 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/power_supply/axp20x_usb_power.txt
> 
> diff --git a/Documentation/devicetree/bindings/power_supply/axp20x_usb_power.txt b/Documentation/devicetree/bindings/power_supply/axp20x_usb_power.txt
> new file mode 100644
> index 0000000..862f4a4
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/power_supply/axp20x_usb_power.txt
> @@ -0,0 +1,34 @@
> +AXP20x USB power supply
> +
> +Required Properties:
> +-compatible: "x-powers,axp202-usb-power-supply"
> +
> +This node is a subnode of the axp20x PMIC.
> +
> +Example:
> +
> +axp209: pmic@34 {
> +	compatible = "x-powers,axp209";
> +	reg = <0x34>;
> +	interrupt-parent = <&nmi_intc>;
> +	interrupts = <0 IRQ_TYPE_LEVEL_LOW>;
> +	interrupt-controller;
> +	#interrupt-cells = <1>;
> +
> +	regulators {
> +		x-powers,dcdc-freq = <1500>;
> +
> +		vdd_cpu: dcdc2 {
> +			regulator-always-on;
> +			regulator-min-microvolt = <1000000>;
> +			regulator-max-microvolt = <1450000>;
> +			regulator-name = "vdd-cpu";
> +		};
> +
> +		...
> +	};
> +
> +	usb-power-supply: usb-power-supply {
> +		compatible = "x-powers,axp202-usb-power-supply";
> +	};
> +};
> 
