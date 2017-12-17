From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH 2/4] sched: cpufreq: Keep track of cpufreq utilization update flags
Date: Sun, 17 Dec 2017 01:19:16 +0100
Message-ID: <20456740.6R3DDKEUDv@aspire.rjw.lan>
References: <cover.1513158452.git.viresh.kumar@linaro.org> <CAJZ5v0jLQ7v5u+OUpK0gSAHvR90K=agvUSuFNzJXMnk+YkKyzQ@mail.gmail.com> <CAKohpomHfV=2CQj0_D=PsoMvbCu5v_ensJqaZmxUURzr27+yhA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from cloudserver094114.home.net.pl ([79.96.170.134]:49635 "EHLO
        cloudserver094114.home.net.pl" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1756960AbdLQAUE (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 16 Dec 2017 19:20:04 -0500
In-Reply-To: <CAKohpomHfV=2CQj0_D=PsoMvbCu5v_ensJqaZmxUURzr27+yhA@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, Linux PM <linux-pm@vger.kernel.org>, Vincent Guittot <vincent.guittot@linaro.org>, Dietmar Eggemann <dietmar.eggemann@arm.com>, Morten Rasmussen <morten.rasmussen@arm.com>, Juri Lelli <juri.lelli@redhat.com>, Todd Kjos <tkjos@android.com>, Joel Fernandes <joelaf@google.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

On Saturday, December 16, 2017 5:47:07 PM CET Viresh Kumar wrote:
> On 16 December 2017 at 22:10, Rafael J. Wysocki <rafael@kernel.org> wrote:
> > On Wed, Dec 13, 2017 at 10:53 AM, Viresh Kumar <viresh.kumar@linaro.org> wrote:
> 
> >> +#define SCHED_CPUFREQ_CLEAR    (1U << 31)
> >
> > I'm not thrilled by this, because schedutil is not the only user of
> > the flags and it's totally unclear what the other user(s) should do
> > when this is set.
> 
> intel-pstate is the only other user of the IOWAIT flag, right? In order
> not to change the current behavior, we can update that to return early
> for now ?

We can do that in principle, but why should it return early?  Maybe it's
a good time to update things, incidentally?

I actually don't like the SCHED_CPUFRREQ_CLEAR flag *concept* as it is very
much specific to schedutil and blatantly ignores everybody else.

Alternatively, you could add two flags for clearing SCHED_CPUFREQ_RT and
SCHED_CPUFREQ_DL that could just be ingored entirely by intel_pstate.

So, why don't you make SCHED_CPUFREQ_RT and SCHED_CPUFREQ_DL "sticky" until,
say, SCHED_CPUFREQ_NO_RT and SCHED_CPUFREQ_NO_DL are passed, respectively?

Thanks,
Rafael
