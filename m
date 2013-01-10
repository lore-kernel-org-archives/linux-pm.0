From: Shawn Guo <shawn.guo@linaro.org>
Subject: Re: [PATCH v2 2/2] ARM: imx: enable imx6q-cpufreq support
Date: Thu, 10 Jan 2013 21:20:55 +0800
Message-ID: <20130110132053.GA9139@S2101-09.ap.freescale.net>
References: <1357806863-6899-1-git-send-email-shawn.guo@linaro.org>
 <1357806863-6899-3-git-send-email-shawn.guo@linaro.org>
 <B5906170F1614E41A8A28DE3B8D121433ECDF7BF@DBDE01.ent.ti.com>
 <20130110110742.GI2265@S2101-09.ap.freescale.net>
 <B5906170F1614E41A8A28DE3B8D121433ECDFC9B@DBDE01.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from va3ehsobe001.messaging.microsoft.com ([216.32.180.11]:18385
	"EHLO va3outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750799Ab3AJNVI (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 10 Jan 2013 08:21:08 -0500
Content-Disposition: inline
In-Reply-To: <B5906170F1614E41A8A28DE3B8D121433ECDFC9B@DBDE01.ent.ti.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Bedia, Vaibhav" <vaibhav.bedia@ti.com>
Cc: "cpufreq@vger.kernel.org" <cpufreq@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "Rafael J. Wysocki" <rjw@sisk.pl>, Viresh Kumar <viresh.kumar@linaro.org>, Sascha Hauer <s.hauer@pengutronix.de>

On Thu, Jan 10, 2013 at 01:02:30PM +0000, Bedia, Vaibhav wrote:
> In the current approach the OPP data is split across DT and kernel code. If you take the
> other approach all OPP entries can reside in DT and for someone just looking at that file
> there's no confusion about what the kernel could potentially support. Whether a particular
> an OPP should be supported is best decided at runtime.
> 
Listing the OPP that some Si rev can not support in DT is also
a confusion to people who is just looking at DTS.  To me, the approach
is not really doing anything better on this aspect.

> Also, IMHO letting platforms invoke opp_add() is open to abuse and platforms should be
> restricted to invoking opp_enable/disable to indicate what's possible on a particular Si rev. 
> 
I do not see anything wrong with platform adding the OPP it can support.
Isn't omap_init_opp_table() being called by platform code?  I do not see
omap-cpufreq driver is calling a platform hook to do that.

Sorry, I'm not really a fan of platform hook, and I have spent past
couple years to minimize the use of it when converting IMX family to
device tree.

Shawn

