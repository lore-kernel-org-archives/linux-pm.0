From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH 2/4] sched: cpufreq: Keep track of cpufreq utilization
 update flags
Date: Wed, 20 Dec 2017 09:34:46 +0530
Message-ID: <20171220040446.GS19815@vireshk-i7>
References: <cover.1513158452.git.viresh.kumar@linaro.org>
 <17ff0b5d83a1275a98f0d1b87daf275f3e964af3.1513158452.git.viresh.kumar@linaro.org>
 <20171219192504.nstxsfii6y7rh37w@hirez.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pf0-f194.google.com ([209.85.192.194]:40643 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752995AbdLTEEv (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 19 Dec 2017 23:04:51 -0500
Received: by mail-pf0-f194.google.com with SMTP id v26so12071826pfl.7
        for <linux-pm@vger.kernel.org>; Tue, 19 Dec 2017 20:04:50 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20171219192504.nstxsfii6y7rh37w@hirez.programming.kicks-ass.net>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Peter Zijlstra <peterz@infradead.org>
Cc: Rafael Wysocki <rjw@rjwysocki.net>, Ingo Molnar <mingo@redhat.com>, linux-pm@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>, dietmar.eggemann@arm.com, morten.rasmussen@arm.com, juri.lelli@redhat.com, tkjos@android.com, joelaf@google.com, linux-kernel@vger.kernel.org, patrick.bellasi@arm.com

On 19-12-17, 20:25, Peter Zijlstra wrote:
> Yeah, not happy about this either; we had code that did the right thing
> without this extra tracking I think.

Sure, but how do you suggest we fix the problems we are facing with
the current design? Patrick had a completely different proposal for
solving those problems, which I didn't like very much. This patchset
replaced these patches from Patrick:

- [PATCH v3 1/6] cpufreq: schedutil: reset sg_cpus's flags at IDLE enter
  https://marc.info/?l=linux-kernel&m=151204247801633&w=2

- [PATCH v3 2/6] cpufreq: schedutil: ensure max frequency while
  running RT/DL tasks
  https://marc.info/?l=linux-kernel&m=151204253801657&w=2

- [PATCH v3 6/6] cpufreq: schedutil: ignore sugov kthreads
  https://marc.info/?l=linux-kernel&m=151204251501647&w=2

> Also, we can look at the rq state if we want to, we don't need to
> duplicate that state.

Well that also looks fine to me, and that would mean this:

- We remove SCHED_CPUFREQ_RT and SCHED_CPUFREQ_DL flags, but still
  call the utilization callbacks from RT and DL classes.

- From the utilization handler, we check runqueues of all three sched
  classes to see if they have some work pending (this can be done
  smartly by checking only RT first and skipping other checks if RT
  has some work).

Will that be acceptable ?

-- 
viresh
