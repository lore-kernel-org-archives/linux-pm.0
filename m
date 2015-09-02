From: Krzysztof Kozlowski <k.kozlowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [PATCH 13/13] dt: power: bq24257-charger: Cover additional devices
Date: Wed, 2 Sep 2015 14:24:05 +0900
Message-ID: <CAJKOXPeyMeUUon0E9Fhm18SHJEaQPEbGAWwU+MKwgt-30AXHiA@mail.gmail.com>
References: <1441073435-12349-1-git-send-email-dannenberg@ti.com>
	<1441073435-12349-14-git-send-email-dannenberg@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1441073435-12349-14-git-send-email-dannenberg-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Andreas Dannenberg <dannenberg-l0cyMroinI0@public.gmane.org>
Cc: Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Dmitry Eremin-Solenikov <dbaryshkov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, Laurentiu Palcu <laurentiu.palcu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-pm@vger.kernel.org

2015-09-01 11:10 GMT+09:00 Andreas Dannenberg <dannenberg-l0cyMroinI0@public.gmane.org>:
> Extend the bq24257 charger's device tree documentation to cover the
> bq24250 and bq24257 devices as well as recent feature additions.
>
> Signed-off-by: Andreas Dannenberg <dannenberg-l0cyMroinI0@public.gmane.org>
> ---
>  .../devicetree/bindings/power/bq24257.txt          | 59 ++++++++++++++++++++--
>  1 file changed, 55 insertions(+), 4 deletions(-)
>
> diff --git a/Documentation/devicetree/bindings/power/bq24257.txt b/Documentation/devicetree/bindings/power/bq24257.txt
> index 5c9d394..36b115c 100644
> --- a/Documentation/devicetree/bindings/power/bq24257.txt
> +++ b/Documentation/devicetree/bindings/power/bq24257.txt
> @@ -2,20 +2,71 @@ Binding for TI bq24257 Li-Ion Charger
>
>  Required properties:
>  - compatible: Should contain one of the following:
> + * "ti,bq24250"
> + * "ti,bq24251"
>   * "ti,bq24257"
> -- reg:                    integer, i2c address of the device.
> +- reg: integer, i2c address of the device.
> +- stat-gpio: GPIO used for the devices STAT_IN pin. Alternatively the pin can
> +    also be defined through the standard interrupt definition properties (see
> +    optional properties section below). Only use one method.

Preferred suffix should be "gpios":
Documentation/devicetree/bindings/gpio/gpio.txt

> +- pg-gpio: GPIO used for the device PG (Power Good) pin. This pin is not
> +    available on all devices and therefore only required on applicable devices.
> +    However it is also possible to explicitly disable the use of this pin
> +    through the optional property "ti,pg-gpio-disable" (see below) if desired.
> +    In this case the "pg-gpio" property is no longer required.
>  - ti,battery-regulation-voltage: integer, maximum charging voltage in uV.
> -- ti,charge-current:      integer, maximum charging current in uA.
> -- ti,termination-current:  integer, charge will be terminated when current in
> -                          constant-voltage phase drops below this value (in uA).
> +- ti,charge-current: integer, maximum charging current in uA.
> +- ti,termination-current: integer, charge will be terminated when current in
> +    constant-voltage phase drops below this value (in uA).
> +
> +Optional properties:
> +- ti,in-ilimit-autoset-disable: If this boolean property is present it disables

I thought "ilimit" is a typo but apparently not :) . The names of this
property and "ti,in-limit-current" below are quite obfuscated. I am
thinking about different names but first I would like to understand
the feature: what do you mean by "automatic setting of the input
current limit"? Like adjusting the limit of possible current to given
charger type?

> +    the automatic setting of the input current limit. This property is also set
> +    implicitly on devices without charger type detection. If this property is
> +    provided the input current limit should be set manually through
> +    "ti,in-limit-current".
> +- ti,in-limit-current: The maximum current to be drawn from the charger's input
> +    (in uA). Use this for devices that don't have charger type detection or if
> +    you have have set "ti,in-ilimit-autoset-disable".
> +- ti,vovp-voltage: Configures the over voltage protection voltage (in uV).
> +- ti,vindpm-voltage:  Configures the threshold input voltage for the dynamic
> +    power path management (in uV).

I think the leading 'v' could be removed, so "ti,ovp-voltage" and
"ti,in-dpm-voltage"?

> +- ti,pg-gpio-disable: If this boolean property is provided a software-based
> +    approach for power good determination is used. Note that the PG-pin based
> +    approach is generally preferable.

That's confusing. If someone does not want to use pg-gpio then he
could just skip the "pg-gpio" property?

> +- ti,timer-2x-enable: If this boolean property is provided the device's safety
> +    timer is extended by a factor of two.

Boolean properties like this have disadvantage - they cannot be
overridden. Also extending them is difficult (e.g. for some next
device the timer could have value of 4). Usually it is better to have
a value-based property with "0" meaning default or disabled.

Also please look at existing bindings:
$ git grep "ti," Documentation/devicetree/bindings/power
Maybe you could reuse some? Each of these existing and new bindings
are made generic (not device specific) so they should be reused.

Best regards,
Krzysztof

> +- interrupt-parent: Should be the phandle for the interrupt controller. Use in
> +    conjunction with "interrupts" and only in case "stat-gpio" is not used.
> +- interrupts: Interrupt mapping for GPIO IRQ (configure for both edges). Use in
> +    conjunction with "interrupt-parent" and only in case "stat-gpio" is not
> +    used.
>
>  Example:
>
>  bq24257 {
>         compatible = "ti,bq24257";
>         reg = <0x6a>;
> +       stat-gpio = <&gpio1 16 GPIO_ACTIVE_HIGH>;
> +       pg-gpio = <&gpio1 28 GPIO_ACTIVE_HIGH>;
>
>         ti,battery-regulation-voltage = <4200000>;
>         ti,charge-current = <1000000>;
>         ti,termination-current = <50000>;
>  };
> +
> +Example:
> +
> +bq24250 {
> +       compatible = "ti,bq24250";
> +       reg = <0x6a>;
> +       interrupt-parent = <&gpio1>;
> +       interrupts = <16 IRQ_TYPE_EDGE_BOTH>;
> +
> +       ti,battery-regulation-voltage = <4200000>;
> +       ti,charge-current = <500000>;
> +       ti,termination-current = <50000>;
> +       ti,in-limit-current = <900000>;
> +       ti,vovp-voltage = <9500000>;
> +       ti,vindpm-voltage = <4440000>;
> +};
> --
> 1.9.1
>
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
