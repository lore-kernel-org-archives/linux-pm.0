From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH v7 1/2] cpufreq: schedutil: Make iowait boost more energy
 efficient
Date: Mon, 24 Jul 2017 14:27:45 +0530
Message-ID: <20170724085745.GU352@vireshk-i7>
References: <20170723155426.9170-1-joelaf@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pg0-f50.google.com ([74.125.83.50]:38853 "EHLO
        mail-pg0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753225AbdGXI5s (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 24 Jul 2017 04:57:48 -0400
Received: by mail-pg0-f50.google.com with SMTP id s4so54434649pgr.5
        for <linux-pm@vger.kernel.org>; Mon, 24 Jul 2017 01:57:48 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20170723155426.9170-1-joelaf@google.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Joel Fernandes <joelaf@google.com>
Cc: linux-kernel@vger.kernel.org, Juri Lelli <juri.lelli@arm.com>, Patrick Bellasi <patrick.bellasi@arm.com>, Andres Oportus <andresoportus@google.com>, Dietmar Eggemann <dietmar.eggemann@arm.com>, linux-pm@vger.kernel.org, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Len Brown <lenb@kernel.org>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>

On 23-07-17, 08:54, Joel Fernandes wrote:
> Currently the iowait_boost feature in schedutil makes the frequency go to max
> on iowait wakeups.  This feature was added to handle a case that Peter
> described where the throughput of operations involving continuous I/O requests
> [1] is reduced due to running at a lower frequency, however the lower
> throughput itself causes utilization to be low and hence causing frequency to
> be low hence its "stuck".
> 
> Instead of going to max, its also possible to achieve the same effect by
> ramping up to max if there are repeated in_iowait wakeups happening. This patch
> is an attempt to do that. We start from a lower frequency (policy->min)
> and double the boost for every consecutive iowait update until we reach the
> maximum iowait boost frequency (iowait_boost_max).
> 
> I ran a synthetic test (continuous O_DIRECT writes in a loop) on an x86 machine
> with intel_pstate in passive mode using schedutil. In this test the iowait_boost
> value ramped from 800MHz to 4GHz in 60ms. The patch achieves the desired improved
> throughput as the existing behavior.
> 
> [1] https://patchwork.kernel.org/patch/9735885/
> 
> Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
> Cc: Len Brown <lenb@kernel.org>
> Cc: Rafael J. Wysocki <rjw@rjwysocki.net>
> Cc: Viresh Kumar <viresh.kumar@linaro.org>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Suggested-by: Peter Zijlstra <peterz@infradead.org>
> Suggested-by: Viresh Kumar <viresh.kumar@linaro.org>
> Signed-off-by: Joel Fernandes <joelaf@google.com>
> ---
>  kernel/sched/cpufreq_schedutil.c | 38 ++++++++++++++++++++++++++++++++------
>  1 file changed, 32 insertions(+), 6 deletions(-)

You Send V7 [1-2]/2 twice, Are they different ?

For both the patches:

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
