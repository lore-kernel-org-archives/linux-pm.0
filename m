From: Sascha Hauer <s.hauer@pengutronix.de>
Subject: Re: [PATCH 1/3] dt-bindings: thermal: Add binding document for
 Mediatek thermal controller
Date: Tue, 1 Sep 2015 07:26:04 +0200
Message-ID: <20150901052604.GU5161@pengutronix.de>
References: <1441006446-4558-1-git-send-email-s.hauer@pengutronix.de>
 <1441006446-4558-2-git-send-email-s.hauer@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:57934 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750773AbbIAF0e (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 1 Sep 2015 01:26:34 -0400
Content-Disposition: inline
In-Reply-To: <1441006446-4558-2-git-send-email-s.hauer@pengutronix.de>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org, Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>
Cc: linux-kernel@vger.kernel.org, kernel@pengutronix.de, linux-mediatek@lists.infradead.org, linux-arm-kernel@lists.infradead.org, Matthias Brugger <matthias.bgg@gmail.com>, devicetree@vger.kernel.org, mark.rutland@arm.com, robh+dt@kernel.org

On Mon, Aug 31, 2015 at 09:34:04AM +0200, Sascha Hauer wrote:
> Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
> Reviewed-by: Daniel Kurtz <djkurtz@chromium.org>

Uh, still forgot the commit log. Will add something like:

This adds the device tree binding documentation for the mediatek thermal
controller found on Mediatek MT8173 and other SoCs.

Sascha

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
> -- 
> 2.5.0
> 
> 

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
