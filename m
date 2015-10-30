From: Krzysztof Kozlowski <k.kozlowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [PATCH 1/2] dt: power: Add support for TI BQ24261 charger
Date: Fri, 30 Oct 2015 10:52:53 +0900
Message-ID: <CAJKOXPcDea5vjX+-tDg=7Z2kPrtsEABybA0+nEPGJDVwaYvb1Q@mail.gmail.com>
References: <1446136625-20845-1-git-send-email-ramakrishna.pallala@intel.com>
	<1446136625-20845-2-git-send-email-ramakrishna.pallala@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1446136625-20845-2-git-send-email-ramakrishna.pallala-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Ramakrishna Pallala <ramakrishna.pallala-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Jenny Tc <jenny.tc-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Andreas Dannenberg <dannenberg-l0cyMroinI0@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

2015-10-30 1:37 GMT+09:00 Ramakrishna Pallala <ramakrishna.pallala-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>:
> This patch adds the device tree documentation for TI BQ24261 charger.
>
> Signed-off-by: Ramakrishna Pallala <ramakrishna.pallala-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
> Signed-off-by: Jenny TC <jenny.tc-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
> ---
>  .../devicetree/bindings/power/bq24261.txt          |   34 ++++++++++++++++++++
>  1 file changed, 34 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/power/bq24261.txt
>
> diff --git a/Documentation/devicetree/bindings/power/bq24261.txt b/Documentation/devicetree/bindings/power/bq24261.txt
> new file mode 100644
> index 0000000..e18f6dc
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/power/bq24261.txt
> @@ -0,0 +1,34 @@
> +Binding for TI bq24261 Li-Ion Charger
> +
> +Required properties:
> +- compatible: Should contain one of the following:
> +    * "ti,bq24261"

Just: 'should be "ti,bq24261"'.

> +- reg: integer, i2c address of the device.
> +- ti,battery-regulation-voltage: integer, maximum charging voltage in uV.
> +- ti,charge-current: integer, maximum charging current in uA.
> +- ti,termination-current: integer, charge will be terminated when current in
> +    constant-voltage phase drops below this value (in uA).

Same as proposed extension of bq24257.txt. I like it.

> +
> +Optional properties:
> +- ti,max-charge-current: integer, maximum charging current (in uA);

I did not look at the code yet but description of property is exactly
the same as "ti,charge-current"... Two different properties with same
description?

> +- ti,max-charge-voltage: integer, maximum charging voltage (in uV);

Ditto.

> +- ti,min-charge-temperature: integer, minimum charging temperature (in DegC);
> +- ti,max-charge-temperature: integer, maximum charging temperature (in DegC).
> +- ti,thermal-sensing: integer, enable(1) or disable(0) JEITA thermal control.

You made it integer instead of boolean, so just to be sure - you
expect the possibility of overriding this property or extending it in
further devices?

Best regards,
Krzysztof
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
