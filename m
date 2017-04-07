From: Patrick Bellasi <patrick.bellasi@arm.com>
Subject: Re: [PATCH 3/6] cpufreq: schedutil: ensure max frequency while
 running RT/DL tasks
Date: Fri, 7 Apr 2017 17:59:07 +0100
Message-ID: <20170407165907.GE29455@e110439-lin>
References: <1488469507-32463-1-git-send-email-patrick.bellasi@arm.com>
 <1488469507-32463-4-git-send-email-patrick.bellasi@arm.com>
 <20170407153055.nd3qlyfrc3eywl5s@hirez.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:58592 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S934261AbdDGQ7O (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 7 Apr 2017 12:59:14 -0400
Content-Disposition: inline
In-Reply-To: <20170407153055.nd3qlyfrc3eywl5s@hirez.programming.kicks-ass.net>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Peter Zijlstra <peterz@infradead.org>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, Viresh Kumar <viresh.kumar@linaro.org>, Steven Rostedt <rostedt@goodmis.org>, Vincent Guittot <vincent.guittot@linaro.org>, John Stultz <john.stultz@linaro.org>, Juri Lelli <juri.lelli@arm.com>, Todd Kjos <tkjos@android.com>, Tim Murray <timmurray@google.com>, Andres Oportus <andresoportus@google.com>, Joel Fernandes <joelaf@google.com>, Morten Rasmussen <morten.rasmussen@arm.com>, Dietmar Eggemann <dietmar.eggemann@arm.com>, Chris Redpath <chris.redpath@arm.com>, Ingo Molnar <mingo@redhat.com>, "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>

On 07-Apr 17:30, Peter Zijlstra wrote:
> On Thu, Mar 02, 2017 at 03:45:04PM +0000, Patrick Bellasi wrote:
> > +	struct task_struct *curr = cpu_curr(smp_processor_id());
> 
> Isn't that a weird way of writing 'current' ?

Right... (cough)... it's a new fangled way. :-/

Will cleanup before reposting the series.

-- 
#include <best/regards.h>

Patrick Bellasi
