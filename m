From: Shawn Guo <shawnguo@kernel.org>
Subject: Re: [EXT] Re: [PATCH v5] arm64: dts: ls1088a: add one more thermal
 zone node
Date: Sun, 21 Apr 2019 14:45:19 +0800
Message-ID: <20190421064517.GA19962@dragon>
References: <20190411083236.9377-1-andy.tang@nxp.com>
 <915c86d8-d00e-f1e1-e7f5-24bc225c8e42@linaro.org>
 <AM6PR04MB4326561F037194D84CEB011AF3280@AM6PR04MB4326.eurprd04.prod.outlook.com>
 <6be740a0-aaa7-6b49-ba82-8d04d47b2339@linaro.org>
 <VI1PR04MB4333D0D121B60E2CDCE820BEF3260@VI1PR04MB4333.eurprd04.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <VI1PR04MB4333D0D121B60E2CDCE820BEF3260@VI1PR04MB4333.eurprd04.prod.outlook.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Andy Tang <andy.tang@nxp.com>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>, Leo Li <leoyang.li@nxp.com>, "robh+dt@kernel.org" <robh+dt@kernel.org>, "mark.rutland@arm.com" <mark.rutland@arm.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "rui.zhang@intel.com" <rui.zhang@intel.com>, "edubezval@gmail.com" <edubezval@gmail.com>
List-Id: linux-pm@vger.kernel.org

