From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH 2/5] cpufreq: governor: Create separate sysfs-ops
Date: Wed, 3 Feb 2016 12:27:45 +0530
Message-ID: <20160203065745.GW31828@vireshk>
References: <20160202154717.GI3947@e106622-lin>
 <CAJZ5v0h3k_CVDkmc8QKczr0MxCuGd+Rm_wSMXO=UHBvOjae0Uw@mail.gmail.com>
 <20160202170144.GL3947@e106622-lin>
 <CAJZ5v0hL4sybqiWCYJpornfJcpMXeAg4E2UNKcCxRB08dhaFPA@mail.gmail.com>
 <56B12BEC.9070603@codeaurora.org>
 <CAJZ5v0jjp7stM6O4XbDjATOUjntpYY-85FeiCC-WUeRVaQwTLA@mail.gmail.com>
 <CAJZ5v0i3WLgu8U5cmEQtfUDy6-LXN3g7auSVjOaMEHd_gqVzvg@mail.gmail.com>
 <56B158A0.6060604@codeaurora.org>
 <CAJZ5v0jEKwgXT0nyUR9ksSw29KMbBK6xjAVxkWFCMgTHw8aHVg@mail.gmail.com>
 <56B17BFC.4070403@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <56B17BFC.4070403@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Saravana Kannan <skannan@codeaurora.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Juri Lelli <juri.lelli@arm.com>, Rafael Wysocki <rjw@rjwysocki.net>, Lists linaro-kernel <linaro-kernel@lists.linaro.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Peter Zijlstra <peterz@infradead.org>, Michael Turquette <mturquette@baylibre.com>, Steve Muckle <steve.muckle@linaro.org>, Vincent Guittot <vincent.guittot@linaro.org>, Morten Rasmussen <morten.rasmussen@arm.com>, dietmar.eggemann@arm.com, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On 02-02-16, 20:03, Saravana Kannan wrote:
> This is the hotplug case I mentioned. The sysfs file removals will happen
> only for the last CPU in that policy (we thankfully optimized that part last
> year). We also know that multiple CPUs can't be hotplugged at the same time.
> So, in the start of cpufreq_offline_prepare, we just need to check if this
> is the last CPU in the policy and if that's the case, do the gov sysfs
> remove and then grab the policy lock and do all our crap. If a read is going
> on, that's going to finish before the sysfs attr remove can go ahead and it
> can grab the policy lock if it needs to and that still won't cause a
> deadlock because we haven't yet grabbed the policy lock in
> cpufreq_offline_prepare(). If the read comes after the sysfs remove, then
> the read is obviously going to fail (we can depend on the sysfs framework on
> doing its job there).

IMHO, these are all dirty hacks we should stay away from. Adding such
hunks in code is considered a band-aid kind of solution and hurts
readability badly. The new solution (new governor show/store)
implement this in a very clean and proper way I feel..

Others are free to disagree though :)

-- 
viresh
