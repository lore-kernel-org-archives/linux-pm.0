From: Daniel Kurtz <djkurtz@chromium.org>
Subject: Re: [PATCH 1/3] dt-bindings: thermal: Add binding document for
 Mediatek thermal controller
Date: Thu, 16 Jul 2015 01:41:02 +0800
Message-ID: <CAGS+omDjXrZSns7b+NMz1pUYbDK1ndW=NOdDtUXLuzTQUtcUPg@mail.gmail.com>
References: <1436783694-30717-1-git-send-email-s.hauer@pengutronix.de> <1436783694-30717-2-git-send-email-s.hauer@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-yk0-f181.google.com ([209.85.160.181]:32849 "EHLO
	mail-yk0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751592AbbGORlW (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 15 Jul 2015 13:41:22 -0400
Received: by ykeo3 with SMTP id o3so42688725yke.0
        for <linux-pm@vger.kernel.org>; Wed, 15 Jul 2015 10:41:22 -0700 (PDT)
In-Reply-To: <1436783694-30717-2-git-send-email-s.hauer@pengutronix.de>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Sascha Hauer <s.hauer@pengutronix.de>
Cc: linux-pm@vger.kernel.org, Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Sasha Hauer <kernel@pengutronix.de>, linux-mediatek@lists.infradead.org, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Matthias Brugger <matthias.bgg@gmail.com>

On Mon, Jul 13, 2015 at 6:34 PM, Sascha Hauer <s.hauer@pengutronix.de> wrote:
> Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
> ---
>  .../bindings/thermal/mediatek-thermal.txt          | 38 ++++++++++++++++++++++
>  1 file changed, 38 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/thermal/mediatek-thermal.txt
>
> diff --git a/Documentation/devicetree/bindings/thermal/mediatek-thermal.txt b/Documentation/devicetree/bindings/thermal/mediatek-thermal.txt
> new file mode 100644
> index 0000000..d90e4dc
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
> +               "therm":        Main clock needed for register access
> +               "auxadc":       The AUXADC clock
> +- resets, reset-names: Reference to the reset controller controlling the thermal
> +                       controller. Required reset-names:
> +               "therm":        The main reset line
> +- auxadc: A phandle to the AUXADC which the thermal controller uses
> +- apmixedsys: A phandle to the APMIXEDSYS controller.

Hmm, shouldn't these custom properties be prefixed with:
  "mediatek,..."

-Dan

> +- #thermal-sensor-cells : Should be 1. See ./thermal.txt for a description
> +
> +Example:
> +
> +       thermal: thermal@1100b000 {
> +               #thermal-sensor-cells = <1>;
> +               compatible = "mediatek,mt8173-thermal";
> +               reg = <0 0x1100b000 0 0x1000>;
> +               interrupts = <0 70 IRQ_TYPE_LEVEL_LOW>;
> +               clocks = <&pericfg CLK_PERI_THERM>, <&pericfg CLK_PERI_AUXADC>;
> +               clock-names = "therm", "auxadc";
> +               resets = <&pericfg MT8173_PERI_THERM_SW_RST>;
> +               reset-names = "therm";
> +               auxadc = <&auxadc>;
> +               apmixedsys = <&apmixedsys>;
> +       };
> --
> 2.1.4
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
