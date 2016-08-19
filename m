From: Steve Muckle <steve.muckle@linaro.org>
Subject: Re: [PATCH] sched: fix incorrect PELT values on SMT
Date: Fri, 19 Aug 2016 13:10:37 -0700
Message-ID: <20160819201037.GE11114@graphite.smuckle.net>
References: <1471571741-19504-1-git-send-email-smuckle@linaro.org>
 <20160819153038.GB25262@e105550-lin.cambridge.arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f46.google.com ([209.85.220.46]:34828 "EHLO
        mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755725AbcHSUKl (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 19 Aug 2016 16:10:41 -0400
Received: by mail-pa0-f46.google.com with SMTP id hb8so463330pac.2
        for <linux-pm@vger.kernel.org>; Fri, 19 Aug 2016 13:10:40 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20160819153038.GB25262@e105550-lin.cambridge.arm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Morten Rasmussen <morten.rasmussen@arm.com>
Cc: Steve Muckle <steve.muckle@linaro.org>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, "Rafael J . Wysocki" <rafael@kernel.org>, Vincent Guittot <vincent.guittot@linaro.org>, Dietmar Eggemann <dietmar.eggemann@arm.com>, Juri Lelli <Juri.Lelli@arm.com>, Patrick Bellasi <patrick.bellasi@arm.com>

On Fri, Aug 19, 2016 at 04:30:39PM +0100, Morten Rasmussen wrote:
> Hi Steve,
> 
> On Thu, Aug 18, 2016 at 06:55:41PM -0700, Steve Muckle wrote:
> > PELT scales its util_sum and util_avg values via
> > arch_scale_cpu_capacity(). If that function is passed the CPU's sched
> > domain then it will reduce the scaling capacity if SD_SHARE_CPUCAPACITY
> > is set. PELT does not pass in the sd however. The other caller of
> > arch_scale_cpu_capacity, update_cpu_capacity(), does. This means
> > util_sum and util_avg scale beyond the CPU capacity on SMT.
> > 
> > On an Intel i7-3630QM for example rq->cpu_capacity_orig is 589 but
> > util_avg scales up to 1024.
> 
> I can't convince myself whether this is the right thing to do. SMT is a
> bit 'special' and it depends on how you model SMT capacity.
> 
> I'm no SMT expert, but the way I understand the current SMT capacity
> model is that capacity_orig represents the capacity of the SMT-thread
> when all its thread-siblings are busy. The true capacity of an
> SMT-thread where all thread-siblings are idle is actually 1024, but we
> don't model this (it would be nightmare to track when the capacity
> should change). The capacity of a core with two or more SMT-threads is
> chosen to be 1024 + smt_gain, where smt_gain is supposed represent the
> additional throughput we gain for the additional SMT-threads. The reason
> why we don't have 1024 per thread is that we would prefer to have only
> one task per core if possible.
> 
> With util_avg scaling to 1024 a core (capacity = 2*589) would be nearly
> 'full' with just one always-running task. If we change util_avg to max
> out at 589, it would take two always-running tasks for the combined
> utilization to match the core capacity. So we may loose some bias
> towards spreading for SMT systems.
> 
> AFAICT, group_is_overloaded() and group_has_capacity() would both be
> affected by this patch.
> 
> Interestingly, Vincent recently proposed to set the SMT-thread capacity
> to 1024 which would affectively make all the current SMT code redundant.
> It would make things a lot simpler, but I'm not sure if we can get away
> with it. It would need discussion at least.
> 
> Opinions?

Thanks for having a look.

The reason I pushed this patch was to address an issue with the
schedutil governor - demand is effectively doubled on SMT systems due to
the above scheme. But this can just be fixed for schedutil by using a
max value there consistent with what __update_load_avg() is using. I'll send
another patch. It looks like there's a good reason for the current PELT
scaling w.r.t. SMT in the scheduler/load balancer.

thanks,
Steve

