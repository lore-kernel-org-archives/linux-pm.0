From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH v7 1/2] cpufreq: schedutil: Make iowait boost more energy efficient
Date: Fri, 28 Jul 2017 01:54:41 +0200
Message-ID: <25908597.bDgOEpvcUY@aspire.rjw.lan>
References: <20170723155426.9170-1-joelaf@google.com> <20170724085745.GU352@vireshk-i7> <CAJWu+oriTd4bXaWo9LB2oUGHbVz11P__Cb20_=cndpjiwqyN7g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from cloudserver094114.home.net.pl ([79.96.170.134]:53059 "EHLO
        cloudserver094114.home.net.pl" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751573AbdG1ACn (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 27 Jul 2017 20:02:43 -0400
In-Reply-To: <CAJWu+oriTd4bXaWo9LB2oUGHbVz11P__Cb20_=cndpjiwqyN7g@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Joel Fernandes <joelaf@google.com>
Cc: Viresh Kumar <viresh.kumar@linaro.org>, LKML <linux-kernel@vger.kernel.org>, Juri Lelli <juri.lelli@arm.com>, Patrick Bellasi <patrick.bellasi@arm.com>, Andres Oportus <andresoportus@google.com>, Dietmar Eggemann <dietmar.eggemann@arm.com>, Linux PM <linux-pm@vger.kernel.org>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Len Brown <lenb@kernel.org>, Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>

On Monday, July 24, 2017 11:37:58 AM Joel Fernandes wrote:
> On Mon, Jul 24, 2017 at 1:57 AM, Viresh Kumar <viresh.kumar@linaro.org> wrote:
> > On 23-07-17, 08:54, Joel Fernandes wrote:
> >> Currently the iowait_boost feature in schedutil makes the frequency go to max
> >> on iowait wakeups.  This feature was added to handle a case that Peter
> >> described where the throughput of operations involving continuous I/O requests
> >> [1] is reduced due to running at a lower frequency, however the lower
> >> throughput itself causes utilization to be low and hence causing frequency to
> >> be low hence its "stuck".
> >>
> >> Instead of going to max, its also possible to achieve the same effect by
> >> ramping up to max if there are repeated in_iowait wakeups happening. This patch
> >> is an attempt to do that. We start from a lower frequency (policy->min)
> >> and double the boost for every consecutive iowait update until we reach the
> >> maximum iowait boost frequency (iowait_boost_max).
> >>
> >> I ran a synthetic test (continuous O_DIRECT writes in a loop) on an x86 machine
> >> with intel_pstate in passive mode using schedutil. In this test the iowait_boost
> >> value ramped from 800MHz to 4GHz in 60ms. The patch achieves the desired improved
> >> throughput as the existing behavior.
> >>
> >> [1] https://patchwork.kernel.org/patch/9735885/
> >>
> >> Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
> >> Cc: Len Brown <lenb@kernel.org>
> >> Cc: Rafael J. Wysocki <rjw@rjwysocki.net>
> >> Cc: Viresh Kumar <viresh.kumar@linaro.org>
> >> Cc: Ingo Molnar <mingo@redhat.com>
> >> Cc: Peter Zijlstra <peterz@infradead.org>
> >> Suggested-by: Peter Zijlstra <peterz@infradead.org>
> >> Suggested-by: Viresh Kumar <viresh.kumar@linaro.org>
> >> Signed-off-by: Joel Fernandes <joelaf@google.com>
> >> ---
> >>  kernel/sched/cpufreq_schedutil.c | 38 ++++++++++++++++++++++++++++++++------
> >>  1 file changed, 32 insertions(+), 6 deletions(-)
> >
> > You Send V7 [1-2]/2 twice, Are they different ?
> 
> No they are the same. Rafael suggested reposting it with linux-pm in
> CC I just resent it.
> 
> >
> > For both the patches:
> >
> > Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
> 
> Thanks!

Applied, thanks!
