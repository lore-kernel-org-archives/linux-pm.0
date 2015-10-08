From: Steve Muckle <steve.muckle@linaro.org>
Subject: Re: [RFCv5 PATCH 38/46] sched: scheduler-driven cpu frequency
 selection
Date: Wed, 7 Oct 2015 17:14:20 -0700
Message-ID: <5615B55C.8010804@linaro.org>
References: <1436293469-25707-1-git-send-email-morten.rasmussen@arm.com>
 <1436293469-25707-39-git-send-email-morten.rasmussen@arm.com>
 <20150815130545.GI10304@worktop.programming.kicks-ass.net>
 <55DC475B.2080502@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f53.google.com ([209.85.220.53]:34988 "EHLO
	mail-pa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750944AbbJHAOX (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 7 Oct 2015 20:14:23 -0400
Received: by pacfv12 with SMTP id fv12so36392581pac.2
        for <linux-pm@vger.kernel.org>; Wed, 07 Oct 2015 17:14:22 -0700 (PDT)
In-Reply-To: <55DC475B.2080502@arm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Juri Lelli <juri.lelli@arm.com>, Peter Zijlstra <peterz@infradead.org>, Morten Rasmussen <Morten.Rasmussen@arm.com>, "mturquette@baylibre.com" <mturquette@baylibre.com>
Cc: "mingo@redhat.com" <mingo@redhat.com>, "vincent.guittot@linaro.org" <vincent.guittot@linaro.org>, "daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>, Dietmar Eggemann <Dietmar.Eggemann@arm.com>, "yuyang.du@intel.com" <yuyang.du@intel.com>, "rjw@rjwysocki.net" <rjw@rjwysocki.net>, "sgurrappadi@nvidia.com" <sgurrappadi@nvidia.com>, "pang.xunlei@zte.com.cn" <pang.xunlei@zte.com.cn>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>

On 08/25/2015 03:45 AM, Juri Lelli wrote:
> But, it is true that if the above events happened the other way around
> (we trigger an update after load balancing and a new task arrives), we
> may miss the opportunity to jump to max with the new task. In my mind
> this is probably not a big deal, as we'll have a tick pretty soon that
> will fix things anyway (saving us some complexity in the backend).
> 
> What you think?

I fear that waiting up to a full tick to resolve a shortfall in CPU
bandwidth will cause complaints.

Thinking about how this would be implemented raises a couple questions
for me though.

1. To avoid issuing a frequency change request while one is already in
flight, the current code uses the stated cpufreq driver transition
latency to throttle. Wouldn't it be more accurate to block further
requests until the CPUFREQ_POSTCHANGE notifier has run? In addition to
removing the requirement of supplying a latency value, frequency
transitions may take different amounts of time depending on system state
so a single latency value may often be incorrect.

2. The decision of whether or not to call into the low level cpufreq
driver in the scheduler hot paths currently hinges on whether or not the
low level cpufreq driver will sleep. Even if the cpufreq driver does not
sleep however, the latency to enqueue a frequency change (and complete
it if the low level driver is not asynchronous) may still be high,
making it unsuitable to run in a scheduler hot path. Should the
semantics of the flag be changed to indicate whether a cpufreq driver is
fast enough to run in this context? Sleeping would still of course mean
that it is not.