On Thu, Apr 18, 2019 at 03:28:56AM +0000, Andy Tang wrote:
> 
> > -----Original Message-----
> > From: Daniel Lezcano <daniel.lezcano@linaro.org>
> > Sent: 2019年4月12日 20:19
> > To: Andy Tang <andy.tang@nxp.com>; shawnguo@kernel.org
> > Cc: Leo Li <leoyang.li@nxp.com>; robh+dt@kernel.org; mark.rutland@arm.com;
> > linux-arm-kernel@lists.infradead.org; devicetree@vger.kernel.org;
> > linux-kernel@vger.kernel.org; linux-pm@vger.kernel.org; rui.zhang@intel.com;
> > edubezval@gmail.com
> > Subject: Re: [EXT] Re: [PATCH v5] arm64: dts: ls1088a: add one more thermal
> > zone node
> > 
> > WARNING: This email was created outside of NXP. DO NOT CLICK links or
> > attachments unless you recognize the sender and know the content is safe.
> > 
> > 
> > 
> > On 12/04/2019 09:47, Andy Tang wrote:
> > >
> > >> -----Original Message-----
> > >> From: Daniel Lezcano <daniel.lezcano@linaro.org>
> > >> Sent: 2019年4月12日 3:15
> > >> To: Andy Tang <andy.tang@nxp.com>; shawnguo@kernel.org
> > >> Cc: Leo Li <leoyang.li@nxp.com>; robh+dt@kernel.org;
> > >> mark.rutland@arm.com; linux-arm-kernel@lists.infradead.org;
> > >> devicetree@vger.kernel.org; linux-kernel@vger.kernel.org;
> > >> linux-pm@vger.kernel.org; rui.zhang@intel.com; edubezval@gmail.com
> > >> Subject: [EXT] Re: [PATCH v5] arm64: dts: ls1088a: add one more
> > >> thermal zone node
> > >>
> > >> WARNING: This email was created outside of NXP. DO NOT CLICK links or
> > >> attachments unless you recognize the sender and know the content is safe.
> > >>
> > >>
> > >>
> > >> On 11/04/2019 10:32, Yuantian Tang wrote:
> > >>> Ls1088a has 2 thermal sensors, core cluster and SoC platform. Core
> > >>> cluster sensor is used to monitor the temperature of core and SoC
> > >>> platform is for platform. The current dts only support the first sensor.
> > >>> This patch adds the second sensor node to dts to enable it.
> > >>>
> > >>> Signed-off-by: Yuantian Tang <andy.tang@nxp.com>
> > >>> ---
> > >>> v5:
> > >>>       - update the thermal zone name due to the length limitation
> > >>>       - remove cooling map in platform zone
> > >>> v4:
> > >>>       - use hyphen instead of underscore in node name
> > >>> v3:
> > >>>       - use more descriptive name for each zone
> > >>> v2:
> > >>>       - Add more information about sensors to description
> > >>>  arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi |   28
> > >> ++++++++++++++++++++---
> > >>>  1 files changed, 24 insertions(+), 4 deletions(-)
> > >>>
> > >>> diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi
> > >>> b/arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi
> > >>> index de93b42..de39672 100644
> > >>> --- a/arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi
> > >>> +++ b/arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi
> > >>> @@ -129,19 +129,19 @@
> > >>>       };
> > >>>
> > >>>       thermal-zones {
> > >>> -             cpu_thermal: cpu-thermal {
> > >>> +             core-cluster {
> > >>>                       polling-delay-passive = <1000>;
> > >>>                       polling-delay = <5000>;
> > >>>                       thermal-sensors = <&tmu 0>;
> > >>>
> > >>>                       trips {
> > >>> -                             cpu_alert: cpu-alert {
> > >>> +                             core_cluster_alert: core-cluster-alert
> > >>> + {
> > >>>                                       temperature = <85000>;
> > >>>                                       hysteresis = <2000>;
> > >>>                                       type = "passive";
> > >>>                               };
> > >>>
> > >>> -                             cpu_crit: cpu-crit {
> > >>> +                             core_cluster_crit: core-cluster-crit {
> > >>>                                       temperature = <95000>;
> > >>>                                       hysteresis = <2000>;
> > >>>                                       type = "critical"; @@ -150,7
> > >>> +150,7 @@
> > >>>
> > >>>                       cooling-maps {
> > >>>                               map0 {
> > >>> -                                     trip = <&cpu_alert>;
> > >>> +                                     trip = <&core_cluster_alert>;
> > >>>                                       cooling-device =
> > >>>                                               <&cpu0
> > >> THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
> > >>>                                               <&cpu1
> > >> THERMAL_NO_LIMIT
> > >>> THERMAL_NO_LIMIT>, @@ -163,6 +163,26 @@
> > >>>                               };
> > >>>                       };
> > >>>               };
> > >>> +
> > >>> +             platform {
> > >>> +                     polling-delay-passive = <1000>;
> > >>> +                     polling-delay = <5000>;
> > >>> +                     thermal-sensors = <&tmu 1>;
> > >>> +
> > >>> +                     trips {
> > >>> +                             platform-alert {
> > >>> +                                     temperature = <85000>;
> > >>> +                                     hysteresis = <2000>;
> > >>> +                                     type = "passive";
> > >>> +                             };
> > >>> +
> > >>> +                             platform-crit {
> > >>> +                                     temperature = <95000>;
> > >>> +                                     hysteresis = <2000>;
> > >>> +                                     type = "critical";
> > >>> +                             };
> > >>> +                     };
> > >>> +             };
> > >>
> > >>
> > >> Unfortunately, the documentation says the thermal zone node must
> > >> contain a "cooling-maps" entry.
> > > That's a question.
> > > If I add "cooling-maps", then multiple zones will use same cooling device.
> > > If I don't, documentation says it is a " Required properties".
> > > I am wondering how it was dealt with on other platform supporting multiple
> > zones.
> > 
> > I think the problem comes from the fact there are no governors capable of
> > handling multiple thermal zones.
> > 
> > The additional cooling device is the devfreq but as the mali driver is not
> > upstream, the cooling map for this device does not appear. We can find the
> > definitions and the driver in the AOSP [1].
> > 
> > Moreover, the power is usually managed by the IPA governor, but this one can
> > not handle multiple thermal zones, so the cooling devices are joined together
> > into a single thermal zone with their contribution to the cooling effect.
> > 
> > Other definitions I have seen upstream are incomplete or broken.
> > 
> > [1]
> > https://eur01.safelinks.protection.outlook.com/?url=https%3A%2F%2Fandroid.g
> > ooglesource.com%2Fkernel%2Fhikey-linaro%2F%2B%2Frefs%2Fheads%2Fandr
> > oid-hikey-linaro-4.14%2Farch%2Farm64%2Fboot%2Fdts%2Fhisilicon%2Fhi3660.
> > dtsi%231340&amp;data=02%7C01%7Candy.tang%40nxp.com%7C559218b1622e
> > 4603251908d6bf410e4b%7C686ea1d3bc2b4c6fa92cd99c5c301635%7C0%7C0%7
> > C636906683466836985&amp;sdata=952xIcrr11g%2B0nl2lgKrG18SlRVgGV6L%2
> > BMBL3U6UaiQ%3D&amp;reserved=0
> Interesting. I think we have to accept the imperfect for now.
> 
> Hi Shawn,
> Any comments?

Sorry.  I'm not going to take a DTS change that contradicts with
bindings.  If you think bindings is not reasonable, change the bindings
first.

Shawn
