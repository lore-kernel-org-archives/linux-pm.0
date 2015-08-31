From: Sascha Hauer <s.hauer@pengutronix.de>
Subject: Re: [PATCH 1/3] dt-bindings: thermal: Add binding document for
 Mediatek thermal controller
Date: Mon, 31 Aug 2015 09:25:30 +0200
Message-ID: <20150831072530.GD18700@pengutronix.de>
References: <1440657677-2890-1-git-send-email-s.hauer@pengutronix.de>
 <1440657677-2890-2-git-send-email-s.hauer@pengutronix.de>
 <9hh1tepj6i4.fsf@e105922-lin.cambridge.arm.com>
 <CAGS+omD4_uvpb-FOqpFbx=84unYjBSZajAKQ+4ek+QqSd-P28A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:42114 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752085AbbHaHZj (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 31 Aug 2015 03:25:39 -0400
Content-Disposition: inline
In-Reply-To: <CAGS+omD4_uvpb-FOqpFbx=84unYjBSZajAKQ+4ek+QqSd-P28A@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Daniel Kurtz <djkurtz@chromium.org>
Cc: Punit Agrawal <punit.agrawal@arm.com>, linux-pm@vger.kernel.org, Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linux-mediatek@lists.infradead.org, Sasha Hauer <kernel@pengutronix.de>, Matthias Brugger <matthias.bgg@gmail.com>, "open list:OPEN FIRMWARE AND..." <devicetree@vger.kernel.org>, Mark Rutland <mark.rutland@arm.com>, Rob Herring <robh+dt@kernel.org>

On Fri, Aug 28, 2015 at 10:23:15AM +0800, Daniel Kurtz wrote:
> On Thu, Aug 27, 2015 at 7:49 PM, Punit Agrawal <punit.agrawal@arm.com> wrote:
> > [ + device tree folks ]
> >
> > Hi Sascha,
> >
> > When introducing a new binding, it is a good idea to get reviews from
> > the device tree maintainers. I've added a few folks here. Please keep
> > them in the loop for future postings.
> >
> > Sascha Hauer <s.hauer@pengutronix.de> writes:
> >
> >> Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
> >> Reviewed-by: Daniel Kurtz <djkurtz@chromium.org>
> >
> > Please add a commit log.
> >
> >> ---
> >>  .../bindings/thermal/mediatek-thermal.txt          | 38 ++++++++++++++++++++++
> >>  include/dt-bindings/thermal/mt8173.h               | 13 ++++++++
> >>  2 files changed, 51 insertions(+)
> >>  create mode 100644 Documentation/devicetree/bindings/thermal/mediatek-thermal.txt
> >>  create mode 100644 include/dt-bindings/thermal/mt8173.h
> >>
> >> diff --git a/Documentation/devicetree/bindings/thermal/mediatek-thermal.txt b/Documentation/devicetree/bindings/thermal/mediatek-thermal.txt
> >> new file mode 100644
> >> index 0000000..1697375
> >> --- /dev/null
> >> +++ b/Documentation/devicetree/bindings/thermal/mediatek-thermal.txt
> >> @@ -0,0 +1,38 @@
> >> +* Mediatek Thermal
> >> +
> >> +This describes the device tree binding for the Mediatek thermal controller
> >> +which measures the on-SoC temperatures. This device does not have its own ADC,
> >> +instead it directly controls the AUXADC via AHB bus accesses. For this reason
> >> +this device needs phandles to the AUXADC. Also it controls a mux in the
> >> +apmixedsys register space via AHB bus accesses, so a phandle to the APMIXEDSYS
> >> +is also needed.
> >> +
> >> +Required properties:
> >> +- compatible: "mediatek,mt8173-thermal"
> >> +- reg: Address range of the thermal controller
> >> +- interrupts: IRQ for the thermal controller
> >> +- clocks, clock-names: Clocks needed for the thermal controller. required
> >> +                       clocks are:
> >> +                    "therm":  Main clock needed for register access
> >> +                    "auxadc": The AUXADC clock
> >> +- resets: Reference to the reset controller controlling the thermal controller.
> >> +- mediatek,auxadc: A phandle to the AUXADC which the thermal controller uses
> >> +- mediatek,apmixedsys: A phandle to the APMIXEDSYS controller.
> >> +- #thermal-sensor-cells : Should be 1. See ./thermal.txt for a description. See
> >> +                       include/dt-bindings/thermal/mt8173.h for valid sensor
> >> +                       numbers.
> >> +
> >> +Example:
> >> +
> >> +     thermal: thermal@1100b000 {
> >> +             #thermal-sensor-cells = <1>;
> >> +             compatible = "mediatek,mt8173-thermal";
> >> +             reg = <0 0x1100b000 0 0x1000>;
> >> +             interrupts = <0 70 IRQ_TYPE_LEVEL_LOW>;
> >> +             clocks = <&pericfg CLK_PERI_THERM>, <&pericfg CLK_PERI_AUXADC>;
> >> +             clock-names = "therm", "auxadc";
> >> +             resets = <&pericfg MT8173_PERI_THERM_SW_RST>;
> >> +             reset-names = "therm";
> >> +             mediatek,auxadc = <&auxadc>;
> >> +             mediatek,apmixedsys = <&apmixedsys>;
> >> +     };
> >> diff --git a/include/dt-bindings/thermal/mt8173.h b/include/dt-bindings/thermal/mt8173.h
> >> new file mode 100644
> >> index 0000000..692e74c
> >> --- /dev/null
> >> +++ b/include/dt-bindings/thermal/mt8173.h
> >> @@ -0,0 +1,13 @@
> >> +/*
> >> + * This header provides constants for mediatek,mt8173-thermal
> >> + */
> >> +
> >> +#ifndef _DT_BINDINGS_THERMAL_MEDIATEK_MT8173_H
> >> +#define _DT_BINDINGS_THERMAL_MEDIATEK_MT8173_H
> >> +
> >> +#define MT8173_THERMAL_ZONE_CA53     0
> >> +#define MT8173_THERMAL_ZONE_CA57     1
> >> +#define MT8173_THERMAL_ZONE_GPU              2
> >> +#define MT8173_THERMAL_ZONE_CORE     3
> >> +
> >> +#endif /* _DT_BINDINGS_THERMAL_MEDIATEK_MT8173_H */
> >
> > The constants in this include are not used in the patchset. Please drop
> > this hunk and introduce it when you use it.
> 
> These constants are part of the devicetree ABI, and I believe they
> should be included with the binding.

Yes, that's what I was told for other series.

> To make this more concrete, I think these constants could be used as
> array indices when initializing the corresponding banks of "bank_data"
> in patch 2 (like you do when initializing scp_domain_data in the
> scpsys driver).

Good idea, will do that in the next round.

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
