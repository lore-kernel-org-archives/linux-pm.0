From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [RFC PATCH v1 4/8] sched/cpufreq_schedutil: split utilization
 signals
Date: Mon, 10 Jul 2017 12:35:35 +0530
Message-ID: <20170710070535.GH2928@vireshk-i7>
References: <20170705085905.6558-1-juri.lelli@arm.com>
 <20170705085905.6558-5-juri.lelli@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pg0-f47.google.com ([74.125.83.47]:34521 "EHLO
        mail-pg0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752335AbdGJHFi (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 10 Jul 2017 03:05:38 -0400
Received: by mail-pg0-f47.google.com with SMTP id t186so45005812pgb.1
        for <linux-pm@vger.kernel.org>; Mon, 10 Jul 2017 00:05:38 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20170705085905.6558-5-juri.lelli@arm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Juri Lelli <juri.lelli@arm.com>
Cc: peterz@infradead.org, mingo@redhat.com, rjw@rjwysocki.net, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, tglx@linutronix.de, vincent.guittot@linaro.org, rostedt@goodmis.org, luca.abeni@santannapisa.it, claudio@evidence.eu.com, tommaso.cucinotta@santannapisa.it, bristot@redhat.com, mathieu.poirier@linaro.org, tkjos@android.com, joelaf@google.com, andresoportus@google.com, morten.rasmussen@arm.com, dietmar.eggemann@arm.com, patrick.bellasi@arm.com, Ingo Molnar <mingo@kernel.org>, "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>

On 05-07-17, 09:59, Juri Lelli wrote:
> To be able to treat utilization signals of different scheduling classes
> in different ways (e.g., CFS signal might be stale while DEADLINE signal
> is never stale by design) we need to split sugov_cpu::util signal in two:
> util_cfs and util_dl.
> 
> This patch does that by also changing sugov_get_util() parameter list.
> After this change, aggregation of the different signals has to be performed
> by sugov_get_util() users (so that they can decide what to do with the
> different signals).
> 
> Suggested-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> Signed-off-by: Juri Lelli <juri.lelli@arm.com>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Ingo Molnar <mingo@kernel.org>
> Cc: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> Cc: Viresh Kumar <viresh.kumar@linaro.org>
> Cc: Luca Abeni <luca.abeni@santannapisa.it>
> Cc: Claudio Scordino <claudio@evidence.eu.com>
> ---
> Changes from RFCv0:
> 
>  - refactor aggregation of utilization in sugov_aggregate_util()
> ---
>  kernel/sched/cpufreq_schedutil.c | 28 ++++++++++++++++------------
>  1 file changed, 16 insertions(+), 12 deletions(-)

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
