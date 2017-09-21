From: "A.s. Dong" <aisheng.dong@nxp.com>
Subject: RE: [PATCH 1/7] PM / OPP: Add platform specific set_clk function
Date: Thu, 21 Sep 2017 02:17:10 +0000
Message-ID: <AM3PR04MB3063900BE634FABE8668F3380660@AM3PR04MB306.eurprd04.prod.outlook.com>
References: <1503504610-12880-1-git-send-email-aisheng.dong@nxp.com>
 <1503504610-12880-2-git-send-email-aisheng.dong@nxp.com>
 <20170919225840.GI30848@ubuntu> <20170920070343.GA32187@b29396-OptiPlex-7040>
 <20170920203033.GD3001@ubuntu>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170920203033.GD3001@ubuntu>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>, Dong Aisheng <dongas86@gmail.com>
Cc: "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "sboyd@codeaurora.org" <sboyd@codeaurora.org>, "vireshk@kernel.org" <vireshk@kernel.org>, "nm@ti.com" <nm@ti.com>, "rjw@rjwysocki.net" <rjw@rjwysocki.net>, "shawnguo@kernel.org" <shawnguo@kernel.org>, Anson Huang <anson.huang@nxp.com>, Jacky Bai <ping.bai@nxp.com>
List-Id: linux-pm@vger.kernel.org

> -----Original Message-----
> From: Viresh Kumar [mailto:viresh.kumar@linaro.org]
> Sent: Thursday, September 21, 2017 4:31 AM
> To: Dong Aisheng
> Cc: A.s. Dong; linux-pm@vger.kernel.org; linux-kernel@vger.kernel.org;
> linux-arm-kernel@lists.infradead.org; sboyd@codeaurora.org;
> vireshk@kernel.org; nm@ti.com; rjw@rjwysocki.net; shawnguo@kernel.org;
> Anson Huang; Jacky Bai
> Subject: Re: [PATCH 1/7] PM / OPP: Add platform specific set_clk function
>=20
> On 20-09-17, 15:03, Dong Aisheng wrote:
> > I've been thinking of that before.
> > Actually IMX already does some similar thing for MX5 (no for MX6).
> > See: clk_cpu_set_rate() in drivers/clk/imx/clk-cpu.c.
> >
> > After some diggings, it seems MX7ULP is a bit more complicated than
> > before mainly due to two reasons:
> > 1) It requires to switch to different CPU mode accordingly when
> > setting clocks rate. That means we need handle this in clock driver as
> > well which looks not quite suitable although we could do if really want=
.
> >
> > 2) It uses different clocks for different CPU mode (RUN 416M or HSRUN
> > 528M), and those clocks have some dependency.
> > e.g. when setting HSRUN clock, we need change RUN clock parent to make
> > sure the SPLL_PFD is got disabled before changing rate, as both CPU
> > mode using the same parent SPLL_PFD clock. Doing this in clock driver
> > also make things a bit more complicated.
> >
> > The whole follow would be something like below:
> > static int imx7ulp_set_clk(struct device *dev, struct clk *clk,
> >                            unsigned long old_freq, unsigned long
> > new_freq) {
> >         u32 val;
> >
> >         /*
> >          * Before changing the ARM core PLL, change the ARM clock soure
> >          * to FIRC first.
> >          */
> >         if (new_freq >=3D HSRUN_FREQ) {
> >                 clk_set_parent(clks[RUN_SCS_SEL].clk, clks[FIRC].clk);
> >
> >                 /* switch to HSRUN mode */
> >                 val =3D readl_relaxed(smc_base + SMC_PMCTRL);
> >                 val |=3D (0x3 << 8);
> >                 writel_relaxed(val, smc_base + SMC_PMCTRL);
> >
> >                 /* change the clock rate in HSRUN */
> >                 clk_set_rate(clks[SPLL_PFD0].clk, new_freq);
> >                 clk_set_parent(clks[HSRUN_SCS_SEL].clk,
> clks[SPLL_SEL].clk);
> >         } else {
> >                 /* change the HSRUN clock to firc */
> >                 clk_set_parent(clks[HSRUN_SCS_SEL].clk,
> > clks[FIRC].clk);
> >
> >                 /* switch to RUN mode */
> >                 val =3D readl_relaxed(smc_base + SMC_PMCTRL);
> >                 val &=3D ~(0x3 << 8);
> >                 writel_relaxed(val, smc_base + SMC_PMCTRL);
> >
> >                 clk_set_rate(clks[SPLL_PFD0].clk, new_freq);
> >                 clk_set_parent(clks[RUN_SCS_SEL].clk,
> clks[SPLL_SEL].clk);
> >         }
> >
> >         return 0;
> > }
>=20
> Right and we have the same thing in the cpufreq driver now. It will stay
> at some place and we need to find the best one, keeping in mind that we
> may or may not want to solve this problem in a generic way.
>=20
> > That's why i thought if we can make OPP core provide a way to handle
> > such complicated things in platform specific cpufreq driver.
> >
> > How would you suggest for this issue?
>=20
> I wouldn't add an API into the OPP framework if I were you. There is just
> too much code to add to the core to handle such platform specific stuff,
> which you are anyway going to keep somewhere as it is. IMHO, keeping that
> in the clock driver is a better thing to do than this.
>=20

Okay, I will give a try in CLK driver.
Thanks for the suggestion.

Regards
Dong Aisheng

> --
> viresh
