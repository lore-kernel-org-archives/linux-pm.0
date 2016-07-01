From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH v3 1/2] clk: Add consumer APIs for discovering possible parent clocks
Date: Fri, 01 Jul 2016 22:53:44 +0200
Message-ID: <1736057.IZk9ncTkZk@vostro.rjw.lan>
References: <1466058085-19353-1-git-send-email-oss@buserror.net> <3794032.AoZL3DhM7U@vostro.rjw.lan> <1467356146.32358.32.camel@buserror.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from cloudserver094114.home.net.pl ([79.96.170.134]:64100 "HELO
	cloudserver094114.home.net.pl" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1751911AbcGAUtj (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 1 Jul 2016 16:49:39 -0400
In-Reply-To: <1467356146.32358.32.camel@buserror.net>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Scott Wood <oss@buserror.net>
Cc: Scott Wood <scott.wood@nxp.com>, Yuantian Tang <yuantian.tang@nxp.com>, Russell King <linux@armlinux.org.uk>, Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@codeaurora.org>, Viresh Kumar <viresh.kumar@linaro.org>, "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>, Yang-Leo Li <leoyang.li@nxp.com>, Xiaofeng Ren <xiaofeng.ren@nxp.com>

On Friday, July 01, 2016 01:55:46 AM Scott Wood wrote:
> On Thu, 2016-06-30 at 15:29 +0200, Rafael J. Wysocki wrote:
> > On Thursday, June 30, 2016 05:46:42 AM Scott Wood wrote:
> > > 
> > > On 06/29/2016 10:02 PM, Yuantian Tang wrote:
> > > > 
> > > > > 
> > > > > -----Original Message-----
> > > > > From: Rafael J. Wysocki [mailto:rjw@rjwysocki.net]
> > > > > Sent: Thursday, June 30, 2016 10:24 AM
> > > > > To: Yuantian Tang <yuantian.tang@nxp.com>
> > > > > Cc: Scott Wood <oss@buserror.net>; Russell King <linux@armlinux.org.uk
> > > > > >;
> > > > > Michael Turquette <mturquette@baylibre.com>; Stephen Boyd
> > > > > <sboyd@codeaurora.org>; Viresh Kumar <viresh.kumar@linaro.org>; linux-
> > > > > clk@vger.kernel.org; linux-pm@vger.kernel.org; linuxppc-
> > > > > dev@lists.ozlabs.org; Yang-Leo Li <leoyang.li@nxp.com>; Xiaofeng Ren
> > > > > <xiaofeng.ren@nxp.com>; Scott Wood <scottwood@freescale.com>
> > > > > Subject: Re: [PATCH v3 1/2] clk: Add consumer APIs for discovering
> > > > > possible
> > > > > parent clocks
> > > > > 
> > > > > On Thursday, June 30, 2016 01:47:09 AM Yuantian Tang wrote:
> > > > > > 
> > > > > > > 
> > > > > > > -----Original Message-----
> > > > > > > From: Rafael J. Wysocki [mailto:rjw@rjwysocki.net]
> > > > > > > Sent: Thursday, June 30, 2016 9:47 AM
> > > > > > > To: Yuantian Tang <yuantian.tang@nxp.com>
> > > > > > > Cc: Scott Wood <oss@buserror.net>; Russell King
> > > > > > > <linux@armlinux.org.uk>; Michael Turquette
> > > > > > > <mturquette@baylibre.com>; Stephen Boyd <sboyd@codeaurora.org>;
> > > > > > > Viresh Kumar <viresh.kumar@linaro.org>; linux- clk@vger.kernel.org
> > > > > > > ;
> > > > > > > linux-pm@vger.kernel.org; linuxppc- dev@lists.ozlabs.org; Yang-Leo
> > > > > > > Li <leoyang.li@nxp.com>; Xiaofeng Ren <xiaofeng.ren@nxp.com>;
> > > > > > > Scott
> > > > > > > Wood <scottwood@freescale.com>
> > > > > > > Subject: Re: [PATCH v3 1/2] clk: Add consumer APIs for discovering
> > > > > > > possible parent clocks
> > > > > > > 
> > > > > > > On Wednesday, June 29, 2016 05:50:26 AM Yuantian Tang wrote:
> > > > > > > > 
> > > > > > > > Hi,
> > > > > > > > 
> > > > > > > > This patch is acked by clock maintainer. If no comments from
> > > > > > > > anyone else,
> > > > > > > we will merge it in next week.
> > > > > > > 
> > > > > > > There is a cpufreq commit depending on it.  Are you going to
> > > > > > > handle
> > > > > > > that one too?
> > > > > > > 
> > > > > > That one has been acked by cpufreq maintainer. You can get this from
> > > > > patch comments.
> > > > > 
> > > > > I know that it has been ACKed.
> > > > > 
> > > > > My question is whether or not you are going to apply it along the
> > > > > [1/2].
> > > > > 
> > > > > If not, it will have to be deferred until the [1/2] is merged and then
> > > > > applied
> > > > > which may not be desirable.
> > > > > 
> > > > I hope we can apply both at same time. Seems Scott has a few concerns.
> > > > 
> > > > What you think about this patch? Can you apply it?
> > > > If you have applied this patch, then I can push CPUfreq maintainer to
> > > > apply another one which will be delayed.
> > > My only concern was getting an ack for this patch (1/2) -- did I miss it
> > > somewhere?
> > OK, so who's going to apply the series?
> 
> Ideally it should go via the cpufreq tree.

OK, I'll apply both, then.

Who exactly has ACKed the [1/2] from the clk side?

Thanks,
Rafael

