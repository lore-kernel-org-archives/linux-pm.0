From: Vincent Guittot <vincent.guittot@linaro.org>
Subject: Re: [PATCH 5/8] sched/cpufreq: pass sched class into cpufreq_update_util
Date: Wed, 16 Mar 2016 10:16:21 +0100
Message-ID: <CAKfTPtCumY3xFxLNNGVgdvpXnXkLMVpzNjm5h4=KGw=5kdHd+g@mail.gmail.com>
References: <1457932932-28444-1-git-send-email-mturquette+renesas@baylibre.com>
 <1457932932-28444-6-git-send-email-mturquette+renesas@baylibre.com>
 <20160315212520.GF6344@twins.programming.kicks-ass.net> <20160315220609.30639.67271@quark.deferred.io>
 <20160316074123.GP6344@twins.programming.kicks-ass.net> <CAKfTPtA8hJUT4HGXjoyX4=qh9iup3_GUMwuJGgbXtBFGgAPFdQ@mail.gmail.com>
 <20160316085339.GU6344@twins.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160316085339.GU6344@twins.programming.kicks-ass.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Zijlstra <peterz@infradead.org>
Cc: Michael Turquette <mturquette@baylibre.com>, "rjw@rjwysocki.net" <rjw@rjwysocki.net>, linux-kernel <linux-kernel@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Juri Lelli <Juri.Lelli@arm.com>, Steve Muckle <steve.muckle@linaro.org>, Morten Rasmussen <morten.rasmussen@arm.com>, Dietmar Eggemann <dietmar.eggemann@arm.com>, Michael Turquette <mturquette+renesas@baylibre.com>
List-Id: linux-pm@vger.kernel.org

On 16 March 2016 at 09:53, Peter Zijlstra <peterz@infradead.org> wrote:
> On Wed, Mar 16, 2016 at 09:29:59AM +0100, Vincent Guittot wrote:
>> I wonder if it's really worth passing per sched_class request to
>> sched_util ? sched_util is about selecting a frequency based on the
>> utilization of the CPU, it only needs a value that reflect the whole
>> utilization. Can't we sum  (or whatever the formula we want to apply)
>> utilizations before calling cpufreq_update_util
>
> So I've thought the same; but I'm conflicted, its a shame to compute
> anything if the call then doesn't do anything with it.

yes, at least we shoud skip all that stuff (including adding a margin)
if no hook has been set in cpufreq_update_util.
I also see potential optimization of updating the value only if the
utilization has been decayed

>
> And keeping a structure of all the various numbers to pass in also has
> cost of yet another cacheline to touch.
