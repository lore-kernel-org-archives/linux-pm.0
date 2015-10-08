From: Juri Lelli <juri.lelli@arm.com>
Subject: Re: [RFCv5 PATCH 38/46] sched: scheduler-driven cpu frequency
 selection
Date: Thu, 8 Oct 2015 10:41:53 +0100
Message-ID: <56163A61.6030207@arm.com>
References: <1436293469-25707-1-git-send-email-morten.rasmussen@arm.com>
 <1436293469-25707-39-git-send-email-morten.rasmussen@arm.com>
 <20150815130545.GI10304@worktop.programming.kicks-ass.net>
 <55DC475B.2080502@arm.com> <5615B55C.8010804@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: 8BIT
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from eu-smtp-delivery-143.mimecast.com ([207.82.80.143]:23612 "EHLO
	eu-smtp-delivery-143.mimecast.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755648AbbJHJl5 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Thu, 8 Oct 2015 05:41:57 -0400
In-Reply-To: <5615B55C.8010804@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Steve Muckle <steve.muckle@linaro.org>, Peter Zijlstra <peterz@infradead.org>, Morten Rasmussen <Morten.Rasmussen@arm.com>, "mturquette@baylibre.com" <mturquette@baylibre.com>
Cc: "mingo@redhat.com" <mingo@redhat.com>, "vincent.guittot@linaro.org" <vincent.guittot@linaro.org>, "daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>, Dietmar Eggemann <Dietmar.Eggemann@arm.com>, "yuyang.du@intel.com" <yuyang.du@intel.com>, "rjw@rjwysocki.net" <rjw@rjwysocki.net>, "sgurrappadi@nvidia.com" <sgurrappadi@nvidia.com>, "pang.xunlei@zte.com.cn" <pang.xunlei@zte.com.cn>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>

On 08/10/15 01:14, Steve Muckle wrote:
> On 08/25/2015 03:45 AM, Juri Lelli wrote:
>> But, it is true that if the above events happened the other way around
>> (we trigger an update after load balancing and a new task arrives), we
>> may miss the opportunity to jump to max with the new task. In my mind
>> this is probably not a big deal, as we'll have a tick pretty soon that
>> will fix things anyway (saving us some complexity in the backend).
>>
>> What you think?
> 
> I fear that waiting up to a full tick to resolve a shortfall in CPU
> bandwidth will cause complaints.
>

Right, especially now that we'll extend the thing for other classes
as well. So, I guess we'll actually need to buffer requests, as Peter
was already suggesting.

> Thinking about how this would be implemented raises a couple questions
> for me though.
> 
> 1. To avoid issuing a frequency change request while one is already in
> flight, the current code uses the stated cpufreq driver transition
> latency to throttle. Wouldn't it be more accurate to block further
> requests until the CPUFREQ_POSTCHANGE notifier has run? In addition to
> removing the requirement of supplying a latency value, frequency
> transitions may take different amounts of time depending on system state
> so a single latency value may often be incorrect.
> 

Looks good to me.

> 2. The decision of whether or not to call into the low level cpufreq
> driver in the scheduler hot paths currently hinges on whether or not the
> low level cpufreq driver will sleep. Even if the cpufreq driver does not
> sleep however, the latency to enqueue a frequency change (and complete
> it if the low level driver is not asynchronous) may still be high,
> making it unsuitable to run in a scheduler hot path. Should the
> semantics of the flag be changed to indicate whether a cpufreq driver is
> fast enough to run in this context? Sleeping would still of course mean
> that it is not.
> 

Yeah, we assumed that not sleeping means fast. I didn't really played
with this configuration, so I can't say if this is a problem or not.
But, I agree with you that, if this is a problem, we could change
semantic of the flag (maybe it is just more general?).

Thanks,

- Juri

