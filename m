From: Scott Wood <oss@buserror.net>
Subject: Re: [PATCH v3 1/2] clk: Add consumer APIs for discovering possible
 parent clocks
Date: Fri, 01 Jul 2016 15:57:22 -0500
Message-ID: <1467406642.32358.39.camel@buserror.net>
References: <1466058085-19353-1-git-send-email-oss@buserror.net>
	 <3794032.AoZL3DhM7U@vostro.rjw.lan>
	 <1467356146.32358.32.camel@buserror.net>
	 <1736057.IZk9ncTkZk@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from host.buserror.net ([209.198.135.123]:60399 "EHLO
	host.buserror.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752549AbcGAU5i (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 1 Jul 2016 16:57:38 -0400
In-Reply-To: <1736057.IZk9ncTkZk@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Russell King <linux@armlinux.org.uk>, Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@codeaurora.org>
Cc: Scott Wood <scott.wood@nxp.com>, Yuantian Tang <yuantian.tang@nxp.com>, Viresh Kumar <viresh.kumar@linaro.org>, "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>, Yang-Leo Li <leoyang.li@nxp.com>, Xiaofeng Ren <xiaofeng.ren@nxp.com>

On Fri, 2016-07-01 at 22:53 +0200, Rafael J. Wysocki wrote:
> On Friday, July 01, 2016 01:55:46 AM Scott Wood wrote:
> >=20
> > On Thu, 2016-06-30 at 15:29 +0200, Rafael J. Wysocki wrote:
> > >=20
> > > On Thursday, June 30, 2016 05:46:42 AM Scott Wood wrote:
> > > >=20
> > > >=20
> > > > On 06/29/2016 10:02 PM, Yuantian Tang wrote:
> > > > >=20
> > > > >=20
> > > > > >=20
> > > > > >=20
> > > > > > -----Original Message-----
> > > > > > From: Rafael J. Wysocki [mailto:rjw@rjwysocki.net]
> > > > > > Sent: Thursday, June 30, 2016 10:24 AM
> > > > > > To: Yuantian Tang <yuantian.tang@nxp.com>
> > > > > > Cc: Scott Wood <oss@buserror.net>; Russell King <linux@arml=
inux.or
> > > > > > g.uk
> > > > > > >=20
> > > > > > > ;
> > > > > > Michael Turquette <mturquette@baylibre.com>; Stephen Boyd
> > > > > > <sboyd@codeaurora.org>; Viresh Kumar <viresh.kumar@linaro.o=
rg>;
> > > > > > linux-
> > > > > > clk@vger.kernel.org; linux-pm@vger.kernel.org; linuxppc-
> > > > > > dev@lists.ozlabs.org; Yang-Leo Li <leoyang.li@nxp.com>; Xia=
ofeng
> > > > > > Ren
> > > > > > <xiaofeng.ren@nxp.com>; Scott Wood <scottwood@freescale.com=
>
> > > > > > Subject: Re: [PATCH v3 1/2] clk: Add consumer APIs for disc=
overing
> > > > > > possible
> > > > > > parent clocks
> > > > > >=20
> > > > > > On Thursday, June 30, 2016 01:47:09 AM Yuantian Tang wrote:
> > > > > > >=20
> > > > > > >=20
> > > > > > > >=20
> > > > > > > >=20
> > > > > > > > -----Original Message-----
> > > > > > > > From: Rafael J. Wysocki [mailto:rjw@rjwysocki.net]
> > > > > > > > Sent: Thursday, June 30, 2016 9:47 AM
> > > > > > > > To: Yuantian Tang <yuantian.tang@nxp.com>
> > > > > > > > Cc: Scott Wood <oss@buserror.net>; Russell King
> > > > > > > > <linux@armlinux.org.uk>; Michael Turquette
> > > > > > > > <mturquette@baylibre.com>; Stephen Boyd <sboyd@codeauro=
ra.org>
> > > > > > > > ;
> > > > > > > > Viresh Kumar <viresh.kumar@linaro.org>; linux- clk@vger=
=2Ekernel
> > > > > > > > .org
> > > > > > > > ;
> > > > > > > > linux-pm@vger.kernel.org; linuxppc- dev@lists.ozlabs.or=
g;
> > > > > > > > Yang-Leo
> > > > > > > > Li <leoyang.li@nxp.com>; Xiaofeng Ren <xiaofeng.ren@nxp=
=2Ecom>;
> > > > > > > > Scott
> > > > > > > > Wood <scottwood@freescale.com>
> > > > > > > > Subject: Re: [PATCH v3 1/2] clk: Add consumer APIs for
> > > > > > > > discovering
> > > > > > > > possible parent clocks
> > > > > > > >=20
> > > > > > > > On Wednesday, June 29, 2016 05:50:26 AM Yuantian Tang w=
rote:
> > > > > > > > >=20
> > > > > > > > >=20
> > > > > > > > > Hi,
> > > > > > > > >=20
> > > > > > > > > This patch is acked by clock maintainer. If no commen=
ts from
> > > > > > > > > anyone else,
> > > > > > > > we will merge it in next week.
> > > > > > > >=20
> > > > > > > > There is a cpufreq commit depending on it.=C2=A0=C2=A0A=
re you going to
> > > > > > > > handle
> > > > > > > > that one too?
> > > > > > > >=20
> > > > > > > That one has been acked by cpufreq maintainer. You can ge=
t this
> > > > > > > from
> > > > > > patch comments.
> > > > > >=20
> > > > > > I know that it has been ACKed.
> > > > > >=20
> > > > > > My question is whether or not you are going to apply it alo=
ng the
> > > > > > [1/2].
> > > > > >=20
> > > > > > If not, it will have to be deferred until the [1/2] is merg=
ed and
> > > > > > then
> > > > > > applied
> > > > > > which may not be desirable.
> > > > > >=20
> > > > > I hope we can apply both at same time. Seems Scott has a few
> > > > > concerns.
> > > > >=20
> > > > > What you think about this patch? Can you apply it?
> > > > > If you have applied this patch, then I can push CPUfreq maint=
ainer
> > > > > to
> > > > > apply another one which will be delayed.
> > > > My only concern was getting an ack for this patch (1/2) -- did =
I miss
> > > > it
> > > > somewhere?
> > > OK, so who's going to apply the series?
> > Ideally it should go via the cpufreq tree.
> OK, I'll apply both, then.
>=20
> Who exactly has ACKed the [1/2] from the clk side?

That's the problem. =C2=A0I'm not sure what ACK Yuantian is referring t=
o. =C2=A0The last
I've heard from a clock maintainer was=C2=A0https://lkml.org/lkml/2015/=
9/18/816=C2=A0des
pite repeated attempts to get Russell King to respond as clock API main=
tainer.

-Scott

