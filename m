From: Shawn Guo <shawnguo@kernel.org>
Subject: Re: [PATCH v2] arm64: dts: ls1088a: add one more thermal zone node
Date: Mon, 4 Mar 2019 14:53:03 +0800
Message-ID: <20190304065302.GD26041@dragon>
References: <20190304032111.21770-1-andy.tang@nxp.com>
 <20190304062115.GB26041@dragon>
 <VI1PR04MB433386B86A5E6AA804E9C3B5F3710@VI1PR04MB4333.eurprd04.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <VI1PR04MB433386B86A5E6AA804E9C3B5F3710@VI1PR04MB4333.eurprd04.prod.outlook.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Andy Tang <andy.tang@nxp.com>
Cc: "mark.rutland@arm.com" <mark.rutland@arm.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Leo Li <leoyang.li@nxp.com>, "edubezval@gmail.com" <edubezval@gmail.com>, "robh+dt@kernel.org" <robh+dt@kernel.org>, "rui.zhang@intel.com" <rui.zhang@intel.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-pm@vger.kernel.org

On Mon, Mar 04, 2019 at 06:46:32AM +0000, Andy Tang wrote:
> 
> 
> > -----Original Message-----
> > From: Shawn Guo <shawnguo@kernel.org>
> > Sent: 2019年3月4日 14:21
> > To: Andy Tang <andy.tang@nxp.com>
> > Cc: Leo Li <leoyang.li@nxp.com>; robh+dt@kernel.org; mark.rutland@arm.com;
> > linux-arm-kernel@lists.infradead.org; devicetree@vger.kernel.org;
> > linux-kernel@vger.kernel.org; linux-pm@vger.kernel.org;
> > daniel.lezcano@linaro.org; rui.zhang@intel.com; edubezval@gmail.com
> > Subject: Re: [PATCH v2] arm64: dts: ls1088a: add one more thermal zone node
> > 
> > On Mon, Mar 04, 2019 at 11:21:11AM +0800, Yuantian Tang wrote:
> > > Ls1088a has 2 thermal sensors, core cluster and SoC platform. Core
> > > cluster sensor is used to monitor the temperature of core and SoC
> > > platform is for platform. The current dts only support the first sensor.
> > > This patch adds the second sensor node to dts to enable it.
> > >
> > > Signed-off-by: Yuantian Tang <andy.tang@nxp.com>
> > > ---
> > > v2:
> > > 	- Add more information about sensors to description
> > > PS: In order to keep consistency to the first thermal-zone node, there
> > > will be "WARNING: line over 80 characters" warnings.
> > >
> > >  arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi |   43
> > +++++++++++++++++++++--
> > >  1 files changed, 39 insertions(+), 4 deletions(-)
> > >
> > > diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi
> > > b/arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi
> > > index 661137f..9f52bc9 100644
> > > --- a/arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi
> > > +++ b/arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi
> > > @@ -129,19 +129,19 @@
> > >  	};
> > >
> > >  	thermal-zones {
> > > -		cpu_thermal: cpu-thermal {
> > > +		ccu {
> > 
> > Is this change really necessary?  What does 'ccu' stand for?
> I think so. ccu stands for core cluster unit. cpu is too general.
> On some platforms, there are more than one core clusters.
> At least we should change it to "core cluster" if short form is not appropriate.

Yes, please give it a more descriptive name.

Shawn
