From: "Bedia, Vaibhav" <vaibhav.bedia@ti.com>
Subject: RE: [PATCH v2 2/2] ARM: imx: enable imx6q-cpufreq support
Date: Fri, 11 Jan 2013 04:43:30 +0000
Message-ID: <B5906170F1614E41A8A28DE3B8D121433ECE0DA7@DBDE01.ent.ti.com>
References: <1357806863-6899-1-git-send-email-shawn.guo@linaro.org>
 <1357806863-6899-3-git-send-email-shawn.guo@linaro.org>
 <B5906170F1614E41A8A28DE3B8D121433ECDF7BF@DBDE01.ent.ti.com>
 <20130110110742.GI2265@S2101-09.ap.freescale.net>
 <B5906170F1614E41A8A28DE3B8D121433ECDFC9B@DBDE01.ent.ti.com>
 <20130110132053.GA9139@S2101-09.ap.freescale.net>
 <B5906170F1614E41A8A28DE3B8D121433ECDFE3B@DBDE01.ent.ti.com>
 <20130110144121.GC8680@S2101-09.ap.freescale.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <cpufreq-owner@vger.kernel.org>
In-Reply-To: <20130110144121.GC8680@S2101-09.ap.freescale.net>
Content-Language: en-US
Sender: cpufreq-owner@vger.kernel.org
To: Shawn Guo <shawn.guo@linaro.org>
Cc: "cpufreq@vger.kernel.org" <cpufreq@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "Rafael J. Wysocki" <rjw@sisk.pl>, Viresh Kumar <viresh.kumar@linaro.org>, Sascha Hauer <s.hauer@pengutronix.de>
List-Id: linux-pm@vger.kernel.org

On Thu, Jan 10, 2013 at 20:11:25, Shawn Guo wrote:
> On Thu, Jan 10, 2013 at 02:02:53PM +0000, Bedia, Vaibhav wrote:
> > On Thu, Jan 10, 2013 at 18:50:55, Shawn Guo wrote:
> > > On Thu, Jan 10, 2013 at 01:02:30PM +0000, Bedia, Vaibhav wrote:
> > > > In the current approach the OPP data is split across DT and kernel code. If you take the
> > > > other approach all OPP entries can reside in DT and for someone just looking at that file
> > > > there's no confusion about what the kernel could potentially support. Whether a particular
> > > > an OPP should be supported is best decided at runtime.
> > > > 
> > > Listing the OPP that some Si rev can not support in DT is also
> > > a confusion to people who is just looking at DTS.  To me, the approach
> > > is not really doing anything better on this aspect.
> > > 
> > 
> > I still think putting the OPP data in a single place is better.
> > 
> Okay, I agree with you on that and plan to commit the following changes.
> But no, still no platform hook.
> 

Fair enough.

Regards,
Vaibhav

