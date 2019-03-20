From: Shawn Guo <shawnguo@kernel.org>
Subject: Re: [PATCH v2] arm64: dts: ls1088a: add one more thermal zone node
Date: Wed, 20 Mar 2019 22:49:09 +0800
Message-ID: <20190320144907.GC8337@dragon>
References: <20190304032111.21770-1-andy.tang@nxp.com>
 <20190304062115.GB26041@dragon>
 <VI1PR04MB433386B86A5E6AA804E9C3B5F3710@VI1PR04MB4333.eurprd04.prod.outlook.com>
 <dc94e884-f5eb-fe07-27ef-6a94c3174acb@linaro.org>
 <VI1PR04MB43330C6FAAD0D8EAE901C56FF34D0@VI1PR04MB4333.eurprd04.prod.outlook.com>
 <cb262e2c-7115-86a5-01ce-4a12d45ee019@linaro.org>
 <VI1PR04MB43338294C193D1AB4F577E92F34D0@VI1PR04MB4333.eurprd04.prod.outlook.com>
 <20190320081853.GE4980@dragon>
 <VI1PR04MB433351C20A9863EEF21A2504F3410@VI1PR04MB4333.eurprd04.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <VI1PR04MB433351C20A9863EEF21A2504F3410@VI1PR04MB4333.eurprd04.prod.outlook.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Andy Tang <andy.tang@nxp.com>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>, "mark.rutland@arm.com" <mark.rutland@arm.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Leo Li <leoyang.li@nxp.com>, "edubezval@gmail.com" <edubezval@gmail.com>, "robh+dt@kernel.org" <robh+dt@kernel.org>, "rui.zhang@intel.com" <rui.zhang@intel.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-pm@vger.kernel.org

On Wed, Mar 20, 2019 at 08:44:18AM +0000, Andy Tang wrote:
> > > Sensor ID		placement
> > > 1			DDR controller 1
> > > 2			DDR controller 2
> > > 3			DDR controller 3
> > > 4			core cluster 1
> > > 5 		core cluster 2
> > > 6 		core cluster 3
> > > 7 		core cluster 4
> > >
> > > Apparently using CPU or CPU-cluster is not appropriate. Core-cluster is better.
> > 
> > So using CPU is appropriate for me, less confusing, more consistent with other
> > platforms.
> What about core cluster? We can't name it cpu0, cpu1 etc I think.

Hmm, yes, that would be even more confusing.  What about cpu-thermal-1,
cpu-thermal-2 ...?

Shawn
