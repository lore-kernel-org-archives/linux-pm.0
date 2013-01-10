From: Shawn Guo <shawn.guo@linaro.org>
Subject: Re: [PATCH v2 2/2] ARM: imx: enable imx6q-cpufreq support
Date: Thu, 10 Jan 2013 22:41:25 +0800
Message-ID: <20130110144121.GC8680@S2101-09.ap.freescale.net>
References: <1357806863-6899-1-git-send-email-shawn.guo@linaro.org>
 <1357806863-6899-3-git-send-email-shawn.guo@linaro.org>
 <B5906170F1614E41A8A28DE3B8D121433ECDF7BF@DBDE01.ent.ti.com>
 <20130110110742.GI2265@S2101-09.ap.freescale.net>
 <B5906170F1614E41A8A28DE3B8D121433ECDFC9B@DBDE01.ent.ti.com>
 <20130110132053.GA9139@S2101-09.ap.freescale.net>
 <B5906170F1614E41A8A28DE3B8D121433ECDFE3B@DBDE01.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from ch1ehsobe006.messaging.microsoft.com ([216.32.181.186]:51753
	"EHLO ch1outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753100Ab3AJOlg (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 10 Jan 2013 09:41:36 -0500
Content-Disposition: inline
In-Reply-To: <B5906170F1614E41A8A28DE3B8D121433ECDFE3B@DBDE01.ent.ti.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Bedia, Vaibhav" <vaibhav.bedia@ti.com>
Cc: "cpufreq@vger.kernel.org" <cpufreq@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "Rafael J. Wysocki" <rjw@sisk.pl>, Viresh Kumar <viresh.kumar@linaro.org>, Sascha Hauer <s.hauer@pengutronix.de>

On Thu, Jan 10, 2013 at 02:02:53PM +0000, Bedia, Vaibhav wrote:
> On Thu, Jan 10, 2013 at 18:50:55, Shawn Guo wrote:
> > On Thu, Jan 10, 2013 at 01:02:30PM +0000, Bedia, Vaibhav wrote:
> > > In the current approach the OPP data is split across DT and kernel code. If you take the
> > > other approach all OPP entries can reside in DT and for someone just looking at that file
> > > there's no confusion about what the kernel could potentially support. Whether a particular
> > > an OPP should be supported is best decided at runtime.
> > > 
> > Listing the OPP that some Si rev can not support in DT is also
> > a confusion to people who is just looking at DTS.  To me, the approach
> > is not really doing anything better on this aspect.
> > 
> 
> I still think putting the OPP data in a single place is better.
> 
Okay, I agree with you on that and plan to commit the following changes.
But no, still no platform hook.

Shawn

diff --git a/arch/arm/boot/dts/imx6q.dtsi b/arch/arm/boot/dts/imx6q.dtsi
index 17c5618..231a32c 100644
--- a/arch/arm/boot/dts/imx6q.dtsi
+++ b/arch/arm/boot/dts/imx6q.dtsi
@@ -38,6 +38,7 @@
                        next-level-cache = <&L2>;
                        operating-points = <
                                /* kHz    uV */
+                               1200000 1275000
                                996000  1250000
                                792000  1150000
                                396000  950000
diff --git a/arch/arm/mach-imx/mach-imx6q.c b/arch/arm/mach-imx/mach-imx6q.c
index 16f9a13..2f974f5 100644
--- a/arch/arm/mach-imx/mach-imx6q.c
+++ b/arch/arm/mach-imx/mach-imx6q.c
@@ -235,9 +235,9 @@ static void __init imx6q_opp_check_1p2ghz(struct device *cpu_dev)

        val = readl_relaxed(base + OCOTP_CFG3);
        val >>= OCOTP_CFG3_SPEED_SHIFT;
-       if ((val & 0x3) == OCOTP_CFG3_SPEED_1P2GHZ)
-               if (opp_add(cpu_dev, 1200000000, 1275000))
-                       pr_warn("failed to add 1.2 GHz operating point\n");
+       if ((val & 0x3) != OCOTP_CFG3_SPEED_1P2GHZ)
+               if (opp_disable(cpu_dev, 1200000000))
+                       pr_warn("failed to disable 1.2 GHz OPP\n");

 put_node:
        of_node_put(np);

