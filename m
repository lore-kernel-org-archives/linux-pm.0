From: Shawn Guo <shawn.guo@freescale.com>
Subject: Re: [RFC] cpufreq-cpu0: allow OPP table supplied by platform
Date: Fri, 14 Mar 2014 20:32:06 +0800
Message-ID: <20140314123205.GC813@S2101-09.ap.freescale.net>
References: <20140313184859.7d6f6512@xhacker>
 <CAKohpokLv0m+Cky7nCUOgP-djTMrA6jyka_EZ07+_exCAexXXg@mail.gmail.com>
 <CAKohpoke1i8xmKProgF+ki7Q=Q+YxbPnewdtbyPqu7857DLLWA@mail.gmail.com>
 <20140313194424.122ec572@xhacker>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from ch1ehsobe005.messaging.microsoft.com ([216.32.181.185]:59461
	"EHLO ch1outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753620AbaCNMbW (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 14 Mar 2014 08:31:22 -0400
Content-Disposition: inline
In-Reply-To: <20140313194424.122ec572@xhacker>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Jisheng Zhang <jszhang@marvell.com>
Cc: Viresh Kumar <viresh.kumar@linaro.org>, Shawn Guo <shawn.guo@linaro.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "cpufreq@vger.kernel.org" <cpufreq@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>

On Thu, Mar 13, 2014 at 07:44:24PM +0800, Jisheng Zhang wrote:
> > On 13 March 2014 16:25, Viresh Kumar <viresh.kumar@linaro.org> wrote:
> > > On 13 March 2014 16:18, Jisheng Zhang <jszhang@marvell.com> wrote:
> > >> Hi all,
> > >>
> > >> cpufreq-cpu0 is suitable for Marvell Berlin SoC. But there's one issue
> > >> to address. The opp is different between chips even on the same step
> > >> SoC, BG2Q for example. we can calculate the OPP table from the value of
> > >> one OTP register. We have two solutions:
> > >>
> > >> 1. bootloader reads OTP register and calculate the OPP table then change
> > >> dtb danamically
> > >>
> > >> 2. supply one driver in mach-berlin to initialize the OPP table; and
> > >> modify cpufreq-cpu0 to allow platform supply OPP table, fall back to
> > >> of_init_opp_table() if there's no OPP table.
> > >>
> > >> Which solution is better?
> > >
> > > I think we can go ahead with second option here. We can just check if opp
> > > tables are already initialized or not. In case they are, don't probe from
> > > dt..
> > >
> > > But lets see with others have to say here..

Yea, we had gone for the second option on imx6q-cpufreq driver with
commit 20b7cbe (cpufreq: imx6q: add of_init_opp_table).

Shawn

