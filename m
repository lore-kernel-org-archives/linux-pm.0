From: Vincent Guittot <vincent.guittot@linaro.org>
Subject: Re: [PATCH] sched/fair: schedutil: update only with all info available
Date: Wed, 11 Apr 2018 18:10:47 +0200
Message-ID: <CAKfTPtDjyjC5R7bhjGxhV8BN5J+LdzJmMgwaaVuE9ypvcSKapA@mail.gmail.com>
References: <20180406172835.20078-1-patrick.bellasi@arm.com>
 <CAKfTPtCkZ1x-LS7sfJ7K2cgsKK=hYnDo1Fi3toPcGT0331Vpog@mail.gmail.com>
 <20180410110412.GG14248@e110439-lin> <20180411151450.GK4043@hirez.programming.kicks-ass.net>
 <CAKfTPtC+-FR3ZD_t1vkGR2gVoUyxXpE=i4g9zqqLXu4jKKqgUA@mail.gmail.com>
 <20180411153710.GN4082@hirez.programming.kicks-ass.net> <CAKfTPtCNdxSmDfDO0Etf7fbYPeryrjdQChSGwMWxSRH8CcXqqg@mail.gmail.com>
 <20180411160000.GO4082@hirez.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180411160000.GO4082@hirez.programming.kicks-ass.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Zijlstra <peterz@infradead.org>
Cc: Patrick Bellasi <patrick.bellasi@arm.com>, linux-kernel <linux-kernel@vger.kernel.org>, "open list:THERMAL" <linux-pm@vger.kernel.org>, Ingo Molnar <mingo@redhat.com>, "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, Viresh Kumar <viresh.kumar@linaro.org>, Juri Lelli <juri.lelli@redhat.com>, Joel Fernandes <joelaf@google.com>, Steve Muckle <smuckle@google.com>, Dietmar Eggemann <dietmar.eggemann@arm.com>, Morten Rasmussen <morten.rasmussen@arm.com>
List-Id: linux-pm@vger.kernel.org

On 11 April 2018 at 18:00, Peter Zijlstra <peterz@infradead.org> wrote:
> On Wed, Apr 11, 2018 at 05:41:24PM +0200, Vincent Guittot wrote:
>> Yes. and to be honest I don't have any clues of the root cause :-(
>> Heiner mentioned that it's much better in latest linux-next but I
>> haven't seen any changes related to the code of those patches
>
> Yeah, it's a bit of a puzzle. Now you touch nohz, and the patches in
> next that are most likely to have affected this are rjw's
> cpuidle-vs-nohz patches. The common demoninator being nohz.
>
> Now I think rjw's patches will ensure we enter nohz _less_, they avoid
> stopping the tick when we expect to go idle for a short period only.
>
> So if your patch makes nohz go wobbly, going nohz less will make that
> better.
>
> Of course, I've no actual clue as to what that patch (it's the last one
> in the series, right?:
>
>   31e77c93e432 ("sched/fair: Update blocked load when newly idle")
>
> ) does that is so offensive to that one machine. You never did manage to
> reproduce, right?

yes

>
> Could is be that for some reason the nohz balancer now takes a very long
> time to run?

Heiner mentions that is was a relatively slow celeron and he uses
ondemand governor. So I was about to ask him to use performance
governor to see if it can be because cpu runs slow and takes too muche
time to enter idle

>
> Could something like the following happen (and this is really flaky
> thinking here):
>
> last CPU goes idle, we enter idle_balance(), that kicks ilb, ilb runs,
> which somehow again triggers idle_balance and around we go?
>
> I'm not immediately seeing how that could happen, but if we do something
> daft like that we can tie up the CPU for a while, mostly with IRQs
> disabled, and that would be visible as that latency he sees.
>
>
