From: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v2 2/5] devicetree: power: Add docs for TI BQ24190
 battery charger
Date: Thu, 10 Aug 2017 21:50:38 -0500
Message-ID: <20170811025038.5qnhbabyybx7rgu5@rob-hp-laptop>
References: <20170807195420.20767-1-liam@networkimprov.net>
 <20170807195420.20767-3-liam@networkimprov.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20170807195420.20767-3-liam-RYWXG+zxWwBdeoIcmNTgJF6hYfS7NtTn@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Liam Breck <liam-RYWXG+zxWwBdeoIcmNTgJF6hYfS7NtTn@public.gmane.org>
Cc: Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Liam Breck <kernel-RYWXG+zxWwBdeoIcmNTgJF6hYfS7NtTn@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

On Mon, Aug 07, 2017 at 12:54:17PM -0700, Liam Breck wrote:
> From: Liam Breck <kernel-RYWXG+zxWwBdeoIcmNTgJF6hYfS7NtTn@public.gmane.org>
> 
> Document monitored-battery and ti,system-minimum-microvolt properties.
> 
> Cc: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
> Cc: devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> Signed-off-by: Liam Breck <kernel-RYWXG+zxWwBdeoIcmNTgJF6hYfS7NtTn@public.gmane.org>
> ---
>  .../devicetree/bindings/power/supply/bq24190.txt   | 49 ++++++++++++++++++++++
>  1 file changed, 49 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/power/supply/bq24190.txt
> 
> diff --git a/Documentation/devicetree/bindings/power/supply/bq24190.txt b/Documentation/devicetree/bindings/power/supply/bq24190.txt
> new file mode 100644
> index 00000000..82a1c842
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/power/supply/bq24190.txt
> @@ -0,0 +1,49 @@
> +TI BQ24190 Li-Ion Battery Charger
> +
> +Required properties:
> +- compatible: contains one of the following:
> +    * "ti,bq24190"
> +    * "ti,bq24192i"
> +- reg: integer, I2C address of the charger.
> +- interrupts[-extended]: configuration for charger INT pin.
> +
> +Optional properties:
> +- monitored-battery: phandle of battery characteristics devicetree node
> +    The charger uses the following battery properties:
> +    + precharge-current-microamp: maximum charge current during precharge
> +      phase (typically 20% of battery capacity).
> +    + charge-term-current-microamp: a charge cycle terminates when the
> +      battery voltage is above recharge threshold, and the current is below
> +      this setting (typically 10% of battery capacity).
> +    See Documentation/devicetree/bindings/power/supply/battery.txt
> +- ti,system-minimum-microvolt: when power is connected and the battery is below
> +    minimum system voltage, the system will be regulated above this setting.
> +
> +Other features:
> +- Use gpio-hog to set the OTG pin high to enable 500mA charge current on USB SDP port.

Why doesn't the charger driver control this?

> +
> +Example:
> +
> +	bat: battery {
> +		compatible = "simple-battery";
> +		precharge-current-microamp = <256000>;
> +		charge-term-current-microamp = <128000>;
> +		// etc.
> +	};
> +
> +	bq24190: charger@6a {
> +		compatible = "ti,bq24190";
> +		reg = <0x6a>;
> +		interrupts-extended = <&gpiochip 10 IRQ_TYPE_EDGE_FALLING>;
> +		monitored-battery = <&bat>;
> +		ti,system-minimum-microvolt = <3200000>;
> +	};
> +
> +	&twl_gpio {
> +		otg {
> +			gpio-hog;
> +			gpios = <6 0>;
> +			output-high;
> +			line-name = "otg-gpio";
> +		};
> +	};
> -- 
> 2.13.2
> 
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
