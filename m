From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH V10 1/4] dt-bindings: fsl: scu: add thermal binding
Date: Thu, 28 Feb 2019 08:49:10 -0600
Message-ID: <CAL_JsqJct4BztHEak+=iNK3G7dwYR-pQPeUqb4kBnEdRQMLr6A@mail.gmail.com>
References: <1551256894-21954-1-git-send-email-Anson.Huang@nxp.com>
 <20190227235455.GA15211@bogus> <DB3PR0402MB391673518C43A0ABE9BDB55FF5750@DB3PR0402MB3916.eurprd04.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <DB3PR0402MB391673518C43A0ABE9BDB55FF5750@DB3PR0402MB3916.eurprd04.prod.outlook.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Anson Huang <anson.huang@nxp.com>
Cc: "mark.rutland@arm.com" <mark.rutland@arm.com>, "shawnguo@kernel.org" <shawnguo@kernel.org>, "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>, "kernel@pengutronix.de" <kernel@pengutronix.de>, "festevam@gmail.com" <festevam@gmail.com>, "catalin.marinas@arm.com" <catalin.marinas@arm.com>, "will.deacon@arm.com" <will.deacon@arm.com>, "rui.zhang@intel.com" <rui.zhang@intel.com>, "edubezval@gmail.com" <edubezval@gmail.com>, "daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>, Aisheng Dong <aisheng.dong@nxp.com>, "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>, "sboyd@kernel.org" <sboyd@kernel.org>, Daniel Baluta <daniel.baluta@nxp.com>, Andy Gross <andy.gross@linaro.org>, "horms+renesas@verge.net.au" <horms+renesas@verge.net.au>, "heiko@sntech.de" <heiko@sn>
List-Id: linux-pm@vger.kernel.org

On Wed, Feb 27, 2019 at 6:48 PM Anson Huang <anson.huang@nxp.com> wrote:
>
> Hi, Rob
>
> Best Regards!
> Anson Huang
>
> > -----Original Message-----
> > From: Rob Herring [mailto:robh@kernel.org]
> > Sent: 2019=E5=B9=B42=E6=9C=8828=E6=97=A5 7:55
> > To: Anson Huang <anson.huang@nxp.com>
> > Cc: mark.rutland@arm.com; shawnguo@kernel.org;
> > s.hauer@pengutronix.de; kernel@pengutronix.de; festevam@gmail.com;
> > catalin.marinas@arm.com; will.deacon@arm.com; rui.zhang@intel.com;
> > edubezval@gmail.com; daniel.lezcano@linaro.org; Aisheng Dong
> > <aisheng.dong@nxp.com>; ulf.hansson@linaro.org; sboyd@kernel.org;
> > Daniel Baluta <daniel.baluta@nxp.com>; Andy Gross
> > <andy.gross@linaro.org>; horms+renesas@verge.net.au; heiko@sntech.de;
> > arnd@arndb.de; maxime.ripard@bootlin.com; bjorn.andersson@linaro.org;
> > jagan@amarulasolutions.com; enric.balletbo@collabora.com;
> > marc.w.gonzalez@free.fr; olof@lixom.net; devicetree@vger.kernel.org;
> > linux-kernel@vger.kernel.org; linux-arm-kernel@lists.infradead.org; lin=
ux-
> > pm@vger.kernel.org; dl-linux-imx <linux-imx@nxp.com>
> > Subject: Re: [PATCH V10 1/4] dt-bindings: fsl: scu: add thermal binding
> >
> > On Wed, Feb 27, 2019 at 08:46:21AM +0000, Anson Huang wrote:
> > > NXP i.MX8QXP is an ARMv8 SoC with a Cortex-M4 core inside as system
> > > controller, the system controller is in charge of system power, clock
> > > and thermal sensors etc. management, Linux kernel has to communicate
> > > with system controller via MU (message unit) IPC to get temperature
> > > from thermal sensors, this patch adds binding doc for i.MX system
> > > controller thermal driver.
> > >
> > > Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
> > > ---
> > > Changes since V9:
> > >     - change #thermal-sensor-cells value in example to 1, since there=
 are
> > other
> > >       thermal sensors inside system controller, it is just because th=
ere are
> > still
> > >       some issue, so system controller does NOT expose them for now,
> > they could
> > >       be exposed later, so it should be 1 from HW perspective.
> > > ---
> > >  .../devicetree/bindings/arm/freescale/fsl,scu.txt   | 21
> > +++++++++++++++++++++
> > >  1 file changed, 21 insertions(+)
> > >
> > > diff --git
> > > a/Documentation/devicetree/bindings/arm/freescale/fsl,scu.txt
> > > b/Documentation/devicetree/bindings/arm/freescale/fsl,scu.txt
> > > index 72d481c..855270b 100644
> > > --- a/Documentation/devicetree/bindings/arm/freescale/fsl,scu.txt
> > > +++ b/Documentation/devicetree/bindings/arm/freescale/fsl,scu.txt
> > > @@ -122,6 +122,21 @@ RTC bindings based on SCU Message Protocol
> > > Required properties:
> > >  - compatible: should be "fsl,imx8qxp-sc-rtc";
> > >
> > > +Thermal bindings based on SCU Message Protocol
> > > +------------------------------------------------------------
> > > +
> > > +Required properties:
> > > +- compatible:                      Should be :
> > > +                             "fsl,imx8qxp-sc-thermal"
> > > +                           followed by "fsl,imx-sc-thermal";
> > > +
> > > +- #thermal-sensor-cells:   See
> > Documentation/devicetree/bindings/thermal/thermal.txt
> > > +                           for a description.
> > > +
> > > +- imx,sensor-resource-id:  A single integer for single thermal zone'=
s
> > resource ID or
> > > +                           an array of integers to specify each ther=
mal
> > zone's sensor
> > > +                           resource ID.
> >
> > Can't you put the resource ids in the thermal-sensor cells? Why do you =
need
> > to list them here?
>
> For the thermal-sensor cells, if you meant the argument of tsens phandle,=
 then
> the reason is that argument is for sensor index starting from 0, previous=
 I use
> it for our resource ID, but it looks confused, since user will think ther=
e are many
> sensors there per Eduardo's comment.
>
> +                       thermal-sensors =3D <&tsens 0>;
>
> If you meant putting it in each thermal sensor node instead of "tsens" no=
de, then
> in previous patch series, I put this " imx,sensor-resource-id " property =
in each thermal
> sensor node, but the thermal sensor nodes are parsed by common thermal fr=
amework,
> thermal driver will need to find the thermal zone node and go through eve=
ry child node
> to get the resource id again, so Eduardo suggested to put it in our platf=
orm tsens node, that makes
> our thermal driver code much more simple.

The phandle args are meant to be an id typically. There's absolutely
no requirement they are 0-N based. They often are because things like
interrupts are 0-N or clocks have no h/w id. If you already have an
id, use it. Don't invent your own.

Rob
