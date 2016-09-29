From: Sai Gurrappadi <sgurrappadi@nvidia.com>
Subject: Re: [RFC] sched/core: Fix up load metric exposed to cpuidle
Date: Thu, 29 Sep 2016 11:22:50 -0700
Message-ID: <57ED5BFA.3050209@nvidia.com>
References: <57E5A37B.8010802@nvidia.com> <20160923220636.GG5012@twins.programming.kicks-ass.net> <57E5B047.5010700@nvidia.com> <1597108.oRJKXZmdK4@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from hqemgate15.nvidia.com ([216.228.121.64]:14172 "EHLO
        hqemgate15.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934616AbcI2S1f (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 29 Sep 2016 14:27:35 -0400
In-Reply-To: <1597108.oRJKXZmdK4@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Peter Zijlstra <peterz@infradead.org>, "rafael.j.wysocki@intel.com" <rafael.j.wysocki@intel.com>, Peter Boonstoppel <pboonstoppel@nvidia.com>, Colin Cross <ccross@android.com>, Arjan van de Ven <arjan@linux.intel.com>, linux-pm@vger.kernel.org


On 09/29/2016 06:22 AM, Rafael J. Wysocki wrote:
> On Friday, September 23, 2016 03:44:23 PM Sai Gurrappadi wrote:
>>
>> On 09/23/2016 03:06 PM, Peter Zijlstra wrote:
>>>> On Fri, Sep 23, 2016 at 02:49:47PM -0700, Sai Gurrappadi wrote:

...

>>>> The previous metric the menu governor used was rq->cpu_load[0] which is a
>>>> snap shot of the weighted_cpuload at the previous load update point so it
>>>> isn't always 0 on idle entry.
>>>
>>> Right, basically a 'random' number :)
>>
>> Indeed. I never really understood how things worked with the cpu_load stuff
>> given how random it seemed.
> 
> Well, the choice seems to be between "better performance, but we don't really
> know how we get that" and "more idle and we understand how it works".
> 
> Honestly, I prefer to understand how it works in the first place.

A busier CPU wants to enter shallower idle states because the cost of entering
deeper idle states (exit latency wise) is bigger. The performance_multiplier 
stuff in the menu governor tries to map a cpu load metric -> exit latency 
tolerance by tweaking a fudge factor. This idea at least makes sense.

The problem is that the cpu load metric it used (rq->cpu_load[0]) isn't the 
best thing for this purpose because it is highly dependent on how the sched
tick aligns with the workload.

We found that not considering CPU load in the menu governor did result in worse
idle state prediction resulting in performance loss due to the higher exit 
latency of the deeper idle states.

> 
> Of course, the fact that the metric used currently is (almost) always 0 is a
> problem, but it doesn't seem like going back to the old one would be a huge
> improvement either.

Yup, I agree. Ideally we redo the performance_multiplier stuff in the menu
governor to use a better metric (rq->cfs.avg.load_avg?) or maybe we go address
why the predictor fails in the first place in a different manner.

Do note that this stuff was using rq->cpu_load when it still used
rq->load.weight as the input metric. This was switched once we added the PELT
metric but the fudge factors in performance_multiplier haven't changed so that
in itself might be a good enough reason to redo it..

Thanks,
-Sai

-----------------------------------------------------------------------------------
This email message is for the sole use of the intended recipient(s) and may contain
confidential information.  Any unauthorized review, use, disclosure or distribution
is prohibited.  If you are not the intended recipient, please contact the sender by
reply email and destroy all copies of the original message.
-----------------------------------------------------------------------------------
