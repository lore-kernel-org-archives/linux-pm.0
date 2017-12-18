From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH 2/4] sched: cpufreq: Keep track of cpufreq utilization
 update flags
Date: Mon, 18 Dec 2017 10:29:45 +0530
Message-ID: <20171218045945.GG19815@vireshk-i7>
References: <cover.1513158452.git.viresh.kumar@linaro.org>
 <CAJZ5v0jLQ7v5u+OUpK0gSAHvR90K=agvUSuFNzJXMnk+YkKyzQ@mail.gmail.com>
 <CAKohpomHfV=2CQj0_D=PsoMvbCu5v_ensJqaZmxUURzr27+yhA@mail.gmail.com>
 <20456740.6R3DDKEUDv@aspire.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pf0-f195.google.com ([209.85.192.195]:34984 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932280AbdLRE7t (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 17 Dec 2017 23:59:49 -0500
Received: by mail-pf0-f195.google.com with SMTP id j124so9244224pfc.2
        for <linux-pm@vger.kernel.org>; Sun, 17 Dec 2017 20:59:49 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20456740.6R3DDKEUDv@aspire.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, Linux PM <linux-pm@vger.kernel.org>, Vincent Guittot <vincent.guittot@linaro.org>, Dietmar Eggemann <dietmar.eggemann@arm.com>, Morten Rasmussen <morten.rasmussen@arm.com>, Juri Lelli <juri.lelli@redhat.com>, Todd Kjos <tkjos@android.com>, Joel Fernandes <joelaf@google.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

On 17-12-17, 01:19, Rafael J. Wysocki wrote:
> We can do that in principle, but why should it return early?  Maybe it's
> a good time to update things, incidentally?
> 
> I actually don't like the SCHED_CPUFRREQ_CLEAR flag *concept* as it is very
> much specific to schedutil and blatantly ignores everybody else.
> 
> Alternatively, you could add two flags for clearing SCHED_CPUFREQ_RT and
> SCHED_CPUFREQ_DL that could just be ingored entirely by intel_pstate.
> 
> So, why don't you make SCHED_CPUFREQ_RT and SCHED_CPUFREQ_DL "sticky" until,
> say, SCHED_CPUFREQ_NO_RT and SCHED_CPUFREQ_NO_DL are passed, respectively?

I didn't like adding scheduling class specific flags, and wanted the code to
treat all of them in the same way. And then the governors can make a policy over
that, on what to ignore and what not to. For example with the current patchset,
the governors can know when nothing else is queued on a CPU and CPU is going to
get into idle loop. They can choose to (or not to) do something in that case.

I just thought that writing consistent (i.e. no special code) code across all
classes would be better.

-- 
viresh
