From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [RFC] cpufreq: Add ->get_rate() driver callback
Date: Fri, 10 Jul 2015 01:26:23 +0200
Message-ID: <1709328.yilXR0UZlG@vostro.rjw.lan>
References: <fb44111fa7a762924661ad48a70985d597229bc4.1436351759.git.viresh.kumar@linaro.org> <1879392.TC0RceaKlH@vostro.rjw.lan> <20150709045902.GI1805@linux>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:50892 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1750955AbbGIW7y (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 9 Jul 2015 18:59:54 -0400
In-Reply-To: <20150709045902.GI1805@linux>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, open list <linux-kernel@vger.kernel.org>

On Thursday, July 09, 2015 10:29:02 AM Viresh Kumar wrote:
> On 09-07-15, 01:41, Rafael J. Wysocki wrote:
> > On Wednesday, July 08, 2015 04:07:32 PM Viresh Kumar wrote:
> > > CPUFreq drivers today support a ->get(cpu) callback, which returns
> > > current rate of a CPU. The problem with ->get() is that it takes a cpu
> > > number as parameter and this unnecessarily makes things complex.
> > > 
> > > Firstly the core gets the cpu number by doing operation 'policy->cpu' on
> > > the policy and then many drivers need to get the policy back and so do
> > > cpufreq_cpu_get(cpu) on the passed cpu.
> > > 
> > > As cpufreq core works on policies, it would be better if we pass them
> > > 'policy' directly and drivers can use policy->cpu if that's all they
> > > need.
> > > 
> > > Hence, this patch adds in another callback, ->get_rate() which does
> > > exactly the same work as ->get(), just that we pass 'policy' as
> > > parameter instead of 'cpu'.
> > > 
> > > The plan is to migrate all drivers to this new callback and remove
> > > ->get() after that.
> > > 
> > > Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> > > ---
> > > Hi Rafael,
> > > 
> > > I hope you are fine with this stuff :), once you approve I will get
> > > other patches to migrate existing drivers to this interface.
> > 
> > I'm generally fine with it, but please target it at 4.4 at the earliest.
> 
> Sure, but I was a bit curious on why 4.4 and not 4.3 ?

I already have 20+ cpufreq patches from you for 4.3 needing my attention,
not to mention the Ashwin's CPPC series.

> as we are still at 4.2-rc1 today, and these patches can be done fairly
> quickly.

*You* can do them faily quickly.  Say if all of the outstanding cpufreq
patches are queued up for 4.3, then it will be the time to submit more.
Otherwise I'll just have an ever growing queue of patches to process
which won't speed up things at all.

Thanks,
Rafael

