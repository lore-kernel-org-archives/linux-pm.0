From: Steve Muckle <steve.muckle@linaro.org>
Subject: Re: [RFCv5 PATCH 25/46] sched: Add over-utilization/tipping point
 indicator
Date: Tue, 29 Sep 2015 13:08:46 -0700
Message-ID: <560AEFCE.1070905@linaro.org>
References: <1436293469-25707-1-git-send-email-morten.rasmussen@arm.com>
 <1436293469-25707-26-git-send-email-morten.rasmussen@arm.com>
 <20150813173533.GZ19282@twins.programming.kicks-ass.net>
 <20150814130247.GD29326@e105550-lin.cambridge.arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f53.google.com ([209.85.220.53]:34000 "EHLO
	mail-pa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751558AbbI2UIt (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 29 Sep 2015 16:08:49 -0400
Received: by padhy16 with SMTP id hy16so15215391pad.1
        for <linux-pm@vger.kernel.org>; Tue, 29 Sep 2015 13:08:48 -0700 (PDT)
In-Reply-To: <20150814130247.GD29326@e105550-lin.cambridge.arm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Morten Rasmussen <morten.rasmussen@arm.com>, Peter Zijlstra <peterz@infradead.org>
Cc: mingo@redhat.com, vincent.guittot@linaro.org, daniel.lezcano@linaro.org, Dietmar Eggemann <Dietmar.Eggemann@arm.com>, yuyang.du@intel.com, mturquette@baylibre.com, rjw@rjwysocki.net, Juri Lelli <Juri.Lelli@arm.com>, sgurrappadi@nvidia.com, pang.xunlei@zte.com.cn, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org

On 08/14/2015 06:02 AM, Morten Rasmussen wrote:
> To be sure not to break smp_nice, we have defined over-utilization as
> when:
> 
> cpu_rq(any)::cfs::avg::util_avg + margin > cpu_rq(any)::capacity
> 
> is true for any cpu in the system. IOW, as soon as one cpu is (nearly)
> 100% utilized, we switch to load_avg to factor in priority.
> 
> Now with this definition, we can skip periodic load-balance as no cpu
> has an always-running task when the system is not over-utilized. All
> tasks will be periodic and we can balance them at wake-up. This
> conservative condition does however mean that some scenarios that could
> benefit from energy-aware decisions even if one cpu is fully utilized
> would not get those benefits.
> 
> For system where some cpus might have reduced capacity on some cpus
> (RT-pressure and/or big.LITTLE), we want periodic load-balance checks as
> soon a just a single cpu is fully utilized as it might one of those with
> reduced capacity and in that case we want to migrate it.
> 
> I haven't found any reasonably easy-to-track conditions that would work
> better. Suggestions are very welcome.

Workloads with a single heavy task and many small tasks are pretty
common. I'm worried about the single heavy task tripping the
over-utilization condition on a b.L system, EAS getting turned off, and
small tasks running on big CPUs, leading to an increase in power
consumption.

Perhaps an extension to the over-utilization logic such as the following
could cause big CPUs being saturated by a single task to be ignored?

util(cpu X) + margin > capacity(cpu X) &&
  (capacity(cpu X) != max_capacity ? 1 : nr_running(cpu X) > 1)
