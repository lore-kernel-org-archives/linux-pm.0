From: Eduardo Valentin <edubezval@gmail.com>
Subject: Re: [PATCH V6 1/4] dt-bindings: fsl: scu: add thermal binding
Date: Tue, 19 Feb 2019 17:04:22 -0800
Message-ID: <20190220010420.GA2811@localhost.localdomain>
References: <1549532838-27025-1-git-send-email-Anson.Huang@nxp.com>
 <DB3PR0402MB39165EFE027405873E8AB4ECF5660@DB3PR0402MB3916.eurprd04.prod.outlook.com>
 <DB3PR0402MB3916C9B1A6F0E4C6352BA43CF57C0@DB3PR0402MB3916.eurprd04.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <DB3PR0402MB3916C9B1A6F0E4C6352BA43CF57C0@DB3PR0402MB3916.eurprd04.prod.outlook.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Anson Huang <anson.huang@nxp.com>
Cc: "robh+dt@kernel.org" <robh+dt@kernel.org>, "mark.rutland@arm.com" <mark.rutland@arm.com>, "shawnguo@kernel.org" <shawnguo@kernel.org>, "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>, "kernel@pengutronix.de" <kernel@pengutronix.de>, "festevam@gmail.com" <festevam@gmail.com>, "catalin.marinas@arm.com" <catalin.marinas@arm.com>, "will.deacon@arm.com" <will.deacon@arm.com>, "rui.zhang@intel.com" <rui.zhang@intel.com>, "daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>, Aisheng Dong <aisheng.dong@nxp.com>, "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>, Daniel Baluta <daniel.baluta@nxp.com>, "horms+renesas@verge.net.au" <horms+renesas@verge.net.au>, Andy Gross <andy.gross@linaro.org>, "heiko@sntech.de" <heiko@sntech.de>, "arnd@arndb.de" <arnd@arndb.de>
List-Id: linux-pm@vger.kernel.org

On Tue, Feb 19, 2019 at 07:20:58AM +0000, Anson Huang wrote:
> Ping...

I will take a look on this.

