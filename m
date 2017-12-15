From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH v2 2/4] sched/fair: add util_est on top of PELT
Date: Fri, 15 Dec 2017 13:58:00 +0100
Message-ID: <20171215125800.fshczo2tgilmcdtk@hirez.programming.kicks-ass.net>
References: <20171205171018.9203-1-patrick.bellasi@arm.com>
 <20171205171018.9203-3-patrick.bellasi@arm.com>
 <20171213161922.qbxq2ko5q6ttzu2p@hirez.programming.kicks-ass.net>
 <20171213163653.GD8264@e110439-lin>
 <20171213170309.5yk62ipzo3ckpw6o@hirez.programming.kicks-ass.net>
 <20171215120331.GA19821@e110439-lin>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from merlin.infradead.org ([205.233.59.134]:43986 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755202AbdLOM6I (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 15 Dec 2017 07:58:08 -0500
Content-Disposition: inline
In-Reply-To: <20171215120331.GA19821@e110439-lin>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Patrick Bellasi <patrick.bellasi@arm.com>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, Ingo Molnar <mingo@redhat.com>, "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, Viresh Kumar <viresh.kumar@linaro.org>, Vincent Guittot <vincent.guittot@linaro.org>, Paul Turner <pjt@google.com>, Dietmar Eggemann <dietmar.eggemann@arm.com>, Morten Rasmussen <morten.rasmussen@arm.com>, Juri Lelli <juri.lelli@redhat.com>, Todd Kjos <tkjos@android.com>, Joel Fernandes <joelaf@google.com>

On Fri, Dec 15, 2017 at 12:03:31PM +0000, Patrick Bellasi wrote:

> So, by moving util_est right after sched_avg, here is what we get (with some
> lines to better highlight 64B boundaries):
> 
>                 const struct sched_class  * sched_class;                                 /*   152     8 */
>                 struct sched_entity {
> 			[...]
> 		---[ Line 9 ]-------------------------------------------------------------------------------
>                         struct sched_avg {
>                                 /* typedef u64 */ long long unsigned int last_update_time; /*   576     8 */
>                                 /* typedef u64 */ long long unsigned int load_sum;       /*   584     8 */
>                                 /* typedef u64 */ long long unsigned int runnable_load_sum; /*   592     8 */
>                                 /* typedef u32 */ unsigned int util_sum;                 /*   600     4 */
>                                 /* typedef u32 */ unsigned int period_contrib;           /*   604     4 */
>                                 long unsigned int load_avg;                              /*   608     8 */
>                                 long unsigned int runnable_load_avg;                     /*   616     8 */
>                                 long unsigned int util_avg;                              /*   624     8 */
>                         } avg; /*   576    56 */
>                         /* --- cacheline 6 boundary (384 bytes) was 24 bytes ago --- */
>                         struct util_est {
>                                 long unsigned int last;                                  /*   632     8 */
> 		---[ Line 10 ]------------------------------------------------------------------------------
>                                 long unsigned int ewma;                                  /*   640     8 */
>                         } util_est; /*   632    16 */
>                 } se; /*   192   512 */
> 		---[ Line 11 ]------------------------------------------------------------------------------
>                 /* --- cacheline 9 boundary (576 bytes) was 24 bytes ago --- */
>                 struct sched_rt_entity {
>                         struct list_head {
>                                 struct list_head * next;                                 /*   704     8 */
>                                 struct list_head * prev;                                 /*   712     8 */
>                         } run_list; /*   704    16 */
> 
> 
> As you can see we still end up with util_est spanning acrosss two cache and
> even worst with an almost empty Line 10. The point is that sched_avg already
> uses 56B... which leave just 8bytes left.

Yes, that's unfortunate.

> So, I can to move util_est there and use unsigned int for "last" and "ewma"
> storage. This should fix the cache alignment but only until we do not add
> other stuff to sched_avg.
> 
> BTW, should not be possible to use a similar "fasting" approach for load_avg
> and runnable_load_avg? Given their range a u32 should be just good enough,
> isn't it?

Probably, I'd have to page all that stuff back in :/

Another issue is that for tasks load and runnable_load are the exact
same; I just never found a sensible way to collapse that.
