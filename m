From: Sascha Hauer <s.hauer@pengutronix.de>
Subject: Re: [PATCH 1/3] dt-bindings: thermal: Add binding document for
 Mediatek thermal controller
Date: Fri, 18 Dec 2015 08:16:33 +0100
Message-ID: <20151218071633.GG11966@pengutronix.de>
References: <1448883753-19068-1-git-send-email-s.hauer@pengutronix.de>
 <1448883753-19068-2-git-send-email-s.hauer@pengutronix.de>
 <CAGS+omCPonvXBTjOqpKrJX0Ebw0KF6TDKH+zRas-3FaAhUWL2w@mail.gmail.com>
 <20151217192329.GA7999@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from metis.ext.4.pengutronix.de ([92.198.50.35]:35501 "EHLO
	metis.ext.4.pengutronix.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751727AbbLRHQj (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 18 Dec 2015 02:16:39 -0500
Content-Disposition: inline
In-Reply-To: <20151217192329.GA7999@localhost.localdomain>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Eduardo Valentin <edubezval@gmail.com>
Cc: Daniel Kurtz <djkurtz@chromium.org>, linux-pm@vger.kernel.org, Zhang Rui <rui.zhang@intel.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linux-mediatek@lists.infradead.org, Sasha Hauer <kernel@pengutronix.de>, Matthias Brugger <matthias.bgg@gmail.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

On Thu, Dec 17, 2015 at 11:23:31AM -0800, Eduardo Valentin wrote:
> On Wed, Dec 16, 2015 at 07:23:22PM +0800, Daniel Kurtz wrote:
> > On Mon, Nov 30, 2015 at 7:42 PM, Sascha Hauer <s.hauer@pengutronix.de> wrote:
> > > This adds the device tree binding documentation for the mediatek thermal
> > > controller found on Mediatek MT8173 and other SoCs.
> > >
> > > Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
> > > Reviewed-by: Daniel Kurtz <djkurtz@chromium.org>
> > > Acked-by: Rob Herring <robh@kernel.org>
> > > ---
> > >  .../bindings/thermal/mediatek-thermal.txt          | 43 ++++++++++++++++++++++
> > >  1 file changed, 43 insertions(+)
> > >  create mode 100644 Documentation/devicetree/bindings/thermal/mediatek-thermal.txt
> > >
> > > diff --git a/Documentation/devicetree/bindings/thermal/mediatek-thermal.txt b/Documentation/devicetree/bindings/thermal/mediatek-thermal.txt
> > > new file mode 100644
> > > index 0000000..81f9a51
> > > --- /dev/null
> > > +++ b/Documentation/devicetree/bindings/thermal/mediatek-thermal.txt
> > > @@ -0,0 +1,43 @@
> > > +* Mediatek Thermal
> > > +
> > > +This describes the device tree binding for the Mediatek thermal controller
> > > +which measures the on-SoC temperatures. This device does not have its own ADC,
> > > +instead it directly controls the AUXADC via AHB bus accesses. For this reason
> > > +this device needs phandles to the AUXADC. Also it controls a mux in the
> > > +apmixedsys register space via AHB bus accesses, so a phandle to the APMIXEDSYS
> > > +is also needed.
> > > +
> > > +Required properties:
> > > +- compatible: "mediatek,mt8173-thermal"
> > > +- reg: Address range of the thermal controller
> > > +- interrupts: IRQ for the thermal controller
> > > +- clocks, clock-names: Clocks needed for the thermal controller. required
> > > +                       clocks are:
> > > +                      "therm":  Main clock needed for register access
> > > +                      "auxadc": The AUXADC clock
> > > +- resets: Reference to the reset controller controlling the thermal controller.
> > > +- mediatek,auxadc: A phandle to the AUXADC which the thermal controller uses
> > > +- mediatek,apmixedsys: A phandle to the APMIXEDSYS controller.
> > > +- #thermal-sensor-cells : Should be 0. See ./thermal.txt for a description.
> > > +
> > > +Optional properties:
> > > +- nvmem-cells: A phandle to the calibration data provided by a nvmem device. If
> > > +               unspecified default values shall be used.
> > > +- nvmem-cell-names: Should be "calibration-data"
> > > +
> > > +Example:
> > > +
> > > +       thermal: thermal@1100b000 {
> > > +               #thermal-sensor-cells = <1>;
> > 
> > Tiny nit: this should now be:
> > 
> > #thermal-sensor-cells = <0>;
> 
> 
> This is actually not so tiny'shy. Why does this driver masks out all
> sensors available? Why don't we expose all of them and use id property
> to expose and identify each of them?

This has been the case until v9 of this series. It was requested by
Mediatek that the CPU frequency regulation works better when the maximum
of all sensors is taken instead of only single sensors. We decided to
expose the maximum of all sensors in the device tree. IN the end it will
be easier to add additional sensors should we need them later than it is
to get rid of sensors we don't need.

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
