From: Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH v1 2/7] devicetree: power: Add docs for TI BQ24190 battery
 charger
Date: Wed, 22 Mar 2017 13:04:41 +0100
Message-ID: <3f423ccd-9f9a-f9f3-0138-d444994465f0@redhat.com>
References: <20170321220921.5834-1-liam@networkimprov.net>
 <20170321220921.5834-3-liam@networkimprov.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20170321220921.5834-3-liam-RYWXG+zxWwBdeoIcmNTgJF6hYfS7NtTn@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Liam Breck <liam-RYWXG+zxWwBdeoIcmNTgJF6hYfS7NtTn@public.gmane.org>, Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Liam Breck <kernel-RYWXG+zxWwBdeoIcmNTgJF6hYfS7NtTn@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

Hi,

On 21-03-17 23:09, Liam Breck wrote:
> From: Liam Breck <kernel-RYWXG+zxWwBdeoIcmNTgJF6hYfS7NtTn@public.gmane.org>
>
> Document monitored-battery and ti,system-minimum-microvolt properties.
>
> Cc: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
> Cc: devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> Signed-off-by: Liam Breck <kernel-RYWXG+zxWwBdeoIcmNTgJF6hYfS7NtTn@public.gmane.org>

Looks good to me:

Reviewed-by: Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>

Regards,

Hans



> ---
>  .../devicetree/bindings/power/supply/bq24190.txt   | 47 ++++++++++++++++++++++
>  1 file changed, 47 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/power/supply/bq24190.txt
>
> diff --git a/Documentation/devicetree/bindings/power/supply/bq24190.txt b/Documentation/devicetree/bindings/power/supply/bq24190.txt
> new file mode 100644
> index 0000000..d252d10
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/power/supply/bq24190.txt
> @@ -0,0 +1,47 @@
> +Binding for TI BQ24190 Li-Ion Battery Charger
> +
> +Required properties:
> +- compatible: Should contain one of the following:
> +    * "ti,bq24190"
> +- reg: integer, I2C address of the device.
> +
> +Optional properties:
> +- monitored-battery: phandle of battery information devicetree node
> +    These battery properties are relevant:
> +    + precharge-current-microamp: maximum charge current during precharge
> +      phase (typically 20% of battery capacity).
> +    + endcharge-current-microamp: a charge cycle terminates when the
> +      battery voltage is above recharge threshold, and the current is below
> +      this setting (typically 10% of battery capacity).
> +    See Documentation/devicetree/bindings/power/supply/battery.txt
> +- ti,system-minimum-microvolt: when power is connected and the battery
> +    is below minimum system voltage, the system will be regulated above this
> +    setting.
> +
> +Other features:
> +- Use gpio-hog to set the OTG pin high to enable 500mA charge current on USB SDP port.
> +
> +Example:
> +
> +bat: battery {
> +	compatible = "simple-battery";
> +	precharge-current-microamp = <256000>;
> +	endcharge-current-microamp = <128000>;
> +};
> +
> +bq24190 charger@6a {
> +	compatible = "ti,bq24190";
> +	reg = <0x6a>;
> +	// interrupt configuration here
> +	monitored-battery = <&bat>;
> +	ti,system-minimum-microvolt = <3200000>;
> +};
> +
> +&twl_gpio {
> +	otg {
> +		gpio-hog;
> +		gpios = <6 0>;
> +		output-high;
> +		line-name = "otg-gpio";
> +	};
> +};
>
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
