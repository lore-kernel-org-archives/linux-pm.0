From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH v2] cpufreq: schedutil: Trace frequency only if it has
 changed
Date: Thu, 23 Mar 2017 10:02:13 +0530
Message-ID: <20170323043213.GC12094@vireshk-i7>
References: <10655562.4O9KtquB0A@aspire.rjw.lan>
 <2563394.lUgF3b60iC@aspire.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pf0-f179.google.com ([209.85.192.179]:32875 "EHLO
        mail-pf0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751271AbdCWEcS (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 23 Mar 2017 00:32:18 -0400
Received: by mail-pf0-f179.google.com with SMTP id o190so18378545pfo.0
        for <linux-pm@vger.kernel.org>; Wed, 22 Mar 2017 21:32:17 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <2563394.lUgF3b60iC@aspire.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Linux PM <linux-pm@vger.kernel.org>, Peter Zijlstra <peterz@infradead.org>, LKML <linux-kernel@vger.kernel.org>, Patrick Bellasi <patrick.bellasi@arm.com>, Vincent Guittot <vincent.guittot@linaro.org>

On 22-03-17, 18:32, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> sugov_update_commit() calls trace_cpu_frequency() to record the
> current CPU frequency if it has not changed in the fast switch case
> to prevent utilities from getting confused (they may report that the
> CPU is idle if the frequency has not been recorded for too long, for
> example).
> 
> However, that may cause the tracepoint to be triggered quite often
> for no real reason (if the frequency doesn't change, we will not
> modify the last update time stamp and governor computations may
> run again shortly when that happens), so don't do that (arguably, it
> is done to work around a utilities bug anyway).
> 
> That allows code duplication in sugov_update_commit() to be reduced
> somewhat too.
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
> 
> -> v2:
> Drop the trace_cpu_frequency() call in the sg_policy->next_freq == next_freq case.
> 
> ---
>  kernel/sched/cpufreq_schedutil.c |   16 +++++++---------
>  1 file changed, 7 insertions(+), 9 deletions(-)

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
