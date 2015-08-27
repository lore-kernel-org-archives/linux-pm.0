From: Punit Agrawal <punit.agrawal-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [PATCH 1/3] dt-bindings: thermal: Add binding document for Mediatek thermal controller
Date: Thu, 27 Aug 2015 12:49:39 +0100
Message-ID: <9hh1tepj6i4.fsf@e105922-lin.cambridge.arm.com>
References: <1440657677-2890-1-git-send-email-s.hauer@pengutronix.de>
	<1440657677-2890-2-git-send-email-s.hauer@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1440657677-2890-2-git-send-email-s.hauer-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org> (Sascha
	Hauer's message of "Thu, 27 Aug 2015 08:41:15 +0200")
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Sascha Hauer <s.hauer-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Cc: linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Zhang Rui <rui.zhang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Eduardo Valentin <edubezval-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-mediatek-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Daniel Kurtz <djkurtz-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, Matthias Brugger <matthias.bgg-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org
List-Id: linux-pm@vger.kernel.org

[ + device tree folks ]

Hi Sascha,

When introducing a new binding, it is a good idea to get reviews from
the device tree maintainers. I've added a few folks here. Please keep
them in the loop for future postings.

Sascha Hauer <s.hauer-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org> writes:

> Signed-off-by: Sascha Hauer <s.hauer-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
> Reviewed-by: Daniel Kurtz <djkurtz-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>

Please add a commit log.

> ---
>  .../bindings/thermal/mediatek-thermal.txt          | 38 ++++++++++++++++++++++
>  include/dt-bindings/thermal/mt8173.h               | 13 ++++++++
>  2 files changed, 51 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/thermal/mediatek-thermal.txt
>  create mode 100644 include/dt-bindings/thermal/mt8173.h
>
> diff --git a/Documentation/devicetree/bindings/thermal/mediatek-thermal.txt b/Documentation/devicetree/bindings/thermal/mediatek-thermal.txt
> new file mode 100644
> index 0000000..1697375
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/thermal/mediatek-thermal.txt
> @@ -0,0 +1,38 @@
> +* Mediatek Thermal
> +
> +This describes the device tree binding for the Mediatek thermal controller
> +which measures the on-SoC temperatures. This device does not have its own ADC,
> +instead it directly controls the AUXADC via AHB bus accesses. For this reason
> +this device needs phandles to the AUXADC. Also it controls a mux in the
> +apmixedsys register space via AHB bus accesses, so a phandle to the APMIXEDSYS
> +is also needed.
> +
> +Required properties:
> +- compatible: "mediatek,mt8173-thermal"
> +- reg: Address range of the thermal controller
> +- interrupts: IRQ for the thermal controller
> +- clocks, clock-names: Clocks needed for the thermal controller. required
> +                       clocks are:
> +		       "therm":	 Main clock needed for register access
> +		       "auxadc": The AUXADC clock
> +- resets: Reference to the reset controller controlling the thermal controller.
> +- mediatek,auxadc: A phandle to the AUXADC which the thermal controller uses
> +- mediatek,apmixedsys: A phandle to the APMIXEDSYS controller.
> +- #thermal-sensor-cells : Should be 1. See ./thermal.txt for a description. See
> +			  include/dt-bindings/thermal/mt8173.h for valid sensor
> +			  numbers.
> +
> +Example:
> +
> +	thermal: thermal@1100b000 {
> +		#thermal-sensor-cells = <1>;
> +		compatible = "mediatek,mt8173-thermal";
> +		reg = <0 0x1100b000 0 0x1000>;
> +		interrupts = <0 70 IRQ_TYPE_LEVEL_LOW>;
> +		clocks = <&pericfg CLK_PERI_THERM>, <&pericfg CLK_PERI_AUXADC>;
> +		clock-names = "therm", "auxadc";
> +		resets = <&pericfg MT8173_PERI_THERM_SW_RST>;
> +		reset-names = "therm";
> +		mediatek,auxadc = <&auxadc>;
> +		mediatek,apmixedsys = <&apmixedsys>;
> +	};
> diff --git a/include/dt-bindings/thermal/mt8173.h b/include/dt-bindings/thermal/mt8173.h
> new file mode 100644
> index 0000000..692e74c
> --- /dev/null
> +++ b/include/dt-bindings/thermal/mt8173.h
> @@ -0,0 +1,13 @@
> +/*
> + * This header provides constants for mediatek,mt8173-thermal
> + */
> +
> +#ifndef _DT_BINDINGS_THERMAL_MEDIATEK_MT8173_H
> +#define _DT_BINDINGS_THERMAL_MEDIATEK_MT8173_H
> +
> +#define MT8173_THERMAL_ZONE_CA53	0
> +#define MT8173_THERMAL_ZONE_CA57	1
> +#define MT8173_THERMAL_ZONE_GPU		2
> +#define MT8173_THERMAL_ZONE_CORE	3
> +
> +#endif /* _DT_BINDINGS_THERMAL_MEDIATEK_MT8173_H */

The constants in this include are not used in the patchset. Please drop
this hunk and introduce it when you use it.

Thanks,
Punit
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
