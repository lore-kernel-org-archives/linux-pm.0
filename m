From: Daniel Kurtz <djkurtz@chromium.org>
Subject: Re: [PATCH 1/3] dt-bindings: thermal: Add binding document for
 Mediatek thermal controller
Date: Wed, 16 Dec 2015 19:23:22 +0800
Message-ID: <CAGS+omCPonvXBTjOqpKrJX0Ebw0KF6TDKH+zRas-3FaAhUWL2w@mail.gmail.com>
References: <1448883753-19068-1-git-send-email-s.hauer@pengutronix.de> <1448883753-19068-2-git-send-email-s.hauer@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-vk0-f51.google.com ([209.85.213.51]:33830 "EHLO
	mail-vk0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752817AbbLPLXn (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 16 Dec 2015 06:23:43 -0500
Received: by mail-vk0-f51.google.com with SMTP id j66so24045700vkg.1
        for <linux-pm@vger.kernel.org>; Wed, 16 Dec 2015 03:23:43 -0800 (PST)
In-Reply-To: <1448883753-19068-2-git-send-email-s.hauer@pengutronix.de>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Sascha Hauer <s.hauer@pengutronix.de>
Cc: linux-pm@vger.kernel.org, Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linux-mediatek@lists.infradead.org, Sasha Hauer <kernel@pengutronix.de>, Matthias Brugger <matthias.bgg@gmail.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

On Mon, Nov 30, 2015 at 7:42 PM, Sascha Hauer <s.hauer@pengutronix.de> wrote:
> This adds the device tree binding documentation for the mediatek thermal
> controller found on Mediatek MT8173 and other SoCs.
>
> Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
> Reviewed-by: Daniel Kurtz <djkurtz@chromium.org>
> Acked-by: Rob Herring <robh@kernel.org>
> ---
>  .../bindings/thermal/mediatek-thermal.txt          | 43 ++++++++++++++++++++++
>  1 file changed, 43 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/thermal/mediatek-thermal.txt
>
> diff --git a/Documentation/devicetree/bindings/thermal/mediatek-thermal.txt b/Documentation/devicetree/bindings/thermal/mediatek-thermal.txt
> new file mode 100644
> index 0000000..81f9a51
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/thermal/mediatek-thermal.txt
> @@ -0,0 +1,43 @@
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
> +                      "therm":  Main clock needed for register access
> +                      "auxadc": The AUXADC clock
> +- resets: Reference to the reset controller controlling the thermal controller.
> +- mediatek,auxadc: A phandle to the AUXADC which the thermal controller uses
> +- mediatek,apmixedsys: A phandle to the APMIXEDSYS controller.
> +- #thermal-sensor-cells : Should be 0. See ./thermal.txt for a description.
> +
> +Optional properties:
> +- nvmem-cells: A phandle to the calibration data provided by a nvmem device. If
> +               unspecified default values shall be used.
> +- nvmem-cell-names: Should be "calibration-data"
> +
> +Example:
> +
> +       thermal: thermal@1100b000 {
> +               #thermal-sensor-cells = <1>;

Tiny nit: this should now be:

#thermal-sensor-cells = <0>;

> +               compatible = "mediatek,mt8173-thermal";
> +               reg = <0 0x1100b000 0 0x1000>;
> +               interrupts = <0 70 IRQ_TYPE_LEVEL_LOW>;
> +               clocks = <&pericfg CLK_PERI_THERM>, <&pericfg CLK_PERI_AUXADC>;
> +               clock-names = "therm", "auxadc";
> +               resets = <&pericfg MT8173_PERI_THERM_SW_RST>;
> +               reset-names = "therm";
> +               mediatek,auxadc = <&auxadc>;
> +               mediatek,apmixedsys = <&apmixedsys>;
> +               nvmem-cells = <&thermal_calibration_data>;
> +               nvmem-cell-names = "calibration-data";
> +       };
> --
> 2.6.2
>
>
> _______________________________________________
> Linux-mediatek mailing list
> Linux-mediatek@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-mediatek
