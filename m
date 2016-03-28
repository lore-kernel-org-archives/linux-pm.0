From: Steve Muckle <steve.muckle@linaro.org>
Subject: Re: [PATCH 1/2] sched/fair: move cpufreq hook to
 update_cfs_rq_load_avg()
Date: Mon, 28 Mar 2016 12:38:26 -0700
Message-ID: <56F98832.3030207@linaro.org>
References: <1458606068-7476-1-git-send-email-smuckle@linaro.org>
 <56F91D56.4020007@arm.com> <56F95D10.4070400@linaro.org>
 <56F97856.4040804@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <56F97856.4040804@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Dietmar Eggemann <dietmar.eggemann@arm.com>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, "Rafael J. Wysocki" <rafael@kernel.org>, Vincent Guittot <vincent.guittot@linaro.org>, Morten Rasmussen <morten.rasmussen@arm.com>, Juri Lelli <Juri.Lelli@arm.com>, Patrick Bellasi <patrick.bellasi@arm.com>, Michael Turquette <mturquette@baylibre.com>
List-Id: linux-pm@vger.kernel.org

On 03/28/2016 11:30 AM, Dietmar Eggemann wrote:
> On 03/28/2016 06:34 PM, Steve Muckle wrote:
>> Hi Dietmar,
>>
>> On 03/28/2016 05:02 AM, Dietmar Eggemann wrote:
>>> Hi Steve,
>>>
>>> these patches fall into the bucket of 'optimization of updating the
>>> value only if the root cfs_rq util has changed' as discussed in '[PATCH
>>> 5/8] sched/cpufreq: pass sched class into cpufreq_update_util' of Mike
>>> T's current series '[PATCH 0/8] schedutil enhancements', right?
>>
>> I would say just the second patch is an optimization. The first and
>> third patches cover additional paths in CFS where the hook should be
>> called but currently is not, which I think is a correctness issue.
> 
> Not disagreeing here but I don't know if this level of accuracy is
> really needed. I mean we currently miss updates in
> enqueue_task_fair()->enqueue_entity()->enqueue_entity_load_avg() and
> idle_balance()/rebalance_domains()->update_blocked_averages() but there
> are plenty of call sides of update_load_avg(se, ...) with
> '&rq_of(cfs_rq_of(se))->cfs == cfs_rq_of(se)'.
>
> The question for me is does schedutil work better with this new, more
> accurate signal? IMO, not receiving a bunch of consecutive
> cpufreq_update_util's w/ the same 'util' value is probably a good thing,
> unless we see the interaction with RT/DL class as mentioned by Sai. Here
> an agreement on the design for the 'capacity vote aggregation from
> CFS/RT/DL' would help to clarify.

Without covering all the paths where CFS utilization changes it's
possible to have to wait up to a tick to act on some changes, since the
tick is the only guaranteed regularly-occurring instance of the hook.
That's an unacceptable amount of latency IMO...

thanks,
Steve
