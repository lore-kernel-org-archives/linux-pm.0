From: Patrick Bellasi <patrick.bellasi@arm.com>
Subject: Re: [PATCH 1/6] cpufreq: schedutil: reset sg_cpus's flags at IDLE
 enter
Date: Fri, 7 Apr 2017 15:59:09 +0100
Message-ID: <20170407145909.GD29455@e110439-lin>
References: <1488469507-32463-1-git-send-email-patrick.bellasi@arm.com>
 <1488469507-32463-2-git-send-email-patrick.bellasi@arm.com>
 <1642681.8y9FrPCKVW@aspire.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:56480 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933809AbdDGO7P (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 7 Apr 2017 10:59:15 -0400
Content-Disposition: inline
In-Reply-To: <1642681.8y9FrPCKVW@aspire.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, Viresh Kumar <viresh.kumar@linaro.org>, Steven Rostedt <rostedt@goodmis.org>, Vincent Guittot <vincent.guittot@linaro.org>, John Stultz <john.stultz@linaro.org>, Juri Lelli <juri.lelli@arm.com>, Todd Kjos <tkjos@android.com>, Tim Murray <timmurray@google.com>, Andres Oportus <andresoportus@google.com>, Joel Fernandes <joelaf@google.com>, Morten Rasmussen <morten.rasmussen@arm.com>, Dietmar Eggemann <dietmar.eggemann@arm.com>, Chris Redpath <chris.redpath@arm.com>, Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>

On 29-Mar 00:18, Rafael J. Wysocki wrote:
> On Thursday, March 02, 2017 03:45:02 PM Patrick Bellasi wrote:
> > Currently, sg_cpu's flags are set to the value defined by the last call of
> > the cpufreq_update_util()/cpufreq_update_this_cpu(); for RT/DL classes
> > this corresponds to the SCHED_CPUFREQ_{RT/DL} flags always being set.
> > 
> > When multiple CPU shares the same frequency domain it might happen that a
> > CPU which executed an RT task, right before entering IDLE, has one of the
> > SCHED_CPUFREQ_RT_DL flags set, permanently, until it exits IDLE.
> 
> But if it is idle, it won't be taken into account by sugov_next_freq_shared(), will it?

Yes, but:

1) This kind of "useless RT requests" are ignored only if more then
   TICK_NSEC have elapsed since the last update.

2) The proposed patch, apart from resetting the flags, it also bails
   out without potentially triggering an already too late switch to MAX,
   which starts also a new throttling interval.

3) By resetting the flags we keep the internal state machine more
   consistent with what the scheduler knows, i.e. we are now idle.

Considering overall these three points, IMO this small patch makes the
schedutil machinery a bit more predictable.
 
> Thanks,
> Rafael

Cheers Patrick

-- 
#include <best/regards.h>

Patrick Bellasi
