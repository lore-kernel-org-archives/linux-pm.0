From: Steve Muckle <steve.muckle@linaro.org>
Subject: Re: [PATCH 4/8] cpufreq/schedutil: sysfs capacity margin tunable
Date: Tue, 15 Mar 2016 20:36:57 -0700
Message-ID: <56E8D4D9.1060202@linaro.org>
References: <1457932932-28444-1-git-send-email-mturquette+renesas@baylibre.com>
 <1457932932-28444-5-git-send-email-mturquette+renesas@baylibre.com>
 <20160315212047.GE6344@twins.programming.kicks-ass.net>
 <20160315214043.30639.75507@quark.deferred.io>
 <20160315214821.GM6344@twins.programming.kicks-ass.net>
 <20160315223701.30639.43127@quark.deferred.io>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160315223701.30639.43127@quark.deferred.io>
Sender: linux-kernel-owner@vger.kernel.org
To: Michael Turquette <mturquette@baylibre.com>, Peter Zijlstra <peterz@infradead.org>
Cc: rjw@rjwysocki.net, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, Juri.Lelli@arm.com, morten.rasmussen@arm.com, dietmar.eggemann@arm.com, vincent.guittot@linaro.org, Michael Turquette <mturquette+renesas@baylibre.com>, Patrick Bellasi <patrick.bellasi@arm.com>
List-Id: linux-pm@vger.kernel.org

On 03/15/2016 03:37 PM, Michael Turquette wrote:
>>>> Yuck sysfs.. I would really rather we did not expose this per default.
>>>> > > > And certainly not in this weird form.
>>> > > 
>>> > > I'm happy to change capacity_margin to up_threshold and use a
>>> > > percentage.
>>> > > 
>>> > > The sysfs approach has two benefits. First, it is aligned with cpufreq
>>> > > user expectations. Second, there has been rough consensus that this
>>> > > value should be tunable and sysfs gets us there quickly and painlessly.
>>> > > We're already exporting rate_limit_us for schedutil via sysfs. Is there
>>> > > a better way interface you can recommend?
>> > 
>> > It really depends on how tunable you want this to be. Do we always want
>> > this to be a tunable, or just now while we're playing about with the
>> > whole thing?
>
> I had considered this myself, and I really think that Steve and Juri
> should chime in as they have spent more time tuning and running the
> numbers.
> 
> I'm inclined to think that a debug version would be good enough, as I
> don't imagine this value being changed at run-time by some userspace
> daemon or something.
> 
> Then again, maybe this knob will be part of the mythical
> power-vs-performance slider?

Patrick Bellasi's schedtune series [0] (which I think is the referenced
mythical slider) aims to provide a more sophisticated interface for
tuning scheduler-driven frequency selection. In addition to a global
boost value it includes a cgroup controller as well for per-task tuning.

I would definitely expect the margin/boost value to be modified at
runtime, for example if the battery is running low, or the user wants
100% performance for a while, or the userspace framework wants to
temporarily tailor the performance level for a particular set of tasks, etc.

[0] http://article.gmane.org/gmane.linux.kernel/2022959
