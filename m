From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH 10/10] cpufreq: mvebu: Use generic platdev driver
Date: Mon, 25 Apr 2016 18:26:05 +0530
Message-ID: <20160425125605.GG6104@vireshk-i7>
References: <cover.1461228504.git.viresh.kumar@linaro.org>
 <7576455.rVXD0283Nr@wuerfel>
 <20160425030041.GF22726@vireshk-i7>
 <6893237.FoNPbfW3DC@wuerfel>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <6893237.FoNPbfW3DC@wuerfel>
Sender: linux-kernel-owner@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: linux-arm-kernel@lists.infradead.org, nm@ti.com, Andrew Lunn <andrew@lunn.ch>, linaro-kernel@lists.linaro.org, Jason Cooper <jason@lakedaemon.net>, linux-pm@vger.kernel.org, sboyd@codeaurora.org, Rafael Wysocki <rjw@rjwysocki.net>, linux-kernel@vger.kernel.org, Gregory Clement <gregory.clement@free-electrons.com>, thomas.petazzoni@free-electrons.com, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
List-Id: linux-pm@vger.kernel.org

On 25-04-16, 14:53, Arnd Bergmann wrote:
> On Monday 25 April 2016 08:30:41 Viresh Kumar wrote:

> I realize that the ordering is fixed through the way that the kernel
> is linked, my worry is more about someone changing the code in some
> way because it's not obvious from reading the code that the
> dependency exists. If either the armada_xp_pmsu_cpufreq_init()
> initcall gets changed so it does not always get called, or the
> cpufreq_dt_platdev_init() initcall gets changed so it comes a little
> earlier, things will break.

cpufreq-dt will just error out in that case, because it wouldn't find
any OPPs registered to the OPP-core. It *shouldn't* crash and if it
does, then we have a problem to fix.

> > The other thing that can happen is that armada_xp_pmsu_cpufreq_init()
> > call can fail. In that case, most of the times cpufreq-dt ->init()
> > will fail as well, so even that is fine for me.
> > 
> > And, so I think we can keep this patch as is.
> 
> What are the downsides of moving armada_xp_pmsu_cpufreq_init()
> into drivers/cpufreq?

More special code :)

-- 
viresh
