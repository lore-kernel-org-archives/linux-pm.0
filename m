From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 10/10] cpufreq: mvebu: Use generic platdev driver
Date: Mon, 25 Apr 2016 17:26:38 +0200
Message-ID: <17150729.NF4MViUffk@wuerfel>
References: <cover.1461228504.git.viresh.kumar@linaro.org> <6893237.FoNPbfW3DC@wuerfel> <20160425125605.GG6104@vireshk-i7>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.126.135]:55485 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932511AbcDYP1X (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 25 Apr 2016 11:27:23 -0400
In-Reply-To: <20160425125605.GG6104@vireshk-i7>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linaro-kernel@lists.linaro.org
Cc: Viresh Kumar <viresh.kumar@linaro.org>, nm@ti.com, Andrew Lunn <andrew@lunn.ch>, Jason Cooper <jason@lakedaemon.net>, linux-pm@vger.kernel.org, Rafael Wysocki <rjw@rjwysocki.net>, sboyd@codeaurora.org, linux-kernel@vger.kernel.org, Gregory Clement <gregory.clement@free-electrons.com>, thomas.petazzoni@free-electrons.com, linux-arm-kernel@lists.infradead.org, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>

On Monday 25 April 2016 18:26:05 Viresh Kumar wrote:
> On 25-04-16, 14:53, Arnd Bergmann wrote:
> > On Monday 25 April 2016 08:30:41 Viresh Kumar wrote:
> 
> > I realize that the ordering is fixed through the way that the kernel
> > is linked, my worry is more about someone changing the code in some
> > way because it's not obvious from reading the code that the
> > dependency exists. If either the armada_xp_pmsu_cpufreq_init()
> > initcall gets changed so it does not always get called, or the
> > cpufreq_dt_platdev_init() initcall gets changed so it comes a little
> > earlier, things will break.
> 
> cpufreq-dt will just error out in that case, because it wouldn't find
> any OPPs registered to the OPP-core. It *shouldn't* crash and if it
> does, then we have a problem to fix.

Ok.

> > > The other thing that can happen is that armada_xp_pmsu_cpufreq_init()
> > > call can fail. In that case, most of the times cpufreq-dt ->init()
> > > will fail as well, so even that is fine for me.
> > > 
> > > And, so I think we can keep this patch as is.
> > 
> > What are the downsides of moving armada_xp_pmsu_cpufreq_init()
> > into drivers/cpufreq?
> 
> More special code :)

Of course the special code still exists, it seems more like neither of
us wants to have it in the portion of the kernel that he maintains ;-)

Maybe the mvebu maintainers have a preference where they'd like the
code to be, they are the ones that are most impacted if anything
goes wrong.

	Arnd
