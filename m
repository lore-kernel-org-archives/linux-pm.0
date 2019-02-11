From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH 0/2] cpufreq/opp: rework regulator initialization
Date: Mon, 11 Feb 2019 15:25:27 +0530
Message-ID: <20190211095527.5brreiqppn7kk3yt@vireshk-i7>
References: <CGME20190207122255eucas1p1cdebed838c799eca46cce6a654a26187@eucas1p1.samsung.com>
 <20190207122227.19873-1-m.szyprowski@samsung.com>
 <20190211084413.b53qyx6sgkxsjhdv@vireshk-i7>
 <9b4a6c9a-93f9-474f-b8c0-4353a531e128@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <9b4a6c9a-93f9-474f-b8c0-4353a531e128@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Marek Szyprowski <m.szyprowski@samsung.com>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, linux-samsung-soc@vger.kernel.org, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@kernel.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Dave Gerlach <d-gerlach@ti.com>, Wolfram Sang <wsa@the-dreams.de>, Sudeep.Holla@arm.com
List-Id: linux-pm@vger.kernel.org

On 11-02-19, 10:52, Marek Szyprowski wrote:
> Hi Viresh,
> 
> On 2019-02-11 09:44, Viresh Kumar wrote:
> > On 07-02-19, 13:22, Marek Szyprowski wrote:
> >> Dear All,
> >>
> >> Recent commit 9ac6cb5fbb17 ("i2c: add suspended flag and accessors for
> >> i2c adapters") added a visible warning for an attempt to do i2c transfer
> >> over a suspended i2c bus. This revealed a long standing issue in the
> >> cpufreq-dt driver, which gives a following warning during system
> >> suspend/resume cycle:
> > Marek,
> >
> > I have sent a patchset which is not directly related to the problem
> > you are facing, but it may solve your problem as a side effect. Can
> > you please see if that works to solve this issue as well ?
> >
> > https://lore.kernel.org/lkml/cover.1549874368.git.viresh.kumar@linaro.org/T/#u
> 
> Thanks for the patch. It indeed solves the problem of the i2c transfer
> in cpu hotplug procedure during system resume, although my resources
> management rewrite is still valid as a way to fix remaining 'todos' in
> the cpufreq-dt driver.

Which remaining todos are you talking about ? Sorry I am not able to
recall :(

-- 
viresh
