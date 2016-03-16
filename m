From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH 5/8] sched/cpufreq: pass sched class into cpufreq_update_util
Date: Wed, 16 Mar 2016 14:23:21 +0100
Message-ID: <CAJZ5v0hMqZ2+6wKf8f1enmCWjaTQJFdBoyCQOUrnUYJ1zfUX5g@mail.gmail.com>
References: <1457932932-28444-1-git-send-email-mturquette+renesas@baylibre.com>
	<1457932932-28444-6-git-send-email-mturquette+renesas@baylibre.com>
	<20160315212520.GF6344@twins.programming.kicks-ass.net>
	<20160315220609.30639.67271@quark.deferred.io>
	<20160316074123.GP6344@twins.programming.kicks-ass.net>
	<CAKfTPtA8hJUT4HGXjoyX4=qh9iup3_GUMwuJGgbXtBFGgAPFdQ@mail.gmail.com>
	<20160316085339.GU6344@twins.programming.kicks-ass.net>
	<CAJZ5v0jPtobKGR01D9obxhHibz4aPrPFjmuX19zAE5a5Uz8aEQ@mail.gmail.com>
	<20160316131008.GW6344@twins.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-lf0-f67.google.com ([209.85.215.67]:33681 "EHLO
	mail-lf0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965315AbcCPNXY (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 16 Mar 2016 09:23:24 -0400
In-Reply-To: <20160316131008.GW6344@twins.programming.kicks-ass.net>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Peter Zijlstra <peterz@infradead.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Vincent Guittot <vincent.guittot@linaro.org>, Michael Turquette <mturquette@baylibre.com>, "rjw@rjwysocki.net" <rjw@rjwysocki.net>, linux-kernel <linux-kernel@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Juri Lelli <Juri.Lelli@arm.com>, Steve Muckle <steve.muckle@linaro.org>, Morten Rasmussen <morten.rasmussen@arm.com>, Dietmar Eggemann <dietmar.eggemann@arm.com>, Michael Turquette <mturquette+renesas@baylibre.com>

On Wed, Mar 16, 2016 at 2:10 PM, Peter Zijlstra <peterz@infradead.org> wrote:
> On Wed, Mar 16, 2016 at 01:39:10PM +0100, Rafael J. Wysocki wrote:
>> On Wed, Mar 16, 2016 at 9:53 AM, Peter Zijlstra <peterz@infradead.org> wrote:
>> > On Wed, Mar 16, 2016 at 09:29:59AM +0100, Vincent Guittot wrote:
>> >> I wonder if it's really worth passing per sched_class request to
>> >> sched_util ? sched_util is about selecting a frequency based on the
>> >> utilization of the CPU, it only needs a value that reflect the whole
>> >> utilization. Can't we sum  (or whatever the formula we want to apply)
>> >> utilizations before calling cpufreq_update_util
>> >
>> > So I've thought the same; but I'm conflicted, its a shame to compute
>> > anything if the call then doesn't do anything with it.
>> >
>> > And keeping a structure of all the various numbers to pass in also has
>> > cost of yet another cacheline to touch.
>>
>> In principle we can use high-order bits of util and max to encode the
>> information on where they come from.
>>
>> Of course, that translates to additional ifs in the governor, but I
>> guess they are unavoidable anyway.
>
> Another thing we can do, for as long as we have the indirect function
> call anyway, is stuff extra pointers in that same cacheline we pull the
> function from.
>
> Something like the below; there's room for 8 pointers (including the
> function pointer) in a cacheline.
>
> That would allow the callback to fetch whatever data it feels is
> required (could be all of it).
>
> We could also put a u64 *now = &rq->clock in, which would leave another
> 4 pointers for DL/RT support.
>
> And since we're then back to 1-2 arguments on the function, we can add a
> flags/mask field to indicate what changed (and if the function
> throttles, it can keep a mask of all that changed since last time it
> actually did something, or allow punching through the throttle if our
> minimum guarantee changes or whatnot).
>
> (this would of course require we allocate struct update_util_data with
> the proper alignment thingies etc..)
>
> Then again, maybe this is somewhat overboard :-)

I was thinking about something along these lines, but then I thought
that passing in registers would be more efficient.

One advantage I can see here is that we don't pass arguments that may
not be used by the callee.

> diff --git a/include/linux/sched.h b/include/linux/sched.h
> index ba49c9efd0b2..d34d75c5cc93 100644
> --- a/include/linux/sched.h
> +++ b/include/linux/sched.h
> @@ -3236,8 +3236,10 @@ static inline unsigned long rlimit_max(unsigned int limit)
>
>  #ifdef CONFIG_CPU_FREQ
>  struct update_util_data {
> -       void (*func)(struct update_util_data *data,
> -                    u64 time, unsigned long util, unsigned long max);
> +       unsigned long *cfs_util_avg;
> +       unsigned long *cfs_util_max;
> +
> +       void (*func)(struct update_util_data *data, u64 time);
>  };

How do we ensure proper alignment?

>  void cpufreq_set_update_util_data(int cpu, struct update_util_data *data);
> diff --git a/kernel/sched/cpufreq.c b/kernel/sched/cpufreq.c
> index 928c4ba32f68..de5b20b11de3 100644
> --- a/kernel/sched/cpufreq.c
> +++ b/kernel/sched/cpufreq.c
> @@ -32,6 +32,9 @@ void cpufreq_set_update_util_data(int cpu, struct update_util_data *data)
>         if (WARN_ON(data && !data->func))
>                 return;
>
> +       data->cfs_util_avg = &cpu_rq(cpu)->cfs.avg.util_avg;
> +       data->cfs_util_max = &cpu_rq(cpu)->cpu_capacity_orig;
> +
>         rcu_assign_pointer(per_cpu(cpufreq_update_util_data, cpu), data);
>  }
>  EXPORT_SYMBOL_GPL(cpufreq_set_update_util_data);
