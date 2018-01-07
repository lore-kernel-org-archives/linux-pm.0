From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH 2/2] cpufreq: imx6q: add 696MHz operating point for i.mx6ul
Date: Mon, 08 Jan 2018 00:34:00 +0100
Message-ID: <2009633.KF2URkV5n1@aspire.rjw.lan>
References: <1514912859-17691-1-git-send-email-Anson.Huang@nxp.com> <CAJZ5v0it+Gc5nTa5Vt8X8_OPHh6ndcQB3peAQA1SDsuQ2+FZKA@mail.gmail.com> <AM3PR04MB131556AF9BDE24E071A51300F51D0@AM3PR04MB1315.eurprd04.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <AM3PR04MB131556AF9BDE24E071A51300F51D0@AM3PR04MB1315.eurprd04.prod.outlook.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Anson Huang <anson.huang@nxp.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <kernel@pengutronix.de>, Fabio Estevam <fabio.estevam@nxp.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Russell King - ARM Linux <linux@armlinux.org.uk>, Viresh Kumar <viresh.kumar@linaro.org>, Jacky Bai <ping.bai@nxp.com>, "A.s. Dong" <aisheng.dong@nxp.com>
List-Id: linux-pm@vger.kernel.org

On Saturday, January 6, 2018 4:05:41 AM CET Anson Huang wrote:
> Hi, Rafael
> 
> Best Regards!
> Anson Huang
> 
> 
> > -----Original Message-----
> > From: rjwysocki@gmail.com [mailto:rjwysocki@gmail.com] On Behalf Of Rafael
> > J. Wysocki
> > Sent: 2018-01-05 8:21 PM
> > To: Anson Huang <anson.huang@nxp.com>
> > Cc: linux-arm-kernel@lists.infradead.org; devicetree@vger.kernel.org; Linux
> > PM <linux-pm@vger.kernel.org>; Linux Kernel Mailing List <linux-
> > kernel@vger.kernel.org>; Shawn Guo <shawnguo@kernel.org>; Sascha Hauer
> > <kernel@pengutronix.de>; Fabio Estevam <fabio.estevam@nxp.com>; Rob
> > Herring <robh+dt@kernel.org>; Mark Rutland <mark.rutland@arm.com>;
> > Russell King - ARM Linux <linux@armlinux.org.uk>; Rafael J. Wysocki
> > <rjw@rjwysocki.net>; Viresh Kumar <viresh.kumar@linaro.org>; Jacky Bai
> > <ping.bai@nxp.com>; A.s. Dong <aisheng.dong@nxp.com>
> > Subject: Re: [PATCH 2/2] cpufreq: imx6q: add 696MHz operating point for
> > i.mx6ul
> > 
> > On Tue, Jan 2, 2018 at 6:07 PM, Anson Huang <Anson.Huang@nxp.com> wrote:
> > > Add 696MHz operating point for i.MX6UL, only for those parts with
> > > speed grading fuse set to 2b'10 supports 696MHz operating point, so,
> > > speed grading check is also added for i.MX6UL in this patch, the clock
> > > tree for each operating point are as below:
> > >
> > > 696MHz:
> > >     pll1                       696000000
> > >        pll1_bypass             696000000
> > >           pll1_sys             696000000
> > >              pll1_sw           696000000
> > >                 arm            696000000
> > > 528MHz:
> > >     pll2                       528000000
> > >        pll2_bypass             528000000
> > >           pll2_bus             528000000
> > >              ca7_secondary_sel 528000000
> > >                 step           528000000
> > >                    pll1_sw     528000000
> > >                       arm      528000000
> > > 396MHz:
> > >     pll2_pfd2_396m             396000000
> > >        ca7_secondary_sel       396000000
> > >           step                 396000000
> > >              pll1_sw           396000000
> > >                 arm            396000000
> > > 198MHz:
> > >     pll2_pfd2_396m             396000000
> > >        ca7_secondary_sel       396000000
> > >           step                 396000000
> > >              pll1_sw           396000000
> > >                 arm            198000000
> > >
> > > Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
> > 
> > This doesn't apply for me and in a nontrivial way.
> > 
> > What kernel is it against?
> 
> I did it based on linux-next, it should be on linux-next-pm branch, I redo
> the patch set V2 based on linux-next-pm, also redo the test,
> sorry for the inconvenience.

But you didn't add the Reviewed-by: tags from Fabio to them.

Was that on purpose or by mistake?

Thanks,
Rafael
