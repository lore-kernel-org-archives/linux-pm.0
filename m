From: Aisheng Dong <aisheng.dong@nxp.com>
Subject: RE: [PATCH V8 1/4] dt-bindings: fsl: scu: add thermal binding
Date: Tue, 26 Feb 2019 12:00:57 +0000
Message-ID: <VI1PR04MB422261F6A295A58FF06E90DE807B0@VI1PR04MB4222.eurprd04.prod.outlook.com>
References: <1550730831-14995-1-git-send-email-Anson.Huang@nxp.com>
 <20190223213759.GA1472@localhost.localdomain>
 <DB3PR0402MB39164677D09DA6CB3A6951B3F5790@DB3PR0402MB3916.eurprd04.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <DB3PR0402MB39164677D09DA6CB3A6951B3F5790@DB3PR0402MB3916.eurprd04.prod.outlook.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Anson Huang <anson.huang@nxp.com>, Eduardo Valentin <edubezval@gmail.com>
Cc: "robh+dt@kernel.org" <robh+dt@kernel.org>, "mark.rutland@arm.com" <mark.rutland@arm.com>, "shawnguo@kernel.org" <shawnguo@kernel.org>, "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>, "kernel@pengutronix.de" <kernel@pengutronix.de>, "festevam@gmail.com" <festevam@gmail.com>, "catalin.marinas@arm.com" <catalin.marinas@arm.com>, "will.deacon@arm.com" <will.deacon@arm.com>, "rui.zhang@intel.com" <rui.zhang@intel.com>, "daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>, "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>, "sboyd@kernel.org" <sboyd@kernel.org>, Daniel Baluta <daniel.baluta@nxp.com>, Andy Gross <andy.gross@linaro.org>, "horms+renesas@verge.net.au" <horms+renesas@verge.net.au>, "heiko@sntech.de" <heiko@sntech.de>, "arnd@arndb.de" <arnd@arndb.d>
List-Id: linux-pm@vger.kernel.org

[...]
> > On Thu, Feb 21, 2019 at 06:38:30AM +0000, Anson Huang wrote:
> > > NXP i.MX8QXP is an ARMv8 SoC with a Cortex-M4 core inside as system
> > > controller, the system controller is in charge of system power,
> > > clock and thermal sensors etc. management, Linux kernel has to
> > > communicate with system controller via MU (message unit) IPC to get
> > > temperature from thermal sensors, this patch adds binding doc for
> > > i.MX system controller thermal driver.
> > >
> > > Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
> > > Reviewed-by: Rob Herring <robh@kernel.org>

You need drop the former Reviewed-by once there's significant changes.

> > > +Thermal bindings based on SCU Message Protocol
> > > +------------------------------------------------------------
> > > +
> > > +Required properties:
> > > +- compatible:			Should be :
> > > +				  "fsl,imx8qxp-sc-thermal"
> > > +				followed by "fsl,imx-sc-thermal";
> > > +
> > > +- #thermal-sensor-cells:	See
> > Documentation/devicetree/bindings/thermal/thermal.txt
> > > +				for a description.
> > > +
> > > +- imx,sensor-resource-id: 	Property array to specify each thermal
> zone's
> > sensor resource ID.
> >
> > If this is an array...
> >
> > > +
> > >  Example (imx8qxp):
> > >  -------------
> > >  lsio_mu1: mailbox@5d1c0000 {
> > > @@ -168,6 +181,12 @@ firmware {
> > >  		rtc: rtc {
> > >  			compatible =3D "fsl,imx8qxp-sc-rtc";
> > >  		};
> > > +
> > > +		tsens: thermal-sensor {
> > > +			compatible =3D "fsl,imx8qxp-sc-thermal", "fsl,imx-sc-
> > thermal";
> > > +			#thermal-sensor-cells =3D <0>;
> > > +			imx,sensor-resource-id =3D <IMX_SC_R_SYSTEM>;
> >
> > then this example should have an array, to be better express how this
> > is supposed to work. Can you please resend this with an array instead?
>=20
> On i.MX8QXP, there is ONLY 1 thermal zone available currently, but the th=
ermal
> driver is supposed to support multi thermal zones as well for i.MX8QM, in=
 V9
> patch set I just sent, I use the " imx,sensor-resource-id " element count=
 to
> determine how many thermal sensors will be supported, so that we can also
> get rid of searching the thermal-zones' child node, I improved the descri=
ption
> as below, is it OK?
>=20

Device tree is used to describe HW.
#thermal-sensor-cells is less to be an optional parameter to me.
If HW supports, then it should be 1 and update the example accordingly.

Regards
Dong Aisheng

>  41 +- imx,sensor-resource-id:      A single integer for single thermal z=
one's
> resource ID or
>  42 +                               an array of integers to specify each
> thermal zone's sensor
>  43 +                               resource ID.
