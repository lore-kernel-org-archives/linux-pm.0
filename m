From: Aisheng Dong <aisheng.dong@nxp.com>
Subject: RE: [PATCH V10 1/4] dt-bindings: fsl: scu: add thermal binding
Date: Wed, 6 Mar 2019 14:40:22 +0000
Message-ID: <AM0PR04MB4211F00DF5BF24BB982AFB3280730@AM0PR04MB4211.eurprd04.prod.outlook.com>
References: <1551256894-21954-1-git-send-email-Anson.Huang@nxp.com>
 <20190227235455.GA15211@bogus>
 <DB3PR0402MB391673518C43A0ABE9BDB55FF5750@DB3PR0402MB3916.eurprd04.prod.outlook.com>
 <CAL_JsqJct4BztHEak+=iNK3G7dwYR-pQPeUqb4kBnEdRQMLr6A@mail.gmail.com>
 <DB3PR0402MB3916D67D2CA6C33D27371F58F5760@DB3PR0402MB3916.eurprd04.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <DB3PR0402MB3916D67D2CA6C33D27371F58F5760@DB3PR0402MB3916.eurprd04.prod.outlook.com>
Content-Language: en-US
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Anson Huang <anson.huang@nxp.com>, Rob Herring <robh@kernel.org>
Cc: "mark.rutland@arm.com" <mark.rutland@arm.com>, "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>, "heiko@sntech.de" <heiko@sntech.de>, "maxime.ripard@bootlin.com" <maxime.ripard@bootlin.com>, "catalin.marinas@arm.com" <catalin.marinas@arm.com>, "will.deacon@arm.com" <will.deacon@arm.com>, "bjorn.andersson@linaro.org" <bjorn.andersson@linaro.org>, "festevam@gmail.com" <festevam@gmail.com>, "daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>, "jagan@amarulasolutions.com" <jagan@amarulasolutions.com>, Andy Gross <andy.gross@linaro.org>, "rui.zhang@intel.com" <rui.zhang@intel.com>, dl-linux-imx <linux-imx@nxp.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "arnd@arndb.de" <arnd@arndb.de>, "marc.w.gonzalez@free.fr" <marc.w.gonzalez@free.fr>, "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>, "edubezval@gmail.com" <edubezval@gmail.com>, olof@lixom.net
List-Id: linux-pm@vger.kernel.org

[...]

> > > > > diff --git
> > > > > a/Documentation/devicetree/bindings/arm/freescale/fsl,scu.txt
> > > > > b/Documentation/devicetree/bindings/arm/freescale/fsl,scu.txt
> > > > > index 72d481c..855270b 100644
> > > > > ---
> > > > > a/Documentation/devicetree/bindings/arm/freescale/fsl,scu.txt
> > > > > +++ b/Documentation/devicetree/bindings/arm/freescale/fsl,scu.tx
> > > > > +++ t
> > > > > @@ -122,6 +122,21 @@ RTC bindings based on SCU Message Protocol
> > > > > Required properties:
> > > > >  - compatible: should be "fsl,imx8qxp-sc-rtc";
> > > > >
> > > > > +Thermal bindings based on SCU Message Protocol
> > > > > +------------------------------------------------------------
> > > > > +
> > > > > +Required properties:
> > > > > +- compatible:                      Should be :
> > > > > +                             "fsl,imx8qxp-sc-thermal"
> > > > > +                           followed by "fsl,imx-sc-thermal";
> > > > > +
> > > > > +- #thermal-sensor-cells:   See
> > > > Documentation/devicetree/bindings/thermal/thermal.txt
> > > > > +                           for a description.
> > > > > +
> > > > > +- imx,sensor-resource-id:  A single integer for single thermal
> > > > > +zone's
> > > > resource ID or
> > > > > +                           an array of integers to specify each
> > > > > + thermal
> > > > zone's sensor
> > > > > +                           resource ID.
> > > >
> > > > Can't you put the resource ids in the thermal-sensor cells? Why do
> > > > you need to list them here?
> > >
> > > For the thermal-sensor cells, if you meant the argument of tsens
> > > phandle, then the reason is that argument is for sensor index
> > > starting from 0, previous I use it for our resource ID, but it looks
> > > confused, since user will think there are many sensors there per Eduardo's
> comment.
> > >
> > > +                       thermal-sensors = <&tsens 0>;
> > >
> > > If you meant putting it in each thermal sensor node instead of "tsens"
> > > node, then in previous patch series, I put this "
> > > imx,sensor-resource-id " property in each thermal sensor node, but
> > > the thermal sensor nodes are parsed by common thermal framework,
> > > thermal driver will need to find the thermal zone node and go
> > > through every child node to get the resource id again, so Eduardo
> > > suggested to put it in
> > our platform tsens node, that makes our thermal driver code much more
> > simple.
> >
> > The phandle args are meant to be an id typically. There's absolutely
> > no requirement they are 0-N based. They often are because things like
> > interrupts are 0-N or clocks have no h/w id. If you already have an id, use it.
> > Don't invent your own.
> 
> At the beginning, I put the HW resource ID in the "tsens" phandle argument of
> "thermal-sensors" node, see  below patch I sent before, the benefit is I do
> NOT need to add new property for passing HW resource ID to driver, the
> disadvantage is, I have to parse the thermal_zones' each child node and get the
> HW resource ID from phandle argument(searing thermal_zones node and go
> through all its child node, and get the phandle argument), they are by default
> ONLY parsed by thermal core driver. When we register thermal zone, we have
> to pass the HW resource ID when calling
> devm_thermal_zone_of_sensor_register(), if we add our own property to pass
> the HW resource ID, then no need to do so, we just pass the index 0-N for each
> thermal sensors in devicetree which also with phandle argument 0-N. So using
> our own property makes the driver much more simple.
> 
> So, @Eduardo, which direction I should go? Looks like Rob suggests just put
> the HW resource ID in the phandle argument like what I did at the beginning,
> can you advise?
> 

I prefer to Rob suggested way that directly use resource id for thermal-sensor cells.

For SW implementation, we can either parse the sensor resource id from device tree
or statically define it in driver.
Parsing from DT could make the driver more generic and do not need change for the number
Of sensor changes in furture SoCs which probably is better.

One more suggestion is please list all supported sensors in binding doc to avoid confusing.

Regards
Dong Aisheng

> Thanks,
> Anson.
> 
> https://patchwork.kernel.org/patch/10703849/
> > +	thermal_zones: thermal-zones {
> > +		cpu-thermal0 {
> > +			polling-delay-passive = <250>;
> > +			polling-delay = <2000>;
> > +			thermal-sensors = <&tsens 355>;
> > +			trips {
> > +				cpu_alert0: trip0 {
> > +					temperature = <107000>;
> > +					hysteresis = <2000>;
> > +					type = "passive";
> > +				};
> 
> >
> > Rob
