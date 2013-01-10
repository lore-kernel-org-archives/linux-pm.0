From: "Bedia, Vaibhav" <vaibhav.bedia@ti.com>
Subject: RE: [PATCH v2 2/2] ARM: imx: enable imx6q-cpufreq support
Date: Thu, 10 Jan 2013 13:02:30 +0000
Message-ID: <B5906170F1614E41A8A28DE3B8D121433ECDFC9B@DBDE01.ent.ti.com>
References: <1357806863-6899-1-git-send-email-shawn.guo@linaro.org>
 <1357806863-6899-3-git-send-email-shawn.guo@linaro.org>
 <B5906170F1614E41A8A28DE3B8D121433ECDF7BF@DBDE01.ent.ti.com>
 <20130110110742.GI2265@S2101-09.ap.freescale.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <cpufreq-owner@vger.kernel.org>
In-Reply-To: <20130110110742.GI2265@S2101-09.ap.freescale.net>
Content-Language: en-US
Sender: cpufreq-owner@vger.kernel.org
To: Shawn Guo <shawn.guo@linaro.org>
Cc: "cpufreq@vger.kernel.org" <cpufreq@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "Rafael J. Wysocki" <rjw@sisk.pl>, Viresh Kumar <viresh.kumar@linaro.org>, Sascha Hauer <s.hauer@pengutronix.de>
List-Id: linux-pm@vger.kernel.org

On Thu, Jan 10, 2013 at 16:37:45, Shawn Guo wrote:
> On Thu, Jan 10, 2013 at 10:50:25AM +0000, Bedia, Vaibhav wrote:
> ...
> > > +static void __init imx6q_opp_check_1p2ghz(struct device *cpu_dev)
> > > +{
> > > +	struct device_node *np;
> > > +	void __iomem *base;
> > > +	u32 val;
> > > +
> > > +	np = of_find_compatible_node(NULL, NULL, "fsl,imx6q-ocotp");
> > > +	if (!np) {
> > > +		pr_warn("failed to find ocotp node\n");
> > > +		return;
> > > +	}
> > > +
> > > +	base = of_iomap(np, 0);
> > > +	if (!base) {
> > > +		pr_warn("failed to map ocotp\n");
> > > +		goto put_node;
> > > +	}
> > > +
> > > +	val = readl_relaxed(base + OCOTP_CFG3);
> > > +	val >>= OCOTP_CFG3_SPEED_SHIFT;
> > > +	if ((val & 0x3) == OCOTP_CFG3_SPEED_1P2GHZ)
> > > +		if (opp_add(cpu_dev, 1200000000, 1275000))
> > > +			pr_warn("failed to add 1.2 GHz operating point\n");
> > > +
> > 
> > I just happened to be thinking about the problem of enabling additional OPPs based on
> > some Si rev info for TI's AM335x. 
> > 
> > The other approach could be to register additional OPPs and mark then as disabled to begin with.
> > A platform specific hook could then be used to selectively enable the OPPs for based on the Si rev
> > info.
> 
> May I ask the advantage of this approach?  I hate to create
> platform_data merely for passing a platform specific hook to driver.
> 

In the current approach the OPP data is split across DT and kernel code. If you take the
other approach all OPP entries can reside in DT and for someone just looking at that file
there's no confusion about what the kernel could potentially support. Whether a particular
an OPP should be supported is best decided at runtime.

Also, IMHO letting platforms invoke opp_add() is open to abuse and platforms should be
restricted to invoking opp_enable/disable to indicate what's possible on a particular Si rev. 

Regards,
Vaibhav
