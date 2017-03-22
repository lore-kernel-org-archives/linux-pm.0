From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH] cpufreq: schedutil: Always trace frequency if it does
 not change
Date: Wed, 22 Mar 2017 09:46:53 +0530
Message-ID: <20170322041653.GW25659@vireshk-i7>
References: <10655562.4O9KtquB0A@aspire.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pf0-f175.google.com ([209.85.192.175]:33732 "EHLO
        mail-pf0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751370AbdCVEQ5 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 22 Mar 2017 00:16:57 -0400
Received: by mail-pf0-f175.google.com with SMTP id o190so6573559pfo.0
        for <linux-pm@vger.kernel.org>; Tue, 21 Mar 2017 21:16:56 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <10655562.4O9KtquB0A@aspire.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Linux PM <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Peter Zijlstra <peterz@infradead.org>, Patrick Bellasi <patrick.bellasi@arm.com>, Vincent Guittot <vincent.guittot@linaro.org>

On 22-03-17, 01:56, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> sugov_update_commit() calls trace_cpu_frequency() to record the
> current CPU frequency if it has not changed in the fast switch case
> to prevent utilities from getting confused (they may report that the
> CPU is idle if the frequency has not been recorded for too long, for
> example).
> 
> However, the same problem may occur for a cpufreq driver that doesn't
> support fast frequency switching and implements the ->target callback
> (that is, it doesn't use frequency tables), but trace_cpu_frequency()
> is not called if frequency updates are skipped in that case.
> 
> For this reason, modify sugov_update_commit() to always call
> trace_cpu_frequency() when the new frequency to be set is equal to
> the one that was set previously and reorganize the code in there to
> reduce duplication somewhat.
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
>  kernel/sched/cpufreq_schedutil.c |   18 +++++++++---------
>  1 file changed, 9 insertions(+), 9 deletions(-)

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
