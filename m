From: Pi-Cheng Chen <pi-cheng.chen@linaro.org>
Subject: Re: [RFC PATCH 3/5] dt-bindings: thermal: Add optional properties of
 Mediatek thermal controller
Date: Mon, 25 Jan 2016 08:21:20 +0800
Message-ID: <20160125002120.GA2848@gmail.com>
References: <1453452029-20843-1-git-send-email-pi-cheng.chen@linaro.org>
 <1453452029-20843-4-git-send-email-pi-cheng.chen@linaro.org>
 <20160122223136.GA21819@rob-hp-laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pf0-f172.google.com ([209.85.192.172]:32874 "EHLO
	mail-pf0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752265AbcAYAV0 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Sun, 24 Jan 2016 19:21:26 -0500
Received: by mail-pf0-f172.google.com with SMTP id e65so72710141pfe.0
        for <linux-pm@vger.kernel.org>; Sun, 24 Jan 2016 16:21:26 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20160122223136.GA21819@rob-hp-laptop>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Rob Herring <robh@kernel.org>
Cc: Nishanth Menon <nm@ti.com>, Eduardo Valentin <edubezval@gmail.com>, Viresh Kumar <viresh.kumar@linaro.org>, Sascha Hauer <kernel@pengutronix.de>, Kevin Hilman <khilman@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>, linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, linux-pm@vger.kernel.org, devicetree@vger.kernel.org

On Fri, Jan 22, 2016 at 04:31:36PM -0600, Rob Herring wrote:
> On Fri, Jan 22, 2016 at 04:40:27PM +0800, Pi-Cheng Chen wrote:
> > This adds optional properties of Mediatek thermal controller which are
> > required by SVS engine integrated with Mediatek thermal controller.
> > 
> > Signed-off-by: Pi-Cheng Chen <pi-cheng.chen@linaro.org>
> > ---
> >  .../bindings/thermal/mediatek-thermal.txt          | 23 ++++++++++++++++------
> >  1 file changed, 17 insertions(+), 6 deletions(-)
> > 
> > diff --git a/Documentation/devicetree/bindings/thermal/mediatek-thermal.txt b/Documentation/devicetree/bindings/thermal/mediatek-thermal.txt
> > index 81f9a51..acaacaa 100644
> > --- a/Documentation/devicetree/bindings/thermal/mediatek-thermal.txt
> > +++ b/Documentation/devicetree/bindings/thermal/mediatek-thermal.txt
> > @@ -7,6 +7,11 @@ this device needs phandles to the AUXADC. Also it controls a mux in the
> >  apmixedsys register space via AHB bus accesses, so a phandle to the APMIXEDSYS
> >  is also needed.
> >  
> > +There is another hardware engine, SVS (Smart Voltage Scaling) which shares the
> > +same block of banked registers with Mediatek thermal controller. Hence the
> > +driver of SVS is integrated with the driver of Mediatek thermal controller. The
> > +properties required by SVS engine are optional for Mediatek thermal controller.
> > +
> >  Required properties:
> >  - compatible: "mediatek,mt8173-thermal"
> >  - reg: Address range of the thermal controller
> > @@ -21,9 +26,15 @@ Required properties:
> >  - #thermal-sensor-cells : Should be 0. See ./thermal.txt for a description.
> >  
> >  Optional properties:
> > -- nvmem-cells: A phandle to the calibration data provided by a nvmem device. If
> > -               unspecified default values shall be used.
> > -- nvmem-cell-names: Should be "calibration-data"
> > +- clocks, clock-names: Clocks that are optional for the thermal controller.
> > +	       Specify to enable SVS engine.
> > +	       "svs_pll": The PLL clock should be switched to during
> > +			  initialization stage of SVS engine.
> > +	       "svs_mux": The MUX clock controls the clock input of SVS engine.
> > +- nvmem-cells: A list of phandles to the calibration data provided by a nvmem
> > +	       device. If unspecified default values shall be used. The SVS
> > +	       engine will be disabled if no SVS calibration data is specified.
> > +- nvmem-cell-names: Should be "calibration-data" and "svs-calibration-data"
> >  
> >  Example:
> >  
> > @@ -33,11 +44,11 @@ Example:
> >  		reg = <0 0x1100b000 0 0x1000>;
> >  		interrupts = <0 70 IRQ_TYPE_LEVEL_LOW>;
> >  		clocks = <&pericfg CLK_PERI_THERM>, <&pericfg CLK_PERI_AUXADC>;
> > -		clock-names = "therm", "auxadc";
> > +		clock-names = "therm", "auxadc", ;
> 
> Huh?
> 

It should be:

clocks = <&pericfg CLK_PERI_THERM>, <&pericfg CLK_PERI_AUXADC>,
	 <&topckgen CLK_TOP_SYSPLL1_D2>, <&topckgen CLK_TOP_AXI_SEL>;
clock-names = "therm", "auxadc", "svs_pll", "svs_mux";

Sorry for my mistake.

> >  		resets = <&pericfg MT8173_PERI_THERM_SW_RST>;
> >  		reset-names = "therm";
> >  		mediatek,auxadc = <&auxadc>;
> >  		mediatek,apmixedsys = <&apmixedsys>;
> > -		nvmem-cells = <&thermal_calibration_data>;
> > -		nvmem-cell-names = "calibration-data";
> > +		nvmem-cells = <&thermal_calibration_data>, <&svs-calibration>;
> > +		nvmem-cell-names = "calibration-data", "svs-calibration-data";
> >  	};
> > -- 
> > 1.9.1
> > 
