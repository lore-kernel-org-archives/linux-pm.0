From: Morten Rasmussen <morten.rasmussen@arm.com>
Subject: Re: [PATCH] sched: fix incorrect PELT values on SMT
Date: Fri, 19 Aug 2016 16:30:39 +0100
Message-ID: <20160819153038.GB25262@e105550-lin.cambridge.arm.com>
References: <1471571741-19504-1-git-send-email-smuckle@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:36954 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755466AbcHSPae (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 19 Aug 2016 11:30:34 -0400
Content-Disposition: inline
In-Reply-To: <1471571741-19504-1-git-send-email-smuckle@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Steve Muckle <steve.muckle@linaro.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, "Rafael J . Wysocki" <rafael@kernel.org>, Vincent Guittot <vincent.guittot@linaro.org>, Dietmar Eggemann <dietmar.eggemann@arm.com>, Juri Lelli <Juri.Lelli@arm.com>, Patrick Bellasi <patrick.bellasi@arm.com>, Steve Muckle <smuckle@linaro.org>

Hi Steve,

On Thu, Aug 18, 2016 at 06:55:41PM -0700, Steve Muckle wrote:
> PELT scales its util_sum and util_avg values via
> arch_scale_cpu_capacity(). If that function is passed the CPU's sched
> domain then it will reduce the scaling capacity if SD_SHARE_CPUCAPACITY
> is set. PELT does not pass in the sd however. The other caller of
> arch_scale_cpu_capacity, update_cpu_capacity(), does. This means
> util_sum and util_avg scale beyond the CPU capacity on SMT.
> 
> On an Intel i7-3630QM for example rq->cpu_capacity_orig is 589 but
> util_avg scales up to 1024.

I can't convince myself whether this is the right thing to do. SMT is a
bit 'special' and it depends on how you model SMT capacity.

I'm no SMT expert, but the way I understand the current SMT capacity
model is that capacity_orig represents the capacity of the SMT-thread
when all its thread-siblings are busy. The true capacity of an
SMT-thread where all thread-siblings are idle is actually 1024, but we
don't model this (it would be nightmare to track when the capacity
should change). The capacity of a core with two or more SMT-threads is
chosen to be 1024 + smt_gain, where smt_gain is supposed represent the
additional throughput we gain for the additional SMT-threads. The reason
why we don't have 1024 per thread is that we would prefer to have only
one task per core if possible.

With util_avg scaling to 1024 a core (capacity = 2*589) would be nearly
'full' with just one always-running task. If we change util_avg to max
out at 589, it would take two always-running tasks for the combined
utilization to match the core capacity. So we may loose some bias
towards spreading for SMT systems.

AFAICT, group_is_overloaded() and group_has_capacity() would both be
affected by this patch.

Interestingly, Vincent recently proposed to set the SMT-thread capacity
to 1024 which would affectively make all the current SMT code redundant.
It would make things a lot simpler, but I'm not sure if we can get away
with it. It would need discussion at least.

Opinions?

Morten
