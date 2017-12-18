From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH 2/4] sched: cpufreq: Keep track of cpufreq utilization
 update flags
Date: Mon, 18 Dec 2017 12:35:33 +0100
Message-ID: <CAJZ5v0h+bvbe6DbMn+9DXbbctKG4POTsvEf_eL8R0nLajKXBTA@mail.gmail.com>
References: <cover.1513158452.git.viresh.kumar@linaro.org> <CAJZ5v0jLQ7v5u+OUpK0gSAHvR90K=agvUSuFNzJXMnk+YkKyzQ@mail.gmail.com>
 <CAKohpomHfV=2CQj0_D=PsoMvbCu5v_ensJqaZmxUURzr27+yhA@mail.gmail.com>
 <20456740.6R3DDKEUDv@aspire.rjw.lan> <20171218045945.GG19815@vireshk-i7>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-oi0-f66.google.com ([209.85.218.66]:36863 "EHLO
        mail-oi0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1758326AbdLRLfe (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 18 Dec 2017 06:35:34 -0500
In-Reply-To: <20171218045945.GG19815@vireshk-i7>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, "Rafael J. Wysocki" <rafael@kernel.org>, Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, Linux PM <linux-pm@vger.kernel.org>, Vincent Guittot <vincent.guittot@linaro.org>, Dietmar Eggemann <dietmar.eggemann@arm.com>, Morten Rasmussen <morten.rasmussen@arm.com>, Juri Lelli <juri.lelli@redhat.com>, Todd Kjos <tkjos@android.com>, Joel Fernandes <joelaf@google.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

On Mon, Dec 18, 2017 at 5:59 AM, Viresh Kumar <viresh.kumar@linaro.org> wrote:
> On 17-12-17, 01:19, Rafael J. Wysocki wrote:
>> We can do that in principle, but why should it return early?  Maybe it's
>> a good time to update things, incidentally?
>>
>> I actually don't like the SCHED_CPUFRREQ_CLEAR flag *concept* as it is very
>> much specific to schedutil and blatantly ignores everybody else.
>>
>> Alternatively, you could add two flags for clearing SCHED_CPUFREQ_RT and
>> SCHED_CPUFREQ_DL that could just be ingored entirely by intel_pstate.
>>
>> So, why don't you make SCHED_CPUFREQ_RT and SCHED_CPUFREQ_DL "sticky" until,
>> say, SCHED_CPUFREQ_NO_RT and SCHED_CPUFREQ_NO_DL are passed, respectively?
>
> I didn't like adding scheduling class specific flags, and wanted the code to
> treat all of them in the same way. And then the governors can make a policy over
> that, on what to ignore and what not to. For example with the current patchset,
> the governors can know when nothing else is queued on a CPU and CPU is going to
> get into idle loop. They can choose to (or not to) do something in that case.

Well, if SCHED_CPUFRREQ_CLEAR means "this CPU is going to enter the
idle loop" really, then it is better to call it
SCHED_CPUFRREQ_ENTER_IDLE, for example.

SCHED_CPUFRREQ_CLEAR meaning basically "you should clear these flags
now" doesn't seem to convey any information to whoever doesn't
squirrel the flags in the first place.
