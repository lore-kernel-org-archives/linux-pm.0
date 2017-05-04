From: Shawn Guo <shawnguo@kernel.org>
Subject: Re: [PATCH] ARM: dts: imx6sx-sdb: Remove cpufreq OPP override
Date: Thu, 4 May 2017 19:43:45 +0800
Message-ID: <20170504114343.GN18578@dragon>
References: <89cc7192100bdc9ce546bf6000446e629457ebc1.1493138693.git.leonard.crestez@nxp.com>
 <HE1PR04MB1450DA079FC35180FBE305388B100@HE1PR04MB1450.eurprd04.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <HE1PR04MB1450DA079FC35180FBE305388B100@HE1PR04MB1450.eurprd04.prod.outlook.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Chen <peter.chen@nxp.com>
Cc: Leonard Crestez <leonard.crestez@nxp.com>, Sascha Hauer <kernel@pengutronix.de>, Anson Huang <anson.huang@nxp.com>, Robin Gong <yibin.gong@nxp.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Fabio Estevam <fabio.estevam@nxp.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-pm@vger.kernel.org

On Thu, Apr 27, 2017 at 01:17:12AM +0000, Peter Chen wrote:
>  
> >
> >The board file for imx6sx-dbg overrides cpufreq operating points to use higher
> >voltages. This is done because the board has a shared rail for VDD_ARM_IN and
> >VDD_SOC_IN and when using LDO bypass the shared voltage needs to be a value
> >suitable for both ARM and SOC.
> >
> >This was introduced in:
> >
> >commit 54183bd7f766 ("ARM: imx6sx-sdb: add revb board and make it default")
> >
> >This only only applies to LDO bypass mode, a feature not present in upstream. When
> >LDOs are enabled the effect is to use higher voltages than necesarry for no good
> >reason.
> >
> >Setting these higher voltages can make some boards fail to boot with ugly semi-
> >random crashes, reminiscent of memory corruption. These failures happen the first
> >time the lowest idle state is used. Remove the OPP override in order to fix those
> >crashes.
> >
> 
> Add Anson and Robin
> 
> This code has existed more than 2 years, it is strange why the bug has not reported both
> for internal user and external user. I run upstream kernel using imx6sx-sdb revB very often
> at recent years, but not meet this issue. How to trigger this unstable issue, anything needs
> to change at u-boot?

Per comments from Henri and Leonard, it sounds like the issue only
happens on RevC board?

Shawn
