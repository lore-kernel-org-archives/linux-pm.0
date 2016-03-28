From: Dietmar Eggemann <dietmar.eggemann@arm.com>
Subject: Re: [PATCH 1/2] sched/fair: move cpufreq hook to
 update_cfs_rq_load_avg()
Date: Mon, 28 Mar 2016 20:30:46 +0200
Message-ID: <56F97856.4040804@arm.com>
References: <1458606068-7476-1-git-send-email-smuckle@linaro.org>
 <56F91D56.4020007@arm.com> <56F95D10.4070400@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-am1on0095.outbound.protection.outlook.com ([157.56.112.95]:25846
	"EHLO emea01-am1-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752879AbcC1UFK (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Mon, 28 Mar 2016 16:05:10 -0400
In-Reply-To: <56F95D10.4070400@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Steve Muckle <steve.muckle@linaro.org>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, "Rafael J. Wysocki" <rafael@kernel.org>, Vincent Guittot <vincent.guittot@linaro.org>, Morten Rasmussen <morten.rasmussen@arm.com>, Juri Lelli <Juri.Lelli@arm.com>, Patrick Bellasi <patrick.bellasi@arm.com>, Michael Turquette <mturquette@baylibre.com>

On 03/28/2016 06:34 PM, Steve Muckle wrote:
> Hi Dietmar,
>
> On 03/28/2016 05:02 AM, Dietmar Eggemann wrote:
>> Hi Steve,
>>
>> these patches fall into the bucket of 'optimization of updating the
>> value only if the root cfs_rq util has changed' as discussed in '[PATCH
>> 5/8] sched/cpufreq: pass sched class into cpufreq_update_util' of Mike
>> T's current series '[PATCH 0/8] schedutil enhancements', right?
>
> I would say just the second patch is an optimization. The first and
> third patches cover additional paths in CFS where the hook should be
> called but currently is not, which I think is a correctness issue.

Not disagreeing here but I don't know if this level of accuracy is 
really needed. I mean we currently miss updates in 
enqueue_task_fair()->enqueue_entity()->enqueue_entity_load_avg() and 
idle_balance()/rebalance_domains()->update_blocked_averages() but there 
are plenty of call sides of update_load_avg(se, ...) with 
'&rq_of(cfs_rq_of(se))->cfs == cfs_rq_of(se)'.

The question for me is does schedutil work better with this new, more 
accurate signal? IMO, not receiving a bunch of consecutive 
cpufreq_update_util's w/ the same 'util' value is probably a good thing, 
unless we see the interaction with RT/DL class as mentioned by Sai. Here 
an agreement on the design for the 'capacity vote aggregation from 
CFS/RT/DL' would help to clarify.

>> I wonder if it makes sense to apply them before a proper 'capacity vote
>> aggregation from CFS/RT/DL' has been agreed upon?
>
> Getting the right call sites for the hook in CFS should be orthogonal to
> the sched class vote aggregation IMO.

Hopefully :-)

[...]

Cheers,

-- Dietmar
