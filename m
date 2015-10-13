From: Steve Muckle <steve.muckle@linaro.org>
Subject: Re: [RFCv5 PATCH 40/46] sched/cpufreq_sched: compute freq_new based
 on capacity_orig_of()
Date: Tue, 13 Oct 2015 12:47:53 -0700
Message-ID: <561D5FE9.2050503@linaro.org>
References: <1436293469-25707-1-git-send-email-morten.rasmussen@arm.com>
 <1436293469-25707-41-git-send-email-morten.rasmussen@arm.com>
 <20150815124638.GG10304@worktop.programming.kicks-ass.net>
 <20150816040333.31346.22542@quantum>
 <20150816202401.GJ10304@worktop.programming.kicks-ass.net>
 <55D1D16F.1070106@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f43.google.com ([209.85.220.43]:35260 "EHLO
	mail-pa0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752592AbbJMTr4 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 13 Oct 2015 15:47:56 -0400
Received: by pabve7 with SMTP id ve7so30574221pab.2
        for <linux-pm@vger.kernel.org>; Tue, 13 Oct 2015 12:47:56 -0700 (PDT)
In-Reply-To: <55D1D16F.1070106@arm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Juri Lelli <juri.lelli@arm.com>, Peter Zijlstra <peterz@infradead.org>, Michael Turquette <mturquette@baylibre.com>
Cc: Morten Rasmussen <Morten.Rasmussen@arm.com>, "mingo@redhat.com" <mingo@redhat.com>, "vincent.guittot@linaro.org" <vincent.guittot@linaro.org>, "daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>, Dietmar Eggemann <Dietmar.Eggemann@arm.com>, "yuyang.du@intel.com" <yuyang.du@intel.com>, "rjw@rjwysocki.net" <rjw@rjwysocki.net>, "sgurrappadi@nvidia.com" <sgurrappadi@nvidia.com>, "pang.xunlei@zte.com.cn" <pang.xunlei@zte.com.cn>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>

On 08/17/2015 05:19 AM, Juri Lelli wrote:
>> Nah, just maybe: (capacity << SCHED_CAPACITY_SHIFT) / capacity_orig_of()
>> > such that you don't have to export that knowledge to this thing.
>> > 
> Oh, right. I guess we can just go with something like:
> 
>  req_cap = get_cpu_usage(cpu) * capacity_margin / capacity_orig_of(cpu);
> 
> on fair.c side and switch back to
> 
>  freq_new = capacity * policy->max >> SCHED_CAPACITY_SHIFT;
> 
> on cpufreq_sched.c side. That saves us exporting capacity_orig_of().

Another good reason to make this change - I believe the current code
will not support a cpufreq policy covering CPUs of different types (such
as a b.L system in a single frequency domain).

The max requested capacity is calculated using the absolute/global
capacity values requested from each CPU. A small CPU needing a higher
OPP may get ignored because of a request from a big CPU for a lower OPP,
because the big CPU @ lower OPP shows up as the max capacity request.
