From: "Bedia, Vaibhav" <vaibhav.bedia@ti.com>
Subject: RE: [PATCH v2 2/2] ARM: imx: enable imx6q-cpufreq support
Date: Thu, 10 Jan 2013 14:02:53 +0000
Message-ID: <B5906170F1614E41A8A28DE3B8D121433ECDFE3B@DBDE01.ent.ti.com>
References: <1357806863-6899-1-git-send-email-shawn.guo@linaro.org>
 <1357806863-6899-3-git-send-email-shawn.guo@linaro.org>
 <B5906170F1614E41A8A28DE3B8D121433ECDF7BF@DBDE01.ent.ti.com>
 <20130110110742.GI2265@S2101-09.ap.freescale.net>
 <B5906170F1614E41A8A28DE3B8D121433ECDFC9B@DBDE01.ent.ti.com>
 <20130110132053.GA9139@S2101-09.ap.freescale.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:39015 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752609Ab3AJODJ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 10 Jan 2013 09:03:09 -0500
In-Reply-To: <20130110132053.GA9139@S2101-09.ap.freescale.net>
Content-Language: en-US
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Shawn Guo <shawn.guo@linaro.org>
Cc: "cpufreq@vger.kernel.org" <cpufreq@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "Rafael J. Wysocki" <rjw@sisk.pl>, Viresh Kumar <viresh.kumar@linaro.org>, Sascha Hauer <s.hauer@pengutronix.de>

On Thu, Jan 10, 2013 at 18:50:55, Shawn Guo wrote:
> On Thu, Jan 10, 2013 at 01:02:30PM +0000, Bedia, Vaibhav wrote:
> > In the current approach the OPP data is split across DT and kernel code. If you take the
> > other approach all OPP entries can reside in DT and for someone just looking at that file
> > there's no confusion about what the kernel could potentially support. Whether a particular
> > an OPP should be supported is best decided at runtime.
> > 
> Listing the OPP that some Si rev can not support in DT is also
> a confusion to people who is just looking at DTS.  To me, the approach
> is not really doing anything better on this aspect.
> 

I still think putting the OPP data in a single place is better.

> > Also, IMHO letting platforms invoke opp_add() is open to abuse and platforms should be
> > restricted to invoking opp_enable/disable to indicate what's possible on a particular Si rev. 
> > 
> I do not see anything wrong with platform adding the OPP it can support.
> Isn't omap_init_opp_table() being called by platform code?  I do not see
> omap-cpufreq driver is calling a platform hook to do that.
> 
> Sorry, I'm not really a fan of platform hook, and I have spent past
> couple years to minimize the use of it when converting IMX family to
> device tree.
> 

I don't know what the OMAP plans are but with DT + generic driver adoption I would expect most
of it to go away. And adding the platform hook with the right DT data is just preparing
things for the future with 2 potential users right now.

If OPP data across Si rev starts looking very different all entries can be placed in a single
place and the platform code enables what are relevant. Unless there's a Si rev specific blob a bunch
of opp_add() calls ignoring what was passed defeats the purpose of moving the information out of the
kernel.
 
Regards,
Vaibhav
