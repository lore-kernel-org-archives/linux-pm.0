From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH 2/5] cpufreq: governor: Create separate sysfs-ops
Date: Tue, 2 Feb 2016 20:40:31 +0100
Message-ID: <CAJZ5v0hL4sybqiWCYJpornfJcpMXeAg4E2UNKcCxRB08dhaFPA@mail.gmail.com>
References: <cover.1454410226.git.viresh.kumar@linaro.org>
	<5a012e56b8404e2d07e172b6699ce02f5c5b5f26.1454410226.git.viresh.kumar@linaro.org>
	<20160202154717.GI3947@e106622-lin>
	<CAJZ5v0h3k_CVDkmc8QKczr0MxCuGd+Rm_wSMXO=UHBvOjae0Uw@mail.gmail.com>
	<20160202170144.GL3947@e106622-lin>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160202170144.GL3947@e106622-lin>
Sender: linux-kernel-owner@vger.kernel.org
To: Juri Lelli <juri.lelli@arm.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, Rafael Wysocki <rjw@rjwysocki.net>, Lists linaro-kernel <linaro-kernel@lists.linaro.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Saravana Kannan <skannan@codeaurora.org>, Peter Zijlstra <peterz@infradead.org>, Michael Turquette <mturquette@baylibre.com>, Steve Muckle <steve.muckle@linaro.org>, Vincent Guittot <vincent.guittot@linaro.org>, Morten Rasmussen <morten.rasmussen@arm.com>, dietmar.eggemann@arm.com, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Tue, Feb 2, 2016 at 6:01 PM, Juri Lelli <juri.lelli@arm.com> wrote:
> Hi Rafael,
>
> On 02/02/16 17:35, Rafael J. Wysocki wrote:
>> On Tue, Feb 2, 2016 at 4:47 PM, Juri Lelli <juri.lelli@arm.com> wrote:
>> > Hi Viresh,
>> >
>> > On 02/02/16 16:27, Viresh Kumar wrote:
>> >> Until now, governors (ondemand/conservative) were using the
>> >> 'global-attr' or 'freq-attr', depending on the sysfs location where we
>> >> want to create governor's directory.
>> >>
>> >> The problem is that, in case of 'freq-attr', we are forced to use
>> >> show()/store() present in cpufreq.c, which always take policy->rwsem.
>> >>
>> >> And because of that we were facing some ABBA lockups during governor
>> >> callback event CPUFREQ_GOV_POLICY_EXIT. And so we were dropping the
>> >> rwsem right before calling governor callback for CPUFREQ_GOV_POLICY_EXIT
>> >> event.
>> >>
>> >> That caused further problems and it never worked perfectly.
>> >>
>> >> This patch attempts to fix that by creating separate sysfs-ops for
>> >> cpufreq governors.
>> >>
>> >> Because things got much simplified now, we don't need separate
>> >> show/store callbacks for governor-for-system and governor-per-policy
>> >> cases.
>> >>
>> >> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
>> >
>> > This patch cleans things up a lot, that's good.
>> >
>> > One thing I'm still concerned about, though: don't we need some locking
>> > in place for some of the store operations on governors attributes? Are
>> > store_{ignore_nice_load, sampling_down_fact, etc} safe without locking?
>>
>> That would require some investigation I suppose.
>>
>> > It seems that we can call them from different cpus concurrently.
>>
>> Yes, we can.
>>
>> One quick-and-dirty way of dealing with that might be to introduce a
>> "sysfs lock" into struct dbs_data and hold that around the invocation
>> of gattr->store() in the sysfs_ops's ->store callback.
>>
>
> There is value in trying to solve this issue by using some of the
> existing locks, IMHO.

Some value - maybe.  I'm not sure how much of it, though.

Finer-grained locking is generally easier to follow, because the locks
tend to be used for specific purposes only.

> Can't we actually try to use the policy->rwsem (or one of the core
> locks) + wait_for_completion approach as we do in cpufreq core?

No.  Too many things depend on that lock already and some of them work
by accident rather than by design.

Thanks,
Rafael
