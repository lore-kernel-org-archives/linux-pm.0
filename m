From: Sai Gurrappadi <sgurrappadi@nvidia.com>
Subject: Re: [RFC] sched/core: Fix up load metric exposed to cpuidle
Date: Fri, 23 Sep 2016 15:44:23 -0700
Message-ID: <57E5B047.5010700@nvidia.com>
References: <57E5A37B.8010802@nvidia.com> <20160923220636.GG5012@twins.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from hqemgate14.nvidia.com ([216.228.121.143]:13325 "EHLO
        hqemgate14.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1760049AbcIWWsu (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 23 Sep 2016 18:48:50 -0400
In-Reply-To: <20160923220636.GG5012@twins.programming.kicks-ass.net>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Peter Zijlstra <peterz@infradead.org>
Cc: "rafael.j.wysocki@intel.com" <rafael.j.wysocki@intel.com>, Peter Boonstoppel <pboonstoppel@nvidia.com>, Colin Cross <ccross@android.com>, Arjan van de Ven <arjan@linux.intel.com>, linux-pm@vger.kernel.org


On 09/23/2016 03:06 PM, Peter Zijlstra wrote:> On Fri, Sep 23, 2016 at 02:49:47PM -0700, Sai Gurrappadi wrote:
>> When triaging a performance degradation of ~5% on some use cases between
>> our k3.18 and k4.4 trees, we found that the menu cpuidle governor on k4.4
>> was way more aggressive when requesting for deeper idle states. It would
>> often get it wrong though resulting in perf loss.
>>
>> The menu governor tries to bias picking shallower idle states based on the
>> historical load on the CPU. The busier the CPU, the shallower the idle
>> state.
>>
>> However, after commit "3289bdb sched: Move the loadavg code to a more
> 
> The normal quoting style is:
> 
>   3289bdb42988 ("sched: Move the loadavg code to a more obvious location")
> 
> Use at least 12 SHA1 characters, collisions on 7-8 char abbrevs have
> already happened.
> 
> Also, that was more than a year ago, nobody noticed?

Ah, sorry. Will do next time.

> 
>> obvious location", the load metric it looks at is rq->load.weight which is
>> the instantaneous se->load.weight sum for top level entities on the rq
>> which on idle entry is always 0 (for the common case at least) because
>> there is nothing on the cfs rq.
>>
>> The previous metric the menu governor used was rq->cpu_load[0] which is a
>> snap shot of the weighted_cpuload at the previous load update point so it
>> isn't always 0 on idle entry.
> 
> Right, basically a 'random' number :)

Indeed. I never really understood how things worked with the cpu_load stuff
given how random it seemed.

> 
>> Unfortunately, it isn't straightforward to switch the metric being used to
>> rq->cfs.load_avg or rq->cfs.util_avg because they overestimate the load a
>> lot more than rq->cpu_load[0] (include blocked task contrib.). That would
>> potentially require redoing the magic constants in the menu governor's
>> performance_multiplier...so for now, use rq->cpu_load[0] instead to
>> preserve old behaviour.
> 
> Works for me I suppose, but I would indeed encourage people to
> investigate better options.

Thanks for the review :)

-Sai