> 
> Best Regards!
> Anson Huang
> 
> > -----Original Message-----
> > From: Anson Huang
> > Sent: 2019年2月13日 13:36
> > To: robh+dt@kernel.org; mark.rutland@arm.com; shawnguo@kernel.org;
> > s.hauer@pengutronix.de; kernel@pengutronix.de; festevam@gmail.com;
> > catalin.marinas@arm.com; will.deacon@arm.com; rui.zhang@intel.com;
> > edubezval@gmail.com; daniel.lezcano@linaro.org; Aisheng Dong
> > <aisheng.dong@nxp.com>; ulf.hansson@linaro.org; Daniel Baluta
> > <daniel.baluta@nxp.com>; horms+renesas@verge.net.au; Andy Gross
> > <andy.gross@linaro.org>; heiko@sntech.de; arnd@arndb.de;
> > maxime.ripard@bootlin.com; jagan@amarulasolutions.com;
> > bjorn.andersson@linaro.org; enric.balletbo@collabora.com;
> > marc.w.gonzalez@free.fr; olof@lixom.net; devicetree@vger.kernel.org;
> > linux-kernel@vger.kernel.org; linux-arm-kernel@lists.infradead.org; linux-
> > pm@vger.kernel.org
> > Cc: dl-linux-imx <linux-imx@nxp.com>
> > Subject: RE: [PATCH V6 1/4] dt-bindings: fsl: scu: add thermal binding
> > 
> > Gental ping...
> > 
> > Best Regards!
> > Anson Huang
> > 
> > > -----Original Message-----
> > > From: Anson Huang
> > > Sent: 2019年2月7日 17:53
> > > To: robh+dt@kernel.org; mark.rutland@arm.com; shawnguo@kernel.org;
> > > s.hauer@pengutronix.de; kernel@pengutronix.de; festevam@gmail.com;
> > > catalin.marinas@arm.com; will.deacon@arm.com; rui.zhang@intel.com;
> > > edubezval@gmail.com; daniel.lezcano@linaro.org; Aisheng Dong
> > > <aisheng.dong@nxp.com>; ulf.hansson@linaro.org; Daniel Baluta
> > > <daniel.baluta@nxp.com>; horms+renesas@verge.net.au; Andy Gross
> > > <andy.gross@linaro.org>; heiko@sntech.de; arnd@arndb.de;
> > > maxime.ripard@bootlin.com; jagan@amarulasolutions.com;
> > > bjorn.andersson@linaro.org; enric.balletbo@collabora.com;
> > > marc.w.gonzalez@free.fr; olof@lixom.net; devicetree@vger.kernel.org;
> > > linux-kernel@vger.kernel.org; linux-arm-kernel@lists.infradead.org;
> > > linux- pm@vger.kernel.org
> > > Cc: dl-linux-imx <linux-imx@nxp.com>
> > > Subject: [PATCH V6 1/4] dt-bindings: fsl: scu: add thermal binding
> > >
> > > NXP i.MX8QXP is an ARMv8 SoC with a Cortex-M4 core inside as system
> > > controller, the system controller is in charge of system power, clock
> > > and thermal sensors etc. management, Linux kernel has to communicate
> > > with system controller via MU (message unit) IPC to get temperature
> > > from thermal sensors, this patch adds binding doc for i.MX system
> > > controller thermal driver.
> > >
> > > Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
> > > Reviewed-by: Rob Herring <robh@kernel.org>
> > > ---
> > > ChangeLog since V5:
> > > 	- add "imx,sensor-resource-id" in each thermal zone to pass resource
> > > ID for thermal driver.
> > > ---
> > >  .../devicetree/bindings/arm/freescale/fsl,scu.txt    | 20
> > > ++++++++++++++++++++
> > >  1 file changed, 20 insertions(+)
> > >
> > > diff --git
> > > a/Documentation/devicetree/bindings/arm/freescale/fsl,scu.txt
> > > b/Documentation/devicetree/bindings/arm/freescale/fsl,scu.txt
> > > index 72d481c..4b79751 100644
> > > --- a/Documentation/devicetree/bindings/arm/freescale/fsl,scu.txt
> > > +++ b/Documentation/devicetree/bindings/arm/freescale/fsl,scu.txt
> > > @@ -122,6 +122,20 @@ RTC bindings based on SCU Message Protocol
> > > Required properties:
> > >  - compatible: should be "fsl,imx8qxp-sc-rtc";
> > >
> > > +Thermal bindings based on SCU Message Protocol
> > > +------------------------------------------------------------
> > > +
> > > +Required properties:
> > > +- compatible : Must be "fsl,imx8qxp-sc-thermal";
> > > +- tsens-num : Total number of thermal sensors supported;
> > > +- #thermal-sensor-cells : Should be 1. See
> > > +
> > > Documentation/devicetree/bindings/thermal/thermal.txt
> > > +			  for a description.
> > > +- imx,sensor-resource-id : This property should be defined in each
> > > +thermal
> > > zone
> > > +			   of thermal-zones node, it passes each thermal
> > > zone's
> > > +			   resource id for thermal driver to get temperature
> > > via
> > > +			   SCU IPC.
> > > +
> > >  Example (imx8qxp):
> > >  -------------
> > >  lsio_mu1: mailbox@5d1c0000 {
> > > @@ -168,6 +182,12 @@ firmware {
> > >  		rtc: rtc {
> > >  			compatible = "fsl,imx8qxp-sc-rtc";
> > >  		};
> > > +
> > > +		tsens: thermal-sensor {
> > > +			compatible = "fsl,imx8qxp-sc-thermal";
> > > +			tsens-num = <1>;
> > > +			#thermal-sensor-cells = <1>;
> > > +		};
> > >  	};
> > >  };
> > >
> > > --
> > > 2.7.4
> 
