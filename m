From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH 10/10] cpufreq: mvebu: Use generic platdev driver
Date: Mon, 25 Apr 2016 20:59:14 +0530
Message-ID: <20160425152914.GI6104@vireshk-i7>
References: <cover.1461228504.git.viresh.kumar@linaro.org>
 <6893237.FoNPbfW3DC@wuerfel>
 <20160425125605.GG6104@vireshk-i7>
 <17150729.NF4MViUffk@wuerfel>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <17150729.NF4MViUffk@wuerfel>
Sender: linux-kernel-owner@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: linaro-kernel@lists.linaro.org, nm@ti.com, Andrew Lunn <andrew@lunn.ch>, Jason Cooper <jason@lakedaemon.net>, linux-pm@vger.kernel.org, Rafael Wysocki <rjw@rjwysocki.net>, sboyd@codeaurora.org, linux-kernel@vger.kernel.org, Gregory Clement <gregory.clement@free-electrons.com>, thomas.petazzoni@free-electrons.com, linux-arm-kernel@lists.infradead.org, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
List-Id: linux-pm@vger.kernel.org

On 25-04-16, 17:26, Arnd Bergmann wrote:
> On Monday 25 April 2016 18:26:05 Viresh Kumar wrote:
> > On 25-04-16, 14:53, Arnd Bergmann wrote:
> > > On Monday 25 April 2016 08:30:41 Viresh Kumar wrote:
> > 
> > > I realize that the ordering is fixed through the way that the kernel
> > > is linked, my worry is more about someone changing the code in some
> > > way because it's not obvious from reading the code that the
> > > dependency exists. If either the armada_xp_pmsu_cpufreq_init()
> > > initcall gets changed so it does not always get called, or the
> > > cpufreq_dt_platdev_init() initcall gets changed so it comes a little
> > > earlier, things will break.
> > 
> > cpufreq-dt will just error out in that case, because it wouldn't find
> > any OPPs registered to the OPP-core. It *shouldn't* crash and if it
> > does, then we have a problem to fix.
> 
> Ok.
> 
> > > > The other thing that can happen is that armada_xp_pmsu_cpufreq_init()
> > > > call can fail. In that case, most of the times cpufreq-dt ->init()
> > > > will fail as well, so even that is fine for me.
> > > > 
> > > > And, so I think we can keep this patch as is.
> > > 
> > > What are the downsides of moving armada_xp_pmsu_cpufreq_init()
> > > into drivers/cpufreq?
> > 
> > More special code :)
> 
> Of course the special code still exists, it seems more like neither of
> us wants to have it in the portion of the kernel that he maintains ;-)

Hehe.. But after $subject patch, we don't have any special code for
creating the device, isn't it?

> Maybe the mvebu maintainers have a preference where they'd like the
> code to be, they are the ones that are most impacted if anything
> goes wrong.

What code are you talking about? Initializing the OPPs or adding the
cpufreq-dt device? The first one (or whatever is left now in that
function) can stay anywhere, even as a cpufreq driver. I was talking
about the fact that we don't have a sequence problem to solve here.

-- 
viresh
