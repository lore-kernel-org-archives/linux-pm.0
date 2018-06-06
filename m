From: Patrick Bellasi <patrick.bellasi@arm.com>
Subject: Re: [PATCH 2/2] sched/fair: util_est: add running_sum tracking
Date: Wed, 6 Jun 2018 11:38:09 +0100
Message-ID: <20180606103809.GG31675@e110439-lin>
References: <20180604160600.22052-1-patrick.bellasi@arm.com>
 <20180604160600.22052-3-patrick.bellasi@arm.com>
 <CAKfTPtD8RDxT=-oO2VYJRbtwoEyEKEAau-Ad-bAd8L2T2zKWEg@mail.gmail.com>
 <20180605151129.GC32302@e110439-lin>
 <20180606082640.GA14694@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180606082640.GA14694@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Vincent Guittot <vincent.guittot@linaro.org>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, "open list:THERMAL" <linux-pm@vger.kernel.org>, Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, Viresh Kumar <viresh.kumar@linaro.org>, Dietmar Eggemann <dietmar.eggemann@arm.com>, Morten Rasmussen <morten.rasmussen@arm.com>, Juri Lelli <juri.lelli@redhat.com>, Joel Fernandes <joelaf@google.com>, Steve Muckle <smuckle@google.com>, Todd Kjos <tkjos@google.com>
List-Id: linux-pm@vger.kernel.org

Hi Vincent,

On 06-Jun 10:26, Vincent Guittot wrote:

[...]

> For the above 2 tasks of the example example we have the pattern
> 
> Task 1
> state       RRRRSSSSSSERRRRSSSSSSERRRRSSSSSS
> util_avg    AAAADDDDDD AAAADDDDDD AAAADDDDDD
> 
> Task 2
> state       WWWWRRRRSSEWWWWRRRRSSEWWWWRRRRSS
> util_avg    DDDDAAAADD DDDDAAAADD DDDDAAAADD
> running_avg     AAAADDC    AAAADDC    AAAADD
> 
> R : Running 1ms, S: Sleep 1ms , W: Wait 1ms, E: Enqueue event 
> A: Accumulate 1ms, D: Decay 1ms, C: Copy util_avg value
> 
> the util_avg of T1 and T2 have the same pattern which is:
>   AAAADDDDDDAAAADDDDDDAAAADDDDDD
> and as a result, the same value which represents their utilization
> 
> For the running_avg of T2, there is only 2 decays aftert the last running
> phase and before the next enqueue
> so the pattern will be AAAADDAAAA
> instead of the         AAAADDDDDDAAAA
> 
> the runninh_avg will report a higher value than reality

Right!... Your example above is really useful, thanks.

Reasoning on the same line, we can easily see that a 50% CFS task
co-scheduled with a 50% RT task, which delays the CFS one and has the
same period,  will make the CFS task appear as a 100% task.

Which is definitively not what we want to sample as estimated
utilization.

The good news, if we like, is instead that util_avg is already
correctly reporting 50% at the end of each activation and thus, when
we collect util_est samples we already have the best utilization value
we can collect for a task.

The only time we collect "wrong" estimation samples is when there
is not idle time, thus eventually util_est should be improved by
discarding samples in that cases... but I'm not entirely sure if and
how we can detect them.

Or just to ensure we have idle time... as you are proposing in
the other thread.

Thanks again for pointing out the issue above.

-- 
#include <best/regards.h>

Patrick Bellasi
