From: Eduardo Valentin <edubezval@gmail.com>
Subject: Re: [PATCH V8 1/4] dt-bindings: fsl: scu: add thermal binding
Date: Sat, 23 Feb 2019 13:40:19 -0800
Message-ID: <20190223214018.GC1472@localhost.localdomain>
References: <1550730831-14995-1-git-send-email-Anson.Huang@nxp.com>
 <20190223213759.GA1472@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190223213759.GA1472@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
To: Anson Huang <anson.huang@nxp.com>
Cc: "robh+dt@kernel.org" <robh+dt@kernel.org>, "mark.rutland@arm.com" <mark.rutland@arm.com>, "shawnguo@kernel.org" <shawnguo@kernel.org>, "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>, "kernel@pengutronix.de" <kernel@pengutronix.de>, "festevam@gmail.com" <festevam@gmail.com>, "catalin.marinas@arm.com" <catalin.marinas@arm.com>, "will.deacon@arm.com" <will.deacon@arm.com>, "rui.zhang@intel.com" <rui.zhang@intel.com>, "daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>, Aisheng Dong <aisheng.dong@nxp.com>, "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>, "sboyd@kernel.org" <sboyd@kernel.org>, Daniel Baluta <daniel.baluta@nxp.com>, Andy Gross <andy.gross@linaro.org>, "horms+renesas@verge.net.au" <horms+renesas@verge.net.au>, "heiko@sntech.de" <heiko@snte>
List-Id: linux-pm@vger.kernel.org

On Sat, Feb 23, 2019 at 01:38:00PM -0800, Eduardo Valentin wrote:
> On Thu, Feb 21, 2019 at 06:38:30AM +0000, Anson Huang wrote:
> > NXP i.MX8QXP is an ARMv8 SoC with a Cortex-M4 core inside as
> > system controller, the system controller is in charge of system
> > power, clock and thermal sensors etc. management, Linux kernel
> > has to communicate with system controller via MU (message unit)
> > IPC to get temperature from thermal sensors, this patch adds
> > binding doc for i.MX system controller thermal driver.
> > 
> > Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
> > Reviewed-by: Rob Herring <robh@kernel.org>
> > ---
> > Changes since V7:
> >         - remove unused property "tsens-num";
> >         - improve the compatible description;
> >         - update examples according to latest dts file.
> > ---
> >  .../devicetree/bindings/arm/freescale/fsl,scu.txt     | 19 +++++++++++++++++++
> >  1 file changed, 19 insertions(+)
> > 
> > diff --git a/Documentation/devicetree/bindings/arm/freescale/fsl,scu.txt b/Documentation/devicetree/bindings/arm/freescale/fsl,scu.txt
> > index 72d481c..d89147e 100644
> > --- a/Documentation/devicetree/bindings/arm/freescale/fsl,scu.txt
> > +++ b/Documentation/devicetree/bindings/arm/freescale/fsl,scu.txt
> > @@ -122,6 +122,19 @@ RTC bindings based on SCU Message Protocol
> >  Required properties:
> >  - compatible: should be "fsl,imx8qxp-sc-rtc";
> >  
> > +Thermal bindings based on SCU Message Protocol
> > +------------------------------------------------------------
> > +
> > +Required properties:
> > +- compatible:			Should be :
> > +				  "fsl,imx8qxp-sc-thermal"
> > +				followed by "fsl,imx-sc-thermal";
> > +
> > +- #thermal-sensor-cells:	See Documentation/devicetree/bindings/thermal/thermal.txt
> > +				for a description.
> > +
> > +- imx,sensor-resource-id: 	Property array to specify each thermal zone's sensor resource ID.
> 
> If this is an array...
> 
> > +
> >  Example (imx8qxp):
> >  -------------
> >  lsio_mu1: mailbox@5d1c0000 {
> > @@ -168,6 +181,12 @@ firmware {
> >  		rtc: rtc {
> >  			compatible = "fsl,imx8qxp-sc-rtc";
> >  		};
> > +
> > +		tsens: thermal-sensor {
> > +			compatible = "fsl,imx8qxp-sc-thermal", "fsl,imx-sc-thermal";
> > +			#thermal-sensor-cells = <0>;
> > +			imx,sensor-resource-id = <IMX_SC_R_SYSTEM>;
> 
> then this example should have an array, to be better express how this is
> supposed to work. Can you please resend this with an array instead?

I mean this could be one example of an array with more than one element.

> 
> > +		};
> >  	};
> >  };
> >  
> > -- 
> > 2.7.4
> > 
